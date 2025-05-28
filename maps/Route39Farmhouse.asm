ROUTE39FARMHOUSE_MILK_PRICE EQU 500

	object_const_def
	const ROUTE39FARMHOUSE_POKEFAN_M
	const ROUTE39FARMHOUSE_POKEFAN_F
	const ROUTE39FARMHOUSE_TWIN1
	const ROUTE39FARMHOUSE_TWIN2

Route39Farmhouse_MapScripts:
	def_scene_scripts

	def_callbacks

PokefanM_DairyFarmer:
	faceplayer
	opentext
	checkevent EVENT_BLACKTHORN_CITY_GRAMPS_BLOCKS_DRAGONS_DEN ; Moomoo died (whether or not the player saved her first).
	iftrue FarmerMScript_SellMilk
	checkevent EVENT_HEALED_MOOMOO
	iftrue FarmerMScript_SellMilk
	writetext FarmerMText_SickCow
	waitbutton
	closetext
	setevent EVENT_TALKED_TO_FARMER_ABOUT_MOOMOO
	end

FarmerMScript_SellMilk:
	checkitem MOOMOO_MILK
	iftrue FarmerMScript_Milking
	writetext FarmerMText_BuyMilk
	special PlaceMoneyTopRight
	yesorno
	iffalse FarmerMScript_NoSale
	checkmoney YOUR_MONEY, ROUTE39FARMHOUSE_MILK_PRICE
	ifequal HAVE_LESS, FarmerMScript_NoMoney
	giveitem MOOMOO_MILK
	iffalse FarmerMScript_NoRoom
	takemoney YOUR_MONEY, ROUTE39FARMHOUSE_MILK_PRICE
	special PlaceMoneyTopRight
	waitsfx
	playsound SFX_TRANSACTION
	writetext FarmerMText_GotMilk
	promptbutton
	itemnotify
	closetext
	end

FarmerMScript_NoMoney:
	writetext FarmerMText_NoMoney
	waitbutton
	closetext
	end

FarmerMScript_NoRoom:
	writetext FarmerMText_NoRoom
	waitbutton
	closetext
	end

FarmerMScript_NoSale:
	writetext FarmerMText_NoSale
	waitbutton
	closetext
	end

FarmerMScript_Milking:
	writetext FarmerMText_Milking
	waitbutton
	closetext
	end

PokefanF_SnoreFarmer:
	faceplayer
	opentext
	checkitem TM_SNORE
	iftrue FarmerFScript_GotSnore
	checkevent EVENT_HEALED_MOOMOO
	iftrue FarmerFScript_GiveSnore
	checkevent EVENT_BLACKTHORN_CITY_GRAMPS_BLOCKS_DRAGONS_DEN ; Moomoo died (whether or not the player saved her first).
	iftrue FarmerFScript_MoomooDead
	writetext FarmerFText_InTrouble
	waitbutton
	closetext
	end

FarmerFScript_GiveSnore:
	writetext FarmerFText_HealedMiltank
	promptbutton
	verbosegiveitem TM_SNORE
	iffalse FarmerFScript_NoRoomForSnore
	setevent EVENT_DARK_CAVE_BLACKTHORN_ENTRANCE_TM_SNORE
FarmerFScript_GotSnore:
	writetext FarmerFText_SnoreSpeech
	waitbutton
FarmerFScript_NoRoomForSnore:
	closetext
	end

FarmerFScript_MoomooDead:
	writetext FarmerMText_Milking
	waitbutton
	closetext
	end

PokefanF_Twin1:
	faceplayer
	opentext
	writetext Twin1Text
	waitbutton
	closetext
	turnobject ROUTE39FARMHOUSE_TWIN1, UP
	end

PokefanF_Twin2:
	jumptextfaceplayer Twin2Text

FarmhouseBookshelf:
	jumpstd PictureBookshelfScript

FarmerMText_SickCow: ; TO TRANSLATE
	text "My MILTANK ain't"
	line "givin' me milk"
	cont "n'more."

	para "This here FARM's"
	line "got famous milk."

	para "Most everyone"
	line "wants a drink."

	para "It'll give me lots"
	line "o' milk if'n I"

	para "feed it lots o'"
	line "ORAN BERRIES,"
	cont "I reckon."
	done

FarmerMText_BuyMilk: 
if DEF(_FR_FR)
	text "Ca te dit du bon"
	line "LAIT MEUMEU?"

	para "C'est ma fierté et"
	line "ma joie, poussin."

	para "Donnes-en à tes"
	line "#MON pour en"
	cont "gagner des PV!"

	para "Pour juste {d:ROUTE39FARMHOUSE_MILK_PRICE}¥"
	line "je te l'offre."
	cont "Pour sûr!"
else
	text "How'd you like my"
	line "MOOMOO MILK?"

	para "It's my pride and"
	line "joy, there."

	para "Give it to #MON"
	line "to restore HP!"

	para "I'll give it to ya"
	line "fer just ¥{d:ROUTE39FARMHOUSE_MILK_PRICE}."
endc

	done

FarmerMText_GotMilk: 
if DEF(_FR_FR)
	text "Tiens, poussin!"
	line "Bien à toi!"
else
	text "Here ya go!"
	line "Drink up'n enjoy!"
endc

	done

FarmerMText_NoMoney: 
if DEF(_FR_FR)
	text "Dommage, t'as pas"
	line "de mitraille!"
else
	text "Sorry, there."
	line "No cash, no sale!"
endc

	done

FarmerMText_NoRoom: 
if DEF(_FR_FR)
	text "T'as pas de place,"
	line "mon poussin."
else
	text "I reckon yer"
	line "PACK's full."
endc

	done

FarmerMText_NoSale: 
if DEF(_FR_FR)
	text "Il en veut pas?"
	line "A plus tard."
else
	text "You don't want it?"
	line "Come again, hear?"
endc

	done

FarmerMText_Milking: 
if DEF(_FR_FR)
	text "Bon. J'ai à"
	line "traire."
else
	text "I best go do my"
	line "milkin'."
endc

	done

FarmerFText_InTrouble: 
if DEF(_FR_FR)
	text "Notre lait est mê-"
	line "me vendu à KANTO."

	para "Si notre fidèle"
	line "ECREMEUH ne donne"

	para "plus de lait,"
	line "c'est la faillite."
else
	text "Our milk even goes"
	line "out to KANTO."

	para "So if our own"
	line "MILTANK won't give"

	para "us any milk, we're"
	line "in trouble."
endc

	done

FarmerFText_HealedMiltank: ; TO TRANSLATE
	text "You helped our"
	line "MOOMOO, hon."

	para "Here's somethin'"
	line "fer your trouble."
	done

FarmerFText_SnoreSpeech: 
if DEF(_FR_FR)
	text "C'est eul'fameux"
	line "RONFLEMENT."

	para "C'est un coup rare"
	line "qui marche que"

	para "quand eul'#MON"
	line "il dort."

	para "Alors à toi eud'"
	line "faire ta stratégie"
	cont "mon p'tit poussin."
else
	text "That there's"
	line "SNORE."

	para "It's a rare move"
	line "that only works"

	para "while the #MON"
	line "is asleep."

	para "You best think how"
	line "you ought to use"
	cont "it, hon."
endc

	done

Twin1Text: ; TO TRANSLATE
	text "I miss MOOMOO…"
	done

Twin2Text: ; TO TRANSLATE
	text "In the end, the"
	line "illness was"
	cont "stronger than"
	cont "MOOMOO."

	para "It's sad, she was"
	line "my favorite."
	done

Route39Farmhouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, ROUTE_39, 2
	warp_event  3,  7, ROUTE_39, 2

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, FarmhouseBookshelf
	bg_event  1,  1, BGEVENT_READ, FarmhouseBookshelf

	def_object_events
	object_event  3,  2, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, PokefanM_DairyFarmer, -1
	object_event  5,  4, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, PokefanF_SnoreFarmer, -1
	object_event  2,  2, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, PokefanF_Twin1, EVENT_BLACKTHORN_CITY_GRAMPS_NOT_BLOCKING_DRAGONS_DEN
	object_event  1,  4, SPRITE_TWIN, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, PokefanF_Twin2, EVENT_BLACKTHORN_CITY_GRAMPS_NOT_BLOCKING_DRAGONS_DEN
