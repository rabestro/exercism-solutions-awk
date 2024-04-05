END {
    print message($0)
}

function message(subject) {
    subject = subject ? subject : "you"
    return "One for "subject", one for me."
}
