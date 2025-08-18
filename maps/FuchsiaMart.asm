	object_const_def
	const FUCHSIAMART_CLERK
	const FUCHSIAMART_VP_CONTROLLER
	const FUCHSIAMART_FISHER
	const FUCHSIAMART_COOLTRAINER_F

FuchsiaMart_MapScripts:
	def_scene_scripts
	scene_script .VaccinePassport ; SCENE_ALWAYS

	def_callbacks

.VaccinePassport:
	jumpstd VaccinePassCheckpoint

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
if DEF(_FR_FR)
	text "Je voulais acheter"
	line "des souvenirs au"

	para "PARC SAFARI mais"
	line "c'est fermé..."
else
	text "I was hoping to"
	line "buy some SAFARI"

	para "ZONE souvenirs,"
	line "but it's closed…"
endc

	done

FuchsiaMartFisherText2:
if DEF(_FR_FR)
	text "Waouh! C'est toi"
	line "qui a racheté le"
	cont "PARC SAFARI!"

	para "Merci beaucoup de"
	line "l'avoir rouvert!"
else
	text "Wow! You're the new"
	line "SAFARI ZONE owner!"

	para "Thank you so much"
	line "for re-opening it!"
endc
	done

FuchsiaMartCooltrainerFText: 
if DEF(_FR_FR)
	text "La petite-fille du"
	line "GARDIEN du PARC"
	cont "SAFARI vit en"
	cont "ville."
else
	text "The SAFARI ZONE"
	line "WARDEN's grand-"
	cont "daughter lives in"
	cont "town."
endc

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
	object_event  5,  7, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VaccinePassportController, -1 ; Should always be at the second spot in the list.
	object_event  3,  2, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, FuchsiaMartFisherScript, -1
	object_event  5,  1, SPRITE_SHINE, SPRITEMOVEDATA_SHINE, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, FuchsiaMartShelfItem1Script, EVENT_MART_FUCHSIA_MISSED
