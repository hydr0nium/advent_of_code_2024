import re
import std/strutils

let filename = "input.txt"

let input = readFile(filename)

let input_no_nl = input.replace("\n", "")
let pattern = re"mul\((\d{1,3},\d{1,3}\))"
let mul = input_no_nl.findAll(pattern)
let pattern2 = re"(\d+),(\d+)"
var sum = 0
for m in mul:
  let nums =  m.findAll(pattern2)[0].split(",")
  let x = parseInt(nums[0])
  let y = parseInt(nums[1])
  let mult = x*y
  sum += mult


echo sum


