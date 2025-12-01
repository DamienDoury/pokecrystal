	object_const_def
	const TOHJOFALLS_POKE_BALL
	const TOHJOFALLS_WATERFALL_TIP

TohjoFalls_MapScripts:
	def_scene_scripts

	def_callbacks

TohjoFallsMoonStone:
	itemball MOON_STONE

TohjoFallsWaterfallTipScript:
	jumptextfaceplayer TohjoFallsWaterfallTipText

TohjoFallsWaterfallTipText:
if DEF(_FR_FR)
	text "Je suis coincée"
	line "ici."
	
	para "J'ai perdu la CS"
	line "qui permet de"
	cont "remonter les"
	cont "cascades dans"
	cont "les TOURB'ILES."
else
	text "I'm stuck here."
	line "I lost the HM that"

	para "lets you ascend"
	line "waterfalls in the"
	cont "WHIRL ISLANDS."
endc
	done

TohjoFalls_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 13, 15, ROUTE_27, 2
	warp_event 25, 15, ROUTE_27, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  6, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, TohjoFallsMoonStone, EVENT_TOHJO_FALLS_MOON_STONE
	object_event  3,  9, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, TohjoFallsWaterfallTipScript, EVENT_GOT_HM07_WATERFALL
