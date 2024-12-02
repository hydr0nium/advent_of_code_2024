import std/strutils
import std/sequtils
import std/strformat


let filename = "input.txt"

let input = readFile(filename)


proc check(line: seq[int]): bool =
  let asc = (line[1] - line[0] > 0)

  for i in 1 ..< line.len:
    let last = line[i-1]
    let current = line[i]
    let diff = abs(last - current)
    if diff == 0 or diff > 3:
      return false
    if asc:
      if last > current:
        return false
    else:
      if last < current:
        return false
  return true

var safe = 0
for line in input.splitLines():
  try:
    let line_numbers = line.split().map(parseInt)
    if check(line_numbers): safe += 1
  except ValueError:
    echo repr(line)

echo "There are ",safe," safe reports."