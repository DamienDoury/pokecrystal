	object_const_def
	const DAYOFWEEKSIBLINGSHOUSE_POKEDEX

DayOfWeekSiblingsHouse_MapScripts:
	def_scene_scripts

	def_callbacks

DayOfWeekSiblingsHousePokedexScript:
	opentext
	writetext DayOfWeekSiblingsHousePokedexText1
	yesorno
	iffalse .End
	writetext DayOfWeekSiblingsHousePokedexText2
	yesorno
	iffalse .End
	writetext DayOfWeekSiblingsHousePokedexText3
	waitbutton
.End:
	closetext
	end

DayOfWeekSiblingsHousePokedexText1: 
if DEF(_FR_FR)
	text "Il y a quelque"
	line "chose d'écrit."

	para "Lire?"
else
	text "There's something"
	line "written here."

	para "Read it?"
endc

	done

DayOfWeekSiblingsHousePokedexText2: 
if DEF(_FR_FR)
	text "A mes frères et"
	line "soeurs:"

	para "Nous devons aider"
	line "les dresseurs de"
	cont "#MON."

	para "Quand un dresseur"
	line "vient vous parler,"
	cont "donnez-lui un"
	cont "objet."

	para "Bisous,"
	line "LUCIE"

	para "Continuer à lire?"
else
	text "To my brothers and"
	line "sisters:"

	para "We take pride in"
	line "serving #MON"
	cont "trainers."

	para "When trainers talk"
	line "to you, give them"
	cont "something useful."

	para "Love,"
	line "MONICA"

	para "Keep reading?"
endc

	done

DayOfWeekSiblingsHousePokedexText3: 
if DEF(_FR_FR)
	text "Lundi, LUCIE"
	line "ROUTE 40"

	para "Mardi, MARIE"
	line "ROUTE 29"

	para "Mercredi, HOMER"
	line "LAC COLERE"

	para "Jeudi, JEROME"
	line "ROUTE 36"

	para "Vendredi, VANESSA"
	line "ROUTE 32"

	para "Samedi, SAMUEL"
	line "EBENELLE"

	para "Dimanche, DIMITRI"
	line "ROUTE 37"
else
	text "Monday, MONICA"
	line "ROUTE 40"

	para "Tuesday, TUSCANY"
	line "ROUTE 29"

	para "Wednesday, WESLEY"
	line "LAKE OF RAGE"

	para "Thursday, ARTHUR"
	line "ROUTE 36"

	para "Friday, FRIEDA"
	line "ROUTE 32"

	para "Saturday, SANTOS"
	line "BLACKTHORN CITY"

	para "Sunday, SUNNY"
	line "ROUTE 37"
endc

	done

DayOfWeekSiblingsHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, ROUTE_26, 3
	warp_event  3,  7, ROUTE_26, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  3, SPRITE_POKEDEX, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DayOfWeekSiblingsHousePokedexScript, -1
