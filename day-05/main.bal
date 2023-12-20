import ballerina/lang.regexp;
import ballerina/io;

type SeedRange record {|
    int rStart;
    int lengh;
|};

type Range record {|
    int srcStart;
    int srcEnd;
    int destStart;
    int destEnd;
|};

type CategoryMap record {|
    string src;
    string dest;
    Range[] ranges;
|};

final regexp:RegExp colonRegex = re `:`;
final regexp:RegExp spaceRegex = re ` `;
final regexp:RegExp dashRegex = re `-`;

function part1LowestLocation(string[] lines) returns int {
    string seedsLine = lines[0].substring(7);
    int[] seeds = strToIntArray(seedsLine);

    CategoryMap[] categoryMaps = getCategoryMaps(lines);
    int minLocationNum = int:MAX_VALUE;
    foreach int seed in seeds {
        int destNumber = findDestNumberForSeed(seed, categoryMaps);
        if destNumber < minLocationNum {
            minLocationNum = destNumber;
        }
    }
    return minLocationNum;
}

function part2LowestLocation(string[] lines) returns int {
    string seedsLine = lines[0].substring(7);
    SeedRange[] seedRanges = getSeedRanges(strToIntArray(seedsLine));
    CategoryMap[] categoryMaps = getCategoryMaps(lines);

    int minLocationNum = int:MAX_VALUE;
    foreach SeedRange seedRange in seedRanges {
        io:println(seedRange);
        int destNumber = findMinLocationSeedRange(seedRange.rStart, seedRange.lengh, categoryMaps);
        if destNumber < minLocationNum {
            minLocationNum = destNumber;
        }
    }
    return minLocationNum;
}

function getSeedRanges(int[] seedLineNumbers) returns SeedRange[] {
    SeedRange[] seedRanges = [];
    int index = 0;
    while (index < seedLineNumbers.length()) {
        SeedRange seedRange = {rStart: seedLineNumbers[index], lengh: seedLineNumbers[index + 1]};
        seedRanges.push(seedRange);
        index += 2;
    }
    return seedRanges;
}

function findMinLocationSeedRange(int seed, int seedLength, CategoryMap[] categoryMaps) returns int {
    int seedStart = seed;
    int minLocationNum = int:MAX_VALUE;
    int seedEnd = seed + seedLength;
    int catLength = categoryMaps.length();

    while (seedStart < seedEnd) {
        int destNumber = seedStart;
        
        int categoryIndex = 0;
        while (categoryIndex < catLength) {
            CategoryMap categoryMap = categoryMaps[categoryIndex];
            int rangeLength = categoryMap.ranges.length();
            int rangeIndex = 0;
            while (rangeIndex < rangeLength) {
                Range range = categoryMap.ranges[rangeIndex];
                if (destNumber >= range.srcStart && destNumber <= range.srcEnd) {
                    int diff = destNumber - range.srcStart;
                    destNumber = range.destStart + diff;
                    break;
                }
                rangeIndex += 1;
            }


            categoryIndex += 1;
        }

        // foreach var categoryMap in categoryMaps {
        //     // foreach Range range in categoryMap.ranges {
        //     //     if (destNumber >= range.srcStart && destNumber <= range.srcEnd) {
        //     //         int diff = destNumber - range.srcStart;
        //     //         destNumber = range.destStart + diff;
        //     //         break;
        //     //     }
        //     // }
        // }

        if destNumber < minLocationNum {
            minLocationNum = destNumber;
        }
        seedStart += 1;
    }
    return minLocationNum;
}

function findDestNumberForSeed(int seed, CategoryMap[] categoryMaps) returns int {
    int destNumber = seed;
    foreach var categoryMap in categoryMaps {
        destNumber = findDestNumber(destNumber, categoryMap);
    }
    return destNumber;
}

function findDestNumber(int srcNumber, CategoryMap categoryMap) returns int {
    foreach Range range in categoryMap.ranges {
        if (srcNumber >= range.srcStart && srcNumber <= range.srcEnd) {
            int diff = srcNumber - range.srcStart;
            return range.destStart + diff;
        }
    }

    return srcNumber;
}

function getCategoryMaps(string[] lines) returns CategoryMap[] {
    CategoryMap[] categoryMaps = [];
    int index = 2;
    while (index < lines.length()) {
        string mapStartLine = lines[index].substring(0, lines[index].length() - 5);
        string[] srcToDest = dashRegex.split(mapStartLine);
        Range[] ranges = [];
        index += 1;
        while (index < lines.length() && lines[index] != "") {
            int[] rangeNumbers = strToIntArray(lines[index]);
            Range range = getRange(rangeNumbers);
            ranges.push(range);
            index += 1;
        }
        CategoryMap categoryMap = {src: srcToDest[0], dest: srcToDest[2], ranges: ranges};
        categoryMaps.push(categoryMap);
        index += 1;
    }
    return categoryMaps;
}

function getRange(int[] numbers) returns Range {
    return {
        srcStart: numbers[1],
        srcEnd: numbers[1] + numbers[2] - 1,
        destStart: numbers[0],
        destEnd: numbers[0] + numbers[2] - 1
    };
}

function strToIntArray(string str) returns int[] {
    int[] result = [];
    string[] numStrList = spaceRegex.split(str);
    foreach string numStr in numStrList {
        int num = checkpanic int:fromString(numStr);
        result.push(num);
    }
    return result;
}

