	object_const_def
	const BLACKTHORNMART_CLERK
	const BLACKTHORNMART_VP_CONTROLLER
	const BLACKTHORNMART_COOLTRAINER_M
	const BLACKTHORNMART_BLACK_BELT

BlackthornMart_MapScripts:
	def_scene_scripts
	scene_script .VaccinePassport ; SCENE_ALWAYS

	def_callbacks

.VaccinePassport:
	jumpstd VaccinePassCheckpoint

BlackthornMartClerkScript:
	opentext
	pokemart MARTTYPE_STANDARD, MART_BLACKTHORN
	closetext
	end

BlackthornMartCooltrainerMScript:
	jumptextfaceplayer BlackthornMartCooltrainerMText

BlackthornMartBlackBeltScript:
	jumptextfaceplayer BlackthornMartBlackBeltText

BlackthornMartShelfItem1Script:
	shelfitem 6, FULL_HEAL, 3600

BlackthornMartCooltrainerMText: 
if DEF(_FR_FR)
	text "Tu ne peux pas"
	line "acheter de RAPPEL"

	para "MAX mais il permet"
	line "de ramener un"
	cont "#MON évanoui"
	cont "en pleine forme."

	para "Fais attention, ça"
	line "ne restaure pas"
	cont "les POINTS DE POU-"
	cont "VOIR des attaques."
else
	text "You can't buy MAX"
	line "REVIVE, but it"

	para "fully restores a"
	line "fainted #MON."

	para "Beware--it won't"
	line "restore PP, the"

	para "POWER POINTS"
	line "needed for moves."
endc

	done

BlackthornMartBlackBeltText: ; TO TRANSLATE
	text "They say the"
	line "inflation might"

	para "only be getting"
	line "worse."

	para "Because of the"
	line "pandemic, prod-"
	
	para "uction lines have"
	line "been disrupted"
	cont "worldwide."

	para "There are short-"
	line "ages all around"
	
	para "the globe, and"
	line "prices have gone"

	para "up because of"
	line "high demand and"
	cont "low supply."

	para "It may take years"
	line "before we go back"
	cont "to stable prices."
	done

BlackthornMart_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, BLACKTHORN_CITY, 4
	warp_event  3,  7, BLACKTHORN_CITY, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  1,  3, SPRITE_CLERK, CLAP_F | SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornMartClerkScript, -1
	object_event  1,  7, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VaccinePassportController, -1 ; Should always be at the second spot in the list.
	object_event  7,  6, SPRITE_COOLTRAINER_M, CLAP_F | SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornMartCooltrainerMScript, -1
	object_event  5,  2, SPRITE_BLACK_BELT, CLAP_F | SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, BlackthornMartBlackBeltScript, -1
	object_event  8,  1, SPRITE_SHINE, SPRITEMOVEDATA_SHINE, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornMartShelfItem1Script, EVENT_MART_BLACKTHORN_MISSED
