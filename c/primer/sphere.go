package main

import (
	"fmt"
	"math"
)

func main() {
	r := 3
	r3 := r * r * r
	v := 4.0 * math.Pi * r3 / 3.0
	fmt.Println(v)
}
