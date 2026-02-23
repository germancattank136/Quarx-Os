org 0x7C00
bits 16

%define ENDL 0x0D, 0x0A

;
; FAT12
;
jmp short start
nop

bdh_oem: 			db 'MSWIN.1'
bdh_bytes_per_sector: 		dw 512
bdh_sector_per_cluser:		db 1
bdh_reserved_sectors:		dw 1
bdh_fat_count:			db 2
bdh_dir_entries_count:		dw 0E0h
bdh_total_sectors:		dw 2880
bhd_media_descriptor_type:	db 0F0h
bdh_sectors_per_fat:		dw 9
bdh_sectors_per_track:		dw 18
bdh_heads:			dw 2
bdh_hidden_sectors:		dd 0

; extended boot sector

ebr_drive_number:		db 0
				db 0
ebr_signature:			db 29h
ebr_volume_id:			db 12h
ebr_volume_label:		db ' Cool  '
ebr_system_id:			db ' FAT12  '

;
; Code goes here
;

start:
	jmp main


;Printing strings

puts:
	;saves reg
	push si
	push ax

.loop:
	lodsb		;loads next char
	or al, al	;checks if the next character is null
	jz .done
	mov bh, 0
	mov ah, 0x0e ;calling bios interup
	int 0x10
	jmp .loop

.done:
	pop ax
	pop si
	pop bx
	ret

main:
	;setup data segments
	mov ax, 0 ;can't write directly to ds or es
	mov ds, ax
	mov es, ax

	;setup stack
	mov ss, ax
	mov sp, 0x7c00
	
	;print message
	mov si, msg_hello
	call puts


	hlt

.halt:
	jmp .halt

;
; Disk routines
;

;
; Converts an LBA address to a CHS address
;
lba_to_chs:
	
	xor dx, dx
	div word [bdh_sectors_per_track]	

	inc dx
	mov cx, dx

	xor dx, dx
	div word [bdb_heads]




msg_hello: db "Hello nerds", 0

times 510-($-$$) db 0
dw 0AA55h
