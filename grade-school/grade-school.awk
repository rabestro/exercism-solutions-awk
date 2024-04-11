# These variables are initialized on the command line (using '-v'):
# - action
# - grade

BEGIN {
    OFS = FS = ","
    PROCINFO["sorted_in"] = "compare_students"
}
!($1 in Grades) {
    Grades[$1] = $2
}
END {
    NF = 0
    for (student in Grades)
        if (action == "roster" || Grades[student] == grade)
            $(++NF) = student
    print
}

function compare_students(name1, grade1, name2, grade2) {
    if (grade1 != grade2) return grade1 - grade2
    return name1 < name2 ? -1 : 1
}
