	object_const_def
	const ROUTE39_POLICE_1_1
	const ROUTE39_POLICE_1_2
	const ROUTE39_POLICE_2_1
	const ROUTE39_POLICE_2_2
	const ROUTE39_POLICE_2_3
	const ROUTE39_POLICE_2_4
	const ROUTE39_POLICE_3_1
	const ROUTE39_POLICE_3_2
	const ROUTE39_POLICE_3_3
	const ROUTE39_POLICE_3_4
	const ROUTE39_POLICE_4_1
	const ROUTE39_POLICE_4_2
	const ROUTE39_POLICE_4_3

	const ROUTE39_SAILOR
	const ROUTE39_POKEFAN_M
	const ROUTE39_POKEFAN_F1
	const ROUTE39_MILTANK1
	const ROUTE39_MILTANK2
	const ROUTE39_MILTANK3
	const ROUTE39_MILTANK4
	const ROUTE39_PSYCHIC_NORMAN
	const ROUTE39_FRUIT_TREE
	const ROUTE39_POKEFAN_F2

Route39_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback

.EnterCallback:
	checkevent EVENT_GOT_COVID_ON_ROUTE_39
	iftrue .end

	loadmem wBattlePokerusSeed, TRUE ; Forcing Covid from enemy during the next battle, wherever that battle happens.

.end
	endcallback

Route39Miltank:
	opentext
	writetext Route39MiltankText
	cry MILTANK
	waitbutton
	closetext
	end

TrainerPokefanmDerek:
	trainer POKEFANM, DEREK1, EVENT_BEAT_POKEFANM_DEREK, PokefanmDerekSeenText, PokefanmDerekBeatenText, 0, .Script

.Script:
	checkevent EVENT_GOT_COVID_ON_ROUTE_39
	iftrue .NoNotification
	
	setevent EVENT_CONTACT_TRACING_NOTIFICATION
.NoNotification
	setevent EVENT_GOT_COVID_ON_ROUTE_39

	loadvar VAR_CALLERID, PHONE_POKEFANM_DEREK
	endifjustbattled
	opentext
	checkflag ENGINE_DEREK_HAS_NUGGET
	iftrue .HasNugget
	checkcellnum PHONE_POKEFANM_DEREK
	iftrue .NumberAccepted
	checkpoke PIKACHU
	iffalse .WantsPikachu
	checkevent EVENT_DEREK_ASKED_FOR_PHONE_NUMBER
	iftrue .AskedAlready
	writetext PokefanMDerekText_NotBragging
	promptbutton
	setevent EVENT_DEREK_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1
	sjump .AskForNumber

.AskedAlready:
	scall .AskNumber2
.AskForNumber:
	askforphonenumber PHONE_POKEFANM_DEREK
	ifequal PHONE_CONTACTS_FULL, .PhoneFull
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, POKEFANM, DEREK1
	scall .RegisteredNumber
	sjump .NumberAccepted

.HasNugget:
	scall .Gift
	verbosegiveitem TOILET_PAPER
	iffalse .NoRoom
	clearflag ENGINE_DEREK_HAS_NUGGET
	sjump .NumberAccepted

.NoRoom:
	sjump .PackFull

.WantsPikachu:
	writetext PokefanMDerekPikachuIsItText
	waitbutton
	closetext
	end

.AskNumber1:
	jumpstd AskNumber1MScript
	end

.AskNumber2:
	jumpstd AskNumber2MScript
	end

.RegisteredNumber:
	jumpstd RegisteredNumberMScript
	end

.NumberAccepted:
	jumpstd NumberAcceptedMScript
	end

.NumberDeclined:
	jumpstd NumberDeclinedMScript
	end

.PhoneFull:
	jumpstd PhoneFullMScript
	end

.Gift:
	jumpstd GiftMScript
	end

.PackFull:
	jumpstd PackFullMScript
	end

TrainerPokefanfRuth:
	trainer POKEFANF, RUTH, EVENT_BEAT_POKEFANF_RUTH, PokefanfRuthSeenText, PokefanfRuthBeatenText, 0, .Script

.Script:
	checkevent EVENT_GOT_COVID_ON_ROUTE_39
	iftrue .NoNotification
	
	setevent EVENT_CONTACT_TRACING_NOTIFICATION
.NoNotification
	setevent EVENT_GOT_COVID_ON_ROUTE_39

	endifjustbattled
	opentext
	writetext PokefanfRuthAfterBattleText
	waitbutton
	closetext
	end

TrainerSailorEugene:
	trainer SAILOR, EUGENE, EVENT_BEAT_SAILOR_EUGENE, SailorEugeneSeenText, SailorEugeneBeatenText, 0, .Script

.Script:
	checkevent EVENT_GOT_COVID_ON_ROUTE_39
	iftrue .NoNotification
	
	setevent EVENT_CONTACT_TRACING_NOTIFICATION
.NoNotification
	setevent EVENT_GOT_COVID_ON_ROUTE_39
	endifjustbattled
	opentext
	writetext SailorEugeneAfterBattleText
	waitbutton
	closetext
	end

TrainerPsychicNorman:
	trainer PSYCHIC_T, NORMAN, EVENT_BEAT_PSYCHIC_NORMAN, PsychicNormanSeenText, PsychicNormanBeatenText, 0, .Script

.Script:
	checkevent EVENT_GOT_COVID_ON_ROUTE_39
	iftrue .NoNotification
	
	setevent EVENT_CONTACT_TRACING_NOTIFICATION
.NoNotification
	setevent EVENT_GOT_COVID_ON_ROUTE_39
	endifjustbattled
	opentext
	writetext PsychicNormanAfterBattleText
	waitbutton
	closetext
	end

TrainerPokefanfJaime:
	faceplayer
	opentext
	checktime NITE
	iffalse .NotNight
	checkevent EVENT_BEAT_POKEFANF_JAIME
	iftrue .Beaten
	writetext PokefanfJaimeSeenText
	waitbutton
	closetext
	winlosstext PokefanfJaimeBeatenText, 0
	loadtrainer POKEFANF, JAIME
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_POKEFANF_JAIME
	closetext
	end

.Beaten:
	writetext PokefanfJaimeAfterBattleText
	waitbutton
	closetext
	end

.NotNight:
	writetext PokefanfJaimeHopeItGetsDarkText
	waitbutton
	closetext
	end

Route39_PoliceTrainer:
	trainer OFFICER, POLICE_2, EVENT_BEAT_POLICE, -1, -1, 0, .Script
.Script:
	checkevent EVENT_GOT_COVID_ON_ROUTE_39
	iftrue .NoNotification
	
	setevent EVENT_CONTACT_TRACING_NOTIFICATION
.NoNotification
	setevent EVENT_GOT_COVID_ON_ROUTE_39
	end

Route39_MoomooJenny:
	opentext
	writetext Route39_CuteText
	waitbutton
	closetext
	showemote EMOTE_SHOCK, ROUTE39_POLICE_3_1, 15
	faceplayer
	opentext
	writetext Route39_IMeanText
	waitbutton
	closetext
	;winlosstext 0, 0
	loadmem wTempTrainerClass, OFFICER
	loadtrainer JENNY, POLICE_3
	startbattle
	reloadmapafterbattle
	end

Route39Sign:
	jumptext Route39SignText

MoomooFarmSign:
	jumptext MoomooFarmSignText

Route39TrainerTips:
	jumptext Route39TrainerTipsText

Route39FruitTree:
	fruittree FRUITTREE_ROUTE_39

Route39HiddenNugget:
	hiddenitem TOILET_PAPER, EVENT_ROUTE_39_HIDDEN_NUGGET

Route39_CuteText: ; TO TRANSLATE
	text "She's so cute!"
	line "I want one!"
	done

Route39_IMeanText: ; TO TRANSLATE
	text "…Uh I mean…"

	para "You are under"
	line "arrest for vio-"
	
	para "lation of the"
	line "sanitary measures!"
	done

Route39MiltankText: 
if DEF(_FR_FR)
	text "ECREMEUH: Meuh!"
else
	text "MILTANK: Mooo!"
endc

	done

SailorEugeneSeenText: 
if DEF(_FR_FR)
	text "Je reviens de"
	line "OLIVILLE."

	para "Ca te dit un p'tit"
	line "combat #MON?"
else
	text "I just got back to"
	line "OLIVINE."

	para "So how about a"
	line "#MON battle?"
endc

	done

SailorEugeneBeatenText: 
if DEF(_FR_FR)
	text "Awaaargh!"
else
	text "Awaaargh!"
endc

	done

SailorEugeneAfterBattleText: 
if DEF(_FR_FR)
	text "J'ai attrapé et"
	line "entraîné mes #-"
	cont "MON à l'étranger."

	para "Ils m'accompagnent"
	line "pendant mes longs"
	cont "voyages."
else
	text "My #MON were"
	line "caught and raised"
	cont "overseas."

	para "They're my compan-"
	line "ions on those long"
	cont "voyages."
endc

	done

PokefanmDerekSeenText: 
if DEF(_FR_FR)
	text "Moi je crâne avec"
	line "mon PIKACHU!"
else
	text "This is a good"
	line "time to brag about"
	cont "my PIKACHU!"
endc

	done

PokefanmDerekBeatenText: 
if DEF(_FR_FR)
	text "J'ai pas pu"
	line "crâner..."
else
	text "I had no time to"
	line "show off PIKACHU…"
endc

	done

PokefanMDerekText_NotBragging: 
if DEF(_FR_FR)
	text "Ne te vante pas!"
	line "Moi j'aime pas"
	cont "ceux qui se"
	cont "vantent!"
else
	text "I'm not listening"
	line "to your bragging!"

	para "We # FANS have"
	line "a policy of not"

	para "listening to other"
	line "people brag!"
endc

	done

PokefanfRuthSeenText: 
if DEF(_FR_FR)
	text "Les jolis"
	line "#MON."

	para "Allez! On se les"
	line "montre en même"
	cont "temps, OK?"
else
	text "Such darling"
	line "#MON."

	para "Let's show our"
	line "#MON together"
	cont "at the same time."
endc

	done

PokefanfRuthBeatenText: 
if DEF(_FR_FR)
	text "J'm'en fiche si je"
	line "perds."
else
	text "I don't mind"
	line "losing."
endc

	done

PokefanfRuthAfterBattleText: 
if DEF(_FR_FR)
	text "Tu connais les"
	line "bébés #MON?"

	para "Ils sont siiii"
	line "mignooons!"
else
	text "Do you know about"
	line "baby #MON?"

	para "I bet they're just"
	line "adorable!"
endc

	done

PokefanMDerekPikachuIsItText: 
if DEF(_FR_FR)
	text "PIKACHU est cool!"
	line "Tu ne trouves pas?"
else
	text "PIKACHU is it!"
	line "Don't you agree?"
endc

	done

PsychicNormanSeenText: ; TO TRANSLATE
	text "Wouldn't you like"
	line "to let your #-"
	cont "MON out, so it can"
	cont "follow you around?"
	done

PsychicNormanBeatenText: ; TO TRANSLATE
	text "I want my #MON"
	line "to follow me!"
	done

PsychicNormanAfterBattleText: ; TO TRANSLATE
	text "Trainers used to"
	line "have their #MON"
	cont "follow them around"
	cont "when exploring."

	para "Unfortunately, it"
	line "has been forbidden"
	cont "because of the"
	cont "pandemic."

	para "It's so sad…"
	done

PokefanfJaimeHopeItGetsDarkText: 
if DEF(_FR_FR)
	text "Hin hin hin..."
	line "Il va faire nuit."
else
	text "Ufufufu… I hope it"
	line "gets dark soon."
endc

	done

PokefanfJaimeSeenText: 
if DEF(_FR_FR)
	text "Tu viens au bon"
	line "moment."

	para "COMBAT."
else
	text "You came at just"
	line "the right time."

	para "Let's battle."
endc

	done

PokefanfJaimeBeatenText: 
if DEF(_FR_FR)
	text "Oh, quel dommage!"
else
	text "Oh, how disap-"
	line "pointing…"
endc

	done

PokefanfJaimeAfterBattleText: 
if DEF(_FR_FR)
	text "J'ai vu MIAOUSS la"
	line "nuit, ici sur la"
	cont "ROUTE 39."

	para "Je ne sais pas"
	line "pourquoi mais il"

	para "aime s'entraîner"
	line "ici."

	para "Il devient plus"
	line "amical de cette"
	cont "façon..."
else
	text "I met my MEOWTH at"
	line "night, right here"
	cont "on ROUTE 39."

	para "I'm not sure why,"
	line "but it seems to"

	para "like it when I"
	line "train here."

	para "It seems to become"
	line "friendlier by"

	para "training here than"
	line "anywhere else."
endc

	done

Route39SignText: 
if DEF(_FR_FR)
	text "ROUTE 39"

	para "OLIVILLE -"
	line "ROSALIA"
else
	text "ROUTE 39"

	para "OLIVINE CITY -"
	line "ECRUTEAK CITY"
endc

	done

MoomooFarmSignText: 
if DEF(_FR_FR)
	text "RANCH MEUMEU"

	para "Le meilleur lait"
	line "sur le marché!"
else
	text "MOOMOO FARM"

	para "Enjoy Our Fresh"
	line "and Tasty Milk"
endc

	done

Route39TrainerTipsText: 
if DEF(_FR_FR)
	text "ASTUCE"

	para "Un COUP D'BOULE"
	line "sur les arbres"
	cont "peut faire tomber"
	cont "des #MON."

	para "Des #MON diffé-"
	line "rents vivent dans"
	cont "les arbres."

	para "Donnez des COUPS"
	line "D'BOULE et vous"
	cont "verrez!"
else
	text "TRAINER TIPS"

	para "Use HEADBUTT on"
	line "trees to shake"
	cont "#MON out."

	para "Different kinds of"
	line "#MON drop out"
	cont "of trees."

	para "Use HEADBUTT on"
	line "any tree you see!"
endc

	done

Route39_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  1,  3, ROUTE_39_BARN, 1
	warp_event  5,  3, ROUTE_39_FARMHOUSE, 1

	def_coord_events

	def_bg_events
	bg_event  5, 31, BGEVENT_READ, Route39TrainerTips
	bg_event  9,  5, BGEVENT_READ, MoomooFarmSign
	bg_event 15,  7, BGEVENT_READ, Route39Sign
	bg_event  5, 13, BGEVENT_ITEM, Route39HiddenNugget

	def_object_events
	object_event 13, 13, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 2, Route39_PoliceTrainer, -1
	object_event 15, 18, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 5, Route39_PoliceTrainer, -1

	object_event  6, 28, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, Route39_PoliceTrainer, -1
	object_event 12,  5, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, Route39_PoliceTrainer, -1
	object_event 15, 12, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 4, Route39_PoliceTrainer, -1
	object_event  9, 29, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, Route39_PoliceTrainer, -1

	object_event  7, 11, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_SCRIPT, 1, Route39_MoomooJenny, -1
	object_event 12, 20, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 3, Route39_PoliceTrainer, -1
	object_event  5,  7, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 3, Route39_PoliceTrainer, -1
	object_event  9, 24, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 3, Route39_PoliceTrainer, -1

	object_event  4, 30, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_LEFT, 1, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 3, Route39_PoliceTrainer, -1
	object_event 12, 30, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_LEFT, 2, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 3, Route39_PoliceTrainer, -1
	object_event 14,  8, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 3, Route39_PoliceTrainer, -1

	object_event 13, 29, SPRITE_SAILOR, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 5, TrainerSailorEugene, -1
	object_event 10, 22, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 4, TrainerPokefanmDerek, -1
	object_event 11, 19, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 4, TrainerPokefanfRuth, -1
	object_event  3, 12, SPRITE_MILTANK, SPRITEMOVEDATA_POKEMON, 0, 0, HIDE_CURFEW, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Route39Miltank, -1
	object_event  6, 11, SPRITE_MILTANK, SPRITEMOVEDATA_POKEMON, 0, 0, HIDE_CURFEW, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Route39Miltank, -1
	object_event  4, 15, SPRITE_MILTANK, SPRITEMOVEDATA_POKEMON, 0, 0, HIDE_CURFEW, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Route39Miltank, -1
	object_event  8, 13, SPRITE_MILTANK, SPRITEMOVEDATA_POKEMON, 0, 0, HIDE_CURFEW, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Route39Miltank, -1
	object_event 13,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerPsychicNorman, -1
	object_event  9,  3, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route39FruitTree, -1
	object_event  4, 22, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, TrainerPokefanfJaime, -1
