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


# duck.ai generated!
proc powerset(s: seq[int]): seq[seq[int]] =
  if s.len == 0:
    return @[@[]]  # Base case: the powerset of an empty sequence is a sequence containing an empty sequence.
  else:
    let
      restPowerset = powerset(s[1..^1])  # Recursive call on the rest of the sequence
      first = s[0]
    result = restPowerset & restPowerset.map(it => it & @[first])  # Combine subsets without and with the first element


proc sum_mult(numbers: seq[int], mult_pos: seq[int]): (int,string) =
  var res = numbers[0]
  var path = "Using " & numbers[0].intToStr()
  for (i,number) in enumerate(numbers[1..^1]):
    let j = i+1
    if j in mult_pos:
      path &= " * " & number.intToStr()
      res *= number 
    else:
      path &= " + " & number.intToStr()
      res += number
  return (res,path)


proc check(line: (int, seq[int])): int =
  let numbers = line[1]
  let res = line[0]
  let s = numbers.foldl(a+b)
  let m = numbers.foldl(a*b)
  if s == res or m == res:
    #echo line, " are true 3"
    return res
  let indexs = toSeq(1 .. len(line[1])-1)
  let power = powerset(indexs)
  for subset in power:
    let (tester,path) = sum_mult(numbers,subset)
    if tester == res:
      return res
  return 0

let x = data.map(check)
echo x.foldl(a+b)

  




