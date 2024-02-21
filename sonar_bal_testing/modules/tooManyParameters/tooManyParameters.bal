import ballerina/io;

public function nonCompliant(int a, int b, int c, int d, int e, int f, int g, int h) returns int {
    return a + b + c + d + e + f + g;
}

public type Point record {
    int x = 0;
    int y = 0;
};

public function compliant1(Point p1, Point p2) returns int {
    return p1.x + p1.y + p2.x + p2.y;
}

public function compliant2(*Point p) returns int {
    return p.x + p.y;
}

public function checkRule() {
    int result = nonCompliant(1, 2, 3, 4, 5, 6, 7, 8);
    io:println(result);

    Point p1 = {x: 1, y: 2};
    Point p2 = {x: 3, y: 4};
    result = compliant1(p1, p2);
    io:println(result);

    result = compliant2(x = 10);
    io:println(result);
}
