NUM_MOM_ITEMS_2 EQUS "((MomItems_2.End - MomItems_2) / 8)"

MomTriesToBuySomething::
	ld a, [wMapReentryScriptQueueFlag]
	and a
	ret nz

	call GetMapPhoneService
	and a
	ret nz

	ld de, ENGINE_MOM_SAVING_MONEY
	ld b, CHECK_FLAG
	farcall EngineFlagAction
	ld a, c
	and a
	ret z ; Mom doesn't buy items if you don't send her money.

	ld a, [wSpecialPhoneCallID]
	and a
	ret nz ; We avoid overriding another important call. Can be in competition with SPECIALCALL_DAILY_EVENTS_RESET.
	
	call CheckBalance_MomItem2
	ret nc

	call Mom_GiveItemOrDoll
	ret nc

	ld b, BANK(.Script)
	ld de, .Script
	farcall LoadScriptBDE
	scf
	ret

.Script:
	callasm .ASMFunction
	farsjump Script_ReceivePhoneCall

.ASMFunction:
	call MomBuysItem_DeductFunds
	call Mom_GetScriptPointer
	ld hl, wWhichMomItem
	inc [hl]
	ld a, PHONE_MOM
	ld [wCurCaller], a
	ld bc, wCallerContact
	ld hl, PHONE_CONTACT_TRAINER_CLASS
	add hl, bc
	ld [hl], TRAINER_NONE
	inc hl
	ld [hl], PHONE_MOM
	ld hl, PHONE_CONTACT_SCRIPT2_BANK
	add hl, bc
	ld a, BANK(Mom_GetScriptPointer)
	ld [hli], a
	ld a, e
	ld [hli], a
	ld a, d
	ld [hl], a
	ret

CheckBalance_MomItem2:
	ld a, [wWhichMomItem]
	cp NUM_MOM_ITEMS_2
	jr nc, .nope

	call GetItemFromMom
	ld a, [hli]
	ldh [hMoneyTemp], a
	ld a, [hli]
	ldh [hMoneyTemp + 1], a
	ld a, [hli]
	ldh [hMoneyTemp + 2], a
	ld de, wMomsMoney
	ld bc, hMoneyTemp
	farcall CompareMoney
	jr nc, .have_enough_money

.nope
	xor a
	ret

.have_enough_money
	scf
	ret

MomBuysItem_DeductFunds:
	call GetItemFromMom
	ld de, 3 ; cost
	add hl, de
	ld a, [hli]
	ldh [hMoneyTemp], a
	ld a, [hli]
	ldh [hMoneyTemp + 1], a
	ld a, [hli]
	ldh [hMoneyTemp + 2], a
	ld de, wMomsMoney
	ld bc, hMoneyTemp
	farcall TakeMoney
	ret

Mom_GiveItemOrDoll:
	call GetItemFromMom
	ld de, 7 ; item ID.
	add hl, de
	ld a, [hl]
	ld [wCurItem], a
	ld a, 1
	ld [wItemQuantityChange], a
	ld hl, wNumPCItems
	call ReceiveItem
	ret

Mom_GetScriptPointer:
	call GetItemFromMom
	
	push hl
	ld de, 7 ; item ID.
	add hl, de
	ld a, [hl]
	ld [wNamedObjectIndex], a
	call GetItemName
	pop hl

	push hl
	ld de, 6 ; item type / item quantity.
	add hl, de
	ld a, [hl]
	ld [wStringBuffer2], a
	pop hl

	ld de, 3 ; item cost.
	add hl, de
	push hl
	ld de, wStringBuffer3
	ld bc, 3
	call CopyBytes
	pop hl

	;ld de, 3 ; item cost.
	;add hl, de
	ld de, .ShoppingDealScript
rept 3 ; Read the 3 bytes of the price.
	ld a, [hli]
	and a
	ret nz
endr
	; At this point, check if lockdowns and curfews have been lifted.
	ld b, CHECK_FLAG
	ld de, EVENT_MOM_CALLED_ABOUT_VACCINATION_PASS
	call EventFlagAction
	ld a, c
	and a
	jr z, .restrictions_apply

	ld de, .NeighborDonationAfterRestrictionsScript
	ret

.restrictions_apply
	ld de, .NeighborDonationDuringRestrictionsScript
	ret

.ShoppingDealScript:
	writetext MomHiHowAreYouText
	writetext MomFoundAnItemText
	writetext MomItsInPCText
	end

.NeighborDonationDuringRestrictionsScript:
	writetext MomHiHowAreYouText
	writetext MomReceivedItemFromNeighborText
	writetext MomWontNeedText
	writetext MomShippedText
	writetext MomItsInPCText
	end

.NeighborDonationAfterRestrictionsScript:
	writetext MomHiHowAreYouText
	writetext MomReceivedItemFromNeighborText
	writetext MomDontHaveAUseText
	writetext MomShippedText
	writetext MomItsInPCText
	end

GetItemFromMom:
	ld a, [wWhichMomItem]
	ld de, MomItems_2

	ld l, a
	ld h, 0
rept 3 ; multiply hl by 8
	add hl, hl
endr
	add hl, de
	ret

INCLUDE "data/items/mom_phone.asm"

MomHiHowAreYouText:
	text_far _MomHiHowAreYouText
	text_end

MomFoundAnItemText:
	text_far _MomFoundAnItemText
	text_end

MomItsInPCText:
	text_far _MomItsInPCText
	text_end

MomReceivedItemFromNeighborText:
	text_far _MomReceivedItemFromNeighborText
	text_end

MomWontNeedText:
	text_far _MomWontNeedText
	text_end

MomDontHaveAUseText:
	text_far _MomDontHaveAUseText
	text_end

MomShippedText:
	text_far _MomShippedText
	text_end

DummyPredef3A:
	ret
