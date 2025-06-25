	object_const_def
	const BILLSHOUSE_GRAMPS
	const BILLSHOUSE_TRADE_MON
	const BILLSHOUSE_TUBE_ANIM_1
	const BILLSHOUSE_TUBE_ANIM_2

BillsHouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .EnterCallback

.EnterCallback:
    disappear BILLSHOUSE_TRADE_MON
	disappear BILLSHOUSE_TUBE_ANIM_1
	disappear BILLSHOUSE_TUBE_ANIM_2
    setval 2 ; Used in engine/overworld/overworld.asm:GetMonSprite.HospitalMon
    writemem wSickMonIsInThisRoom
    endcallback

BillsGrandpa:
	faceplayer
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .JustShowedSomething
	checkevent EVENT_GOT_THUNDERSTONE_FROM_BILLS_GRANDPA
	iftrue .GotThunderstone
	checkevent EVENT_MET_BILLS_GRANDPA
	iftrue .MetGrandpa
	writetext BillsGrandpaIntroText
	promptbutton
	setevent EVENT_MET_BILLS_GRANDPA
.MetGrandpa:
	checkevent EVENT_SHOWED_PICHU_TO_BILLS_GRANDPA
	iftrue .ShowedPichu
	checkevent EVENT_SHOWED_GROWLITHE_VULPIX_TO_BILLS_GRANDPA
	iftrue .ShowedGrowlitheVulpix
	checkevent EVENT_SHOWED_STARYU_TO_BILLS_GRANDPA
	iftrue .ShowedStaryu
	checkevent EVENT_SHOWED_ODDISH_TO_BILLS_GRANDPA
	iftrue .ShowedOddish
	checkevent EVENT_SHOWED_LICKITUNG_TO_BILLS_GRANDPA
	iftrue .ShowedLickitung
	writetext BillsGrandpaLickitungText
	promptbutton
	writetext BillsGrandpaAskToSeeMonText
	yesorno
	iffalse .SaidNo
	scall .ExcitedToSee
	special BillsGrandfather
	iffalse .SaidNo
	ifnotequal LICKITUNG, .WrongPokemon
	scall .CorrectPokemon
	setevent EVENT_SHOWED_LICKITUNG_TO_BILLS_GRANDPA
	sjump .ShowedLickitung

.GotEverstone:
	writetext BillsGrandpaOddishText
	promptbutton
	writetext BillsGrandpaAskToSeeMonText
	yesorno
	iffalse .SaidNo
	scall .ExcitedToSee
	special BillsGrandfather
	iffalse .SaidNo
	ifnotequal ODDISH, .WrongPokemon
	scall .CorrectPokemon
	setevent EVENT_SHOWED_ODDISH_TO_BILLS_GRANDPA
	sjump .ShowedOddish

.GotLeafStone:
	writetext BillsGrandpaStaryuText
	promptbutton
	writetext BillsGrandpaAskToSeeMonText
	yesorno
	iffalse .SaidNo
	scall .ExcitedToSee
	special BillsGrandfather
	iffalse .SaidNo
	ifnotequal STARYU, .WrongPokemon
	scall .CorrectPokemon
	setevent EVENT_SHOWED_STARYU_TO_BILLS_GRANDPA
	sjump .ShowedStaryu

.GotWaterStone:
	checkver
	iftrue .AskVulpix
	writetext BillsGrandpaGrowlitheText
	promptbutton
	writetext BillsGrandpaAskToSeeMonText
	yesorno
	iffalse .SaidNo
	scall .ExcitedToSee
	special BillsGrandfather
	iffalse .SaidNo
	ifnotequal GROWLITHE, .WrongPokemon
	scall .CorrectPokemon
	setevent EVENT_SHOWED_GROWLITHE_VULPIX_TO_BILLS_GRANDPA
	sjump .ShowedGrowlitheVulpix

.AskVulpix:
	writetext BillsGrandpaVulpixText
	promptbutton
	writetext BillsGrandpaAskToSeeMonText
	yesorno
	iffalse .SaidNo
	scall .ExcitedToSee
	special BillsGrandfather
	iffalse .SaidNo
	ifnotequal VULPIX, .WrongPokemon
	scall .CorrectPokemon
	setevent EVENT_SHOWED_GROWLITHE_VULPIX_TO_BILLS_GRANDPA
	sjump .ShowedGrowlitheVulpix

.GotFireStone:
	writetext BillsGrandpaPichuText
	promptbutton
	writetext BillsGrandpaAskToSeeMonText
	yesorno
	iffalse .SaidNo
	scall .ExcitedToSee
	special BillsGrandfather
	iffalse .SaidNo
	ifnotequal PICHU, .WrongPokemon
	scall .CorrectPokemon
	setevent EVENT_SHOWED_PICHU_TO_BILLS_GRANDPA
	sjump .ShowedPichu

.ShowedLickitung:
	checkevent EVENT_GOT_EVERSTONE_FROM_BILLS_GRANDPA
	iftrue .GotEverstone
	scall .ReceiveItem
	verbosegiveitem EVERSTONE
	iffalse .BagFull
	setevent EVENT_GOT_EVERSTONE_FROM_BILLS_GRANDPA
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	closetext
	end

.ShowedOddish:
	checkevent EVENT_GOT_LEAF_STONE_FROM_BILLS_GRANDPA
	iftrue .GotLeafStone
	scall .ReceiveItem
	verbosegiveitem LEAF_STONE
	iffalse .BagFull
	setevent EVENT_GOT_LEAF_STONE_FROM_BILLS_GRANDPA
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	closetext
	end

.ShowedStaryu:
	checkevent EVENT_GOT_WATER_STONE_FROM_BILLS_GRANDPA
	iftrue .GotWaterStone
	scall .ReceiveItem
	verbosegiveitem WATER_STONE
	iffalse .BagFull
	setevent EVENT_GOT_WATER_STONE_FROM_BILLS_GRANDPA
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	closetext
	end

.ShowedGrowlitheVulpix:
	checkevent EVENT_GOT_FIRE_STONE_FROM_BILLS_GRANDPA
	iftrue .GotFireStone
	scall .ReceiveItem
	verbosegiveitem FIRE_STONE
	iffalse .BagFull
	setevent EVENT_GOT_FIRE_STONE_FROM_BILLS_GRANDPA
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	closetext
	end

.ShowedPichu:
	scall .ReceiveItem
	verbosegiveitem THUNDERSTONE
	iffalse .BagFull
	setevent EVENT_GOT_THUNDERSTONE_FROM_BILLS_GRANDPA
	closetext
	end

.ExcitedToSee:
	writetext BillsGrandpaExcitedToSeeText
	promptbutton
	end

.SaidNo:
	writetext BillsGrandpaYouDontHaveItTextText
	waitbutton
	closetext
	end

.CorrectPokemon:
	writetext BillsGrandpaShownPokemonText
	promptbutton
	end

.ReceiveItem:
	writetext BillsGrandpaTokenOfAppreciationText
	promptbutton
	end

.JustShowedSomething:
	writetext BillsGrandpaComeAgainText
	waitbutton
	closetext
	end

.GotThunderstone:
	writetext BillsGrandpaShownAllThePokemonText
	waitbutton
	closetext
	end

.WrongPokemon:
	writetext BillsGrandpaWrongPokemonText
	waitbutton
	closetext
	end

.BagFull:
	closetext
	end

BillsHouse_TubeAnim_LeftToRight:
	appear BILLSHOUSE_TUBE_ANIM_1
	appear BILLSHOUSE_TUBE_ANIM_2

	loadmem wTubeAnimX, $60
	loadmem wObject2SpriteX, $60
	loadmem wObject3SpriteX, $60
	loadmem wObject2SpriteY, $25
	loadmem wObject3SpriteY, $25
	reloadmappart

.anim_loop
	readmem wTubeAnimX
	addval 1
	writemem wTubeAnimX
	writemem wObject2SpriteX
	writemem wObject3SpriteX
	turnobject BILLSHOUSE_TUBE_ANIM_1, UP
	turnobject BILLSHOUSE_TUBE_ANIM_2, UP
	reloadmappart

	addval 1
	writemem wTubeAnimX
	writemem wObject2SpriteX
	writemem wObject3SpriteX
	turnobject BILLSHOUSE_TUBE_ANIM_1, DOWN
	turnobject BILLSHOUSE_TUBE_ANIM_2, DOWN
	reloadmappart
	ifless $78, .anim_loop

	;loadmem wObject2SpriteX, $f0
	;loadmem wObject3SpriteX, $f0
	disappear BILLSHOUSE_TUBE_ANIM_1
	disappear BILLSHOUSE_TUBE_ANIM_2
	reloadmappart
	end

BillsHouse_TubeAnim_RightToLeft:
	appear BILLSHOUSE_TUBE_ANIM_1
	appear BILLSHOUSE_TUBE_ANIM_2

	loadmem wTubeAnimX, $28
	loadmem wObject2SpriteX, $28
	loadmem wObject3SpriteX, $28
	loadmem wObject2SpriteY, $25
	loadmem wObject3SpriteY, $25
	reloadmappart

	.anim_loop
	readmem wTubeAnimX
	addval -1
	writemem wTubeAnimX
	writemem wObject2SpriteX
	writemem wObject3SpriteX
	turnobject BILLSHOUSE_TUBE_ANIM_1, UP
	turnobject BILLSHOUSE_TUBE_ANIM_2, UP
	reloadmappart

	addval -1
	writemem wTubeAnimX
	writemem wObject2SpriteX
	writemem wObject3SpriteX
	turnobject BILLSHOUSE_TUBE_ANIM_1, DOWN
	turnobject BILLSHOUSE_TUBE_ANIM_2, DOWN
	reloadmappart
	ifgreater $10, .anim_loop

	;loadmem wObject2SpriteX, $f0
	;loadmem wObject3SpriteX, $f0
	disappear BILLSHOUSE_TUBE_ANIM_1
	disappear BILLSHOUSE_TUBE_ANIM_2
	reloadmappart
	end

BillsHouseVatDoorScript:
	opentext
	writetext BillsHouseVatDoorAskPokemonText
	yesorno
	iffalse .close_text

	callasm SelectMonForBillsMachine
	ifgreater 5, .end ; If the player cancelled, we end the script.

	; Play trade OW animation (bubble moving along trade tube).
	playsound SFX_BALL_POOF
	waitsfx
	pause 15
	playsound SFX_GIVE_TRADEMON
	pause 20
	readvar VAR_XCOORD
	ifgreater 3, .left_vat

; right vat.
	moveobject BILLSHOUSE_TRADE_MON, 6, 3 ; Displaces the Pokémon to the right.
	scall BillsHouse_TubeAnim_LeftToRight
	turnobject PLAYER, RIGHT
	pause 15
	scall .trade_animation
	applymovement PLAYER, BillsHouseWalkFromLeftToRightVatMovement
	sjump .get_mon_out_of_vat

.left_vat
	moveobject BILLSHOUSE_TRADE_MON, 1, 3 ; Displaces the Pokémon to the left.
	scall BillsHouse_TubeAnim_RightToLeft
	turnobject PLAYER, LEFT
	pause 15
	scall .trade_animation
	applymovement PLAYER, BillsHouseWalkFromRightToLeftVatMovement

.get_mon_out_of_vat
	pause 15
	playsound SFX_BALL_POOF
	pause 10
	sjump BillsHouseTradedMonScript

.trade_animation
	callasm StopSFX

	callasm TradeEvo
	iffalse .no_need_to_return_to_map

	callasm ReturnToMap
	special RestartMapMusic
	pause 15

.no_need_to_return_to_map
	appear BILLSHOUSE_TRADE_MON
	reloadmappart
	playsound SFX_BALL_POOF
	waitsfx
	pause 30
	end

.close_text
	closetext
.end
	end

BillsHouseTradedMonScript:
	disappear BILLSHOUSE_TRADE_MON
	end

BillsHouseMachineInstructionsScript:
	jumptext BillsHouseMachineInstructionsText

BillsHouseWalkFromLeftToRightVatMovement:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

BillsHouseWalkFromRightToLeftVatMovement:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step_end

BillsGrandpaIntroText: 
if DEF(_FR_FR)
	text "Tu connais LEO?"
	line "C'est mon"
	cont "petit-fils."

	para "Il est à JOHTO."
	line "Il s'occupe de PC."

	para "Alors moi je m'oc-"
	line "cupe de la maison."
else
	text "Hm? You know BILL?"
	line "He's my grandson."

	para "He's in JOHTO. He"
	line "does something"

	para "with PCs, so I'm"
	line "house-sitting."
endc

	done

BillsGrandpaAskToSeeMonText: 
if DEF(_FR_FR)
	text "Si tu as ce #-"
	line "MON, peux-tu me"
	cont "le montrer?"
else
	text "If you have that"
	line "#MON, may I see"
	cont "it, please?"
endc

	done

BillsGrandpaExcitedToSeeText: 
if DEF(_FR_FR)
	text "Tu vas me le mon-"
	line "trer? Cool!"
else
	text "You will show me?"
	line "How good of you!"
endc

	done

BillsGrandpaYouDontHaveItTextText: 
if DEF(_FR_FR)
	text "Tu ne l'as pas?"
	line "Dommage..."
else
	text "You don't have it?"
	line "That's too bad…"
endc

	done

BillsGrandpaShownPokemonText: 
if DEF(_FR_FR)
	text "Alors c'est"
	line "@"
	text_ram wStringBuffer3
	text "?"

	para "Il est mimi!"
	line "Merci mon p'tit!"
else
	text "Ah, so that is"
	line "@"
	text_ram wStringBuffer3
	text "?"

	para "Isn't it cute!"
	line "That's so kind of"
	cont "you."
endc

	done

BillsGrandpaTokenOfAppreciationText: 
if DEF(_FR_FR)
	text "Toi t'es cool!"

	para "Voilà une petite"
	line "récompense."
else
	text "Thanks!"

	para "This is a token of"
	line "my appreciation."
endc

	done

BillsGrandpaComeAgainText: 
if DEF(_FR_FR)
	text "Rends-moi visite"
	line "des fois."
else
	text "Come visit again"
	line "sometime."
endc

	done

BillsGrandpaShownAllThePokemonText: 
if DEF(_FR_FR)
	text "Merci de me mon-"
	line "trer autant de"
	cont "#MON tout mimi."

	para "C'est vraiment"
	line "très amusant. Ma"

	para "vie est belle"
	line "grâce à toi."
else
	text "Thanks for showing"
	line "me so many cute"
	cont "#MON."

	para "I really enjoyed"
	line "myself. I'm glad"

	para "I've lived such a"
	line "long life."
endc

	done

BillsGrandpaWrongPokemonText: 
if DEF(_FR_FR)
	text "Hmm?"

	para "Ce n'est pas le"
	line "#MON dont on"
	cont "m'a parlé."
else
	text "Hm?"

	para "That's not the"
	line "#MON that I was"
	cont "told about."
endc

	done

BillsGrandpaLickitungText: 
if DEF(_FR_FR)
	text "LEO mon petit-fils"
	line "m'a parlé d'un"

	para "#MON avec une"
	line "longue langue."
else
	text "My grandson BILL"
	line "told me about a"

	para "#MON that has a"
	line "long tongue."
endc

	done

BillsGrandpaOddishText: 
if DEF(_FR_FR)
	text "Mon petit-fils m'a"
	line "parlé d'un #-"

	para "MON vert et rond"
	line "avec des feuilles"
	cont "sur sa tête."
else
	text "Ah, my grandson"
	line "mentioned a round,"

	para "green #MON that"
	line "has leaves growing"
	cont "on its head."
endc

	done

BillsGrandpaStaryuText: 
if DEF(_FR_FR)
	text "Connais-tu un"
	line "#MON marin avec"

	para "une sphère rouge"
	line "dans le corps?"

	para "Tu sais... Celui"
	line "qui est en forme"
	cont "d'étoile?"

	para "On dit qu'il appa-"
	line "raît la nuit."

	para "J'aimerais tant"
	line "le voir."
else
	text "Do you know of a"
	line "sea #MON that"

	para "has a red sphere"
	line "in its body?"

	para "You know, the one"
	line "that's shaped like"
	cont "a star?"

	para "I heard that it"
	line "appears at night."

	para "I would surely"
	line "like to see it."
endc

	done

BillsGrandpaGrowlitheText: 
if DEF(_FR_FR)
	text "LEO m'a parlé d'un"
	line "#MON très loyal"

	para "envers son dres-"
	line "seur."

	para "On dit qu'il HURLE"
	line "très bien."
else
	text "BILL told me about"
	line "a #MON that is"

	para "very loyal to its"
	line "trainer."

	para "It's supposed to"
	line "ROAR well."
endc

	done

BillsGrandpaVulpixText: 
if DEF(_FR_FR)
	text "On m'a parlé d'un"
	line "joli #MON à"
	cont "six queues."

	para "J'aimerais tant"
	line "caresser un #-"
	cont "MON comme ça."
else
	text "I heard about a"
	line "cute #MON that"
	cont "has six tails."

	para "I would love to"
	line "hug a cute #MON"
	cont "like that."
endc

	done

BillsGrandpaPichuText: 
if DEF(_FR_FR)
	text "Tu connais ce"
	line "#MON super"
	cont "populaire?"

	para "Ce #MON qui"
	line "a un corps jaune"
	cont "et des joues"
	cont "rouges..."

	para "J'aimerais tant le"
	line "voir avant qu'il"
	cont "n'évolue."
else
	text "Do you know that"
	line "hugely popular"
	cont "#MON?"

	para "The #MON that"
	line "has a yellow body"
	cont "and red cheeks."

	para "I would love to"
	line "see what it looks"

	para "like before it"
	line "evolves."
endc

	done

BillsHouseMachineInstructionsText:
if DEF(_FR_FR)
	text "-MACHINE PROTOTYPE"
	line "TRANSFERT #MON-"

	para "Instructions:"
	line "Placer 1 #MON"
	cont "dans une cuve."

	para "Il sera transféré"
	line "dans l'autre cuve."

	para "Bugs connus:"

	para "..."
	line "Fin du fichier."
	done
else
	text "-#MON TRANSFER"
	line "MACHINE PROTOTYPE-"

	para "Instructions:"
	line "Insert 1 #MON"
	cont "into a vat."

	para "It should be"
	line "transfered into"
	cont "the other vat."

	para "Known bugs:"
	
	para "…"
	line "End of file."
	done
endc


BillsHouseVatDoorAskPokemonText:
if DEF(_FR_FR)
	text "La machine est"
	line "active."

	para "Veux-tu mettre"
	line "un #MON dedans?"
	done
else
	text "The machine is up"
	line "and running."

	para "Do you want to put"
	line "a #MON inside?"
	done
endc

BillsHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, ROUTE_25, 1
	warp_event  3,  7, ROUTE_25, 1

	def_coord_events

	def_bg_events
	bg_event  2,  4, BGEVENT_UP, BillsHouseMachineInstructionsScript
	bg_event  3,  4, BGEVENT_UP, BillsHouseMachineInstructionsScript
	bg_event  1,  2, BGEVENT_UP, BillsHouseVatDoorScript	
	bg_event  6,  2, BGEVENT_UP, BillsHouseVatDoorScript

	def_object_events
	object_event  5,  5, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 2, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, BillsGrandpa, -1
	object_event  6,  3, SPRITE_HOSPITAL_MON, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 6, OBJECTTYPE_SCRIPT, 0, BillsHouseTradedMonScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event  3,  4, SPRITE_TUBE_TRANSFER_1, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4 ; The {3, 4} position is always visible within this map.
	object_event  3,  4, SPRITE_TUBE_TRANSFER_2, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4 ; The {3, 4} position is always visible within this map.
