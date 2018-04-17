TITLE Assem HW02

; This program Convert dec to radix number

; Program Description : Convert to dec to radix number
; Author : 20121635 JangJongSeok
; Creation Date: 2017.06.04
; Revisions:
; Date: 2017.06.04
; Modifyed by : 


INCLUDE Irvine32.inc

.data

	prompt1		BYTE "Enter a decimal number N (0<= N <= 640000) : " ,0
	prompt2		BYTE "Enter the radix R to convert (2<= R <= 10) : " ,0
	prompt3		BYTE "Again(y/n)? " ,0
	prompt4		BYTE "Number too big! Re-enter N : " ,0
	prompt5		BYTE "Wrong radix! Re-enter R : ", 0
	
	flag		BYTE ?
	DNum		DWORD ?
	Radix		DWORD ?
	Convert		BYTE 40 DUP(?)
			
.code
main proc

L1:

	mov ecx, 41
init:
	mov edx, ecx
	dec edx
	mov Convert[edx], 0
	loop init

	mov edx, OFFSET prompt1
	call WriteString

DNUM_INPUT:
	call ReadDec
	mov DNum, eax

	cmp DNum, 640000
	jbe	RADIX_INPUT
		
	mov edx, OFFSET prompt4
	call WriteString
	jmp DNUM_INPUT

		RADIX_INPUT : 
			mov edx, OFFSET prompt2
			call WriteString
		RE_RADIX_INPUT:
			call ReadDec
			mov Radix, eax

			cmp Radix, 10
			ja ERROR1
			cmp Radix, 2
			jae GO_CONVERT

			ERROR1:
				mov edx, OFFSET prompt5
				call WriteString
				jmp RE_RADIX_INPUT

	GO_CONVERT:
		mov eax, DNum
		mov ebx, Radix
		call Convert_Num

	mov edx, OFFSET Convert
	call WriteString
	call crlf

BYE_CHECK:
	mov edx, OFFSET prompt3	
	call WriteString

	call ReadChar
	mov flag, al

	call WriteChar
	call crlf

	cmp flag, 121
	je	L1

	exit

main endp
Convert_Num PROC
	mov esi, 0
	mov ecx, ebx
	
	;convert decimal to radix
CON_L1:
	mov edx, 0
	cmp eax, ebx
	jb CON_L2
	div ecx

	mov Convert[esi], dl
	inc esi
	jmp CON_L1

CON_L2:
	mov Convert[esi], al

	mov ecx, esi
	inc ecx


	; using stack, exchange from front to end
CON_PUSH:
	mov ebx, ecx
	dec ebx
	mov al, Convert[ebx]
	push eax
	loop CON_PUSH


	mov ecx, esi
	inc ecx

CON_POP:
	mov ebx, ecx
	dec ebx
	pop eax
	Add eax, 30h
	mov Convert[ebx], al
	loop CON_POP


ret

Convert_Num ENDP
	; (insert additional procedures here)
end main