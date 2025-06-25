	object_const_def
	const BLACKTHORNPOKECENTER1F_NURSE
	const BLACKTHORNPOKECENTER1F_GENTLEMAN
	const BLACKTHORNPOKECENTER1F_TWIN
	const BLACKTHORNPOKECENTER1F_COOLTRAINER_M

BlackthornPokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .BlackthornPokecenter1F_AntiSoftLock

.BlackthornPokecenter1F_AntiSoftLock:
	farsjump AntiSoftLockPokeball

BlackthornPokecenter1FNurseScript:
	jumpstd PokecenterNurseScript

BlackthornPokecenter1FGentlemanScript:
	jumptextfaceplayer BlackthornPokecenter1FGentlemanText

BlackthornPokecenter1FTwinScript:
	jumptextfaceplayer BlackthornPokecenter1FTwinText

BlackthornPokecenter1FCooltrainerMScript:
	jumpstd HappinessCheckScript

BlackthornPokecenter1FGentlemanText:
if DEF(_FR_FR)
	text "Mon COUPON TRAçAGE"
	line "me rassure!"

	para "Mais hélas, il ne"
	line "m'avertit pas si"

	para "je suis contaminé"
	line "par un #MON"
	cont "sauvage."

	para "J'aimerais que"
	line "tous les #MON"
	cont "sauvages aient"
	cont "un #GEAR."
	done
else
	text "My CONTACT TRACING"
	line "CARD feels great!"

	para "But unfortunately"
	line "it won't notify me"

	para "if I get contami-"
	line "nated by a wild"
	cont "#MON."

	para "I wish wild #-"
	line "MON all had a"
	cont "#GEAR."
	done
endc

BlackthornPokecenter1FTwinText: 
if DEF(_FR_FR)
	text "Il y avait une"
	line "capacité que je"

	para "voulais donner à"
	line "mon #MON..."

	para "Alors j'ai demandé"
	line "au TYPE QUI EFFACE"
	cont "LES CAPACITES de"
	cont "lui faire oublier"
	cont "une CS."
else
	text "There was this"
	line "move I just had"

	para "to teach my #-"
	line "MON."

	para "So I got the MOVE"
	line "DELETER to make it"
	cont "forget an HM move."
endc

	done

BlackthornPokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, BLACKTHORN_CITY, 5
	warp_event  4,  7, BLACKTHORN_CITY, 5
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornPokecenter1FNurseScript, -1
	object_event  5,  3, SPRITE_GENTLEMAN, CLAP_F | SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_CURFEW & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornPokecenter1FGentlemanScript, -1
	object_event  1,  4, SPRITE_TWIN, CLAP_F | SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, BlackthornPokecenter1FTwinScript, -1
	object_event  7,  6, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, HIDE_LOCKDOWN & HIDE_CURFEW & HIDE_VACCINE_PASS, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, BlackthornPokecenter1FCooltrainerMScript, -1
