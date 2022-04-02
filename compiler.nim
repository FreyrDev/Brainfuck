import strutils, strformat


proc encode(input: string): seq[(char, int)] =
  var runLength: int
  var runChar: char
  for instruction in input:
    if instruction == runChar:
      runLength.inc()
    else:
      result.add((runChar, runLength))
      runLength = 1
      runChar = instruction
  result.add((runChar, runLength))
  result.delete(0)


proc compile(input: string): string =
  let encoded = input.encode()
  result = "var\n  data = newSeq[byte](30000)\n  dataPtr = 0\n\n"
  for elem in encoded:
    case elem[0]:
      of '>': result &= &"dataPtr.inc({elem[1]})\n"
      of '<': result &= &"dataPtr.dec({elem[1]})\n"
      of '+': result &= &"data[dataPtr].inc({elem[1]})\n"
      of '-': result &= &"data[dataPtr].dec({elem[1]})\n"
      else: discard


echo("++++++++>><+++-++>---[-]".compile())
