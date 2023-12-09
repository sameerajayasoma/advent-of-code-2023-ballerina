function part1SumOfAllGears(string[] lines) returns int {
    int[][] schematic = parseStringInput(lines);
    int[] gearRatios = getGearRatios(schematic);
    int sum = 0;
    foreach var gearRatio in gearRatios {
        sum += gearRatio;    
    }
    return sum;
}

function getGearRatios(int[][] schematic) returns int[] {
    int[] gearRatios = [];
    int row = 0;
    while (row < schematic.length()) {
        int col = 0; 
        while (col < schematic[row].length()) {
            if schematic[row][col] == STAR_SYMBOL {
                int|error gearRatio = getGearRatio(row, col, schematic);
                if gearRatio is int {
                    gearRatios.push(gearRatio);
                }
            }
            col += 1;
        }
        row += 1;
    }
    return gearRatios;
}

const LEFT = 1;
const RIGHT = 2;
const UP = 3;
const DOWN = 4;
const UP_LEFT = 5;
const UP_RIGHT = 6;
const DOWN_LEFT = 7;
const DOWN_RIGHT = 8;

function getGearRatio(int row, int col, int[][] schematic) returns int|error {
    int rowLength = schematic.length();
    int colLength = schematic[row].length();

    boolean upLeft = false;
    boolean up = false;
    boolean downLeft = false;
    boolean down = false;

    int[] directions = [];
    // Check left
    if col - 1 >= 0 && isDigit(row, col - 1, schematic) {
        directions.push(LEFT);
    }

    // Check right
    if col + 1 < colLength && isDigit(row, col + 1, schematic) {
        directions.push(RIGHT);
    }

    // Check up-left
    if row - 1 >= 0 && col - 1 >= 0 && isDigit(row - 1, col - 1, schematic) {
        directions.push(UP_LEFT);
        upLeft = true;
    }

    // Check up
    if row - 1 >= 0 && isDigit(row - 1, col, schematic) {
        up = true;
        if !upLeft {
            directions.push(UP);
        }
    }

    // Check up-right
    if row - 1 >= 0 && col + 1 < colLength && isDigit(row - 1, col + 1, schematic) {
        if !up {
            directions.push(UP_RIGHT);
        }
    }

    // Check down-left
    if row + 1 < rowLength && col - 1 >= 0 && isDigit(row + 1, col - 1, schematic) {
        directions.push(DOWN_LEFT);
        downLeft = true;
    }

    // Check down
    if row + 1 < rowLength && isDigit(row + 1, col, schematic) {
        down = true;
        if !downLeft {
            directions.push(DOWN);
        }
    }

    // Check down-right
    if row + 1 < rowLength && col + 1 < colLength && isDigit(row + 1, col + 1, schematic) {
        if !down {
            directions.push(DOWN_RIGHT);
        }
    }

    if directions.length() != 2 {
        return error ("No gear ratio found");
    }

    int number1 = getNumber(directions[0], row, col, schematic);
    int number2 = getNumber(directions[1], row, col, schematic);

    return number1 * number2;
}

function getNumber(int direction, int row, int col, int[][] schematic) returns int {
    var [r, c] = updateRowCol(direction, row, col);

    int rightColIndex = c;
    while (rightColIndex < schematic[r].length() && isDigit(r, rightColIndex, schematic)) {
        rightColIndex += 1;
    }
    rightColIndex -= 1;

    int leftColIndex = c;
    while (leftColIndex >= 0 && isDigit(r, leftColIndex, schematic)) {
        leftColIndex -= 1;
    }
    leftColIndex += 1;

    return numberFromDigit(leftColIndex, rightColIndex, r, schematic);
}

function updateRowCol(int direction, int row, int col) returns [int, int] {
    int r = row;
    int c = col;
    match direction {
        UP => {
            r -= 1;
        }
        DOWN => {
            r += 1;
        }
        LEFT => {
            c -= 1;
        }
        RIGHT => {
            c += 1;
        }
        UP_LEFT => {
            r -= 1;
            c -= 1;
        }
        UP_RIGHT => {
            r -= 1;
            c += 1;
        }
        DOWN_LEFT => {
            r += 1;
            c -= 1;
        }
        DOWN_RIGHT => {
            r += 1;
            c += 1;
        }
    }
    return [r, c];
}

function numberFromDigit(int leftColIndex, int rightColIndex, int row, int[][] schematic) returns int {
    int index = rightColIndex;
    int place = 1;
    int number = 0;
    while (index >= leftColIndex) {
        number += place * schematic[row][index];
        place *= 10;
        index -= 1;
    }
    return number;
}

function isDigit(int row, int col, int[][] schematic) returns boolean => schematic[row][col] >= 0;

