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
	scall CinnabarPokecenter1f_OldRodGuy

	clearevent EVENT_CINNABAR_RAVE_PARTY
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

	readvar VAR_WEEKDAY
	ifequal THURSDAY, .if_thursday
	ifequal FRIDAY, .if_friday
	endcallback

.if_thursday:
	readvar VAR_HOUR
	ifgreater 20, .DoRaveParty
	endcallback

.if_friday:
	readvar VAR_HOUR
	ifless 4, .DoRaveParty
	endcallback

.DoRaveParty:
	setevent EVENT_CINNABAR_RAVE_PARTY
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; Display all the party people!
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2 ; Hide the Old Rod guy.
	endcallback

CinnabarPokecenter1f_OldRodGuy:
	checkevent EVENT_GOT_OLD_ROD
	iffalse .end

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
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
	text "CINNABAR GYM's"
	line "BLAINE now lives"
	cont "alone in a cave…"

	para "Everyone else"
	line "left the island…"
	done

CinnabarPokecenter1FFisherText:
	text "It's been a year"
	line "since the volcano"
	cont "erupted."
	done

CinnabarPokecenterRunnerText:
	text "Where's my sister?"
	done

CinnabarPokecenterDancerText:
	text "Yeaaah!"
	done

CinnabarPokecenterSeriousText:
	text "Clubs are closed."
	line "So the youth has"
	cont "to find another"
	cont "way to party."

	para "And as raves are"
	line "illegal, it's even"
	cont "more exciting!"
	done

CinnabarPokecenterDJText:
	text "DJ: WHAAAAAT?"

	para "OH YEAH, I'M"
	line "PLUGGED INTO THE"

	para "POKéMON CENTER"
	line "SPEAKER SYSTEM,"
	cont "IT'S GIGA LOUD!"
	done

CinnabarPokecenterDJText2:
	text "aaaaaaand…"
	para "(FOGHOOOOORN)"
	para "  DROP THE BASS"
	done

WetFloorText:
	text "Wet floor"
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
	object_event  2,  4, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CinnabarPokecenter1FFisherScript, EVENT_CINNABAR_RAVE_PARTY
	object_event  9,  2, SPRITE_CAPTAIN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CinnabarPokecenterDJScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  7,  5, SPRITE_DROWZEE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, CinnabarPokecenter1FDrowzeeScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  7,  7, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CinnabarPokecenterSleeperScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  5,  4, SPRITE_BLACK_BELT, SPRITEMOVEDATA_PATROL_CIRCLE_RIGHT, 4, 2, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CinnabarPokecenterRunnerScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  2,  1, SPRITE_BEAUTY, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, CinnabarPokecenterDancerScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  1,  1, SPRITE_ROCKER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, CinnabarPokecenterDancerScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  0,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CinnabarPokecenterSeriousScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  8,  1, SPRITE_CONE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_ROCK, OBJECTTYPE_SCRIPT, 0, CinnabarPokecenterConeScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  7,  3, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CinnabarPokecenter1FFishingGuruScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
