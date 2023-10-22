package main

import (
	"log"
	"strconv"
)

// Non Compliant as the function has too many parameters
func tooManyParamsFunc(a, b, c, d, e, f, g, h, i int) int {
    return a + b + c + d + e + f + g + h + i
}

func main(){
log.Printf(strconv.Itoa(tooManyParamsFunc(1,2,3,4,5,6,7,8,9)))
}