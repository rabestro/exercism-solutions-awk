{
    for (eggs = 0; $0; $0 = rshift($0, 1))
        eggs += and($0, 1)
    print eggs
}
