include templates


var 
  data = newSeq[byte](30000)
  dataPtr = 0
  codePtr = 0


proc interpret(code: string) =
  while dataPtr >= 0 and codePtr < code.len():
    case code[codePtr]:
      of '>': dataPtr.inc()
      of '<': dataPtr.dec()
      of '+': data[dataPtr].inc()
      of '-': data[dataPtr].dec()
      of '.': data[dataPtr].char.write()
      of ',': data[dataPtr] = readChar().byte
      else: discard
    codePtr.inc()

let input = readLine()
interpret(input)