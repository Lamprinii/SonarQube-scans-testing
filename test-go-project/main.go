package main

import (
	"log"
	"strconv"
)

func doStuff() string {
    return "I do stuff!"
}

func doPrint1() {
    log.Printf("Hello world!")
}

// Non Compliant as the method body is empty
func noBodyFunc(){
}

// Non Compliant function due to _ symbol
func non_compliant_function(){
    log.Printf("This is a non compliant function in Go")
}

func doNonCompliantOperation(){
    // Non compliant as both statements are on same line
    doPrint1(); doPrint1()
}

func rename(name string) {
    // Non compliant as variable is self assigned
    name = name
}

func returnValue() int {
    // Non compliant as there are redundent pairs of parenthesis
    if ((true)) {  // Noncompliant
        log.Printf("Non Compliant If condition")
    }

    // Non compliant as there are redundent pairs of parenthesis
    return ((20))
}

// Non compliant as the same message has been conveyed 3 times
func redundentMessage(){
    log.Printf("Repeated message")
    log.Printf("Repeated message")
    log.Printf("Repeated message")
}

func main() {
	log.Printf("starting service sonar ...")
	log.Printf(doStuff())
	doNonCompliantOperation()
	rename("Jhon Doe")
	non_compliant_function()
	log.Printf(strconv.Itoa(returnValue()))
}