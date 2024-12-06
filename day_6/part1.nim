import strutils
import std/enumerate


proc move(a: (int, int), b: (int, int)): (int, int) =
  return (a[0] + b[0], a[1] + b[1])

let filename = "input.txt"
let input = readFile(filename)

var grid = input.splitLines()

let max_y = grid.high
let max_x = grid[0].high
var guard: (int,int) # (y,x) down is positive
const directions = @[(-1,0), (0,1), (1,0), (0,-1)]
var direction = 0

for (i,line) in enumerate(grid):
  for (j,c) in enumerate(line):
    if c=='^':
      guard = (i,j)

while not(guard[0] == max_y or guard[1] == max_x):
  grid[guard[0]][guard[1]] = 'X'
  let potential_spot = guard.move(directions[direction])
  if grid[potential_spot[0]][potential_spot[1]] != '#':
    guard = guard.move(directions[direction])
  else:
    direction = (direction + 1) mod 4

grid[guard[0]][guard[1]] = 'X'
var sum = 0
for line in grid:
  sum += line.count("X")
echo sum

