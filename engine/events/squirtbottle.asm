_Squirtbottle:
	ld hl, .SquirtbottleScript

	call QueueScript
	ld a, [wUsingItemWithSelect]
	and a
	jr z, .skip_screen_refresh

	call RefreshScreen
.skip_screen_refresh
	ld a, $1
	ld [wItemEffectSucceeded], a
	ret

.SquirtbottleScript:
	reloadmappart
	special UpdateTimePals

	callasm GetSquirtbottleTarget
	iffalse .SquirtbottleNothingScript
	ifequal 2, .Sudowoodo

; Fruit tree.
	farsjump SquirtbottleOnFruitTreeScript

.Sudowoodo:
	farsjump WateredWeirdTreeScript

.SquirtbottleNothingScript:
	opentext
	farwritetext _SquirtbottleUseText
	promptbutton
	farwritetext _SquirtbottleNothingText
	waitbutton
	closetext
	end

GetSquirtbottleTarget::
	farcall GetFacingObject
	jr c, .nope

	ld a, [wMapGroup]
	cp GROUP_ROUTE_36
	jr nz, .check_fruit_tree

	ld a, [wMapNumber]
	cp MAP_ROUTE_36
	jr nz, .check_fruit_tree

	ld a, d
	cp SPRITEMOVEDATA_SUDOWOODO
	jr nz, .check_fruit_tree

	; Is the real Sudowoodo.
	xor a ; Resets the carry.
	ld a, 2
	ld [wScriptVar], a
	ret

.check_fruit_tree
	ld hl, MAPOBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	cp SPRITE_FRUIT_TREE
	jr nz, .nope

	ld hl, MAPOBJECT_SCRIPT_POINTER
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a

	call GetMapScriptsBank
	call GetFarWord

	ld a, l
	cp fruittree_command
	jr nz, .nope

	; At this point, the object we are facing has the sprite and the script of a fruit tree.
	; That's enough to determine that it is a real fruit tree.

	ld a, h
	ld [wCurFruitTree], a

	xor a ; Resets the carry.
	ld a, 1
	ld [wScriptVar], a
	ret

.nope
	xor a
	ld [wScriptVar], a
	ret
