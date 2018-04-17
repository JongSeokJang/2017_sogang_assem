TITLE Assem HW02

; This program Print line some element normal other element convert

; Program Description : print normal or convert
; Author : 20121635 JangJongSeok
; Creation Date: 2017.06.03
; Revisions:
; Date: 2017.06.03
; Modifyed by : 


INCLUDE Irvine32.inc

.data

	prompt1		BYTE "Enter a string : " ,0
	prompt5		BYTE "Bye!" ,0

	buffer1		BYTE 42 DUP(?)
	buffer2		BYTE 42 DUP(?)
	bufferSize	DWORD 42 DUP(0)		

	byteCount	DWORD ?
	count		DWORD 0
	checkCount	BYTE 0
	index		DWORD ?

	data_flag	BYTE 0
	blank_flag	BYTE 0

		
.code
main PROC

L1:
	mov count, 0
	mov byteCount, 0
	mov data_flag, 0
	mov blank_flag, 0

	mov ecx, 43
init:
	mov edx, ecx
	dec edx
	mov bufferSize[edx*4], 0
	mov buffer2[edx], 0
	loop init



	mov edx, OFFSET prompt1	
	call WriteString
	call Crlf

	mov edx, OFFSET buffer1
	mov ecx, SIZEOF buffer1
	call ReadString
	mov byteCount, eax
	
	; compare byteCount >= 40
	cmp al, 29h
	jae L1

	; compare byteCount == 0
	cmp eax, 0
	je	BYE


	mov ecx, byteCount
	mov edx, OFFSET buffer1
	mov esi, 0	; element's count
	mov edi, 0	; index

;calculate  blank, element;s count 
ELEMENT_COUNT:
	
	mov eax, 20h
	cmp [edx], al	; if( [edx] == blnak )
	jne ELEMENT_DATA

	ELEMENT_BLANK:
		mov data_flag, 1

		cmp blank_flag, 0	; if( blank_flag == 0)
		je ALREADY_START	; blank_flag == 0 -> next element counting

		mov blank_flag, 0
		ADD edi, 4
		inc count
		mov bufferSize[edi], 0

		ALREADY_START:

			mov esi, bufferSize[edi]
			inc esi	
			mov bufferSize[edi], esi

			jmp NEXT_ELEMENT
			
	ELEMENT_DATA:
		mov blank_flag, 1

		cmp data_flag , 0
		je ALREADY_START2	; blank_flag == 0 -> next element counting

		mov data_flag, 0
		ADD edi, 4
		inc count
		mov bufferSize[edi], 0

		ALREADY_START2:

			mov esi, bufferSize[edi]
			inc esi	
			mov bufferSize[edi], esi

			jmp NEXT_ELEMENT

NEXT_ELEMENT:
	inc edx
	loop ELEMENT_COUNT


;init
mov ecx, count
inc ecx

mov checkCount, 0
mov esi, 0
mov edi, 0
mov ebx, 0
mov edx, 0

; print
LOOP1:
	push ecx

	mov ecx, 4
	mov al, checkCount
	div cl
	
	mov ecx, bufferSize[esi]
	cmp ah, 02h
	mov index, ebx
	je CONVERT
	cmp ah, 03h
	je CONVERT

SUB_LOOP: ; print normal

	mov dl, buffer1[ebx]
	mov buffer2[edi], dl

	inc edi
	inc ebx
	loop SUB_LOOP
	jmp next


CONVERT:  ; print convert
	mov eax, index
	add eax, ecx
	dec eax
	mov dl, buffer1[eax]
	mov buffer2[edi], dl

	inc edi
	inc ebx
	loop CONVERT

next:
	pop ecx
	add esi ,4
	inc checkCount

	loop LOOP1


mov edx, OFFSET buffer2
call WriteString
call crlf
jmp L1

BYE:
	mov edx, OFFSET prompt5
	call WriteString
	call crlf
	exit

main ENDP
END main