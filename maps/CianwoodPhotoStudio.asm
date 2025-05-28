	object_const_def
	const CIANWOODPHOTOSTUDIO_FISHING_GURU

CianwoodPhotoStudio_MapScripts:
	def_scene_scripts

	def_callbacks

CianwoodPhotoStudioFishingGuruScript:
	faceplayer
	opentext
	writetext CianwoodPhotoStudioFishingGuruText_Question
	yesorno
	iffalse .Refused
	writetext CianwoodPhotoStudioFishingGuruText_Yes
	waitbutton
	special PhotoStudio
	waitbutton
	closetext
	end

.Refused:
	writetext CianwoodPhotoStudioFishingGuruText_No
	waitbutton
	closetext
	end

CianwoodPhotoStudioFishingGuruText_Question: 
if DEF(_FR_FR)
	text "Mais dis-moi toi,"
	line "ils sont choux tes"
	cont "#MON."

	para "Ca te dirait une"
	line "petite photo en"
	cont "souvenir?"
else
	text "You have magnifi-"
	line "cent #MON with"
	cont "you."

	para "How about a photo"
	line "for a souvenir?"
endc

	done

CianwoodPhotoStudioFishingGuruText_Yes: 
if DEF(_FR_FR)
	text "Attention le petit"
	line "oiseau va sortir!"
	cont "Cui-cui!!!"
else
	text "OK! Big smile now!"
endc

	done

CianwoodPhotoStudioFishingGuruText_No: 
if DEF(_FR_FR)
	text "Oh! Pas terrible,"
	line "terrible. Je pen-"

	para "sais que ça ferait"
	line "quelque chose de"
	cont "plus... Enfin de"
	cont "moins..."
else
	text "Oh, that's too"
	line "bad. I thought it"

	para "would be a great"
	line "memento…"
endc

	done

CianwoodPhotoStudio_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, CIANWOOD_CITY, 5
	warp_event  3,  7, CIANWOOD_CITY, 5

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CianwoodPhotoStudioFishingGuruScript, -1
