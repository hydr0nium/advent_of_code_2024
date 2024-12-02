import strutils
import std/algorithm
import std/sequtils

let example_input = readFile("input.txt")
let lines = example_input.splitLines()
var left: seq[int] = @[]
var right: seq[int] = @[]



for line in lines:
  let splitted = line.splitWhitespace()
  var left_int = parseInt(splitted[0])
  var right_int = parseInt(splitted[1])
  left.add(left_int)
  right.add(right_int)

left.sort()
right.sort()

assert left.len == right.len


var sum = 0
for n in 0 ..< left.len:
  let count = count(right, left[n])
  sum = sum + (left[n]*count)

echo "Sum is: ", sum


    
