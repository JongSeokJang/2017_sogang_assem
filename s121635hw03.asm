TITLE Assem HW02

; This program calculate some expression

;.386
;.model flat,stdcall
;.stack 4096
;ExitProcess proto,dwExitCode:dword

; Program Description : Print Fibonacci Numbr
; Author : 20121635 JangJongSeok
; Creation Date: 2017.05.20
; Revisions:
; Date: 2017.05.20
; Modifyed by : 


INCLUDE Irvine32.inc

.data

	blank		BYTE " ",0
	prompt1		BYTE "Enter N (3<= N <= 47) : ",0 
	fib_num		DWORD 50 dup(0)
	fib_size	DWORD 0
	
.code
main PROC

	;print (Enter N prompt)
	mov edx, OFFSET prompt1	
	call WriteString
	call ReadDec

	;(for Fibonacci_num, store fib_size to ecx)
	mov ecx, eax			
	mov fib_size, ecx
	inc fib_size

	;(init fib_num(0) = 0, fib_num (1) = 1)
	mov fib_num[0], 0
	mov fib_num[4], 1

	;(Fibbonacci_Num call)
	mov eax, OFFSET fib_num
	call Fibonacci_Num

	;(To print array setting loop counter)
	mov ecx, fib_size
	mov esi, 0
L2:
	;(print FiboNumber)
	mov eax, fib_num[esi]
	add esi, 4
	call WriteDec

	;(print blank " ")
	mov edx, OFFSET blank
	call writeString

	loop L2

	call crlf
	exit

main ENDP

Fibonacci_Num PROC
	;(using Fino(2)'s address sett esi = 8, because 32bit)
	mov esi, 8
	sub ecx, 1

L1:
	mov ebx, fib_num[esi-8] ; fib[n-2]
	mov edx, fib_num[esi-4] ; fib[n-1]

	add ebx, edx
	mov fib_num[esi], ebx	; fib[n] = fib[n-2] + fib[n-1]
	add esi, 4
	loop L1

	ret 

Fibonacci_Num ENDP
END main