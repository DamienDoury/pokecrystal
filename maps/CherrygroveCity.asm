	object_const_def
	const CHERRYGROVECITY_TRAVEL_CONTROLLER
	const CHERRYGROVECITY_GRAMPS
	const CHERRYGROVECITY_SILVER
	const CHERRYGROVECITY_TEACHER
	const CHERRYGROVECITY_YOUNGSTER
	const CHERRYGROVECITY_FISHER
	const CHERRYGROVECITY_LOCKDOWN_NPC_1
	const CHERRYGROVECITY_LOCKDOWN_NPC_2
	const CHERRYGROVECITY_LOCKDOWN_NPC_3

CherrygroveCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint
	callback MAPCALLBACK_TILES, .TilesLoad

.FlyPoint:
	setflag ENGINE_FLYPOINT_CHERRYGROVE
	endcallback

.TilesLoad:
	readmem wCurFreedomState
	ifnotequal 1 << CURFEW, .EndTilesCallback

	changeblock 22,  2, $37

.EndTilesCallback
	endcallback

CherrygroveCityGuideGent:
	faceplayer
	opentext
	writetext GuideGentIntroText
	yesorno
	iffalse .No
	sjump .Yes
.Yes:
	writetext GuideGentTourText1
	waitbutton
	closetext
	playmusic MUSIC_SHOW_ME_AROUND

	readvar VAR_FACING
	ifequal LEFT, .PlayerWalksLeft
	ifequal RIGHT, .PlayerWalksRight
	applymovement PLAYER, CherrygroveCity_PlayerWalksUpMovement
	sjump .StartFollowGrampForMap

.PlayerWalksLeft:
	applymovement PLAYER, CherrygroveCity_PlayerWalksLeftMovement
	sjump .StartFollowGrampForMap

.PlayerWalksRight:
	applymovement PLAYER, CherrygroveCity_PlayerWalksRightMovement
	sjump .StartFollowGrampForMap

.StartFollowGrampForMap:
	follow CHERRYGROVECITY_GRAMPS, PLAYER
	applymovement CHERRYGROVECITY_GRAMPS, GuideGentMovement1
	opentext
	writetext GuideGentPokecenterText
	waitbutton
	closetext
	applymovement CHERRYGROVECITY_GRAMPS, GuideGentMovement2
	turnobject PLAYER, UP
	opentext
	writetext GuideGentMartText
	waitbutton
	closetext
	applymovement CHERRYGROVECITY_GRAMPS, GuideGentMovement3
	turnobject PLAYER, UP
	opentext
	writetext GuideGentRoute30Text
	waitbutton
	closetext
	applymovement CHERRYGROVECITY_GRAMPS, GuideGentMovement4
	turnobject PLAYER, LEFT
	opentext
	writetext GuideGentSeaText
	waitbutton
	closetext
	applymovement CHERRYGROVECITY_GRAMPS, GuideGentMovement5
	stopfollow
	applymovement CHERRYGROVECITY_GRAMPS, CherrygroveCity_PlayerWalksRightMovement
	turnobject CHERRYGROVECITY_GRAMPS, UP
	turnobject PLAYER, UP
	pause 60
	turnobject CHERRYGROVECITY_GRAMPS, LEFT
	turnobject PLAYER, RIGHT
	opentext
	writetext GuideGentGiftText
	promptbutton
	getstring STRING_BUFFER_4, .mapcardname
	scall .JumpstdReceiveItem
	setflag ENGINE_MAP_CARD
	writetext GotMapCardText
	promptbutton
	writetext GuideGentPokegearText
	waitbutton
	closetext
	special RestartMapMusic
	turnobject PLAYER, UP
	applymovement CHERRYGROVECITY_GRAMPS, GuideGentMovement6
	playsound SFX_ENTER_DOOR
	disappear CHERRYGROVECITY_GRAMPS
	clearevent EVENT_GUIDE_GENT_VISIBLE_IN_CHERRYGROVE
	waitsfx
	end

.JumpstdReceiveItem:
	jumpstd ReceiveItemScript

.mapcardname 
if DEF(_FR_FR)
	db "CPN CARTE@"

else
	db "MAP CARD@"

endc

.No:
	writetext GuideGentNoText
	waitbutton
	closetext
	end

CherrygroveSilverSceneSouth:
	moveobject CHERRYGROVECITY_SILVER, 39, 7
CherrygroveSilverSceneNorth:
	turnobject PLAYER, RIGHT
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	pause 15
	appear CHERRYGROVECITY_SILVER
	applymovement CHERRYGROVECITY_SILVER, CherrygroveCity_RivalWalksToYou
	turnobject PLAYER, RIGHT
	playmusic MUSIC_RIVAL_ENCOUNTER
	opentext
	writetext CherrygroveRivalText_Seen
	waitbutton
	closetext
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .Totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .Chikorita
	winlosstext SilverCherrygroveWinText, SilverCherrygroveLossText
	setlasttalked CHERRYGROVECITY_SILVER
	loadtrainer RIVAL1, RIVAL1_1_TOTODILE
	loadvar VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	startbattle
	dontrestartmapmusic
	reloadmap
	iftrue .AfterVictorious
	sjump .AfterYourDefeat

.Totodile:
	winlosstext SilverCherrygroveWinText, SilverCherrygroveLossText
	setlasttalked CHERRYGROVECITY_SILVER
	loadtrainer RIVAL1, RIVAL1_1_CHIKORITA
	loadvar VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	startbattle
	dontrestartmapmusic
	reloadmap
	iftrue .AfterVictorious
	sjump .AfterYourDefeat

.Chikorita:
	winlosstext SilverCherrygroveWinText, SilverCherrygroveLossText
	setlasttalked CHERRYGROVECITY_SILVER
	loadtrainer RIVAL1, RIVAL1_1_CYNDAQUIL
	loadvar VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	startbattle
	dontrestartmapmusic
	reloadmap
	iftrue .AfterVictorious
	sjump .AfterYourDefeat

.AfterVictorious:
	playmusic MUSIC_RIVAL_AFTER
	opentext
	writetext CherrygroveRivalText_YouWon
	waitbutton
	closetext
	sjump .FinishRival

.AfterYourDefeat:
	playmusic MUSIC_RIVAL_AFTER
	opentext
	writetext CherrygroveRivalText_YouLost
	waitbutton
	closetext
.FinishRival:
	playsound SFX_TACKLE
	applymovement PLAYER, CherrygroveCity_RivalPushesYouOutOfTheWay
	turnobject PLAYER, LEFT
	applymovement CHERRYGROVECITY_SILVER, CherrygroveCity_RivalExitsStageLeft
	disappear CHERRYGROVECITY_SILVER
	clearevent EVENT_CHERRYGROVECITY_MEET_RIVAL
	special HealParty
	playmapmusic
	end

CherrygroveTeacherScript:
	checkflag ENGINE_MAP_CARD
	iftrue .HaveMapCard
	jumptextfaceplayer CherrygroveTeacherText_NoMapCard

.HaveMapCard:
	jumptextfaceplayer CherrygroveTeacherText_HaveMapCard

CherrygroveYoungsterScript:
	faceplayer
	opentext
	checkflag ENGINE_POKEDEX
	iftrue .HavePokedex
	writetext CherrygroveYoungsterText_NoPokedex
	waitbutton
	closetext
	end

.HavePokedex:
	writetext CherrygroveYoungsterText_HavePokedex
	waitbutton
	closetext
	end

MysticWaterGuy:
	faceplayer
	opentext
	checkevent EVENT_GOT_MYSTIC_WATER_IN_CHERRYGROVE
	iftrue .After
	writetext MysticWaterGuyTextBefore
	promptbutton
	verbosegiveitem MYSTIC_WATER
	iffalse .Exit
	setevent EVENT_GOT_MYSTIC_WATER_IN_CHERRYGROVE
.After:
	writetext MysticWaterGuyTextAfter
	waitbutton
.Exit:
	closetext
	end

Cherrygrove_DoorScript:
	jumpstd LockdownCurfewClosedDoor

FirstInLineFirstLockdown:
	jumptext FirstInLineFirstLockdownText

MysticWaterGuyFirstLockdown:
	jumptextfaceplayer MysticWaterGuyFirstLockdownText

CooltrainerFirstLockdown:
	jumptextfaceplayer CooltrainerFirstLockdownText

CherrygroveCitySign:
	jumptext CherrygroveCitySignText

GuideGentsHouseSign:
	jumptext GuideGentsHouseSignText

CherrygroveCityPokecenterSign:
	jumpstd PokecenterSignScript

CherrygroveCityMartSign:
	jumpstd MartSignScript

CherrygroveCity_PlayerWalksUpMovement:
	step UP
	step_end

CherrygroveCity_PlayerWalksLeftMovement:
	step LEFT
	step_end

CherrygroveCity_PlayerWalksRightMovement:
	step RIGHT
	step_end

GuideGentMovement1:
	step LEFT
	step LEFT
	step UP
	step LEFT
	turn_head UP
	step_end

GuideGentMovement2:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	turn_head UP
	step_end

GuideGentMovement3:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	turn_head UP
	step_end

GuideGentMovement4:
	step LEFT
	step LEFT
	step LEFT
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	step DOWN
	turn_head LEFT
	step_end

GuideGentMovement5:
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

GuideGentMovement6:
	step UP
	step UP
	step_end

CherrygroveCity_RivalWalksToYou:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step_end

CherrygroveCity_RivalPushesYouOutOfTheWay:
	big_step DOWN
	turn_head UP
	step_end

CherrygroveCity_RivalExitsStageLeft:
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step UP
	big_step UP
	big_step LEFT
	big_step LEFT
	step_end

GuideGentIntroText: 
if DEF(_FR_FR)
	text "Toi, tu débutes,"
	line "non? Ca se voit!"

	para "C'est bon! Tout le"
	line "monde a des"
	cont "défauts!"

	para "Si tu veux, je"
	line "peux t'apprendre"
	cont "deux, trois petits"
	cont "trucs sympa!"
else
	text "You're a rookie"
	line "trainer, aren't"
	cont "you? I can tell!"

	para "That's OK! Every-"
	line "one is a rookie"
	cont "at some point!"

	para "If you'd like, I"
	line "can teach you a"
	cont "few things."
endc

	done

GuideGentTourText1: 
if DEF(_FR_FR)
	text "Bon allez!"
	line "Suis-moi!"
else
	text "OK, then!"
	line "Follow me!"
endc

	done

GuideGentPokecenterText: 
if DEF(_FR_FR)
	text "C'est un CENTRE"
	line "#MON. On y"

	para "soigne les #-"
	line "MON en moins de"
	cont "temps qu'il n'en"
	cont "faut pour le dire!"

	para "Tu en auras grand"
	line "besoin pendant ta"

	para "quête, alors"
	line "apprends à les"
	cont "utiliser."
else
	text "This is a #MON"
	line "CENTER. They heal"

	para "your #MON in no"
	line "time at all."

	para "You'll be relying"
	line "on them a lot, so"

	para "you better learn"
	line "about them."
endc

	done

GuideGentMartText: 
if DEF(_FR_FR)
	text "C'est une BOUTIQUE"
	line "#MON."

	para "On y vend des"
	line "BALLS permettant"

	para "de capturer les"
	line "#MON et"
	cont "plein d'autres"
	cont "objets utiles."
else
	text "This is a #MON"
	line "MART."

	para "They sell BALLS"
	line "for catching wild"

	para "#MON and other"
	line "useful items."
endc

	done

GuideGentRoute30Text: 
if DEF(_FR_FR)
	text "La ROUTE 30 est"
	line "par-là."

	para "Les dresseurs"
	line "s'y affrontent"

	para "avec leurs #MON"
	line "favoris."
else
	text "ROUTE 30 is out"
	line "this way."

	para "Trainers will be"
	line "battling their"

	para "prized #MON"
	line "there."
endc

	done

GuideGentSeaText: 
if DEF(_FR_FR)
	text "Voici la mer."

	para "Certains #MON"
	line "se trouvent"
	cont "uniquement dans"
	cont "l'eau."
else
	text "This is the sea,"
	line "as you can see."

	para "Some #MON are"
	line "found only in"
	cont "water."
endc

	done

GuideGentGiftText: 
if DEF(_FR_FR)
	text "Voilà."

	para "C'est chez moi!"
	line "Merci de m'avoir"
	cont "tenu compagnie."

	para "Je vais te donner"
	line "un p'tit truc."
else
	text "Here…"

	para "It's my house!"
	line "Thanks for your"
	cont "company."

	para "Let me give you a"
	line "small gift."
endc

	done

GotMapCardText: 
if DEF(_FR_FR)
	text "Le #MATOS de"
	line "<PLAYER> contient"
	cont "maintenant une"
	cont "CARTE!"
else
	text "<PLAYER>'s #GEAR"
	line "now has a MAP!"
endc

	done

GuideGentPokegearText: 
if DEF(_FR_FR)
	text "Le #MATOS"
	line "est plus utile"
	cont "lorsqu'on y ajou-"
	cont "te des COUPONS."

	para "Je te souhaite"
	line "bonne chance!"
else
	text "#GEAR becomes"
	line "more useful as you"
	cont "add CARDS."

	para "I wish you luck on"
	line "your journey!"
endc

	done

GuideGentNoText: 
if DEF(_FR_FR)
	text "Oh..."
	line "D'accord."

	para "Viens me voir"
	line "quand tu veux."
else
	text "Oh… It's something"
	line "I enjoy doing…"

	para "Fine. Come see me"
	line "when you like."
endc

	done

CherrygroveRivalText_Seen: 
if DEF(_FR_FR)
	text "<……> <……> <……>"

	para "Tu as un #MON"
	line "du LABO."

	para "Du gâchis, ouais!"
	line "Une mauviette"
	cont "comme toi..."

	para "<……> <……> <……>"

	para "Bon."
	line "J't'aime pas."

	para "Je vais te montrer"
	line "le bon #MON"
	cont "que j'ai moi!"
else
	text "<……> <……> <……>"

	para "You got a #MON"
	line "at the LAB."

	para "What a waste."
	line "A wimp like you."

	para "<……> <……> <……>"

	para "Don't you get what"
	line "I'm saying?"

	para "Well, I too, have"
	line "a good #MON."

	para "I'll show you"
	line "what I mean!"
endc

	done

SilverCherrygroveWinText: 
if DEF(_FR_FR)
	text "Alors?"
	line "C'est la joie?"
else
	text "Humph. Are you"
	line "happy you won?"
endc

	done

CherrygroveRivalText_YouLost: 
if DEF(_FR_FR)
	text "<……> <……> <……>"

	para "Mon nom est ???."

	para "Je serai le plus"
	line "grand dresseur de"
	cont "#MON du"
	cont "monde."
else
	text "<……> <……> <……>"

	para "My name's ???."

	para "I'm going to be"
	line "the world's great-"
	cont "est #MON"
	cont "trainer."
endc

	done

SilverCherrygroveLossText: 
if DEF(_FR_FR)
	text "Pfff. Une perte"
	line "de temps."
else
	text "Humph. That was a"
	line "waste of time."
endc

	done

CherrygroveRivalText_YouWon: 
if DEF(_FR_FR)
	text "<……> <……> <……>"

	para "Mon nom est ???."

	para "Je serai le plus"
	line "grand dresseur de"
	cont "#MON du"
	cont "monde."
else
	text "<……> <……> <……>"

	para "My name's ???."

	para "I'm going to be"
	line "the world's great-"
	cont "est #MON"
	cont "trainer."
endc

	done

CherrygroveTeacherText_NoMapCard: 
if DEF(_FR_FR)
	text "As-tu parlé au"
	line "vieil homme près"
	cont "du CENTRE"
	cont "#MON?"

	para "Il déposera une"
	line "CARTE de JOHTO"
	cont "dans ton"
	cont "#MATOS."
else
	text "Did you talk to"
	line "the old man by the"
	cont "#MON CENTER?"

	para "He'll put a MAP of"
	line "JOHTO on your"
	cont "#GEAR."
endc

	done

CherrygroveTeacherText_HaveMapCard: 
if DEF(_FR_FR)
	text "C'est trop bien"
	line "de se balader avec"
	cont "ses #MON!"
else
	text "When you're with"
	line "#MON, going"
	cont "anywhere is fun."
endc

	done

CherrygroveYoungsterText_NoPokedex: 
if DEF(_FR_FR)
	text "La maison de"
	line "M.#MON est un"
	cont "peu plus loin."
else
	text "MR.#MON's house"
	line "is still farther"
	cont "up ahead."
endc

	done

CherrygroveYoungsterText_HavePokedex: 
if DEF(_FR_FR)
	text "J'ai combattu"
	line "un paquet de"
	cont "dresseurs sur la"
	cont "route."

	para "Mes #MON ont"
	line "perdu avec honneur"

	para "mais bon, le"
	line "résultat est là."
	cont "Je dois aller vite"
	cont "fait dans un"
	cont "CENTRE #MON."
else
	text "I battled the"
	line "trainers on the"
	cont "road."

	para "My #MON lost."
	line "They're a mess! I"

	para "must take them to"
	line "a #MON CENTER."
endc

	done

MysticWaterGuyTextBefore: 
if DEF(_FR_FR)
	text "Le #MON que"
	line "j'ai attrapé avait"
	cont "un objet."

	para "Je crois que c'est"
	line "de l'EAU MYSTIQUE."

	para "Je n'en ai pas"
	line "besoin..."
	cont "La veux-tu?"
else
	text "A #MON I caught"
	line "had an item."

	para "I think it's"
	line "MYSTIC WATER."

	para "I don't need it,"
	line "so do you want it?"
endc

	done

MysticWaterGuyTextAfter: 
if DEF(_FR_FR)
	text "Allez hop, retour"
	line "à la pêche."
else
	text "Back to fishing"
	line "for me, then."
endc

	done

FirstInLineFirstLockdownText: ; TO TRANSLATE
	text "The declaration of"
	line "the lockdown got"
	cont "me hooked…"
	done

MysticWaterGuyFirstLockdownText: ; TO TRANSLATE
	text "I heard the news"
	line "on the radio while"

	para "fishing, and im-"
	line "mediately rushed"

	para "here."

	para "I can't believe"
	line "there is such a"
	cont "long LINE!"

	para "Get it?"
	done

CooltrainerFirstLockdownText: ; TO TRANSLATE
	text "Some supplies were"
	line "already rare and"

	para "expensive because"
	line "of shortages."

	para "After this sudden"
	line "influx, it's going"
	cont "to be chaotic…"
	done

CherrygroveCitySignText: 
if DEF(_FR_FR)
	text "VILLE GRIOTTE"

	para "La ville aux"
	line "fleurs parfumées"
else
	text "CHERRYGROVE CITY"

	para "The City of Cute,"
	line "Fragrant Flowers"
endc

	done

GuideGentsHouseSignText: 
if DEF(_FR_FR)
	text "MAISON DES GUIDES"
else
	text "GUIDE GENT'S HOUSE"
endc

	done

CherrygroveCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 23,  3, CHERRYGROVE_MART, 2
	warp_event 29,  3, CHERRYGROVE_POKECENTER_1F, 1
	warp_event 17,  7, CHERRYGROVE_GYM_SPEECH_HOUSE, 1
	warp_event 25,  9, GUIDE_GENTS_HOUSE, 1
	warp_event 31, 11, CHERRYGROVE_EVOLUTION_SPEECH_HOUSE, 1

	def_coord_events
	coord_event 33,  6, CE_EVENT_FLAG_SET, EVENT_CHERRYGROVECITY_MEET_RIVAL, CherrygroveSilverSceneNorth
	coord_event 33,  7, CE_EVENT_FLAG_SET, EVENT_CHERRYGROVECITY_MEET_RIVAL, CherrygroveSilverSceneSouth

	def_bg_events
	bg_event 30,  8, BGEVENT_READ, CherrygroveCitySign
	bg_event 23,  9, BGEVENT_READ, GuideGentsHouseSign
	bg_event 24,  3, BGEVENT_READ, CherrygroveCityMartSign
	bg_event 30,  3, BGEVENT_READ, CherrygroveCityPokecenterSign
	bg_event 23,  3, BGEVENT_CLOSED_DOOR, Cherrygrove_DoorScript

	def_object_events
	object_event 31,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, TravelController, EVENT_TRAVEL_CONTROL
	object_event 32,  6, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, CherrygroveCityGuideGent, EVENT_GUIDE_GENT_IN_HIS_HOUSE
	object_event 39,  6, SPRITE_SILVER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_RIVAL_CHERRYGROVE_CITY
	object_event 27, 12, SPRITE_TEACHER, CLAP_F | SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CherrygroveTeacherScript, -1
	object_event 23,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CherrygroveYoungsterScript, -1
	object_event  7, 12, SPRITE_FISHER, CLAP_F | SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, MysticWaterGuy, -1
	object_event 23,  4, SPRITE_FISHER, CLAP_F | SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, FirstInLineFirstLockdown, EVENT_LOCKDOWN_MART_RUSH
	object_event 22,  4, SPRITE_FISHER, CLAP_F | SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, MysticWaterGuyFirstLockdown, EVENT_LOCKDOWN_MART_RUSH
	object_event 24,  4, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, CooltrainerFirstLockdown, EVENT_LOCKDOWN_MART_RUSH
