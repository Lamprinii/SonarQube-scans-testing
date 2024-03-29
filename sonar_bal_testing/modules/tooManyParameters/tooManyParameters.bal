import ballerina/io;

// Noncompliant
public function nonCompliant(int a, int b, int c, int d, int e, int f, int g, int h) returns int {
    return a + b + c + d + e + f + g;
}

// Compliant 1
public type Point record {|
    int x;
    int y;
|};

public type ShapeProperties record {|
    int width;
    int height;
    int depth;
|};

public function setCoordinates(Point p1, Point p2, Point p3) returns int {
    return p1.x + p1.y + p2.x + p2.y + p3.x + p3.y;
}

public function setSize(int shapeID, ShapeProperties properties) returns int {
    return properties.width + properties.height + properties.depth;
}

public function compliantSolution1() {
    Point p1 = {x: 1, y: 1};
    Point p2 = {x: 2, y: 2};
    Point p3 = {x: 1, y: 2};

    int shapeID = setCoordinates(p1, p2, p3);
    io:println(shapeID);

    ShapeProperties properties = {width: 3, height: 3, depth: 3};
    int result = setSize(shapeID, properties);
    io:println(result);
}

// Compliant 2

public type Coordinates record {|
    Point p1;
    Point p2;
    Point p3;
|};

public function setCoordinates2(*Coordinates coordinates) returns int {
    return coordinates.p1.x + coordinates.p1.y + coordinates.p2.x + coordinates.p2.y + coordinates.p3.x + coordinates.p3.y;
}

public function setSize2(int shapeID, *ShapeProperties properties) returns int {
    return properties.width + properties.height + properties.depth;
}

public function compliantSolution2() {
    int shapeID = setCoordinates(p1 = {x: 1, y: 2},
        p2 = {x: 1, y: 2},
        p3 = {x: 1, y: 2});
    io:println(shapeID);

    int result = setSize2(shapeID, {width: 3, height: 3, depth: 3});
    io:println(result);
}

public function checkRule() {
    int result = nonCompliant(1, 2, 3, 4, 5, 6, 7, 8);
    io:println(result);

    compliantSolution1();

    compliantSolution2();
}
