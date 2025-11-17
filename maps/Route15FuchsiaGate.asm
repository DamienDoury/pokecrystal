	object_const_def
	const ROUTE15FUCHSIAGATE_OFFICER
	const ROUTE15FUCHSIAGATE_BLOCKER

Route15FuchsiaGate_MapScripts:
	def_scene_scripts

	def_callbacks

Route15FuchsiaGateOfficerScript:
	jumptextfaceplayer Route15FuchsiaGateOfficerText

Route15FuchsiaGateBlockerScript:
	faceplayer
	pause 10
	showemote EMOTE_HAPPY, FUCHSIACITY_BLOCKER, 15
	checkevent EVENT_FUCHSIA_EXCAVATION_STARTED
	iftrue .HasSeenPlayerInFuchsia
	jumptext Route15FuchsiaGateBlockerNewText
.HasSeenPlayerInFuchsia:
	jumptext Route15FuchsiaGateBlockerText

Route15FuchsiaGateOfficerText: 
if DEF(_FR_FR)
	text "Tu veux compléter"
	line "un #DEX? C'est"

	para "génial! Surtout"
	line "n'abandonne pas!"
else
	text "You're working on"
	line "a #DEX? That's"

	para "really something."
	line "Don't give up!"
endc

	done

Route15FuchsiaGateBlockerNewText:
if DEF(_FR_FR)
	text "Bien le bonjour!"
	
	para "Pas si vite!"
	line "Reste donc te dé-"
	cont "tendre dans notre"
	cont "belle PARMANIE!"
else
	text "Howdy trainer!"

	para "Don't rush!"
	line "Come relax in our"
	cont "beautiful FUCHSIA"
	cont "CITY!"
endc
	done

Route15FuchsiaGateBlockerText:
if DEF(_FR_FR)
	text "Coucou toi!"
	
	para "Dégager ces ro-"
	line "chers était plus"
	
	para "fatiguant que je"
	line "l'aurais imaginé."
	
	para "Je vais me reposer"
	line "ici en espérant"
	
	para "voir venir des"
	line "touristes visiter"
	cont "notre chère ville!"
else
	text "Hey friend!"

	para "Clearing those"
	line "boulders was more"
	cont "exhausting than"
	cont "I expected."

	para "I'll be resting"
	line "here, in hope of"
	cont "seeing tourists"
	cont "come visit our"
	cont "beautiful town!"
endc
	done

Route15FuchsiaGate_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  4, FUCHSIA_CITY, 8
	warp_event  0,  5, FUCHSIA_CITY, 9
	warp_event  9,  4, ROUTE_15, 1
	warp_event  9,  5, ROUTE_15, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  2, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route15FuchsiaGateOfficerScript, -1
	object_event  1,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, Route15FuchsiaGateBlockerScript, -1
