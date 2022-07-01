#!/usr/bin/env tclsh
#
# compute factorial

# recursive
proc fact n {expr {$n<2? 1: $n * [fact [incr n -1]]}}

# iterative
# proc fact n {
#   set count $n
#   for {set total 1} {$count > 0} {incr count -1} {
#     set total [expr $total * $count]
#   }
#   return $total
# }

# testing
#proc fact n {
#  set n
#}

set arg [lindex $argv 0]
puts [fact $arg]
