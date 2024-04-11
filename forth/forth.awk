BEGIN {
    Number = @/-?[[:digit:]]+/
    BiOperator = @/[-+*]|[/]|swap|over/
}

BEGINFILE {
    delete Stack
    delete Macro
    Size = 0
}
{
    $0 = tolower($0)
}
$1 == ":" {
    if ($NF != ";") die("macro not terminated with semicolon")
    if (NF < 4) die("empty macro definition")
    if ($2 ~ Number) die("illegal operation")
    name = $2
    $1 = $2 = $NF = ""
    for (i = 3; i < NF; ++i) if ($i in Macro) $i = Macro[$i]
    Macro[name] = $0
    next
}
{
    for (i = 1; i <= NF; ++i) {
        if ($i ~ Number) push($i)
        else if ($i in Macro) {
            $i = Macro[$i]
            $0 = $0
            --i
        } else if ($i ~ BiOperator) {
            required(2)
            b = pop()
            a = pop()
            switch ($i) {
                case "+": push(a + b); break
                case "-": push(a - b); break
                case "*": push(a * b); break
                case "/":
                    if (!b) die("divide by zero")
                    push(int(a / b)); break
                case "swap": push(b); push(a); break
                case "over": push(a); push(b); push(a); break
            }
        } else if ($i ~ /dup|drop/) {
            required(1)
            a = pop()
            if ($i == "dup") {
                push(a); push(a);
            }
        } else die("undefined operation")
    }
}

ENDFILE {
    NF = Size
    while (Size) {
        $Size = Stack[Size]
        --Size
    }
    print
}

function die(message) {print message > "/dev/stderr"; exit 1}

function required(n) {
    if (!Size) print "empty stack"
    else if (n > 1 && Size == 1) print "only one value on the stack"
    else return
    exit 1
}
function push(element) {
    Stack[++Size] = element
}
function pop() {
    return Stack[Size--]
}
