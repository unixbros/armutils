LDFLAGS = --entry _start -nostdlib -static
ASFLAGS = -g

echo: echo.s
cat: cat.s
