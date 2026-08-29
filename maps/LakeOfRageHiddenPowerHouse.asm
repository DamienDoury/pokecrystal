	object_const_def
	const LAKEOFRAGEHIDDENPOWERHOUSE_FISHER

LakeOfRageHiddenPowerHouse_MapScripts:
	def_scene_scripts

	def_callbacks

AorAnStringBuffer1:
	loadmem wStringBuffer5, "@"

	farscall IsVowelFromStringBuffer1
	iftrue .an
	end

.an
	loadmem wStringBuffer5, "n"
	loadmem wStringBuffer5 + 1, "@"
	end

HiddenPowerGuy:
	faceplayer
	opentext
	checkitem TM_HIDDEN_POWER
	iftrue .AlreadyGotItem
	writetext HiddenPowerGuyText1
	promptbutton
	verbosegiveitem TM_HIDDEN_POWER
	writetext HiddenPowerGuyText2
	waitbutton
	closetext
	end
.AlreadyGotItem:
	writetext HiddenPowerGuyText_GiveHelp
	waitbutton
	callasm SelectMonForHiddenPowerReveal
	ifequal -1, .cancelled
	ifequal -2, .egg

	scall AorAnStringBuffer1
	writetext HiddenPowerGuyText_Answer1
	promptbutton
	writetext HiddenPowerGuyText_Answer2

.closetext:
	waitbutton
	closetext
	end

.cancelled:
	writetext HiddenPowerGuyText3
	sjump .closetext

.egg:
	writetext HiddenPowerGuyText_Egg
	sjump .closetext

HiddenPowerHouseBookshelf:
	jumpstd DifficultBookshelfScript

HiddenPowerHouseRadio:
	jumpstd Radio3Script

HiddenPowerGuyText1: 
if DEF(_FR_FR)
	text "...Tu as bien"
	line "voyagé..."

	para "Moi, j'ai médité."
	line "Au fond de moi une"

	para "nouvelle force"
	line "s'est réveillée."

	para "Laisse-moi parta-"
	line "ger mon pouvoir"

	para "avec tes #MON."
	line "Prends-ça."
else
	text "…You have strayed"
	line "far…"

	para "Here I have medi-"
	line "tated. Inside me,"

	para "a new power has"
	line "been awakened."

	para "Let me share my"
	line "power with your"

	para "#MON."
	line "Take this, child."
endc

	done

HiddenPowerGuyText2: 
if DEF(_FR_FR)
	text "Tu vois? C'est"
	line "PUIS.CACHEE!"

	para "Elle prolonge la"
	line "puissance de tes"
	cont "#MON."

	para "Rappelle-toi: cela"
	line "dépend du type et"
	cont "de la puissance du"
	cont "#MON utilisé."
else
	text "Do you see it? It"
	line "is HIDDEN POWER!"

	para "It draws out the"
	line "power of #MON"
	cont "for attacking."

	para "Remember this: its"
	line "type and power de-"
	cont "pend on the #-"
	cont "MON using it."
endc

	done

HiddenPowerGuyText_GiveHelp: 
if DEF(_FR_FR)
	text "Je peux sentir la"
	line "puissance cachée"
	cont "de tes #MON."
else
	text "I can sense the"
	line "hidden power of"
	cont "your #MON."
endc

	done

HiddenPowerGuyText_Answer1:
if DEF(_FR_FR)
	text "Ton @"
	text_ram wStringBuffer3 
	text "..."
	line "... Hmmm."
else
	text "Your @"
	text_ram wStringBuffer3 
	text "…"
	line "…Hmmm."
endc

	done

HiddenPowerGuyText_Answer2:
if DEF(_FR_FR)
	text "Je vois une"
	line "puissance cachée"
	cont "de type @"
	text_ram wStringBuffer1 
	text "."
else
	text "I see a@"
	text_ram wStringBuffer5
	text " @"
	text_ram wStringBuffer1 
	text "-"
	line "type hidden power."
endc

	done

HiddenPowerGuyText_Egg:
if DEF(_FR_FR)
	text "Impossible de"
	line "sentir un OEUF."
else
	text "I can't sense an"
	line "EGG."
endc

	done

HiddenPowerGuyText3: 
if DEF(_FR_FR)
	text "Je médite..."
else
	text "I am meditating…"
endc

	done

LakeOfRageHiddenPowerHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, LAKE_OF_RAGE, 1
	warp_event  4,  7, LAKE_OF_RAGE, 1

	def_coord_events

	def_bg_events
	bg_event  1,  1, BGEVENT_READ, HiddenPowerHouseBookshelf
	bg_event  2,  1, BGEVENT_READ, HiddenPowerHouseRadio

	def_object_events
	object_event  2,  3, SPRITE_FISHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, HiddenPowerGuy, -1
