Basic integer calculator implemented in assembly MIPS that stores the last 3 operations in memory.

Operations:
    - 1 Addition
    - 2 Subtraction
    - 3 Division
    - 4 Multiplication
    - 5 Potentiation
    - 6 Square Root
    - 7 Multiplication Table
    - 8 Factorial
    - 9 Fibonacci sequence

Casos de Testes:

0.  in: M
        M1
        "ERRO! Essa memória está vazia"

1.  in:  C
         1
         40
         65
    out: 105

2.  in:  C
         2
         40
         65
    out: -25

3.  in:  C
         1
         65
         12
    out: 5

4.  in:  C
         4
         40
         65
    out: 2600

5.  in:  C
         5
         5
         10
    out: 9765625

6.  in:  C
         6
         203
    out: 14

7.  in:  C
         7
         13
    out: 13 X 1  = 13
         13 X 2  = 26
         13 X 3  = 39
         13 X 4  = 52
         13 X 5  = 65 
         13 X 6  = 78
         13 X 7  = 91
         13 X 8  = 104
         13 X 9  = 117
         13 X 10 = 130

8.  in:  C
         8
         4
    out: 24


9.  in:  C
         9
         10
    out: 1 1 2 3 5 8 13 21 34 55

10. in: M
        M1
    out: (resultado da última operação)

11. in: M
        M2
    out: (resultado da penúltima operação)

12. in: M
        M3
    out: (resultado da antipenúltima operação)