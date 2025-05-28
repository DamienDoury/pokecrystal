	object_const_def
	const LAKEOFRAGEHIDDENPOWERHOUSE_FISHER

LakeOfRageHiddenPowerHouse_MapScripts:
	def_scene_scripts

	def_callbacks

HiddenPowerGuy:
	faceplayer
	opentext
	checkevent EVENT_GOT_TM10_HIDDEN_POWER
	iftrue .AlreadyGotItem
	writetext HiddenPowerGuyText1
	promptbutton
	verbosegiveitem TM_HIDDEN_POWER
	iffalse .Done
	setevent EVENT_GOT_TM10_HIDDEN_POWER
	writetext HiddenPowerGuyText2
	waitbutton
	closetext
	end
.AlreadyGotItem:
	writetext HiddenPowerGuyText3
	waitbutton
.Done:
	closetext
	end

HiddenPowerHouseBookshelf:
	jumpstd DifficultBookshelfScript

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

	def_object_events
	object_event  2,  3, SPRITE_FISHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, HiddenPowerGuy, -1
