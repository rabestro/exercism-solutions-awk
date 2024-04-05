BEGIN {
    OFS = FS = ","
    One = "one"
    Two = "two"
}
$1 < $3 && $2 < $3 {die("invalid goal")}

$4 == One {
    Source = One
    Target = Two
}
$4 == Two {
    Source = Two
    Target = One
}
{
    Goal = $3
    Volume[One] = $1
    Volume[Two] = $2
    Water[One] = Water[Two] = 0

    do {
        process_step()
        record_step()
    } while(!is_goal_achieved())

    winner = Water[One] == Goal ? One : Two
    second = winner == One ? Two : One
    print Step, winner, Water[second]
}

function process_step() {
    if (is_empty(Source))
        fill(Source)
    else if (Volume[Target] == Goal)
        fill(Target)
    else if (is_full(Target))
        empty(Target)
    else
        pouring()
}

function is_goal_achieved() {
    return Water[Source] == Goal || Water[Target] == Goal
}

function record_step(   state) {
    state = Water[Source]","Water[Target]
    if (state in History) die("invalid goal")
    History[state] = ++Step
}

function is_empty(bucket) {
    return Water[bucket] == 0
}

function is_full(bucket) {
    return Water[bucket] == Volume[bucket]
}

function fill(bucket) {
    Water[bucket] = Volume[bucket]
}

function empty(bucket) {
    Water[bucket] = 0
}

function pouring(   free_volume,pouring_volume) {
    free_volume = Volume[Target] - Water[Target]
    pouring_volume = Water[Source] < free_volume ? Water[Source] : free_volume

    Water[Source] -= pouring_volume
    Water[Target] += pouring_volume
}

function die(message) {print message > "/dev/stderr"; exit 1}
