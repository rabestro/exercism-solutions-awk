{
    Amount = $2
}
/open/ {
    requireClosedAccount()
    Balance = 0
}
/close/ {
    requireOpenAccount()
    Balance = ""
}
/balance/ {
    requireOpenAccount()
    print Balance
}
/deposit/ {
    requireOpenAccount()
    requirePositiveAmount()
    Balance += Amount
}
/withdraw/ {
    requireOpenAccount()
    requirePositiveAmount()
    requireMinimumBalance()
    Balance -= Amount
}

function requireOpenAccount() {
    if (Balance == "")
        die("account not open")
}
function requireClosedAccount() {
    if (Balance != "")
        die("account already open")
}
function requirePositiveAmount() {
    if (Amount <= 0)
        die("amount must be greater than 0")
}
function requireMinimumBalance() {
    if (Amount > Balance)
        die("amount must be less than balance")
}
function die(message) {print message > "/dev/stderr"; exit 1}
