; HM moves can't be forgotten

IsHM::
	cp HM01
	jr c, .NotHM
	scf
	ret
.NotHM:
	and a
	ret

IsHMMove::
	ld hl, .HMMoves
	jmp IsInByteArray

.HMMoves:
	db CUT
	db FLY
	db SURF
	db STRENGTH
	db FLASH
	db WATERFALL
	db WHIRLPOOL
	db -1 ; end
