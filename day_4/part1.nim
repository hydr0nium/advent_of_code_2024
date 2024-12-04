
import strutils

let filename = "input.txt"
let input = readFile(filename)

let grid = input.splitLines()

let max_y = grid.high
let max_x = grid[0].high

proc search_down_dia(grid: seq[string], x: int, y:int): int =
  var checking_1 = ""
  var checking_2 = ""
  if x <= max_x-3:
    checking_1 = grid[y][x] &
    grid[y+1][x+1] &
    grid[y+2][x+2] &
    grid[y+3][x+3]
  if x>=3:
    checking_2 = grid[y][x] & grid[y+1][x-1] & grid[y+2][x-2] & grid[y+3][x-3]
  if checking_1 == "XMAS": result += 1
  if checking_2 == "XMAS": result += 1

proc search_down_straight(grid: seq[string], x:int, y:int): int =
  let checking = grid[y][x] & grid[y+1][x] & grid[y+2][x] & grid[y+3][x]
  if checking == "XMAS": result += 1

proc search_up_dia(grid: seq[string], x: int, y:int): int =
  var checking_1 = ""
  var checking_2 = ""
  if x <= max_x-3:
    checking_1 = grid[y][x] & grid[y-1][x+1] & grid[y-2][x+2] & grid[y-3][x+3]
  if x >= 3:
    checking_2 = grid[y][x] & grid[y-1][x-1] & grid[y-2][x-2] & grid[y-3][x-3]
  if checking_1 == "XMAS": result += 1
  if checking_2 == "XMAS": result += 1

proc search_up_straight(grid: seq[string], x:int, y:int): int =
  let checking = grid[y][x] & grid[y-1][x] & grid[y-2][x] & grid[y-3][x]
  if checking == "XMAS": result += 1

proc search_up(grid: seq[string], x: int, y: int): int =
  return search_up_dia(grid, x, y) + search_up_straight(grid, x, y)

proc search_down(grid: seq[string], x: int, y: int): int =
  return search_down_dia(grid, x, y) + search_down_straight(grid, x, y)

proc search_left(grid: seq[string], x: int, y: int): int =
  #echo grid
  let checking = grid[y][(x-3) .. x]
  #echo "X:", x, " | Y: ", y, " | ", checking
  if checking == "SAMX": result += 1

proc search_right(grid: seq[string], x: int, y: int): int =
  #echo grid
  let checking = grid[y][x .. x+3]
  #echo "X:", x, " | Y: ", y, " | ", checking
  if checking == "XMAS": result += 1


var xmas = 0
for y in 0 .. max_y:
  for x in 0 .. max_x:
    if y >= 3:
      xmas += search_up(grid, x, y)
    if y <= max_y-3:
      xmas += search_down(grid, x, y)
    if x>=3:
      xmas += search_left(grid, x, y)
    if x <= max_x-3:
      xmas += search_right(grid, x, y)
echo xmas