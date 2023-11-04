function manyParams(int 1, int b, int c, int d, int e, int f, int g, int h, int j, int k) returns int{
    return 0;
}

function someFunction(){
    int x = checkpanic manyParams();
}

function someFunction2(){
    checkpanic checkpanic checkpanic checkpanic
}

function someFunction3(){
    checkpanic
    checkpanic
    checkpanic
    checkpanic
    checkpanic
}

function someFunction4(){
    string y = "checkpanic";
    string checkpanicTester = "checkpanic";
}