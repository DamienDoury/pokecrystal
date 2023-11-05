	object_const_def
	const BLACKTHORNMART_CLERK
	const BLACKTHORNMART_COOLTRAINER_M
	const BLACKTHORNMART_BLACK_BELT

BlackthornMart_MapScripts:
	def_scene_scripts

	def_callbacks

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
	text "You can't buy MAX"
	line "REVIVE, but it"

	para "fully restores a"
	line "fainted #MON."

	para "Beware--it won't"
	line "restore PP, the"

	para "POWER POINTS"
	line "needed for moves."
	done

BlackthornMartBlackBeltText:
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
	object_event  1,  3, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornMartClerkScript, -1
	object_event  7,  6, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornMartCooltrainerMScript, -1
	object_event  5,  2, SPRITE_BLACK_BELT, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, BlackthornMartBlackBeltScript, -1
	object_event  8,  1, SPRITE_SHINE, SPRITEMOVEDATA_SHINE, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, BlackthornMartShelfItem1Script, EVENT_MART_BLACKTHORN_MISSED
