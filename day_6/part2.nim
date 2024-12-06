import strutils
import std/enumerate


proc move(a: (int, int), b: (int, int)): (int, int) =
  return (a[0] + b[0], a[1] + b[1])

let filename = "input.txt"
let input = readFile(filename)
var grid = input.splitLines()
let max_y = grid.high
let max_x = grid[0].high

proc test(change: (int,int)): bool = 
  var grid = input.splitLines()
  if grid[change[0]][change[1]] == '#':
    return false
  grid[change[0]][change[1]] = '#'

  let max_y = grid.high
  let max_x = grid[0].high
  var guard: (int,int) # (y,x) down is positive
  const directions = @[(-1,0), (0,1), (1,0), (0,-1)]
  var direction = 0
  var visited_turns: seq[(int,int,int)] = @[] # (y,x,direction)
  for (i,line) in enumerate(grid):
    for (j,c) in enumerate(line):
      if c=='^':
        guard = (i,j)
        visited_turns.add((i,j,direction))
  while true:
    let potential_spot = guard.move(directions[direction])
    if potential_spot[0] == max_y+1 or potential_spot[0] == -1 or potential_spot[1] == max_x+1 or potential_spot[1] == -1:
      return false
    if (potential_spot[0],potential_spot[1],direction) in visited_turns:
      return true
    if grid[potential_spot[0]][potential_spot[1]] != '#':
      guard = guard.move(directions[direction])
    else:
      visited_turns.add((guard[0],guard[1],direction))
      direction = (direction + 1) mod 4
  return false

var sum = 0
for y in 0..max_y:
  for x in 0..max_x:
    if test((y,x)):
      sum += 1
echo sum