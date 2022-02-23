BITS 16

mov [BOOT_DISK], dl
CODE_SEG equ GDT_Code - GDT_Start
DATA_SEG equ GDT_Data - GDT_Start

cli			; pauses all interrupts	
mov eax, cr0		
or eax, 1 
mov cr0, eax		; sets bit flag to allow protected mode to start 
lgdt[GDT_Desc]		; loads GDT
jmp CODE_SEG:start_protected_mode
jmp $

; -------------
; GDT table definition

GDT_Start:
	GDT_Null:
		dd 0
		dd 0
	GDT_Code:
		dw 0xffff
		dw 0
		db 0
		db 10011010
		db 11001111
		db 0
	GDT_Data:
		dw 0xffff
		dw 0
		db 0
		db 10010010
		db 11001111
		db 0
GDT_End:

GDT_Desc:
	dw GDT_End - GDT_Start - 1
	dd GDT_Start
;--------------


BITS 32
start_protected_mode:
	; video mem 0xb8000
	; BEN YOU FORGOT TO SET THE REGISTERS WHAT ARE YOU DOING
	; NOW YOU CANT EVEN REMEMBER WHICH REGISTERS NEED TO BE SET
	mov eax, 0
	mov sp, eax
	mov bp, eax
	mov si, eax
	

	mov al, 'A'
	mov ah, 0x0f
	mov [0xb8000], ax
	jmp $

BOOT_DISK:
	db 0

times 510-($-$$) db 0
dw 0xaa55
