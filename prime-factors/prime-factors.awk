{
    Command = "factor | sed -E 's/[0-9]+: ?//'"
    print $1 | Command
    close(Command)
}
