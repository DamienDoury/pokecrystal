	object_const_def
	const CIANWOODPHARMACY_PHARMACIST

CianwoodPharmacy_MapScripts:
	def_scene_scripts
	scene_script .DummyScene

	def_callbacks

.DummyScene:
	end

CianwoodPharmacist:
	faceplayer
	opentext
	checkevent EVENT_GOT_SECRETPOTION_FROM_PHARMACY
	iftrue .Mart
	checkevent EVENT_JASMINE_EXPLAINED_AMPHYS_SICKNESS
	iffalse .Mart
	writetext PharmacistGiveSecretpotionText
	promptbutton
	verbosegiveitem CHLOROQUINE
	waitsfx
	setevent EVENT_GOT_SECRETPOTION_FROM_PHARMACY
	writetext PharmacistDescribeSecretpotionText
	waitbutton
	closetext
	end

.Mart:
	pokemart MARTTYPE_PHARMACY, MART_CIANWOOD
	closetext
	end

CianwoodPharmacyBookshelf:
	jumpstd DifficultBookshelfScript

CianwoodPharmacyRadio:
	jumpstd Radio3Script

PharmacistGiveSecretpotionText: 
if DEF(_FR_FR)
	text "Ton #MON"
	line "semble en pleine"

	para "forme. Quelque"
	line "chose te tracasse?"

	para "..."

	para "Le PHARE #MON"
	line "est en danger?"

	para "J'ai pigé!"

	para "Ca devrait faire"
	line "l'affaire."
else
	text "Your #MON ap-"
	line "pear to be fine."

	para "Is something wor- "
	line "rying you?"

	para "…"

	para "The LIGHTHOUSE"
	line "#MON is in"
	cont "trouble?"

	para "I got it!"

	para "This ought to do"
	line "the trick."
endc

	done

PharmacistDescribeSecretpotionText:
if DEF(_FR_FR)
	text "Ma CHLOROQUINE"
	line "est un tantinet"

	para "trop forte. Je ne"
	line "l'offre qu'en cas"
	cont "d'extrême urgence."
	done
else
	text "My CHLOROQUINE is"
	line "a tad too strong."

	para "I only offer it in"
	line "an emergency."
	done
endc

CianwoodPharmacy_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, CIANWOOD_CITY, 4
	warp_event  3,  7, CIANWOOD_CITY, 4

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, CianwoodPharmacyBookshelf
	bg_event  1,  1, BGEVENT_READ, CianwoodPharmacyBookshelf
	bg_event  7,  1, BGEVENT_READ, CianwoodPharmacyRadio

	def_object_events
	object_event  2,  3, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CianwoodPharmacist, EVENT_JASMINE_RETURNED_TO_GYM
