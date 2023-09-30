package main

import "fmt"

func main() {
  // This is a code smell: a magic number
  const magicNumber = 42

  // This is a code smell: a redundant variable
  var redundantVariable = magicNumber

  // This is a code smell: a dead code
  fmt.Println(redundantVariable)
}
