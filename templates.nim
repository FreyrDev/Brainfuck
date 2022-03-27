template `..\`*[T](a,b: T): T =
  countdown(a, b, 1)

template write*(a: varargs[string, `$`]) =
  stdout.write(a)

template writeLine*(a: varargs[string, `$`]) =
  stdout.writeLine(a)

template readLine*(): string =
  stdin.readLine()

template readChar*(): char =
  stdin.readChar()

template newLine*(a: int = 0) =
  for i in 0..a: echo()