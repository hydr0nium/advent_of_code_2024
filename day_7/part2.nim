import std/strutils
import std/sequtils
import std/enumerate
import std/sugar

let filename = "input.txt"

let input = readFile(filename)

let lines = input.splitLines()

var data: seq[(int, seq[int])] = @[]

for line in lines:
  let parts = line.split(":")
  let res = parts[0].parseInt()
  var list = parts[1].splitWhitespace().map(parseInt)
  data.add((res,list))

proc toBase3WithPadding(num: int, length: int): string =
  
  if num == 0:
    result = "0"
  else:
    var n = num
    while n > 0:
      result = chr((n mod 3) + ord('0')) & result
      n = n div 3

  # Pad the result with leading zeros if it's shorter than the desired length
  while result.len < length:
    result = "0" & result



proc sum_mult(numbers: seq[int], mult_options: string, check_digit: int): (int,string) =
  var res = numbers[0]
  var path = "Using " & numbers[0].intToStr()
  for (i,number) in enumerate(numbers[1..^1]):
    if res > check_digit:
      return (0,"invalid to big")
    let op = mult_options[i]
    case op:
      of '0':
        path &= " + " & number.intToStr()
        res += number
      of '1':
        path &= " * " & number.intToStr()
        res *= number
      of '2':
        res = (res.intToStr() & number.intToStr()).parseInt()
        path &= " || " & number.intToStr()
      else:
        echo "WTF"
        quit(0)
  return (res,path)


proc check(line: (int, seq[int])): int =
  echo "Checking line: ", line
  let numbers = line[1]
  let res = line[0]
  let s = numbers.foldl(a+b)
  let m = numbers.foldl(a*b)
  if s == res or m == res:
    #echo line, " are true 3"
    #echo "Finished iteration"
    return res
  let num_length = line[1].len-1
  var count = 0
  let finish = "2".repeat(num_length)
  var mult_options = toBase3WithPadding(count,num_length)
  while mult_options!=finish:
    let (tester,path) = sum_mult(numbers,mult_options,res)
    #if tester != 0: echo res, " | ",path, " = ", tester
    if tester == res:
      #echo "Finished iteration true"
      return res
    count += 1
    mult_options = toBase3WithPadding(count,num_length)
  let (tester,path) = sum_mult(numbers,mult_options,res)
  #if tester != 0: echo res, " | ",path, " = ", tester
  if tester == res:
    #echo "Finished iteration true"
    return res
  #echo "Finished iteration false"
  return 0

let x = data.map(check)
#echo x
echo x.foldl(a+b)

  




