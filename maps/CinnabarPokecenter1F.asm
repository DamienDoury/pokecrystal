	object_const_def
	const CINNABARPOKECENTER1F_NURSE
	const CINNABARPOKECENTER1F_COOLTRAINER_F
	const CINNABARPOKECENTER1F_FISHER
	const CINNABARPOKECENTER1F_DJ
	const CINNABARPOKECENTER1F_DROWZEE
	const CINNABARPOKECENTER1F_SLEEPER
	const CINNABARPOKECENTER1F_RUNNER
	const CINNABARPOKECENTER1F_DANCER
	const CINNABARPOKECENTER1F_DANCER2
	const CINNABARPOKECENTER1F_SERIOUS
	const CINNABARPOKECENTER1F_CONE
	const CINNABARPOKECENTER1F_FISHING_GURU

CinnabarPokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .RaveParty

.RaveParty:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; Hide all party people.
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2 ; Hide the Old Rod guy.
	clearevent EVENT_CINNABAR_RAVE_PARTY

	readvar VAR_WEEKDAY
	ifequal THURSDAY, .if_thursday
	ifequal FRIDAY, .if_friday
	sjump .AntiSoftlock

.if_thursday:
	readvar VAR_HOUR
	ifgreater 20, .DoRaveParty
	sjump .AntiSoftlock

.if_friday:
	readvar VAR_HOUR
	ifless 4, .DoRaveParty
	sjump .AntiSoftlock

.DoRaveParty:
	setevent EVENT_CINNABAR_RAVE_PARTY
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; Display all the party people!

.AntiSoftlock
	scall CinnabarPokecenter1f_OldRodGuy
	farsjump AntiSoftLockPokeball ; Calls endcallback.

CinnabarPokecenter1f_OldRodGuy::
	checkitem OLD_ROD
	iftrue .end

	checkitem GOOD_ROD
	iftrue .end

	checkitem SUPER_ROD
	iftrue .end

	; No need to check if the player owns Surf. The player NEEDS surf to reach an island in the first hand.

	loadmem wPutativeTMHMMove, SURF
	callasm CanAtLeastOnePartyMemberLearnTMHMMove
	iftrue .end ; We don't offer a Rod to the player if they can get away from the island with one of their party Pokémon using Surf.

	checkitem HM_FLY
	iffalse .offer_rod

	loadmem wPutativeTMHMMove, FLY
	callasm CanAtLeastOnePartyMemberLearnTMHMMove
	iftrue .end ; We don't offer a Rod to the player if they can get away from the island with one of their party Pokémon using Fly.

.offer_rod
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
.end
	end

CinnabarPokecenterSleeperScript:
	showemote EMOTE_SLEEP, CINNABARPOKECENTER1F_SLEEPER, 15
	end

CinnabarPokecenter1FDrowzeeScript:
	cry DROWZEE
	end

CinnabarPokecenterRunnerScript:
	jumptextfaceplayer CinnabarPokecenterRunnerText

CinnabarPokecenter1FNurseScript:
	jumpstd PokecenterNurseScript

CinnabarPokecenter1FCooltrainerFScript:
	jumptextfaceplayer CinnabarPokecenter1FCooltrainerFText

CinnabarPokecenter1FFisherScript:
	jumptextfaceplayer CinnabarPokecenter1FFisherText

CinnabarPokecenterDancerScript:
	jumptextfaceplayer CinnabarPokecenterDancerText

CinnabarPokecenterSeriousScript:
	jumptextfaceplayer CinnabarPokecenterSeriousText

CinnabarPokecenterConeScript:
	jumptext WetFloorText

CinnabarPokecenterDJScript:
	faceplayer
	opentext
	writetext CinnabarPokecenterDJText
	waitbutton
	turnobject CINNABARPOKECENTER1F_DJ, UP
	pause 5
	writetext CinnabarPokecenterDJText2
	waitbutton
	closetext
	end

CinnabarPokecenter1FFishingGuruScript:
	farsjump Route32Pokecenter1FFishingGuruScript

CinnabarPokecenter1FCooltrainerFText:
if DEF(_FR_FR)
	text "Le CHAMPION"
	line "AUGUSTE de"
	cont "CRAMOIS'ILE"
	cont "vit seul dans"
	cont "une grotte..."

	para "Tout le monde a"
	line "quitté l'île"
	cont "sauf lui..."
else
	text "CINNABAR GYM's"
	line "BLAINE now lives"
	cont "alone in a cave…"

	para "Everyone else"
	line "left the island…"
endc
	done

CinnabarPokecenter1FFisherText: 
if DEF(_FR_FR)
	text "Cela fait un an"
	line "depuis l'éruption"
	cont "du volcan."
else
	text "It's been a year"
	line "since the volcano"
	cont "erupted."
endc

	done

CinnabarPokecenterRunnerText:
if DEF(_FR_FR)
	text "Où est ma soeur?"
else
	text "Where's my sister?"
endc
	done

CinnabarPokecenterDancerText:
if DEF(_FR_FR)
	text "Ouaaais!"
else
	text "Yeaaah!"
endc
	done

CinnabarPokecenterSeriousText:
if DEF(_FR_FR)
	text "Les clubs sont"
	line "fermés."
	
	para "Les jeunes doivent"
	line "trouver d'autres"
	cont "moyens pour faire"
	cont "la fête."

	para "Et comme les raves"
	line "sont illégales,"
	cont "c'est encore plus"
	cont "grisant!"
else
	text "Clubs are closed."
	line "So the youth has"
	cont "to find another"
	cont "way to party."

	para "And as raves are"
	line "illegal, it's even"
	cont "more exciting!"
endc
	done

CinnabarPokecenterDJText:
if DEF(_FR_FR)
	text "DJ: QUOOOI?"

	para "OH OUAIS, JE SUIS"
	line "BRANCHé SUR"

	para "LE SYSTEME"
	line "AUDIO DU CENTRE"

	para "#MON, CA A"
	cont "DE LA PATATE!"
else
	text "DJ: WHAAAAAT?"

	para "OH YEAH, I'M"
	line "PLUGGED INTO THE"

	para "POKéMON CENTER"
	line "SPEAKER SYSTEM,"
	cont "IT'S GIGA LOUD!"
endc
	done

CinnabarPokecenterDJText2:
if DEF(_FR_FR)
	text "eeeeeeeeet..."
	para "(CORNE DE BRUME)"
	para "  DROP THE BASS"
else
	text "aaaaaaand…"
	para "(FOGHOOOOORN)"
	para "  DROP THE BASS"
endc
	done

WetFloorText:
if DEF(_FR_FR)
	text "Sol glissant"
else
	text "Wet floor"
endc
	done

CinnabarPokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, CINNABAR_ISLAND, 1
	warp_event  4,  7, CINNABAR_ISLAND, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CinnabarPokecenter1FNurseScript, EVENT_CINNABAR_RAVE_PARTY
	object_event  7,  6, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CinnabarPokecenter1FCooltrainerFScript, EVENT_CINNABAR_RAVE_PARTY
	object_event  0,  3, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CinnabarPokecenter1FFisherScript, EVENT_CINNABAR_RAVE_PARTY
	object_event  9,  2, SPRITE_CAPTAIN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CinnabarPokecenterDJScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  7,  5, SPRITE_DROWZEE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, CinnabarPokecenter1FDrowzeeScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  7,  7, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CinnabarPokecenterSleeperScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  5,  4, SPRITE_BLACK_BELT, SPRITEMOVEDATA_PATROL_CIRCLE_RIGHT, 4, 2, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CinnabarPokecenterRunnerScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  2,  1, SPRITE_BEAUTY, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, CinnabarPokecenterDancerScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  1,  1, SPRITE_ROCKER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, CinnabarPokecenterDancerScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  0,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CinnabarPokecenterSeriousScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  8,  1, SPRITE_CONE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_ROCK, OBJECTTYPE_SCRIPT, 0, CinnabarPokecenterConeScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  2,  4, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CinnabarPokecenter1FFishingGuruScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
