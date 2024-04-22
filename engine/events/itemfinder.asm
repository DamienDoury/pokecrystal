ItemFinder:
	farcall CheckForHiddenItems
	jr c, .found_something
	ld hl, .Script_FoundNothing
	jr .resume

.found_something
	ld hl, .Script_FoundSomething

.resume
	call QueueScript
	ld a, [wUsingItemWithSelect]
	and a
	jr z, .skip_screen_refresh

	call RefreshScreen
.skip_screen_refresh
	ld a, $1
	ld [wItemEffectSucceeded], a
	ret

.ItemfinderSound:
	ld a, [wItemFinderDistance]
	cp 2
	jr nc, .convert_distance_to_delay
	
	ld a, 1 ; Distances of 1 and 0 are set to 1. Because DelayFrames doesn't work properly with C=0.
.convert_distance_to_delay
	add a
	ld c, a
	add a
	add a
	add c
	inc a
	inc a
	ld [wItemFinderDistance], a ; Delay between beeps.
	ld de, SFX_SECOND_PART_OF_ITEMFINDER
	call PlaySFX
	ld de, SFX_TRANSACTION
	call WaitPlaySFX

	ld c, 2 ; Numbers of beeps after the first one.
.sfx_loop
	push bc
	ld a, [wItemFinderDistance]
	ld c, a
	call DelayFrames

	ld de, SFX_SECOND_PART_OF_ITEMFINDER
	call PlaySFX
	ld de, SFX_TRANSACTION
	call WaitPlaySFX
	pop bc
	dec c
	jr nz, .sfx_loop

	call WaitSFX
	ret

.Script_FoundSomething:
	reloadmappart
	special UpdateTimePals
	callasm .ItemfinderSound
	writetext .ItemfinderItemNearbyText
	closetext
	end

.Script_FoundNothing:
	reloadmappart
	special UpdateTimePals
	writetext .ItemfinderNopeText
	closetext
	end

.ItemfinderItemNearbyText:
	text_far _ItemfinderItemNearbyText
	text_end

.ItemfinderNopeText:
	text_far _ItemfinderNopeText
	text_end
