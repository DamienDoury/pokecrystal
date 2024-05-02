LoadSquirtbottleGFX:
	ld a, [wVirtualOAMSprite04Attributes]
	and $fc
	or PAL_OW_SILVER
	ld [wVirtualOAMSprite04Attributes], a

	ldh a, [rVBK]
	push af
	ld a, $1
	ldh [rVBK], a

	ld de, SquirtbottleGFX
	ld a, [wPlayerGender]
	bit PLAYERGENDER_FEMALE_F, a
	jr z, .got_gender
	ld de, KrisSquirtbottleGFX
.got_gender

	ld hl, vTiles0 tile $00
	call .LoadGFX

	ld c, EMOTE_SPRINKLE_1
	farcall LoadEmote

	pop af
	ldh [rVBK], a
	ret

.LoadGFX:
	lb bc, BANK(SquirtbottleGFX), 12
	push de
	call Get2bpp
	pop de
	ld hl, 12 tiles
	add hl, de
	ld d, h
	ld e, l
	ret

SquirtbottleGFX:
INCBIN "gfx/overworld/chris_squirtbottle.2bpp"

KrisSquirtbottleGFX:
INCBIN "gfx/overworld/kris_squirtbottle.2bpp"
