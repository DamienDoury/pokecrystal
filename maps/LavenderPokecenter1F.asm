	object_const_def
	const LAVENDERPOKECENTER1F_NURSE
	const LAVENDERPOKECENTER1F_GENTLEMAN
	const LAVENDERPOKECENTER1F_TEACHER
	const LAVENDERPOKECENTER1F_YOUNGSTER

LavenderPokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .LavenderPokecenter1F_AntiSoftLock

.LavenderPokecenter1F_AntiSoftLock:
	farsjump AntiSoftLockPokeball

LavenderPokecenter1FNurseScript:
	jumpstd PokecenterNurseScript

LavenderPokecenter1FGentlemanScript:
	jumptextfaceplayer LavenderPokecenter1FGentlemanText

LavenderPokecenter1FTeacherScript:
	jumptextfaceplayer LavenderPokecenter1FTeacherText

LavenderPokecenter1FYoungsterScript:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	writetext LavenderPokecenter1FYoungsterText
	waitbutton
	closetext
	end

.ReturnedMachinePart:
	writetext LavenderPokecenter1FYoungsterText_ReturnedMachinePart
	waitbutton
	closetext
	end

LavenderPokecenter1FGentlemanText: 
if DEF(_FR_FR)
	text "Au Nord de LAVAN-"
	line "VILLE se trouve la"

	para "GROTTE. Traverse-"
	line "la pour accéder"
	cont "à la CENTRALE."
else
	text "To the north of"
	line "LAVENDER is ROCK"

	para "TUNNEL. Go through"
	line "it to get to the"
	cont "POWER PLANT."
endc

	done

LavenderPokecenter1FTeacherText: 
if DEF(_FR_FR)
	text "Une émission de"
	line "radio diffuse des"
	cont "mélodies jouées à"
	cont "la # FLUTE."

	para "Oh? Il faut un"
	line "CPN EXPAN. à ta"
	cont "radio pour pouvoir"
	cont "l'écouter."
else
	text "There's a radio"
	line "program that plays"
	cont "# FLUTE music."

	para "Oh? Ah, your radio"
	line "needs an EXPN CARD"
	cont "to tune into it."
endc

	done

LavenderPokecenter1FYoungsterText: 
if DEF(_FR_FR)
	text "Si la CENTRALE ne"
	line "marche pas, le"

	para "TRAIN MAGNET ne"
	line "peut pas circuler."

	para "La STATION RADIO"
	line "ne peut rien"
	cont "émettre non plus."
else
	text "If the POWER PLANT"
	line "isn't running, the"

	para "MAGNET TRAIN won't"
	line "run either…"

	para "It also means the"
	line "RADIO STATION"
	cont "can't broadcast…"
endc

	done

LavenderPokecenter1FYoungsterText_ReturnedMachinePart: 
if DEF(_FR_FR)
	text "Le DIRECTEUR de la"
	line "STATION de RADIO"
	cont "était content."

	para "Il dit que les"
	line "émissions peuvent"

	para "reprendre depuis"
	line "la réparation de"
	cont "la CENTRALE."
else
	text "The DIRECTOR of"
	line "the RADIO STATION"
	cont "sure was happy."

	para "He said they're"
	line "back on the air"

	para "because the POWER"
	line "PLANT is running"
	cont "smoothly again."
endc

	done

LavenderPokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, LAVENDER_TOWN, 1
	warp_event  4,  7, LAVENDER_TOWN, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LavenderPokecenter1FNurseScript, -1
	object_event  7,  6, SPRITE_GENTLEMAN, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LavenderPokecenter1FGentlemanScript, -1
	object_event  5,  3, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, LavenderPokecenter1FTeacherScript, -1
	object_event  1,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, LavenderPokecenter1FYoungsterScript, -1
