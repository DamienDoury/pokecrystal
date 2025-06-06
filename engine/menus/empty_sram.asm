EmptyAllSRAMBanks:
	ld a, 0
	call .EmptyBank
	ld a, 1
	call .EmptyBank
	ld a, 2
	call .EmptyBank
	ld a, 3
	; fallthrough.

.EmptyBank:
	call OpenSRAM
	ld hl, SRAM_Begin
	ld bc, SRAM_End - SRAM_Begin
	xor a
	call ByteFill
	jmp CloseSRAM
