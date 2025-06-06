	object_const_def
	const BLACKTHORNGYM2F_COOLTRAINER_M
	const BLACKTHORNGYM2F_COOLTRAINER_F
	const BLACKTHORNGYM2F_BOULDER1
	const BLACKTHORNGYM2F_BOULDER2
	const BLACKTHORNGYM2F_BOULDER3
	const BLACKTHORNGYM2F_BOULDER4
	const BLACKTHORNGYM2F_BOULDER5
	const BLACKTHORNGYM2F_BOULDER6

BlackthornGym2F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_CMDQUEUE, .SetUpStoneTable

.SetUpStoneTable:
	writecmdqueue .CommandQueue
	endcallback

.CommandQueue:
	cmdqueue CMDQUEUE_STONETABLE, .StoneTable ; check if any stones are sitting on a warp

.StoneTable:
	stonetable 5, BLACKTHORNGYM2F_BOULDER1, .Boulder1
	stonetable 3, BLACKTHORNGYM2F_BOULDER2, .Boulder2
	stonetable 4, BLACKTHORNGYM2F_BOULDER3, .Boulder3
	db -1 ; end

.Boulder1:
	disappear BLACKTHORNGYM2F_BOULDER1
	sjump .Fall

.Boulder2:
	disappear BLACKTHORNGYM2F_BOULDER2
	sjump .Fall

.Boulder3:
	disappear BLACKTHORNGYM2F_BOULDER3
	sjump .Fall

.Fall:
	pause 5
	scall .FX
	opentext
	farwritetext IcePathBoulderFellThroughText
	waitbutton
	closetext
	end

.FX:
	playsound SFX_STRENGTH
	earthquake 80
	end

BlackthornGymBoulder:
	jumpstd StrengthBoulderScript

TrainerCooltrainermCody:
	trainer COOLTRAINERM, CODY, EVENT_BEAT_COOLTRAINERM_CODY, CooltrainermCodySeenText, CooltrainermCodyBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer CooltrainermCodyAfterBattleText

TrainerCooltrainerfFran:
	trainer COOLTRAINERF, FRAN, EVENT_BEAT_COOLTRAINERF_FRAN, CooltrainerfFranSeenText, CooltrainerfFranBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer CooltrainerfFranAfterBattleText

CooltrainermCodySeenText: 
if DEF(_FR_FR)
	text "On n'utilise pas"
	line "tous des #MON"
	cont "dragon."
else
	text "It's not as if we"
	line "all use dragon-"
	cont "type #MON."
endc

	done

CooltrainermCodyBeatenText: 
if DEF(_FR_FR)
	text "Zut! Il me faut"
	line "un dragon!"
else
	text "Rats! If only I"
	line "had a dragon!"
endc

	done

CooltrainermCodyAfterBattleText: 
if DEF(_FR_FR)
	text "Les membres de la"
	line "confrérie des"

	para "dragons ne peuvent"
	line "utiliser des #-"
	cont "MON dragon que si"

	para "le MAITRE le"
	line "permet."
else
	text "Members of our"
	line "dragon-user clan"

	para "can use dragon"
	line "#MON only after"

	para "our MASTER allows"
	line "it."
endc

	done

CooltrainerfFranSeenText: 
if DEF(_FR_FR)
	text "Un dresseur"
	line "quelconque ne"
	cont "passera pas!"

	para "SANDRA ne le"
	line "permettrait pas!"
else
	text "I can't allow a"
	line "nameless trainer"
	cont "past me!"

	para "CLAIR would be"
	line "livid if I did!"
endc

	done

CooltrainerfFranBeatenText: 
if DEF(_FR_FR)
	text "Pffff. Perdu..."
else
	text "Awww… I lost…"
endc

	done

CooltrainerfFranAfterBattleText: 
if DEF(_FR_FR)
	text "Oulà! La SANDRA"
	line "elle sera furax!"
else
	text "Uh-oh… CLAIR is"
	line "going to be mad…"
endc

	done

BlackthornGym2F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  1,  7, BLACKTHORN_GYM_1F, 3
	warp_event  7,  9, BLACKTHORN_GYM_1F, 4
	warp_event  2,  5, BLACKTHORN_GYM_1F, 5 ; hole
	warp_event  8,  7, BLACKTHORN_GYM_1F, 6 ; hole
	warp_event  8,  3, BLACKTHORN_GYM_1F, 7 ; hole

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4,  1, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerCooltrainermCody, -1
	object_event  4, 11, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerCooltrainerfFran, -1
	object_event  8,  2, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornGymBoulder, EVENT_BOULDER_IN_BLACKTHORN_GYM_1
	object_event  2,  3, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornGymBoulder, EVENT_BOULDER_IN_BLACKTHORN_GYM_2
	object_event  6, 16, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornGymBoulder, EVENT_BOULDER_IN_BLACKTHORN_GYM_3
	object_event  3,  3, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornGymBoulder, -1
	object_event  6,  1, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornGymBoulder, -1
	object_event  8, 14, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornGymBoulder, -1
