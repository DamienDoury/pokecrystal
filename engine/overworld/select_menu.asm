UseRegisteredItem::
	farcall CheckItemMenu
	farcall LoadOW_BGPal7
	ld a, 1
	ld [wUsingItemWithSelect], a
	call DoItemEffect
	xor a
	ld [wUsingItemWithSelect], a
	ld a, [wItemEffectSucceeded]
	cp 1
	jr nz, .CantUse
	scf
	ld a, HMENURETURN_SCRIPT
	ldh [hMenuReturn], a
	ret

.CantUse:
	call RefreshScreen
	call CantUseItem
	call CloseText
	and a
	ret
