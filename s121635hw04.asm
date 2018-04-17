TITLE Assem HW02

; This program calculate some expression

; Program Description : Conver six decimal to ten decimal
; Author : 20121635 JangJongSeok
; Creation Date: 2017.05.26
; Revisions:
; Date: 2017.05.26
; Modifyed by : 


INCLUDE Irvine32.inc

.data

	prompt1		BYTE "Enter a radix 6 number (<= 9 digits) : " ,0
	prompt2		BYTE " ERROR: The input is not a radix-6 number." ,0
	prompt3		BYTE " ERROR: The string size must be less than or equal to 9." ,0
	prompt4		BYTE "Enter y to repeat(otherwise enter anything) : " ,0
	prompt5		BYTE "Bye!", 0
	flag		BYTE ?

	buffer		BYTE 20 DUP(?)
	mulnum		DWORD 20 DUP(?)
	byteCount	DWORD ?
	result		DWORD ?
		
.code
main PROC

mov mulnum[0] , 10077696
mov mulnum[4] , 1679616
mov mulnum[8] , 279936 
mov mulnum[12] , 46656
mov mulnum[16] , 7776
mov mulnum[20] , 1296
mov mulnum[24] , 216
mov mulnum[28] , 36
mov mulnum[32] , 6
mov mulnum[36] , 1

L1:

	; print prompt1
	mov result, 0
	mov edx, OFFSET prompt1	
	call WriteString

	; scanf ridix - 6
	mov edx, OFFSET buffer
	mov ecx, SIZEOF buffer
	call ReadString
	mov byteCount, eax

	; compare byteCount >= 10
	mov eax, byteCount
	cmp eax, 10
	jae ERROR1

	; compare byteCount == 0
	mov eax, byteCount
	cmp eax, 0
	je	L1

	; check radix-6 numbr
	mov ecx, byteCount
	mov esi, OFFSET buffer

CHECK:
	mov edx, 48		; compare [esi] < 0
	mov al, [esi]
	cmp eax, edx
	jb	ERROR2
	mov edx, 53		; compare [esi] > 5
	cmp eax, edx
	ja	ERROR2
	inc esi
	loop CHECK


	; Calculate
	mov ecx, byteCount
	mov esi, OFFSET buffer

CALCULATE:
	
	push ecx

	mov eax, 0		; initalize
	mov al, [esi]	

	mov edx, ecx	; calculeate index
	add edx, ecx
	add edx, edx
	mov edi, 40		
	sub edi, edx

	mov ecx, eax
	sub ecx, 48		; ecx = val(eax) - '0'

	mov ebx, 0		; initalize

	cmp ecx, 0
	je SAVE
CAL:	
	add ebx, mulnum[edi]
	loop CAL

SAVE:
	add result, ebx		

	pop ecx
	inc esi
	loop CALCULATE

	
	mov eax, result
	call WriteDec
	call crlf

	jmp BYE_CHECK


ERROR1: 

	; print ERROR1
	mov edx, OFFSET prompt3	
	call WriteString
	call crlf
	jmp L1

ERROR2:

	; print ERROR1
	mov edx, OFFSET prompt2	
	call WriteString
	call crlf
	jmp L1


BYE_CHECK: 
	mov edx, OFFSET prompt4	
	call WriteString
	
	call ReadChar
	mov flag, al

	call WriteChar
	call crlf
	
	cmp flag, 121
	je	L1

	cmp flag, 110
	je BYE

	cmp flag, 0
	je BYE

BYE:
	mov edx, OFFSET prompt5
	call WriteString
	call crlf
	exit

main ENDP
END main