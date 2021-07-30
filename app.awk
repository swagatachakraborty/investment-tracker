#! /usr/bin/awk

BEGIN {
    count=0
    FS="\n"
}

(/ - / && !/,/ && !/\./) {
    name=getMFName($0)
    count=count+1
}

(/\./) {
    invested=getInvestedAmount($0)
    valuation=getValuation($0)
    change=getChangePercentage(invested, valuation)
    row[count]=name" | "invested" | "valuation" | "change"%"
}

END {
    for(i = 0; i <= count; i = i + 1) {
        print row[i]
    }
}

function getMFName(line, separator, order) {
    split(line, a, "-")
    return a[2]
}

function getInvestedAmount(line) {
    size=split(line, a, " ")
    return a[size-1]
}

function getValuation(line) {
    size=split(line, a, " ")
        return a[size]
}

function getChangePercentage(invested, valuation) {
    return (valuation-invested)/invested*100
}
