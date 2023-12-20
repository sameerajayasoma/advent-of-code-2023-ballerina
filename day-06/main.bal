import ballerina/lang.regexp;

function part1MuliplicationOfWaysToBeetTheRecord(string[] lines) returns int {
    int[] seconds = parseNumbers(lines[0]);
    int[] distances = parseNumbers(lines[1]);

    int[] waystoBeat = [];
    int index = 0;
    while (index < seconds.length()) {
        int curSeconds = seconds[index];
        int recordDist = distances[index];
        int lowerbound = getLowerBound(curSeconds, recordDist);
        int upperbound = getUpperBound(curSeconds, recordDist);
        
        waystoBeat.push(upperbound - lowerbound + 1);
        index += 1;
    }

    int waysToBeatIndex = 2;
    int mulWaysToBeat = waystoBeat[0] * waystoBeat[1];
    while (waysToBeatIndex < waystoBeat.length()) {
        mulWaysToBeat *= waystoBeat[waysToBeatIndex];
        waysToBeatIndex += 1;
    }

    return mulWaysToBeat;
}

function part2MuliplicationOfWaysToBeetTheRecord(string[] lines) returns int {
    int seconds = parseNumber(lines[0]);
    int distance = parseNumber(lines[1]);
    int lowerbound = getLowerBound(seconds, distance);
    int upperbound = getUpperBound(seconds, distance);  
    return upperbound - lowerbound + 1;
}

function parseNumbers(string line) returns int[] {
    string[] numberStrings = parseNumberStrings(line);
    int index = 0;
    int[] numbers = [];
    while (index < numberStrings.length()) {
        int n = checkpanic int:fromString(numberStrings[index]);
        numbers.push(n);
        index += 1;
    }
    return numbers;
}

function parseNumber(string line) returns int {
    string[] numberStrings = parseNumberStrings(line);
    int index = 0;
    string numberStr = "";
    while (index < numberStrings.length()) {
        numberStr += numberStrings[index];
        index += 1;
    }

    return checkpanic int:fromString(numberStr);
}

function parseNumberStrings(string line) returns string[] {
    regexp:RegExp digitRegex = re `\d+`;
    regexp:Span[] findAll = digitRegex.findAll(line);
    int index = 0;
    string[] numbers = [];
    while (index < findAll.length()) {
        numbers.push(findAll[index].substring());
        index += 1;
    }
    return numbers;
}

function getLowerBound(int seconds, int distance) returns int {
    int lowerbound = 1;
    while (lowerbound < seconds) {
        int curDist = (seconds - lowerbound) * lowerbound;
        if distance < curDist {
            break;
        }
        lowerbound += 1;
    }
    return lowerbound;
}

function getUpperBound(int seconds, int distance) returns int {
    int upperbound = seconds - 1;
    while (upperbound > 0) {
        int curDist = (seconds - upperbound) * upperbound;
        if distance < curDist {
            break;
        }
        upperbound -= 1;
    }
    return upperbound;
}

