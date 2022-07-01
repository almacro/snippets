#!/usr/bin/env tclsh
#
# compute factorial

proc fact n {expr {$n<2? 1: $n * [fact [incr n -1]]}}

#proc fact n {
#  set n
#}

set arg [lindex $argv 0]
puts [fact $arg]
