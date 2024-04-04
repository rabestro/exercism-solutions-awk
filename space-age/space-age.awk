BEGIN {
    OFMT = "%.2f"
    OrbitalPeriod["Earth"] = Earth = 31 557 600
    OrbitalPeriod["Mercury"] = Earth * 0.2408467
    OrbitalPeriod["Venus"] = 0.61519726 * Earth
    OrbitalPeriod["Mars"] = 1.8808158 * Earth
    OrbitalPeriod["Jupiter"] = 11.862615 * Earth
    OrbitalPeriod["Saturn"] = 29.447498 * Earth
    OrbitalPeriod["Uranus"] = 84.016846 * Earth
    OrbitalPeriod["Neptune"] = 164.79132 * Earth
}

$1 in OrbitalPeriod {
    print $2 / OrbitalPeriod[$1]
    next
}
{
    print $1, "is not a planet"
    exit 1
}
