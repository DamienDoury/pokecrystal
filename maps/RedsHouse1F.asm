	object_const_def
	const REDSHOUSE1F_REDS_MOM
	const REDSHOUSE1F_REDS_MOM_PIKACHU

RedsHouse1F_MapScripts:
	def_scene_scripts
	scene_script .DummyScene

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .RedsMomSetupCallback

.DummyScene:
	end

.RedsMomSetupCallback:
	disappear REDSHOUSE1F_REDS_MOM
	checkevent EVENT_REDS_PIKACHU_AVAILABLE
	iffalse .end
	appear REDSHOUSE1F_REDS_MOM
.end:
	endcallback

RedsMom:
	jumptextfaceplayer RedsMomText1

RedsMomPikachu:
	jumptextfaceplayer RedsMomSawPikachuText

RedsHouse1FTV:
	jumptext RedsHouse1FTVText

RedsHouse1FBookshelf:
	jumpstd PictureBookshelfScript

RedsMomText1:
	text "Hi!"

	para "RED's been away"
	line "for a long time."

	para "He hasn't called"
	line "either, so I have"

	para "no idea where he"
	line "is or what he's"
	cont "been doing."

	para "They say that no"
	line "word is proof that"

	para "he's doing fine,"
	line "but I do worry"
	cont "he could get hurt"
	cont "or sick."
	done

RedsMomSawPikachuText:
	text "My son's PIKACHU"
	line "came back home."

	para "He looks sick,"
	line "I'm afraid to"
	cont "touch him."
	done

RedsHouse1FTVText:
	text "They have programs"
	line "that aren't shown"
	cont "in JOHTO…"
	done

RedsHouse1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, PALLET_TOWN, 1
	warp_event  3,  7, PALLET_TOWN, 1
	warp_event  7,  0, REDS_HOUSE_2F, 1

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, RedsHouse1FBookshelf
	bg_event  1,  1, BGEVENT_READ, RedsHouse1FBookshelf
	bg_event  2,  1, BGEVENT_READ, RedsHouse1FTV

	def_object_events
	object_event  5,  3, SPRITE_REDS_MOM, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RedsMom, 0
	object_event  7,  2, SPRITE_REDS_MOM, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, RedsMomPikachu, EVENT_REDS_PIKACHU_AVAILABLE
