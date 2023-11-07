CheckCoordEventType::
	ld a, d
	and $f ; We mask to keep the Coord Event Type.

	; Faster than a jumptable, but uglier.
	cp CE_ALWAYS
	jr z, .return_true

	cp CE_EVENT_FLAG_SET
	jr z, .ce_event_set
	
	cp CE_EVENT_FLAG_CLEARED
	jr z, .ce_event_cleared

	cp CE_SCENE_ID
	jr z, .ce_scene_id

	cp CE_GOT_ITEM
	jr z, .ce_got_item

	jr .return_no_event ; Unmanaged cases are dumped.

.ce_event_set
	ld b, TRUE
	push bc
	jr .ce_event

.ce_event_cleared
	ld b, FALSE
	push bc
.ce_event
	swap d
	ld a, d
	and $f
	ld d, a
	; E is already set.
	; DE now contains the event flag to check.
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	and a
	jr z, .binary_result

	ld a, TRUE
.binary_result
	pop bc
	cp b
	jr z, .return_true
	jr .return_no_event

.ce_scene_id
	call CheckScenes
	cp e
	jr z, .return_true
	jr .return_no_event

.ce_got_item
	ld a, e
	ld [wCurItem], a
	ld hl, wNumItems
	call CheckItem
	jr c, .return_true
	jr .return_no_event

.return_true
	scf
	ret

.return_no_event
	xor a
	ret
