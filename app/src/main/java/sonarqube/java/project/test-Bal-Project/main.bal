function manyParams(int a, int b, int c, int d, int e, int f, int g, int h, int j, int k) returns int {
    return 0;
}

function someFunction() {
    int x = checkpanic manyParams(1, 2, 3, 4, 5, 6, 7, 8, 9, 1);
}

function someFunction3() {
    checkpanic someFunction();
}

function someFunction4() {
    string y = "checkpanic";
    string checkpanicTester = "checkpanic";
    string 'checkpanic = "";
}
