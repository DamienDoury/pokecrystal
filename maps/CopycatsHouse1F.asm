	object_const_def
	const COPYCATSHOUSE1F_POKEFAN_M
	const COPYCATSHOUSE1F_POKEFAN_F
	const COPYCATSHOUSE1F_CLEFAIRY

CopycatsHouse1F_MapScripts:
	def_scene_scripts

	def_callbacks

CopycatsHouse1FPokefanMScript:
	jumptextfaceplayer CopycatsHouse1FPokefanMText

CopycatsHouse1FPokefanFScript:
	faceplayer
	opentext
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	writetext CopycatsHouse1FPokefanFText
	waitbutton
	closetext
	end

.ReturnedMachinePart:
	writetext CopycatsHouse1FPokefanFText_ReturnedMachinePart
	waitbutton
	closetext
	end

CopycatsHouse1FBlisseyScript:
	opentext
	writetext CopycatsHouse1FBlisseyText
	cry BLISSEY
	waitbutton
	closetext
	end

CopycatsHouse1FPokefanMText: 
if DEF(_FR_FR)
	text "Ma fille aime imi-"
	line "ter les gens."

	para "On l'appelle la"
	line "COPIEUSE."
else
	text "My daughter likes"
	line "to mimic people."

	para "Her mimicry has"
	line "earned her the"

	para "nickname COPYCAT"
	line "around here."
endc

	done

CopycatsHouse1FPokefanFText: 
if DEF(_FR_FR)
	text "Ma fille est très"
	line "égocentrique..."

	para "Elle n'a pas beau-"
	line "coup d'amis."
else
	text "My daughter is so"
	line "self-centered…"

	para "She only has a few"
	line "friends."
endc

	done

CopycatsHouse1FPokefanFText_ReturnedMachinePart: 
if DEF(_FR_FR)
	text "Elle a perdu la"
	line "# POUPEE qu'un"

	para "garçon lui a don-"
	line "née il y a 3 ans."

	para "Et depuis, elle"
	line "imite encore mieux"
	cont "qu'avant..."
else
	text "She recently lost"
	line "the # DOLL that"

	para "a boy gave her"
	line "three years ago."

	para "Ever since then,"
	line "she's gotten even"
	cont "better at mimicry…"
endc

	done

CopycatsHouse1FBlisseyText: 
if DEF(_FR_FR)
	text "LEUPHORIE: Rriii!"
else
	text "BLISSEY: Bliisii!"
endc

	done

CopycatsHouse1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, SAFFRON_CITY, 8
	warp_event  3,  7, SAFFRON_CITY, 8
	warp_event  2,  0, COPYCATS_HOUSE_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CopycatsHouse1FPokefanMScript, -1
	object_event  5,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CopycatsHouse1FPokefanFScript, -1
	object_event  6,  6, SPRITE_BLISSEY, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, CopycatsHouse1FBlisseyScript, -1
