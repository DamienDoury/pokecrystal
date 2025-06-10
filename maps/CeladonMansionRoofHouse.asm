	object_const_def
	const CELADONMANSIONROOFHOUSE_PHARMACIST

CeladonMansionRoofHouse_MapScripts:
	def_scene_scripts

	def_callbacks

CeladonMansionRoofHousePharmacistScript:
	faceplayer
	opentext
	checkitem TM_CURSE
	iftrue .GotCurse
	writetext CeladonMansionRoofHousePharmacistIntroText
	promptbutton
	checktime NITE
	iftrue .Night
	writetext CeladonMansionRoofHousePharmacistNotNightText
	waitbutton
	closetext
	end

.Night:
	writetext CeladonMansionRoofHousePharmacistStoryText
	promptbutton
	verbosegiveitem TM_CURSE
.GotCurse:
	writetext CeladonMansionRoofHousePharmacistCurseText
	waitbutton
	closetext
	end

CeladonMansionRoofHouseRadio:
	jumpstd Radio3Script

CeladonMansionRoofHousePharmacistIntroText: 
if DEF(_FR_FR)
	text "Je vais te racon-"
	line "ter un truc terri-"
	cont "fiant..."
else
	text "Let me recount a"
	line "terrifying tale…"
endc

	done

CeladonMansionRoofHousePharmacistNotNightText: 
if DEF(_FR_FR)
	text "...Il vaut mieux"
	line "attendre la fin"

	para "de la journée. Il"
	line "y a encore de la"
	cont "lumière dehors."

	para "Reviens la nuit"
	line "tombée, OK?"
else
	text "Then again, it's"
	line "not as scary while"

	para "it's still light"
	line "outside."

	para "Come back after"
	line "sunset, OK?"
endc

	done

CeladonMansionRoofHousePharmacistStoryText: 
if DEF(_FR_FR)
	text "Il était une fois,"
	line "un petit garçon"

	para "qui reçut une nou-"
	line "velle BICYCLETTE."

	para "Il voulut l'essa-"
	line "yer tout de suite."

	para "Il s'amusait et"
	line "n'avait pas remar-"

	para "qué que la nuit"
	line "commençait à"
	cont "tomber..."

	para "Tout en pédalant"
	line "comme un furieux"

	para "pour rentrer chez"
	line "lui dans la nuit"
	cont "noire, son vélo"
	cont "ralentit!"

	para "Les pédales devin-"
	line "rent lourdes!"

	para "Epuisé, il s'arrê-"
	line "ta mais la bicy-"

	para "clette roula vers"
	line "l'arrière!"

	para "Il lui semblait"
	line "que le vélo était"

	para "maudit et tentait"
	line "de l'entraîner"
	cont "vers les ténèbres!"

	para "..."

	para "......."

	para "YAHAAAAAAHA!"

	para "Il montait en fait"
	line "la pente de la"
	cont "PISTE CYCLABLE!"

	para "..."
	line "Super histoire!"

	para "Merci. Merci."
	line "Tu aimes tant ma"
	cont "belle histoire,"
	cont "voilà pour toi:"
	cont "la CT03!"
else
	text "Once upon a time,"
	line "there was a little"

	para "boy who was given"
	line "a new BICYCLE…"

	para "He wanted to try"
	line "it right away…"

	para "He was having so"
	line "much fun that he"

	para "didn't notice the"
	line "sun had set…"

	para "While riding home"
	line "in the pitch-black"

	para "night, the bike"
	line "suddenly slowed!"

	para "The pedals became"
	line "heavy!"

	para "When he stopped"
	line "pedaling, the bike"

	para "began slipping"
	line "backwards!"

	para "It was as if the"
	line "bike were cursed"

	para "and trying to drag"
	line "him into oblivion!"

	para "…"

	para "…"

	para "SHRIEEEEK!"

	para "The boy had been"
	line "riding uphill on"
	cont "CYCLING ROAD!"

	para "…"
	line "Ba-dum ba-dum!"

	para "For listening so"
	line "patiently, you may"
	cont "take this--TM03!"
endc

	done

CeladonMansionRoofHousePharmacistCurseText: 
if DEF(_FR_FR)
	text "CT03: MALEDICTION."

	para "Une capacité"
	line "terrifiante qui"

	para "épuise doucement"
	line "les PV de la"
	cont "victime."
else
	text "TM03 is CURSE."

	para "It's a terrifying"
	line "move that slowly"

	para "whittles down the"
	line "victim's HP."
endc

	done

CeladonMansionRoofHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, CELADON_MANSION_ROOF, 3
	warp_event  3,  7, CELADON_MANSION_ROOF, 3

	def_coord_events

	def_bg_events
	bg_event  7,  1, BGEVENT_READ, CeladonMansionRoofHouseRadio

	def_object_events
	object_event  3,  2, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 2, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonMansionRoofHousePharmacistScript, -1
