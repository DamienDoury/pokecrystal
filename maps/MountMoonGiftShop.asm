	object_const_def
	const MOUNTMOONGIFTSHOP_GRAMPS1 ; morning only
	const MOUNTMOONGIFTSHOP_VP_CONTROLLER
	const MOUNTMOONGIFTSHOP_GRAMPS2 ; day only
	const MOUNTMOONGIFTSHOP_LASS1 ; morning only
	const MOUNTMOONGIFTSHOP_LASS2 ; day only

MountMoonGiftShop_MapScripts:
	def_scene_scripts
	scene_script .VaccinePassport ; SCENE_ALWAYS

	def_callbacks

.VaccinePassport:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_6
	iftrue .end

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_6

	checktime NITE
	iftrue .end

	jumpstd VaccinePassCheckpoint
.end
	end

MountMoonGiftShopClerkScript:
	faceplayer
	opentext
	pokemart MARTTYPE_STANDARD, MART_MT_MOON
	closetext
	end

MountMoonGiftShopLassScript:
	jumptextfaceplayer MountMoonGiftShopLassText

MountMoonGiftShopShelfItem1Script:
	shelfitem 1, SCOPE_LENS, 4900

MountMoonGiftShopShelfItem2Script:
	shelfitem 1, METAL_COAT, 4900

MountMoonGiftShopShelfItem3Script:
	shelfitem 3, MAX_ELIXER, 13500

MountMoonGiftShopLassText: ; AUTOTRAD
	text "When the sun goes"
	line "down, CLEFAIRY"
	cont "come out to play."
	done

MountMoonGiftShop_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, MOUNT_MOON_SQUARE, 3
	warp_event  4,  7, MOUNT_MOON_SQUARE, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, MORN, 0, OBJECTTYPE_SCRIPT, 0, MountMoonGiftShopClerkScript, -1
	object_event  5,  7, SPRITE_GRANNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_LOCKDOWN & HIDE_CURFEW, %11100000 | MORN | DAY, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, VaccinePassportController, -1 ; Should always be at the second spot in the list.
	object_event  1,  2, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, DAY, 0, OBJECTTYPE_SCRIPT, 0, MountMoonGiftShopClerkScript, -1
	object_event  1,  6, SPRITE_LASS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, MORN, 0, OBJECTTYPE_SCRIPT, 0, MountMoonGiftShopLassScript, -1
	object_event  5,  4, SPRITE_LASS, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, DAY, 0, OBJECTTYPE_SCRIPT, 0, MountMoonGiftShopLassScript, -1
	object_event  1,  4, SPRITE_SHINE, SPRITEMOVEDATA_SHINE, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MountMoonGiftShopShelfItem1Script, EVENT_MART_MTMOON_1_MISSED
	object_event  0,  5, SPRITE_SHINE, SPRITEMOVEDATA_SHINE, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MountMoonGiftShopShelfItem2Script, EVENT_MART_MTMOON_2_MISSED
	object_event  6,  4, SPRITE_SHINE, SPRITEMOVEDATA_SHINE, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MountMoonGiftShopShelfItem3Script, EVENT_MART_MTMOON_3_MISSED
