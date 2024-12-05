import strutils
import tables
import sequtils
import std/enumerate
import system/exceptions

proc parse_rule(rules: string): seq[(int,int)]

proc parse_instructions(instructions: string): seq[Table[int,int]]

proc check_instruction(instruction: Table[int,int]): int

let filename = "input.txt"
let input = readFile(filename)

let parts = input.split("\n\n")

let rules_unparsed = parts[0]
let instructions_unparsed = parts[1]

let rules = parse_rule(rules_unparsed)
#echo rules
let instructions = parse_instructions(instructions_unparsed)
#echo instructions
let mapped = instructions.map(check_instruction)
echo mapped.foldl(a + b)








proc parse_rule(rules: string): seq[(int,int)] =
  for line in rules.splitLines():
    let parts = line.split("|")
    let left = parseInt(parts[0])
    let right = parseInt(parts[1])
    result.add((left,right))

proc parse_instructions(instructions: string): seq[Table[int,int]] =
  for line in instructions.splitLines():
    var table = initTable[int,int]()
    let numbers = line.split(",").map(parseInt)
    for (i,num) in enumerate(numbers):
      table[num] = i
    result.add(table)

proc check_instruction(instruction: Table[int,int]): int =
  for rule in rules:
    let (num1,num2) = rule
    try:
      let index1 = instruction[num1]
      let index2 = instruction[num2]
      if index1 > index2:
        return 0
    except:
      continue
  let index = ((instruction.len+1) div 2)-1
  for page in instruction.keys:
    if instruction[page] == index:
      return page 
  raise newException(IndexDefect, "This should not happen")

  