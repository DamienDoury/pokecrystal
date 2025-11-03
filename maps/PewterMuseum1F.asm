	object_const_def
	;const PEWTERSNOOZESPEECHHOUSE_GRAMPS

PewterMuseum1F_MapScripts:
	def_scene_scripts

	def_callbacks

PewterMuseum1FHelix:
	refreshscreen
	pokepic OMANYTE
	waitbutton
	closepokepic
	
	opentext
	writetext PewterMuseum1FHelixText
	promptbutton
	closetext
	end

PewterMuseum1FSilverWing:
	hiddenitem SILVER_WING, EVENT_PEWTER_MUSEUM_HIDDEN_SILVER_WING

PewterMuseum1FHole:
	jumptext PewterMuseum1FHoleText

PewterMuseum1FBrokenGlass:
	jumptext PewterMuseum1FBrokenGlassText

PewterMuseum1FCounter:
	jumptext PewterMuseum1FCounterText

PewterMuseum1FStool:
	jumptext PewterMuseum1FStoolText

PewterMuseum1FDNA:
	jumptext PewterMuseum1FDNAText
	
PewterMuseum1FBooks:
	jumptext PewterMuseum1FBooksText

PewterMuseum1FClosedDoor:
	jumptext PewterMuseum1FClosedDoorText

PewterMuseum1FHoleText:
if DEF(_FR_FR)
	text "Un #MON a"
	line "fait un trou"
	cont "dans le mur."
else
	text "A #MON made a"
	line "hole in the wall."
endc
	done

PewterMuseum1FHelixText:
if DEF(_FR_FR)
	text "Une peinture"
	line "murale ancestrale"
	cont "d'un #MON vénéré"
else
	text "An ancient wall"
	line "painting of a"
	cont "revered #MON."
endc
	done

PewterMuseum1FBrokenGlassText:
if DEF(_FR_FR)
	text "“Cette plume"
	line "appartiendrait à"
	cont "un ancien #MON"
	cont "légendaire.”"

	para "Le verre est"
	line "brisé."

	para "Impossible de la"
	line "voir de ce côté."
else
	text "“This feather is"
	line "said to belong to"
	cont "an old legendary"
	cont "#MON.”"

	para "The glass is"
	line "broken."

	para "Can't see it"
	line "from here."
endc
	done

PewterMuseum1FCounterText:
if DEF(_FR_FR)
	text "Le comptoir est"
	line "démoli."
else
	text "The counter is"
	line "broken."
endc
	done

PewterMuseum1FDNAText:
if DEF(_FR_FR)
	text "“Ce VIEIL AMBRE"
	line "contient l'ADN"
	cont "d'un #MON pré-"
	cont "historique.”"
else
	text "“This OLD AMBER"
	line "contains the DNA"
	cont "of a prehistoric"
	cont "#MON.”"
endc
	done

PewterMuseum1FStoolText:
if DEF(_FR_FR)
	text "Par tous les"
	line "saints..."

	para "Le tabouret n'a pas"
	line "été replacé per-"
	cont "pendiculairement"
	cont "au carrelage."

	para "C'est"
	line "INACCEPTABLE!"
else
	text "Oh dear lord…"

	para "The stool hasn't"
	line "been put away"
	cont "perpendicularly to"
	cont "the floor tiles."
	
	para "This is"
	line "UNACCEPTABLE!"
endc
	done

PewterMuseum1FBooksText:
if DEF(_FR_FR)
	text "Beaucoup de livres"
	line "ont disparu."
else
	text "Many books are"
	line "missing."
endc
	done

PewterMuseum1FClosedDoorText:
if DEF(_FR_FR)
	text "La porte est"
	line "fermée de"
	cont "l'extérieur."
else
	text "The door is closed"
	line "from the outside."
endc
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
	bg_event 11,  7, BGEVENT_READ, PewterMuseum1FClosedDoor
	bg_event 10,  7, BGEVENT_READ, PewterMuseum1FClosedDoor
	bg_event 11,  8, BGEVENT_READ, PewterMuseum1FClosedDoor
	bg_event 10,  8, BGEVENT_READ, PewterMuseum1FClosedDoor
	

	def_object_events
	;object_event  2,  3, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PewterMuseum1FHelix, -1
