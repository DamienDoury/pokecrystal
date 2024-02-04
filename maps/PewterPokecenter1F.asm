	object_const_def
	const PEWTERPOKECENTER1F_NURSE
	const PEWTERPOKECENTER1F_TEACHER
	const PEWTERPOKECENTER1F_JIGGLYPUFF
	const PEWTERPOKECENTER1F_BUG_CATCHER
	const PEWTERPOKECENTER1F_CHRIS

PewterPokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks

PewterPokecenter1FNurseScript:
	jumpstd PokecenterNurseScript

PewterPokecenter1FTeacherScript:
	jumptextfaceplayer PewterPokecenter1FTeacherText

PewterJigglypuff:
	opentext
	writetext PewterJigglypuffText
	playmusic MUSIC_JIGGLYPUFF_SONG
	applymovement PEWTERPOKECENTER1F_JIGGLYPUFF, JigglypuffDanceMovement
	applymovement PEWTERPOKECENTER1F_JIGGLYPUFF, JigglypuffDanceMovement
	applymovement PEWTERPOKECENTER1F_JIGGLYPUFF, JigglypuffDanceMovement
	applymovement PEWTERPOKECENTER1F_JIGGLYPUFF, JigglypuffDanceLastMovement
	closetext
	loadmem wMap3ObjectMovement, SPRITEMOVEDATA_STANDING_UP ; PEWTERPOKECENTER1F_JIGGLYPUFF
	musicfadeout MUSIC_POKEMON_CENTER, 16
	showemote EMOTE_SLEEP, PLAYER, 75
	pause 5
	showemote EMOTE_SAD, PEWTERPOKECENTER1F_JIGGLYPUFF, 30
	pause 10
	showemote EMOTE_QUESTION, PLAYER, 10

; Make all party mons sleep, unless they already have a status ailment, or if they have fainted.
FOR N, 1, PARTY_LENGTH + 1
	readmem wPartyMon{d:N}Status
	ifnotequal 0, .mon_{d:N}

	readmem wPartyMon{d:N}HP
	ifnotequal 0, .do_mon_{d:N}

	readmem wPartyMon{d:N}HP + 1
	ifequal 0, .mon_{d:N}

.do_mon_{d:N}
	loadmem wPartyMon{d:N}Status, SLP
.mon_{d:N}
endr
	end

JigglypuffDanceMovement:
	turn_head DOWN
	step_sleep 30
	turn_head UP
	step_sleep 20
	step_end

JigglypuffDanceLastMovement:
	turn_head DOWN
	step_sleep 60
	turn_head UP
	step_sleep 40
	step_end

PewterPokecenter1FBugCatcherScript:
	jumptextfaceplayer PewterPokecenter1FBugCatcherText

Chris:
	faceplayer
	opentext
	trade NPC_TRADE_CHRIS
	waitbutton
	closetext
	end

PewterPokecenter1FTeacherText:
	text "…Yeah, and the"
	line "GYM in CINNABAR's"

	para "gone. I was really"
	line "amazed."

	para "…Yes? I'm on the"
	line "phone. Go away!"
	done

PewterJigglypuffText:
	text "JIGGLYPUFF: Puu"
	line "pupuu."
	done

PewterPokecenter1FBugCatcherText:
	text "Most #MON get"
	line "drowsy if they"

	para "hear a JIGGLYPUFF"
	line "singing."

	para "There are several"
	line "moves that can be"

	para "used only while a"
	line "#MON is asleep."
	done

PewterPokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, PEWTER_CITY, 4
	warp_event  4,  7, PEWTER_CITY, 4
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PewterPokecenter1FNurseScript, -1
	object_event  8,  6, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, PewterPokecenter1FTeacherScript, -1
	object_event  1,  3, SPRITE_JIGGLYPUFF, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, PewterJigglypuff, -1
	object_event  2,  3, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, PewterPokecenter1FBugCatcherScript, -1
	object_event  7,  2, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Chris, -1
