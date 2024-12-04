
import strutils

let filename = "input.txt"
let input = readFile(filename)

let grid = input.splitLines()

let max_y = grid.high
let max_x = grid[0].high

proc check_xmas(grid: seq[string], x: int, y: int): int =
  if grid[x][y] == 'A':
    let first = grid[x-1][y-1] & grid[x][y] & grid[x+1][y+1]
    let second = grid[x+1][y-1] & grid[x][y] & grid[x-1][y+1]
    if (first == "MAS" or first == "SAM") and (second == "MAS" or second == "SAM"): return 1
  return 0


var xmas = 0
for y in 1 .. max_y-1:
  for x in 1 .. max_x-1:
    xmas += check_xmas(grid,x,y)
echo xmas