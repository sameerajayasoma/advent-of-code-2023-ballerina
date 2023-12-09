const IGNORE = -1;
const OTHER_SYMBOL = -2;
const STAR_SYMBOL = -3;
type SYMBOL OTHER_SYMBOL | STAR_SYMBOL;

function part1SumOfAllPartNumbers(string[] lines) returns int {
    int[][] schematic = parseStringInput(lines);
    int sum = 0;
    foreach var partNum in getPartNumbers(schematic) {
        sum += partNum;
    }
    return sum;
}

function getPartNumbers(int[][] schematic) returns int[] {
    int[] partNumbers = [];
    int row = 0;
    while (row < schematic.length()) {
        int col = 0;
        while (col < schematic[row].length()) {
            int d = schematic[row][col];
            match d {
                0|1|2|3|4|5|6|7|8|9 => {
                    var [number, length, isPartNum] = partNumberStatus(row, col, schematic);
                    col += length;
                    if isPartNum {
                        partNumbers.push(number);
                    }
                }
            }
            col += 1;
        }
        row += 1;
    }

    return partNumbers;
}

function partNumberStatus(int row, int col, int[][] schematic) returns [int, int, boolean] {
    int[] digits = [];
    int colNum = col;
    boolean isPartNumber = false;
    while (colNum < schematic[row].length() && schematic[row][colNum] >= 0) {
        digits.push(schematic[row][colNum]);
        if !isPartNumber {
            isPartNumber = partNumber(row, colNum, schematic);
        }
        colNum += 1;
    }
    return [numberFromDigits(digits), digits.length(), isPartNumber];
}

function numberFromDigits(int[] digits) returns int {
    int place = 1;
    int index = digits.length() - 1;
    int number = 0;
    while (index >= 0) {
        number += digits[index] * place;
        place *= 10;
        index -= 1;
    }
    return number;
}

function partNumber(int row, int col, int[][] schematic) returns boolean {
    int rowLength = schematic.length();
    int colLength = schematic[row].length();

    // Check left
    if col - 1 >= 0 && schematic[row][col - 1] is SYMBOL {
        return true;
    }

    // Check right
    if col + 1 < colLength && schematic[row][col + 1] is SYMBOL {
        return true;
    }

    // Check up
    if row - 1 >= 0 && schematic[row - 1][col] is SYMBOL {
        return true;
    }
    
    // Check down
    if row + 1 < rowLength && schematic[row + 1][col] is SYMBOL {
        return true;
    }

    // Check up-left
    if row - 1 >= 0 && col - 1 >= 0 && schematic[row - 1][col - 1] is SYMBOL {
        return true;
    }

    // Check up-right
    if row - 1 >= 0 && col + 1 < colLength && schematic[row - 1][col + 1] is SYMBOL {
        return true;
    }

    // Check down-left
    if row + 1 < rowLength && col - 1 >= 0 && schematic[row + 1][col - 1] is SYMBOL {
        return true;
    }

    // Check down-right
    if row + 1 < rowLength && col + 1 < colLength && schematic[row + 1][col + 1] is SYMBOL {
        return true;
    }

    return false;
}

function parseStringInput(string[] lines) returns int[][] {
    int[][] result = [];
    foreach var line in lines {
        int[] numbers = [];
        foreach var c in line {
            match c {
                "." => {
                    numbers.push(IGNORE);
                }

                "0"|"1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9" => {
                    numbers.push(checkpanic int:fromString(c));
                }

                "*" => {
                    numbers.push(STAR_SYMBOL);
                }

                _ => {
                    numbers.push(OTHER_SYMBOL);
                }
            }
        }
        result.push(numbers);
    }
    return result;
}
