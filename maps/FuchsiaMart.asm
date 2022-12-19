	object_const_def
	const FUCHSIAMART_CLERK
	const FUCHSIAMART_FISHER
	const FUCHSIAMART_COOLTRAINER_F

FuchsiaMart_MapScripts:
	def_scene_scripts

	def_callbacks

FuchsiaMartClerkScript:
	opentext
	pokemart MARTTYPE_STANDARD, MART_FUCHSIA
	closetext
	end

FuchsiaMartFisherScript:
	checkevent EVENT_BOUGHT_SAFARI_PARK
	iftrue .BoughtSafari

	jumptextfaceplayer FuchsiaMartFisherText

.BoughtSafari
	jumptextfaceplayer FuchsiaMartFisherText2

FuchsiaMartCooltrainerFScript:
	jumptextfaceplayer FuchsiaMartCooltrainerFText

FuchsiaMartShelfItem1Script:
	shelfitem 6, MOOMOO_MILK, 6000

FuchsiaMartFisherText:
	text "I was hoping to"
	line "buy some SAFARI"

	para "ZONE souvenirs,"
	line "but it's closed…"
	done

FuchsiaMartFisherText2:
	text "Wow! You're the new"
	line "SAFARI ZONE owner!"

	para "Thank you so much"
	line "for re-opening it!"
	done

FuchsiaMartCooltrainerFText:
	text "The SAFARI ZONE"
	line "WARDEN's grand-"
	cont "daughter lives in"
	cont "town."
	done

FuchsiaMart_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, FUCHSIA_CITY, 1
	warp_event  3,  7, FUCHSIA_CITY, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  1,  3, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaMartClerkScript, -1
	object_event  3,  2, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, FuchsiaMartFisherScript, -1
	object_event  5,  1, SPRITE_SHINE, SPRITEMOVEDATA_SHINE, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaMartShelfItem1Script, EVENT_MART_FUCHSIA_MISSED
