import std/strutils
import std/sequtils
import system


let filename = "input.txt"

let input = readFile(filename)



proc remover(line: seq[int]): seq[seq[int]] = 
  var seq_without: seq[seq[int]] = @[]
  seq_without.add(line[1..^1])
  seq_without.add(line[0..^2])
  for i in 1 ..< line.len-1:
    let left = line[0 ..< i]
    let right = line[i+1 .. ^1]
    seq_without.add(left & right)
  return seq_without & line

# -----------------------------------------

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
# ------------------------------

var safe = 0
for line in input.splitLines():
  var line_numbers: seq[int] = line.split().map(parseInt)
  let is_safe: bool = remover(line_numbers).any(check)
  if is_safe: safe += 1

echo "There are ",safe," safe reports."