include templates


var 
  data = newSeq[byte](30000)
  dataPtr = 0
  codePtr = 0


proc matchBrackets(input: string, index: int, shape: char): int =
  var sequence: seq[char]

  template findIndex(open, close, iter): untyped =
    for j in iter:
      if input[j] == open:
        sequence.delete(0)
      elif input[j] == close:
        sequence.add(input[index])
      if sequence == @[]:
        return j

  if shape == '[':
    findIndex('[', ']', index..<input.len)
  elif shape == ']':
    findIndex(']', '[', index..\0)


proc interpret(code: string) =
  while dataPtr >= 0 and codePtr < code.len():
    case code[codePtr]:
      of '>': dataPtr.inc()
      of '<': dataPtr.dec()
      of '+': data[dataPtr].inc()
      of '-': data[dataPtr].dec()
      of '.': data[dataPtr].char.write()
      of ',': data[dataPtr] = readChar().byte
      of '[':
        if data[dataPtr] == 0: codePtr = code.matchBrackets(codePtr, '[')
      of ']':
        if data[dataPtr] != 0: codePtr = code.matchBrackets(codePtr, ']')
      else: discard
    codePtr.inc()

let input = readFile("helloworld.txt")
interpret(input)
