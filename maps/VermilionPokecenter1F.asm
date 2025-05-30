	object_const_def
	const VERMILIONPOKECENTER1F_NURSE
	const VERMILIONPOKECENTER1F_FISHING_GURU
	const VERMILIONPOKECENTER1F_SAILOR
	const VERMILIONPOKECENTER1F_BUG_CATCHER

VermilionPokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .VermilionPokecenter1F_AntiSoftLock

.VermilionPokecenter1F_AntiSoftLock:
	farsjump AntiSoftLockPokeball

VermilionPokecenter1FNurseScript:
	jumpstd PokecenterNurseScript

VermilionPokecenter1FFishingGuruScript:
	faceplayer
	opentext
	checkevent EVENT_FOUGHT_SNORLAX
	iftrue .FoughtSnorlax
	writetext VermilionPokecenter1FFishingGuruText
	waitbutton
	closetext
	end

.FoughtSnorlax:
	writetext VermilionPokecenter1FFishingGuruText_FoughtSnorlax
	waitbutton
	closetext
	end

VermilionPokecenter1FSailorScript:
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iffalse .power_restored
	jumptextfaceplayer VermilionPokecenter1FSailorText
.power_restored
	jumptextfaceplayer VermilionPokecenter1FSailorPowerOutageText

VermilionPokecenter1FBugCatcherScript:
	jumptextfaceplayer VermilionPokecenter1FBugCatcherText

VermilionPokecenter1FFishingGuruText: 
if DEF(_FR_FR)
	text "Un #MON endormi"
	line "est devant la"
	cont "CAVE TAUPIQUEUR."

	para "On pourrait l'at-"
	line "traper, mais com-"
	cont "ment le réveiller?"
else
	text "A sleeping #MON"
	line "is lying in front"
	cont "of DIGLETT'S CAVE."

	para "It's a fantastic"
	line "opportunity to get"

	para "it, but how do you"
	line "wake it up?"
endc

	done

VermilionPokecenter1FFishingGuruText_FoughtSnorlax: 
if DEF(_FR_FR)
	text "Il y avait un"
	line "#MON endormi"

	para "devant la CAVE"
	line "TAUPIQUEUR."

	para "Mais il a disparu,"
	line "on dirait."
else
	text "There used to be a"
	line "sleeping #MON"

	para "lying in front of"
	line "DIGLETT'S CAVE."

	para "But it seems to"
	line "have disappeared."
endc

	done

VermilionPokecenter1FSailorText: 
if DEF(_FR_FR)
	text "Le BATEAU EXPRESS"
	line "est un bon moyen"

	para "de rencontrer et"
	line "d'affronter des"
	cont "dresseurs."
else
	text "The FAST SHIP is a"
	line "great place to"

	para "meet and battle"
	line "trainers."
endc

	done

VermilionPokecenter1FSailorPowerOutageText: ; TO TRANSLATE
	text "Oh fudge! BILL's PC"
	line "can't connect to"
	cont "JOHTO's servers!"

	para "Now I'm stuck here"
	line "without access to"
	cont "my #MON…"

	para "I should've"
	line "listened to"
	cont "the CAPTAIN!"
	done

VermilionPokecenter1FBugCatcherText: 
if DEF(_FR_FR)
	text "Oh? Tu as des"
	line "BADGES que je n'ai"
	cont "jamais vus."

	para "Je vois. Tu les"
	line "as eus à JOHTO."
else
	text "Oh? You have some"
	line "BADGES I've never"
	cont "seen before."

	para "Oh, I get it. You"
	line "got them in JOHTO."
endc

	done

VermilionPokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, VERMILION_CITY, 2
	warp_event  4,  7, VERMILION_CITY, 2
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VermilionPokecenter1FNurseScript, -1
	object_event  7,  2, SPRITE_FISHING_GURU, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, VermilionPokecenter1FFishingGuruScript, -1
	object_event  6,  5, SPRITE_SAILOR, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, VermilionPokecenter1FSailorScript, -1
	object_event  1,  5, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VermilionPokecenter1FBugCatcherScript, -1
