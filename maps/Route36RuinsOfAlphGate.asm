	object_const_def
	const ROUTE36RUINSOFALPHGATE_OFFICER
	const ROUTE36RUINSOFALPHGATE_GRAMPS

Route36RuinsOfAlphGate_MapScripts:
	def_scene_scripts

	def_callbacks

Route36RuinsOfAlphGateOfficerScript:
	checkevent EVENT_GOT_WIDE_LENS
	iffalse .GiveWideLens

	jumptextfaceplayer Route36RuinsOfAlphGateOfficerText

.GiveWideLens
	faceplayer
	opentext
	writetext Route36RuinsOfAlphGateOfficerWideLensText
	promptbutton
	verbosegiveitem WIDE_LENS
	iffalse .NoRoom

	setevent EVENT_GOT_WIDE_LENS
.NoRoom
	closetext
	end

Route36RuinsOfAlphGateGrampsScript:
	jumptextfaceplayer Route36RuinsOfAlphGateGrampsText

Route36RuinsOfAlphGateOfficerText: 
if DEF(_FR_FR)
	text "Qui a bien pu"
	line "construire tout ça"
	cont "et....."
	cont "Pourquoi?"
else
	text "Don't you wonder"
	line "who'd make some-"
	cont "thing like this?"
	cont "And why?"
endc

	done
	
Route36RuinsOfAlphGateOfficerWideLensText:
if DEF(_FR_FR)
	text "Si tu ne veux rien"
	line "louper des RUINES"
	cont "D'ALPHA, ceci"
	cont "te sera utile."
else
	text "If you're going to"
	line "inspect the RUINS"
	cont "OF ALPH, this will"
	cont "come in handy."
endc
	done

Route36RuinsOfAlphGateGrampsText: 
if DEF(_FR_FR)
	text "Tu as vu cet arbre"
	line "louche sur la"
	cont "route?"

	para "C'est à cause de"
	line "lui que personne"

	para "ne visite les"
	line "RUINES D'ALPHA."
else
	text "Did you see that"
	line "strange tree in"
	cont "the road?"

	para "That may explain"
	line "why fewer people"

	para "are visiting the"
	line "RUINS OF ALPH."
endc

	done

Route36RuinsOfAlphGate_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4,  0, ROUTE_36, 3
	warp_event  5,  0, ROUTE_36, 4
	warp_event  4,  7, RUINS_OF_ALPH_OUTSIDE, 9
	warp_event  5,  7, RUINS_OF_ALPH_OUTSIDE, 9

	def_coord_events

	def_bg_events

	def_object_events
	object_event  0,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, Route36RuinsOfAlphGateOfficerScript, -1
	object_event  7,  5, SPRITE_GRAMPS, SPRITEMOVEDATA_WANDER, 1, 2, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, Route36RuinsOfAlphGateGrampsScript, -1
