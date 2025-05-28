	object_const_def
	const CELADONMANSION3F_COOLTRAINER_M_1
	const CELADONMANSION3F_COOLTRAINER_M_2
	const CELADONMANSION3F_GYM_GUIDE
	const CELADONMANSION3F_SUPER_NERD
	const CELADONMANSION3F_FISHER

CeladonMansion3F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .LoadTiles
	
.LoadTiles:
	checkevent EVENT_CONSOLE_SELLER_BACK_IN_STORE
	iftrue .endcallback

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
.endcallback
	endcallback

GameFreakBotheringFanScript:
	faceplayer
	opentext
	writetext GameFreakBotheringFanText1
	waitbutton
	closetext

	turnobject CELADONMANSION3F_COOLTRAINER_M_1, LEFT
	pause 3 ; Damien
	turnobject CELADONMANSION3F_COOLTRAINER_M_1, RIGHT
	pause 2 ; Damien
	turnobject CELADONMANSION3F_COOLTRAINER_M_1, LEFT
	pause 3 ; Damien
	turnobject CELADONMANSION3F_COOLTRAINER_M_1, RIGHT

	opentext
	writetext GameFreakBotheringFanText2
	waitbutton
	closetext

	turnobject CELADONMANSION3F_COOLTRAINER_M_1, DOWN
	pause 1 ; Damien
	turnobject CELADONMANSION3F_COOLTRAINER_M_1, LEFT
	pause 1 ; Damien
	turnobject CELADONMANSION3F_COOLTRAINER_M_1, UP
	pause 1 ; Damien
	turnobject CELADONMANSION3F_COOLTRAINER_M_1, RIGHT
	pause 1 ; Damien
	turnobject CELADONMANSION3F_COOLTRAINER_M_1, DOWN
	pause 1 ; Damien
	turnobject CELADONMANSION3F_COOLTRAINER_M_1, LEFT
	pause 1 ; Damien
	turnobject CELADONMANSION3F_COOLTRAINER_M_1, UP

	pause 25
	showemote EMOTE_SHOCK, CELADONMANSION3F_COOLTRAINER_M_1, 15
	opentext
	writetext GameFreakBotheringFanText3
	waitbutton
	closetext

	applymovement CELADONMANSION3F_COOLTRAINER_M_1, GameFreakRunAwayMovement
	disappear CELADONMANSION3F_COOLTRAINER_M_1
	pause 10
	playsound SFX_EXIT_BUILDING
	clearevent EVENT_CONSOLE_SELLER_BACK_IN_STORE
	end

GameFreakGameDesignerScript:
	faceplayer
	opentext
	writetext GameFreakGameDesignerText
	readvar VAR_DEXCAUGHT
	ifgreater NUM_POKEMON - 2 - 1, .CompletedPokedex ; ignore Mew and Celebi
	waitbutton
	closetext
	end

.CompletedPokedex:
	promptbutton
	writetext GameFreakGameDesignerCompletedPokedexText
	playsound SFX_DEX_FANFARE_230_PLUS
	waitsfx
	writetext GameFreakGameDesignerPauseForDiplomaText
	promptbutton
	special Diploma
	writetext GameFreakGameDesignerAfterDiplomaText
	waitbutton
	closetext
	setevent EVENT_ENABLE_DIPLOMA_PRINTING
	end

GameFreakGraphicArtistScript:
	faceplayer
	opentext
	checkevent EVENT_ENABLE_DIPLOMA_PRINTING
	iftrue .CanPrintDiploma
	writetext GameFreakGraphicArtistText
	waitbutton
	closetext
	end

.CanPrintDiploma:
	writetext GameFreakGraphicArtistPrintDiplomaText
	yesorno
	iffalse .Refused
	special PrintDiploma
	closetext
	end

.Refused:
	writetext GameFreakGraphicArtistRefusedText
	waitbutton
	closetext
	end

GameFreakProgrammerScript:
	jumptextfaceplayer GameFreakProgrammerText

GameFreakCharacterDesignerScript:
	jumptextfaceplayer GameFreakCharacterDesignerText

CeladonMansion3FDevRoomSign:
	jumptext CeladonMansion3FDevRoomSignText

CeladonMansion3FDrawing:
	jumptext CeladonMansion3FDrawingText

CeladonMansion3FGameProgram:
	jumptext CeladonMansion3FGameProgramText

CeladonMansion3FReferenceMaterial:
	jumptext CeladonMansion3FReferenceMaterialText

GameFreakRunAwayMovement:
	big_step RIGHT
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	step_end

GameFreakBotheringFanText1: ; TO TRANSLATE
	text "I avoided the"
	line "security guards"
	cont "to come and see"
	cont "my heroes!"

	para "I want to see"
	line "what they are"
	cont "working on!"
	done

GameFreakBotheringFanText2: ; TO TRANSLATE
	text "Could you take"
	line "a picture of me?"
	cont "Maybe I should"
	cont "apply for a"
	cont "position?"

	para "I'm so excited!!"
	line "Hyaaa!!"
	done

GameFreakBotheringFanText3: ; TO TRANSLATE
	text "I have no right"
	line "to be here."

	para "I should go back"
	line "to my shop now."
	done

GameFreakGameDesignerText: ; TO TRANSLATE
	text "SATOSHI TAJIRI: Is"
	line "that right?"

	para "I'm the GAME"
	line "DESIGNER!"

	para "Filling up your"
	line "#DEX is tough,"
	cont "but don't give up!"
	done

GameFreakGameDesignerCompletedPokedexText: ; TO TRANSLATE
	text "SATOSHI TAJIRI:"
	line "Wow! Excellent!"
	cont "You completed your"
	cont "#DEX!"

	para "Congratulations!"
	done

GameFreakGameDesignerPauseForDiplomaText:
	text "…"
	done

GameFreakGameDesignerAfterDiplomaText: 
if DEF(_FR_FR)
	text "L'ARTISTE GRAPHI-"
	line "QUE va imprimer un"
	cont "DIPLOME pour toi."

	para "Va te vanter, mon"
	line "petit."
else
	text "The GRAPHIC ARTIST"
	line "will print out a"
	cont "DIPLOMA for you."

	para "You should go show"
	line "it off."
endc

	done

GameFreakGraphicArtistText: ; TO TRANSLATE
	text "KEN SUGIMORI: I'm"
	line "the GRAPHIC"
	cont "ARTIST."

	para "I drew you!"
	done

GameFreakGraphicArtistPrintDiplomaText: ; TO TRANSLATE
	text "KEN SUGIMORI: I'm"
	line "the GRAPHIC"
	cont "ARTIST."

	para "Oh, you completed"
	line "your #DEX?"

	para "Want me to print"
	line "out your DIPLOMA?"
	done

GameFreakGraphicArtistRefusedText: 
if DEF(_FR_FR)
	text "Appelle-moi si tu"
	line "veux que j'imprime"
	cont "ton DIPLOME."
else
	text "Give me a shout if"
	line "you want your"
	cont "DIPLOMA printed."
endc

	done

GameFreakGraphicArtistErrorText: 
if DEF(_FR_FR)
	text "Ca ne marche pas."
	line "Je ne peux pas"
	cont "imprimer."
else
	text "Something's wrong."
	line "I'll have to can-"
	cont "cel printing."
endc

	done

GameFreakProgrammerText: ; TO TRANSLATE
	text "TETSUYA WATANABE:"
	line "Who, me? I'm the"
	cont "PROGRAMMER."

	para "Play the slot"
	line "machines!"
	done

GameFreakCharacterDesignerText: ; TO TRANSLATE
	text "KOHJI NISHINO:"
	line "Aren't the TWINS"
	cont "adorable?"

	para "JASMINE's pretty"
	line "too."

	para "Oh, I love them!"
	done

CeladonMansion3FDevRoomSignText: 
if DEF(_FR_FR)
	text "GAME FREAK"
	line "SALLE de"
	cont "DEVELOPPEMENT"
else
	text "GAME FREAK"
	line "DEVELOPMENT ROOM"
endc

	done

CeladonMansion3FDrawingText: 
if DEF(_FR_FR)
	text "C'est le dessin"
	line "d'une jolie fille."
else
	text "It's a detailed"
	line "drawing of a"
	cont "pretty girl."
endc

	done

CeladonMansion3FGameProgramText: 
if DEF(_FR_FR)
	text "C'est le programme"
	line "du jeu. Si on y"

	para "touche, il y aura"
	line "des bogues!"
else
	text "It's the game"
	line "program. Messing"

	para "with it could put"
	line "a bug in the game!"
endc

	done

CeladonMansion3FReferenceMaterialText: 
if DEF(_FR_FR)
	text "Il y a plein de"
	line "produits dérivés."
	cont "Il y a même une"
	cont "# POUPEE."
else
	text "It's crammed with"
	line "reference materi-"
	cont "als. There's even"
	cont "a # DOLL."
endc

	done

CeladonMansion3F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  0, CELADON_MANSION_ROOF, 1
	warp_event  1,  0, CELADON_MANSION_2F, 2
	warp_event  6,  0, CELADON_MANSION_2F, 3
	warp_event  7,  0, CELADON_MANSION_ROOF, 2

	def_coord_events

	def_bg_events
	bg_event  5,  8, BGEVENT_UP, CeladonMansion3FDevRoomSign
	bg_event  4,  3, BGEVENT_UP, CeladonMansion3FDrawing
	bg_event  1,  6, BGEVENT_UP, CeladonMansion3FGameProgram
	bg_event  1,  3, BGEVENT_UP, CeladonMansion3FReferenceMaterial

	def_object_events
	object_event  5,  9, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GameFreakBotheringFanScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  2,  6, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GameFreakGameDesignerScript, -1
	object_event  3,  4, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GameFreakGraphicArtistScript, -1
	object_event  0,  7, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, GameFreakProgrammerScript, -1
	object_event  0,  4, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 2, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GameFreakCharacterDesignerScript, -1
