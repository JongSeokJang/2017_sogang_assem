TITLE Assem HW02

; This program calculate some expression

;.386
;.model flat,stdcall
;.stack 4096
;ExitProcess proto,dwExitCode:dword

; Program Description : Make password and write the password to file
; Author : 20121635 JangJongSeok
; Creation Date: 2017.05.13
; Revisions:
; Date: 2017.05.13
; Modifyed by : 


INCLUDE Irvine32.inc
.data
	
	PWD			BYTE 35 DUP(?)
	buf_sz		DWORD 1	DUP(?)
	prompt1		BYTE "Enter the number of passwords to create<<= 255> :",0
	prompt2		BYTE "Enter the password size<<= 32> :",0
	prompt3		BYTE "Generated!", 13, 10, 0
	filename	BYTE "s121635hw02.txt",0

.code
main proc

	; file open
	mov edx, OFFSET filename
	call CreateOutputFile
	mov ebx, eax 

	; total num of password
	mov edx, OFFSET prompt1
	call WriteString
	call ReadDec
	mov ecx, eax 
	
	; lengh of password
	mov edx, OFFSET prompt2
	call WriteString
	call ReadDec
	mov buf_sz, eax
	
	; set CR, LF, 0
	mov PWD[eax], 13
	mov PWD[eax+1], 10
	mov PWD[eax+2], 0

L1:	
	push ecx	;	store total number of password Loop 1

	mov ecx, buf_sz		; set length of password for Loop 2
	mov esi, 0			; set esi

L2 : 
	; make random value (ACSII_CODE 65 ~91)
	mov eax, 26
	call RandomRange		
	add eax, 65

	; store random value's element to PWD BUFFER
	mov PWD[esi], al
	inc esi

	LOOP L2
	
	; Write to FILE
	mov eax, ebx
	mov edx, OFFSET PWD
	mov ecx, buf_sz
	add ecx, 2
	call WriteToFile

	; set total number of password for Loop 1
	pop ecx
	LOOP L1

	; File Close
	mov eax, ebx
	call CloseFile

	; print (Generated!)
	mov edx, OFFSET prompt3
	call WriteString
	exit

main endp
	; (insert additional procedures here)
end main