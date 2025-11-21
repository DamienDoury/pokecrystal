	object_const_def
	const ROUTE38_POLICE_1_1
	const ROUTE38_POLICE_1_2
	const ROUTE38_POLICE_1_3
	const ROUTE38_POLICE_2_1
	const ROUTE38_POLICE_2_2
	const ROUTE38_POLICE_2_3
	const ROUTE38_POLICE_2_4
	const ROUTE38_POLICE_2_5
	const ROUTE38_POLICE_3_1
	const ROUTE38_POLICE_3_2
	const ROUTE38_POLICE_3_3
	const ROUTE38_POLICE_4_1
	const ROUTE38_POLICE_4_2
	const ROUTE38_POLICE_4_3
	const ROUTE38_POLICE_4_4

	const ROUTE38_STANDING_YOUNGSTER1
	const ROUTE38_LASS
	const ROUTE38_STANDING_YOUNGSTER2
	const ROUTE38_BEAUTY1
	const ROUTE38_SAILOR
	const ROUTE38_FRUIT_TREE
	const ROUTE38_BEAUTY2

Route38_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerBirdKeeperToby:
	trainer BIRD_KEEPER, TOBY, EVENT_BEAT_BIRD_KEEPER_TOBY, BirdKeeperTobySeenText, BirdKeeperTobyBeatenText, 0, .Script

.Script
	endifjustbattled
	jumptextfaceplayer BirdKeeperTobyAfterBattleText

TrainerSailorHarry:
	trainer SAILOR, HARRY, EVENT_BEAT_SAILOR_HARRY, SailorHarrySeenText, SailorHarryBeatenText, 0, .Script

.Script
	endifjustbattled
	jumptextfaceplayer SailorHarryAfterBattleText

TrainerLassDana1:
	trainer LASS, DANA1, EVENT_BEAT_LASS_DANA, LassDana1SeenText, LassDana1BeatenText, 0, .Script

.Script
	loadvar VAR_CALLERID, PHONE_LASS_DANA
	endifjustbattled
	opentext
	checkflag ENGINE_DANA_READY_FOR_REMATCH
	iftrue .DanaRematch
	checkflag ENGINE_DANA_HAS_THUNDERSTONE
	iftrue .TryGiveThunderstone
	checkcellnum PHONE_LASS_DANA
	iftrue .NumberAccepted
	checkevent EVENT_DANA_ASKED_FOR_PHONE_NUMBER
	iftrue .SecondTimeAsking
	writetext LassDanaMoomooMilkText
	promptbutton
	setevent EVENT_DANA_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1F
	sjump .AskForPhoneNumber

.SecondTimeAsking:
	scall .AskNumber2F
.AskForPhoneNumber:
	askforphonenumber PHONE_LASS_DANA
	ifequal PHONE_CONTACTS_FULL, .PhoneFull
	ifequal PHONE_CONTACT_REFUSED, .DeclinedPhoneNumber
	gettrainername STRING_BUFFER_3, LASS, DANA1
	scall .RegisteredPhoneNumber
	sjump .NumberAccepted

.DanaRematch:
	scall .Rematch
	winlosstext LassDana1BeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight4
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight3
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight2
	checkflag ENGINE_FLYPOINT_CIANWOOD
	iftrue .LoadFight1
	loadtrainer LASS, DANA1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_DANA_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer LASS, DANA2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_DANA_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer LASS, DANA3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_DANA_READY_FOR_REMATCH
	end

.LoadFight3:
	loadtrainer LASS, DANA4
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_DANA_READY_FOR_REMATCH
	end

.LoadFight4:
	loadtrainer LASS, DANA5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_DANA_READY_FOR_REMATCH
	end

.TryGiveThunderstone:
	scall .Gift
	verbosegiveitem THUNDERSTONE
	iffalse .NoRoomForThunderstone
	clearflag ENGINE_DANA_HAS_THUNDERSTONE
	setevent EVENT_DANA_GAVE_THUNDERSTONE
	sjump .NumberAccepted

.NoRoomForThunderstone:
	sjump .PackFull

.AskNumber1F:
	jumpstd AskNumber1FScript

.AskNumber2F:
	jumpstd AskNumber2FScript

.RegisteredPhoneNumber:
	jumpstd RegisteredNumberFScript

.NumberAccepted:
	jumpstd NumberAcceptedFScript

.DeclinedPhoneNumber:
	jumpstd NumberDeclinedFScript

.PhoneFull:
	jumpstd PhoneFullFScript

.Rematch:
	jumpstd RematchFScript

.Gift:
	jumpstd GiftFScript

.PackFull:
	jumpstd PackFullFScript

TrainerSchoolboyChad1:
	trainer SCHOOLBOY, CHAD1, EVENT_BEAT_SCHOOLBOY_CHAD, SchoolboyChad1SeenText, SchoolboyChad1BeatenText, 0, .Script

.Script
	loadvar VAR_CALLERID, PHONE_SCHOOLBOY_CHAD
	endifjustbattled
	opentext
	checkflag ENGINE_CHAD_READY_FOR_REMATCH
	iftrue .ChadRematch
	checkcellnum PHONE_SCHOOLBOY_CHAD
	iftrue .HaveChadsNumber
	checkevent EVENT_CHAD_ASKED_FOR_PHONE_NUMBER
	iftrue .SecondTimeAsking
	writetext SchoolboyChadSoManyTestsText
	promptbutton
	setevent EVENT_CHAD_ASKED_FOR_PHONE_NUMBER
	scall .AskPhoneNumber1
	sjump .AskToRegisterNumber

.SecondTimeAsking:
	scall .AskPhoneNumber2
.AskToRegisterNumber:
	askforphonenumber PHONE_SCHOOLBOY_CHAD
	ifequal PHONE_CONTACTS_FULL, .PhoneFull
	ifequal PHONE_CONTACT_REFUSED, .SaidNo
	gettrainername STRING_BUFFER_3, SCHOOLBOY, CHAD1
	scall .RegisteredChad
	sjump .HaveChadsNumber

.ChadRematch:
	scall .Rematch
	winlosstext SchoolboyChad1BeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight4
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight3
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight2
	checkflag ENGINE_FLYPOINT_MAHOGANY
	iftrue .LoadFight1
	loadtrainer SCHOOLBOY, CHAD1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_CHAD_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer SCHOOLBOY, CHAD2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_CHAD_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer SCHOOLBOY, CHAD3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_CHAD_READY_FOR_REMATCH
	end

.LoadFight3:
	loadtrainer SCHOOLBOY, CHAD4
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_CHAD_READY_FOR_REMATCH
	end

.LoadFight4:
	loadtrainer SCHOOLBOY, CHAD5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_CHAD_READY_FOR_REMATCH
	end

.AskPhoneNumber1:
	jumpstd AskNumber1MScript

.AskPhoneNumber2:
	jumpstd AskNumber2MScript

.RegisteredChad:
	jumpstd RegisteredNumberMScript

.HaveChadsNumber:
	jumpstd NumberAcceptedMScript

.SaidNo:
	jumpstd NumberDeclinedMScript

.PhoneFull:
	jumpstd PhoneFullMScript

.Rematch:
	jumpstd RematchMScript

TrainerBeautyValerie:
	trainer BEAUTY, VALERIE, EVENT_BEAT_BEAUTY_VALERIE, BeautyValerieSeenText, BeautyValerieBeatenText, 0, .Script

.Script
	endifjustbattled
	jumptextfaceplayer BeautyValerieAfterBattleText

TrainerBeautyOlivia:
	trainer BEAUTY, OLIVIA, EVENT_BEAT_BEAUTY_OLIVIA, BeautyOliviaSeenText, BeautyOliviaBeatenText, 0, .Script

.Script
	endifjustbattled
	jumptextfaceplayer BeautyOliviaAfterBattleText

Route38Sign:
	jumptext Route38SignText

Route38TrainerTips:
	jumptext Route38TrainerTipsText

Route38FruitTree:
	fruittree FRUITTREE_ROUTE_38

BirdKeeperTobySeenText: 
if DEF(_FR_FR)
	text "Volez, mes jolis"
	line "petits #MON!"
else
	text "Fly high into the"
	line "sky, my beloved"
	cont "bird #MON!"
endc

	done

BirdKeeperTobyBeatenText: 
if DEF(_FR_FR)
	text "Chplof!"
else
	text "I feel like just"
	line "flying away now."
endc

	done

BirdKeeperTobyAfterBattleText: 
if DEF(_FR_FR)
	text "Je vais entraîner"
	line "mes #MON à"

	para "IRISIA pour leur"
	line "apprendre à voler."
else
	text "I plan to train in"
	line "CIANWOOD CITY to"

	para "teach my #MON"
	line "how to FLY."
endc

	done

SchoolboyChad1SeenText: 
if DEF(_FR_FR)
	text "J'vais te montrer"
	line "ce que j'ai appris"
	cont "aujourd'hui."
else
	text "Let me try some-"
	line "thing I learned"
	cont "today."
endc

	done

SchoolboyChad1BeatenText: 
if DEF(_FR_FR)
	text "Faut que j'étudie"
	line "encore un peu."
else
	text "I didn't study"
	line "enough, I guess."
endc

	done

SchoolboyChadSoManyTestsText: 
if DEF(_FR_FR)
	text "Les études ça me"
	line "prend la tête."

	para "Je préfère les"
	line "#MON."

	para "Alors moi, jouer,"
	line "c'est mon truc."
else
	text "I have to take so"
	line "many tests, I"

	para "don't have much"
	line "time for #MON."

	para "So when I do get"
	line "to play, I really"
	cont "concentrate."
endc

	done

LassDana1SeenText: 
if DEF(_FR_FR)
	text "Tu as l'air de t'y"
	line "connaître en"
	cont "#MON."

	para "Tu veux bien me"
	line "donner des"
	cont "conseils?"
else
	text "You seem to be"
	line "good at #MON."

	para "If you are, how"
	line "about giving me"
	cont "some advice?"
endc

	done

LassDana1BeatenText: 
if DEF(_FR_FR)
	text "Je vois. C'est pas"
	line "mal."
else
	text "I see. So you can"
	line "battle that way."
endc

	done

LassDanaMoomooMilkText: 
if DEF(_FR_FR)
	text "Je vais te dire"
	line "un truc..."

	para "Le lait du RANCH"
	line "MEUMEU est super"
	cont "bon."
else
	text "I know something"
	line "good!"

	para "MOOMOO FARM's milk"
	line "is famous for its"
	cont "flavor."
endc

	done

BeautyValerieSeenText: 
if DEF(_FR_FR)
	text "Hé! T'es mimi"
	line "comme dresseur!"

	para "Je peux voir tes"
	line "#MON?"
else
	text "Hi! Aren't you a"
	line "cute trainer!"

	para "May I see your"
	line "#MON?"
endc

	done

BeautyValerieBeatenText: 
if DEF(_FR_FR)
	text "Merci."
	line "Sympa!"
else
	text "I'm glad I got to"
	line "see your #MON!"
endc

	done

BeautyValerieAfterBattleText: 
if DEF(_FR_FR)
	text "Les #MON, ça me"
	line "calme les nerfs."
else
	text "When I see #-"
	line "MON, it seems to"
	cont "soothe my nerves."
endc

	done

SailorHarrySeenText:
if DEF(_FR_FR)
	text "AXOLOTO est joie."
	line "AXOLOTO est amour."
else
	text "WOOPER is love."
	line "WOOPER is life."
endc
	done

SailorHarryBeatenText:
if DEF(_FR_FR)
	text "L'Axo est tombé."
	line "Je suis dévasté."
else
	text "The Woop fell."
	line "I'm devastated."
endc
	done

SailorHarryAfterBattleText:
if DEF(_FR_FR)
	text "Souviens-toi de"
	line "ce conseil:"
	
	para "AXOLOTO est le"
	line "meilleur #MON."
else
	text "Remember this tip:"
	line "WOOPER is the"
	cont "best #MON."
endc
	done

BeautyOliviaSeenText: 
if DEF(_FR_FR)
	text "Tu ne trouves pas"
	line "que mes #MON et"
	cont "moi-même avons une"
	cont "classe folle?"
else
	text "Don't you think my"
	line "#MON and I are"
	cont "beautiful?"
endc

	done

BeautyOliviaBeatenText: 
if DEF(_FR_FR)
	text "On boit du LAIT"
	line "MEUMEU tous les"
	cont "jours."
else
	text "We drink MOOMOO"
	line "MILK every day."
endc

	done

BeautyOliviaAfterBattleText: 
if DEF(_FR_FR)
	text "Le LAIT MEUMEU est"
	line "bon pour la forme"

	para "mais ils n'en"
	line "vendent qu'une"

	para "bouteille à la"
	line "fois."
else
	text "MOOMOO MILK is"
	line "good for beauty"

	para "and health, but"
	line "inconveniently,"

	para "they only sell a"
	line "bottle at a time."
endc

	done

Route38SignText: 
if DEF(_FR_FR)
	text "ROUTE 38"

	para "OLIVILLE -"
	line "ROSALIA"
else
	text "ROUTE 38"

	para "OLIVINE CITY -"
	line "ECRUTEAK CITY"
endc

	done

Route38TrainerTipsText: 
if DEF(_FR_FR)
	text "ASTUCE"

	para "Vous pouvez arrê-"
	line "ter l'évolution d'"
	cont "un #MON."

	para "Appuyez sur B pen-"
	line "dant l'évolution."

	para "Cela surprendra le"
	line "#MON et le"
	cont "fera s'arrêter."
else
	text "TRAINER TIPS"

	para "If a #MON is"
	line "trying to evolve,"
	cont "you can stop it."

	para "Press the B But-"
	line "ton during evolu-"
	cont "tion."

	para "That startles the"
	line "#MON and stops"
	cont "its evolution."
endc

	done

Route38_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 35,  8, ROUTE_38_ECRUTEAK_GATE, 1
	warp_event 35,  9, ROUTE_38_ECRUTEAK_GATE, 2

	def_coord_events

	def_bg_events
	bg_event 33,  7, BGEVENT_READ, Route38Sign
	bg_event  5, 13, BGEVENT_READ, Route38TrainerTips

	def_object_events
	object_event 14,  3, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event 30,  8, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event  8,  5, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1

	object_event  5,  4, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event  9,  7, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 2, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 22, 14, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_X, 1, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 35,  6, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 5, PoliceTrainer, -1

	object_event 14, 12, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_X, 3, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1
	object_event 18, 12, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_X, 2, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1
	object_event  6, 11, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_Y, 0, 1, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1

	object_event 24,  5, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 17, 10, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 2, PoliceTrainer, -1
	object_event 13,  9, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 15,  3, SPRITE_OFFICER, SPRITEMOVEDATA_WANDER, 2, 1, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1

	object_event  4,  1, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerSchoolboyChad1, -1
	object_event 15,  3, SPRITE_LASS, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerLassDana1, -1
	object_event 12, 15, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerBirdKeeperToby, -1
	object_event 19,  9, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerBeautyValerie, -1
	object_event 24,  5, SPRITE_SAILOR, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerSailorHarry, -1
	object_event 12, 10, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route38FruitTree, -1
	object_event  5,  8, SPRITE_BEAUTY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerBeautyOlivia, -1
