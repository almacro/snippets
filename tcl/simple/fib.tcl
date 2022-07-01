#!/usr/bin/env tclsh
#
# compute fibonacci

# iterative
proc fib {pen ult n} {
    for {set i 0} {$i<$n} {incr i} {
        set new [expr $ult+$pen]
        set pen $ult
        set ult $new
    }
    return $pen
}

# recursive
# proc fib {pen ult n} {
#     if {$n == 0} {
#         return $pen
#     }
#     return [fib $ult [expr $pen+$ult] [expr $n-1]]
# }

set arg [lindex $argv 0]
puts [fib 0 1 $arg]
