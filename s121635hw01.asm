TITLE Assem HW01 

; This program calculate some expression

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword
INCLUDE Irvine32.inc

.data
	INCLUDE PHW01.inc
	; declare variables here
.code
main proc

	mov ecx, Val1	; ecx = Val1 * 1
	add ecx, ecx	; ecx = Val1 * 2
	add ecx, ecx	; ecx = Val1 * 4
	add ecx, ecx	; ecx = Val1 * 8
	mov eax, ecx	; eax = 8 * Val1
	add ecx, ecx	; ecx = Val * 16
	add eax, ecx	; eax = 8*Val1 + 16*Val1
	add ecx, ecx	; ecx = Val1 * 32
	mov ebx, ecx	; ebx = 32*Val1

	mov ecx, Val1
	sub ecx, Val4	; ecx = Val1 - Val4
	mov edx, Val1
	sub edx, Val4	; edx = Val1 - Val4 (temp)

	add ecx, ecx	; ecx = (Val1 - Val4) * 2
	add ecx, ecx	; ecx = (Val1 - Val4) * 4
	add ecx, ecx	; ecx = (Val1 - Val4) * 8
	add ecx, ecx	; ecx = (Val1 - Val4) * 16
	add ecx, ecx	; ecx = (Val1 - Val4) * 32
	sub ecx, edx	; ecx = (Val1 - Val4) * 31
	sub eax, ecx	; eax = 24*Val1 - 31*(Val1-Val4)
	add ebx, ecx	; ebx = 32*Val1 + 31*(Val1-Val4)

	mov ecx, Val3
	sub ecx, Val2	; ecx = Val3 - Val2
	mov edx, Val3
	sub edx, Val2	; edx = Val3 - Val2 (temp)

	add ecx, ecx	; ecx = (Val3 - Val2) * 2
	add ecx, ecx	; ecx = (Val3 - Val2) * 4
	add ecx, ecx	; ecx = (Val3 - Val2) * 8
	add ecx, ecx	; ecx = (Val3 - Val2) * 16

	add ecx, edx	; ecx = (Val3 - Val2) * 17
	sub eax, ecx	; eax = 24*Val1 - 31*(Val1-Val4 ) - 17*(Val3 - Val2)	

	sub ecx, edx	; ecx = (Val3 - Val2) * 16
	sub ecx, edx	; ecx = (Val3 - Val2) * 15
	add ebx, ecx	; ebx = 32*Val1 - 31*(Val1-Val4 ) + 15*(Val3 - Val2)
		
	call	DumpRegs
	; write your code here

	invoke ExitProcess,0
main endp
end main