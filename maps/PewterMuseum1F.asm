	object_const_def
	;const PEWTERSNOOZESPEECHHOUSE_GRAMPS

PewterMuseum1F_MapScripts:
	def_scene_scripts

	def_callbacks

PewterMuseum1FSilverWing:
	hiddenitem SILVER_WING, EVENT_PEWTER_MUSEUM_HIDDEN_SILVER_WING

PewterMuseum1FHole:
	jumptext PewterMuseum1FHoleText

PewterMuseum1FHelix:
	opentext
	writetext PewterMuseum1FHelixText
	promptbutton
	closetext
	refreshscreen
	pokepic 137
	waitbutton
	closepokepic
	end

PewterMuseum1FBrokenGlass:
	jumptext PewterMuseum1FBrokenGlassText

PewterMuseum1FCounter:
	jumptext PewterMuseum1FCounterText

PewterMuseum1FStool:
	jumptext PewterMuseum1FStoolText

PewterMuseum1FBooks:
	jumptext PewterMuseum1FBooksText

PewterMuseum1FDNA:
	jumptext PewterMuseum1FDNAText

PewterMuseum1FHoleText:
	text "A #MON made a"
	line "hole in the wall."
	done

PewterMuseum1FHelixText:
	text "An ancient wall"
	line "painting of a"
	cont "revered #MON."
	done

PewterMuseum1FBrokenGlassText:
	text "“This feather is"
	line "said to belong to"
	cont "an old legendary"
	cont "#MON.”"

	para "The glass is"
	line "broken."

	para "Can't see it"
	line "from here."
	done

PewterMuseum1FCounterText:
	text "The counter is"
	line "broken."
	done

PewterMuseum1FDNAText:
	text "“This OLD AMBER"
	line "contains the DNA"
	cont "of a prehistoric"
	cont "#MON.”"
	done

PewterMuseum1FStoolText:
	text "Oh dear lord…"

	para "The stool hasn't"
	line "been put away"
	cont "perpendicularly to"
	cont "the floor tiles."
	
	para "This is"
	line "UNACCEPTABLE!"
	done

PewterMuseum1FBooksText:
	text "Many books are"
	line "missing."
	done

	PewterMuseum1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 16,  7, PEWTER_CITY, 6
	warp_event 17,  7, PEWTER_CITY, 6
	warp_event  7,  7, PEWTER_MUSEUM_2F, 1

	def_coord_events

	def_bg_events
	bg_event  3,  5, BGEVENT_ITEM, PewterMuseum1FSilverWing
	bg_event  3,  0, BGEVENT_READ, PewterMuseum1FHole
	bg_event  2,  3, BGEVENT_READ, PewterMuseum1FHelix
	bg_event  2,  6, BGEVENT_READ, PewterMuseum1FBrokenGlass
	bg_event 12,  5, BGEVENT_READ, PewterMuseum1FCounter
	bg_event 16,  2, BGEVENT_READ, PewterMuseum1FDNA
	bg_event 12,  3, BGEVENT_READ, PewterMuseum1FStool
	bg_event 12,  1, BGEVENT_READ, PewterMuseum1FBooks
	bg_event 13,  1, BGEVENT_READ, PewterMuseum1FBooks
	bg_event 14,  1, BGEVENT_READ, PewterMuseum1FBooks
	bg_event 15,  1, BGEVENT_READ, PewterMuseum1FBooks
	bg_event 16,  1, BGEVENT_READ, PewterMuseum1FBooks
	bg_event 17,  1, BGEVENT_READ, PewterMuseum1FBooks
	bg_event 18,  1, BGEVENT_READ, PewterMuseum1FBooks
	bg_event 19,  1, BGEVENT_READ, PewterMuseum1FBooks
	

	def_object_events
	;object_event  5,  3, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, PewterSnoozeSpeechHouseGrampsScript, -1
