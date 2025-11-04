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
if DEF(_FR_FR)
	text "Salut!"

	para "RED est parti il"
	line "y a longtemps."

	para "Il n'a même pas"
	line "appelé... Je ne"

	para "sais vraiment pas"
	line "ce qu'il fait en"
	cont "ce moment."

	para "“Pas de nouvelles,"
	line "bonnes nouvelles”"
	cont "à ce qu'on dit."
	
	para "A vrai dire, je me"
	line "fais du souci."
else
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
endc
	done

RedsMomSawPikachuText:
if DEF(_FR_FR)
	text "Le PIKACHU de mon"
	line "fils est rentré."

	para "Il a l'air malade,"
	line "j'ai peur de le"
	cont "toucher."
else
	text "My son's PIKACHU"
	line "came back home."

	para "He looks sick,"
	line "I'm afraid to"
	cont "touch him."
endc
	done

RedsHouse1FTVText: 
if DEF(_FR_FR)
	text "Il y a des émis-"
	line "sions qui ne pas-"
	cont "sent pas à JOHTO."
else
	text "They have programs"
	line "that aren't shown"
	cont "in JOHTO…"
endc

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
