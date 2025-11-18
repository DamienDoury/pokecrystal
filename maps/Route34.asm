	object_const_def
	const ROUTE34_POLICE_1_1
	const ROUTE34_POLICE_1_2
	const ROUTE34_POLICE_1_3
	const ROUTE34_POLICE_2_1
	const ROUTE34_POLICE_2_2
	const ROUTE34_POLICE_2_3
	const ROUTE34_POLICE_2_4
	const ROUTE34_POLICE_3_1
	const ROUTE34_POLICE_3_2
	const ROUTE34_POLICE_3_3
	const ROUTE34_POLICE_3_4
	const ROUTE34_POLICE_4_1
	const ROUTE34_POLICE_4_2
	const ROUTE34_POLICE_4_3
	const ROUTE34_POLICE_4_4
	
	const ROUTE34_YOUNGSTER1
	const ROUTE34_YOUNGSTER2
	const ROUTE34_YOUNGSTER3
	const ROUTE34_LASS
	const ROUTE34_POKEFAN_M
	const ROUTE34_GRAMPS
	const ROUTE34_DAY_CARE_MON_1
	const ROUTE34_DAY_CARE_MON_2
	const ROUTE34_COOLTRAINER_F1
	const ROUTE34_COOLTRAINER_F2
	const ROUTE34_COOLTRAINER_F3
	const ROUTE34_POKE_BALL

Route34_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .EggCheckCallback

.EggCheckCallback:
	checkflag ENGINE_DAY_CARE_MAN_HAS_EGG
	iftrue .PutDayCareManOutside
	clearevent EVENT_DAY_CARE_MAN_IN_DAY_CARE
	setevent EVENT_DAY_CARE_MAN_ON_ROUTE_34
	sjump .CheckMon1

.PutDayCareManOutside:
	setevent EVENT_DAY_CARE_MAN_IN_DAY_CARE
	clearevent EVENT_DAY_CARE_MAN_ON_ROUTE_34
	sjump .CheckMon1

.CheckMon1:
	checkflag ENGINE_DAY_CARE_MAN_HAS_MON
	iffalse .HideMon1
	clearevent EVENT_DAY_CARE_MON_1
	sjump .CheckMon2

.HideMon1:
	setevent EVENT_DAY_CARE_MON_1
	sjump .CheckMon2

.CheckMon2:
	checkflag ENGINE_DAY_CARE_LADY_HAS_MON
	iffalse .HideMon2
	clearevent EVENT_DAY_CARE_MON_2
	endcallback

.HideMon2:
	setevent EVENT_DAY_CARE_MON_2
	endcallback

DayCareManScript_Outside:
	faceplayer
	opentext
	special DayCareManOutside
	waitbutton
	closetext
	ifequal TRUE, .end_fail
	clearflag ENGINE_DAY_CARE_MAN_HAS_EGG
	applymovement ROUTE34_GRAMPS, Route34MovementData_DayCareManWalksBackInside
	playsound SFX_ENTER_DOOR
	disappear ROUTE34_GRAMPS
.end_fail
	end

DayCareMon1Script:
	opentext
	special DayCareMon1
	closetext
	end

DayCareMon2Script:
	opentext
	special DayCareMon2
	closetext
	end

TrainerCamperTodd1:
	trainer CAMPER, TODD1, EVENT_BEAT_CAMPER_TODD, CamperTodd1SeenText, CamperTodd1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_CAMPER_TODD
	endifjustbattled
	opentext
	checkflag ENGINE_TODD_READY_FOR_REMATCH
	iftrue .Rematch
	checkflag ENGINE_GOLDENROD_DEPT_STORE_SALE_IS_ON
	iftrue .SaleIsOn
	checkcellnum PHONE_CAMPER_TODD
	iftrue .NumberAccepted
	checkevent EVENT_TODD_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext CamperTodd1AfterText
	promptbutton
	setevent EVENT_TODD_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber
	sjump .FinishAsk

.AskAgain:
	scall .AskNumber2
.FinishAsk:
	askforphonenumber PHONE_CAMPER_TODD
	ifequal PHONE_CONTACTS_FULL, .PhoneFull
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, CAMPER, TODD1
	scall .RegisteredNumber
	sjump .NumberAccepted

.Rematch:
	scall .RematchStd
	winlosstext CamperTodd1BeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight4
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight3
	checkflag ENGINE_FLYPOINT_BLACKTHORN
	iftrue .LoadFight2
	checkflag ENGINE_FLYPOINT_CIANWOOD
	iftrue .LoadFight1
	loadtrainer CAMPER, TODD1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_TODD_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer CAMPER, TODD2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_TODD_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer CAMPER, TODD3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_TODD_READY_FOR_REMATCH
	end

.LoadFight3:
	loadtrainer CAMPER, TODD4
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_TODD_READY_FOR_REMATCH
	end

.LoadFight4:
	loadtrainer CAMPER, TODD5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_TODD_READY_FOR_REMATCH
	end

.SaleIsOn:
	writetext CamperToddSaleText
	waitbutton
	closetext
	end

.AskNumber:
	jumpstd AskNumber1MScript

.AskNumber2:
	jumpstd AskNumber2MScript

.RegisteredNumber:
	jumpstd RegisteredNumberMScript

.NumberAccepted:
	jumpstd NumberAcceptedMScript

.NumberDeclined:
	jumpstd NumberDeclinedMScript

.PhoneFull:
	jumpstd PhoneFullMScript

.RematchStd:
	jumpstd RematchMScript

TrainerPicnickerGina1:
	trainer PICNICKER, GINA1, EVENT_BEAT_PICNICKER_GINA, PicnickerGina1SeenText, PicnickerGina1BeatenText, 0, .Script

.Script:
	loadvar VAR_CALLERID, PHONE_PICNICKER_GINA
	endifjustbattled
	opentext
	checkflag ENGINE_GINA_READY_FOR_REMATCH
	iftrue .Rematch
	checkflag ENGINE_GINA_HAS_LEAF_STONE
	iftrue .LeafStone
	checkcellnum PHONE_PICNICKER_GINA
	iftrue .NumberAccepted
	checkevent EVENT_GINA_ASKED_FOR_PHONE_NUMBER
	iftrue .AskAgain
	writetext PicnickerGina1AfterText
	promptbutton
	setevent EVENT_GINA_ASKED_FOR_PHONE_NUMBER
	scall .AskNumber1
	sjump .FinishAsk

.AskAgain:
	scall .AskNumber2
.FinishAsk:
	askforphonenumber PHONE_PICNICKER_GINA
	ifequal PHONE_CONTACTS_FULL, .PhoneFull
	ifequal PHONE_CONTACT_REFUSED, .NumberDeclined
	gettrainername STRING_BUFFER_3, PICNICKER, GINA1
	scall .RegisteredNumber
	sjump .NumberAccepted

.Rematch:
	scall .RematchStd
	winlosstext PicnickerGina1BeatenText, 0
	checkevent EVENT_RESTORED_POWER_TO_KANTO
	iftrue .LoadFight4
	checkevent EVENT_BEAT_ELITE_FOUR
	iftrue .LoadFight3
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .LoadFight2
	checkflag ENGINE_FLYPOINT_MAHOGANY
	iftrue .LoadFight1
	loadtrainer PICNICKER, GINA1
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_GINA_READY_FOR_REMATCH
	end

.LoadFight1:
	loadtrainer PICNICKER, GINA2
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_GINA_READY_FOR_REMATCH
	end

.LoadFight2:
	loadtrainer PICNICKER, GINA3
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_GINA_READY_FOR_REMATCH
	end

.LoadFight3:
	loadtrainer PICNICKER, GINA4
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_GINA_READY_FOR_REMATCH
	end

.LoadFight4:
	loadtrainer PICNICKER, GINA5
	startbattle
	reloadmapafterbattle
	clearflag ENGINE_GINA_READY_FOR_REMATCH
	end

.LeafStone:
	scall .Gift
	verbosegiveitem LEAF_STONE
	iffalse .BagFull
	clearflag ENGINE_GINA_HAS_LEAF_STONE
	setevent EVENT_GINA_GAVE_LEAF_STONE
	sjump .NumberAccepted

.BagFull:
	sjump .PackFull

.AskNumber1:
	jumpstd AskNumber1FScript

.AskNumber2:
	jumpstd AskNumber2FScript

.RegisteredNumber:
	jumpstd RegisteredNumberFScript

.NumberAccepted:
	jumpstd NumberAcceptedFScript

.NumberDeclined:
	jumpstd NumberDeclinedFScript

.PhoneFull:
	jumpstd PhoneFullFScript

.RematchStd:
	jumpstd RematchFScript

.Gift:
	jumpstd GiftFScript

.PackFull:
	jumpstd PackFullFScript

TrainerYoungsterSamuel:
	trainer YOUNGSTER, SAMUEL, EVENT_BEAT_YOUNGSTER_SAMUEL, YoungsterSamuelSeenText, YoungsterSamuelBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer YoungsterSamuelAfterText

TrainerYoungsterIan:
	trainer YOUNGSTER, IAN, EVENT_BEAT_YOUNGSTER_IAN, YoungsterIanSeenText, YoungsterIanBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer YoungsterIanAfterText

TrainerPokefanmBrandon:
	trainer POKEFANM, BRANDON, EVENT_BEAT_POKEFANM_BRANDON, PokefanmBrandonSeenText, PokefanmBrandonBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer PokefanmBrandonAfterText

TrainerCooltrainerfIrene:
	trainer COOLTRAINERF, IRENE, EVENT_BEAT_COOLTRAINERF_IRENE, CooltrainerfIreneSeenText, CooltrainerfIreneBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	checkevent EVENT_GOT_SOFT_SAND_FROM_KATE
	iftrue .GotSoftSand
	writetext CooltrainerfIreneAfterText1
	waitbutton
	closetext
	end

.GotSoftSand:
	writetext CooltrainerfIreneAfterText2
	waitbutton
	closetext
	end

TrainerCooltrainerfJenn:
	trainer COOLTRAINERF, JENN, EVENT_BEAT_COOLTRAINERF_JENN, CooltrainerfJennSeenText, CooltrainerfJennBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	checkevent EVENT_GOT_SOFT_SAND_FROM_KATE
	iftrue .GotSoftSand
	writetext CooltrainerfJennAfterText1
	waitbutton
	closetext
	end

.GotSoftSand:
	writetext CooltrainerfJennAfterText2
	waitbutton
	closetext
	end

TrainerCooltrainerfKate:
	trainer COOLTRAINERF, KATE, EVENT_BEAT_COOLTRAINERF_KATE, CooltrainerfKateSeenText, CooltrainerfKateBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	checkevent EVENT_GOT_SOFT_SAND_FROM_KATE
	iftrue .GotSoftSand
	writetext CooltrainerfKateOfferSoftSandText
	promptbutton
	verbosegiveitem SOFT_SAND
	iffalse .BagFull
	setevent EVENT_GOT_SOFT_SAND_FROM_KATE
.GotSoftSand:
	writetext CooltrainerfKateAfterText
	waitbutton
.BagFull:
	closetext
	end

Route34Sign:
	jumptext Route34SignText

Route34TrainerTips:
	jumptext Route34TrainerTipsText

DayCareSign:
	jumptext DayCareSignText

Route34Nugget:
	itemball TOILET_PAPER

Route34HiddenRareCandy:
	hiddenitem RARE_CANDY, EVENT_ROUTE_34_HIDDEN_RARE_CANDY

Route34HiddenSuperPotion:
	hiddenitem SUPER_POTION, EVENT_ROUTE_34_HIDDEN_SUPER_POTION

Route34MovementData_DayCareManWalksBackInside:
	slow_step LEFT
	slow_step UP
	step_end

YoungsterSamuelSeenText: 
if DEF(_FR_FR)
	text "C'est ici que je"
	line "m'entraîne!"
else
	text "This is where I do"
	line "my training!"
endc

	done

YoungsterSamuelBeatenText:
if DEF(_FR_FR)
	text "La PENSION n'a pas"
	line "été efficace..."
else
	text "The DAY-CARE wasn't"
	line "a good training…"
endc
	done

YoungsterSamuelAfterText:
if DEF(_FR_FR)
	text "BLANCHE m'a dit"
	line "qu'un #MON de"
	cont "haut niveau gagne"
	
	para "plus de PTS EXP."
	line "à la PENSION qu'un"
	cont "qu'un plus faible."
else
	text "WHITNEY told me"
	line "that a high level"
	cont "#MON gains"
	
	para "more exp. at the"
	line "DAY-CARE than a"
	cont "low level one."
endc
	done

YoungsterIanSeenText: 
if DEF(_FR_FR)
	text "Le meilleur de la"
	line "classe à #MON,"
	cont "c'est moi!"
else
	text "I'm the best in my"
	line "class at #MON."
endc

	done

YoungsterIanBeatenText: 
if DEF(_FR_FR)
	text "Il existe de meil-"
	line "leurs dresseurs..."
else
	text "No! There are bet-"
	line "ter trainers…"
endc

	done

YoungsterIanAfterText:
if DEF(_FR_FR)
	text "Tu savais qu'un"
	line "#MON enfant est"
	
	para "presque toujours"
	line "plus robuste que"
	cont "ses parents?"
	
	para "C'est parce qu'il"
	line "hérite des meil-"
	cont "leurs attributs"
	cont "de ses parents!"
	
	para "Mais il reste"
	line "toujours une part"
	
	para "de hasard dans le"
	line "processus de"
	cont "reproduction."
	
	para "C'est le vieux de"
	line "la PENSION qui me"
	cont "l'a dit."
else
	text "Did you know that"
	line "a child #MON"
	
	para "is almost always"
	line "stronger than"
	cont "its parents?"
	
	para "It's because it"
	line "inherits from the"
	
	para "best traits of"
	line "its parents!"
	
	para "But there's always"
	line "a slight bit of"
	
	para "randomness in the"
	line "breeding process."

	para "The old man at the"
	line "DAY-CARE told me."
endc
	done

CamperTodd1SeenText: 
if DEF(_FR_FR)
	text "J'ai foi en mon"
	line "talent de dresseur"
	cont "de #MON."

	para "Tu veux voir?"
else
	text "I'm confident in"
	line "my ability to"
	cont "raise #MON."

	para "Want to see?"
endc

	done

CamperTodd1BeatenText: 
if DEF(_FR_FR)
	text "J'ai raté mon en-"
	line "traînement?"
else
	text "Did I screw up my"
	line "training?"
endc

	done

CamperTodd1AfterText: 
if DEF(_FR_FR)
	text "Je devrais en"
	line "mettre un en PEN-"

	para "SION. Ou peut-"
	line "être utiliser des"
	cont "objets..."
else
	text "Maybe I should"
	line "take one to a DAY-"

	para "CARE. Or maybe use"
	line "some items…"
endc

	done

CamperToddSaleText: 
if DEF(_FR_FR)
	text "Faire des courses"
	line "sous le ciel!"

	para "Ca c'est la super"
	line "classe."
else
	text "Shopping under the"
	line "sky!"

	para "It feels so nice"
	line "up on a rooftop."
endc

	done

PicnickerGina1SeenText: 
if DEF(_FR_FR)
	text "Tu t'entraînes?"

	para "On se fait un duel"
	line "d'entraînement?"
else
	text "Are you a trainer?"

	para "Let's have a"
	line "practice battle."
endc

	done

PicnickerGina1BeatenText: 
if DEF(_FR_FR)
	text "Ne gagnerai-je"
	line "donc jamais?"
else
	text "Oh, no! I just"
	line "can't win…"
endc

	done

PicnickerGina1AfterText: 
if DEF(_FR_FR)
	text "Tu es trop balèze"
	line "pour qu'on s'en-"
	cont "traîne ensemble."
else
	text "You're too strong"
	line "to be a practice"
	cont "partner."
endc

	done

PokefanmBrandonSeenText: 
if DEF(_FR_FR)
	text "Mon #MON vient"
	line "de rentrer de la"
	cont "PENSION."

	para "Voyons s'il est"
	line "plus fort!"
else
	text "I just got my"
	line "#MON back from"
	cont "DAY-CARE."

	para "Let's see how much"
	line "stronger it got!"
endc

	done

PokefanmBrandonBeatenText: 
if DEF(_FR_FR)
	text "Pourquoi?"
else
	text "Why does it end"
	line "this way?"
endc

	done

PokefanmBrandonAfterText:
if DEF(_FR_FR)
	text "J'ai laissé mon"
	line "#MON à la"
	cont "PENSION pendant"
	cont "une semaine puis"
	cont "j'ai attendu."
	
	para "Quand je l'ai"
	line "récupéré, il avait"
	cont "gagné 6 niveaux!"
else
	text "I left my #MON"
	line "at the DAY-CARE"
	cont "for one week and"
	cont "waited."

	para "When I got it"
	line "back, it had"
	cont "gained 6 levels!"
endc
	done

CooltrainerfIreneSeenText: 
if DEF(_FR_FR)
	text "AMY: Kyaaah! On"
	line "nous a trouvées!"
else
	text "IRENE: Kyaaah!"
	line "Someone found us!"
endc

	done

CooltrainerfIreneBeatenText: 
if DEF(_FR_FR)
	text "AMY: Ohhh!"
else
	text "IRENE: Ohhh!"
	line "Too strong!"
endc

	done

CooltrainerfIreneAfterText1: 
if DEF(_FR_FR)
	text "AMY: Ma soeur"
	line "IRENE te fera "
	cont "payer ça!"
else
	text "IRENE: My sister"
	line "KATE will get you"
	cont "for this!"
endc

	done

CooltrainerfIreneAfterText2: 
if DEF(_FR_FR)
	text "AMY: Elle est"
	line "pas excellente"
	cont "cette plage?"

	para "C'est notre"
	line "cachette secrète!"
else
	text "IRENE: Isn't this"
	line "beach great?"

	para "It's our secret"
	line "little getaway!"
endc

	done

CooltrainerfJennSeenText: 
if DEF(_FR_FR)
	text "MARIA: Tu ne peux"
	line "battre AMY comme"
	cont "ça! Attends!"
else
	text "JENN: You can't"
	line "beat IRENE and go"
	cont "unpunished!"
endc

	done

CooltrainerfJennBeatenText: 
if DEF(_FR_FR)
	text "MARIA: Pardon AMY!"
else
	text "JENN: So sorry,"
	line "IRENE! Sis!"
endc

	done

CooltrainerfJennAfterText1: 
if DEF(_FR_FR)
	text "MARIA: Ne crâne"
	line "pas trop! Ma"
	cont "soeur IRENE est"
	cont "très forte!"
else
	text "JENN: Don't get"
	line "cocky! My sister"
	cont "KATE is tough!"
endc

	done

CooltrainerfJennAfterText2: 
if DEF(_FR_FR)
	text "MARIA: Le soleil"
	line "rend le corps"
	cont "plus fort."
else
	text "JENN: Sunlight"
	line "makes your body"
	cont "stronger."
endc

	done

CooltrainerfKateSeenText: 
if DEF(_FR_FR)
	text "IRENE: T'as pas"
	line "été sympa avec mes"
	cont "petites soeurs!"
else
	text "KATE: You sure"
	line "were mean to my"
	cont "little sisters!"
endc

	done

CooltrainerfKateBeatenText: 
if DEF(_FR_FR)
	text "IRENE: Non! J'ai"
	line "perdu! Incroyable!"
else
	text "KATE: No! I can't"
	line "believe I lost."
endc

	done

CooltrainerfKateOfferSoftSandText: 
if DEF(_FR_FR)
	text "IRENE: Tu es trop"
	line "balèze. Je n'avais"
	cont "aucune chance."

	para "Tiens, tu mérites"
	line "bien ceci."
else
	text "KATE: You're too"
	line "strong. I didn't"
	cont "stand a chance."

	para "Here. You deserve"
	line "this."
endc

	done

CooltrainerfKateAfterText: 
if DEF(_FR_FR)
	text "IRENE: Désolée de"
	line "t'avoir sauté"
	cont "dessus."

	para "On ne pensait pas"
	line "que quelqu'un"

	para "nous trouverait"
	line "ici. Tu nous as"
	cont "bien surprises!"
else
	text "KATE: I'm sorry we"
	line "jumped you."

	para "We never expected"
	line "anyone to find us"

	para "here. You sure"
	line "startled us."
endc

	done

Route34IlexForestSignText: 
if DEF(_FR_FR)
	text "BOIS AUX CHENES"
	line "Après la porte"
else
	text "ILEX FOREST"
	line "THROUGH THE GATE"
endc

	done

Route34SignText: 
if DEF(_FR_FR)
	text "ROUTE 34"

	para "DOUBLONVILLE -"
	line "ECORCIA"

	para "BOIS AUX CHENES"
	line "Sur la route"
else
	text "ROUTE 34"

	para "GOLDENROD CITY -"
	line "AZALEA TOWN"

	para "ILEX FOREST"
	line "SOMEWHERE BETWEEN"
endc

	done

Route34TrainerTipsText: 
if DEF(_FR_FR)
	text "ASTUCE"

	para "Les arbres à BAIES"
	line "donnent des BAIES"
	cont "tous les jours."

	para "Notez quel arbre"
	line "donne quelle BAIE."
else
	text "TRAINER TIPS"

	para "BERRY trees grow"
	line "new BERRIES"
	cont "every day."

	para "Make a note of"
	line "which trees bear"
	cont "which BERRIES."
endc

	done

DayCareSignText: 
if DEF(_FR_FR)
	text "PENSION"

	para "On élève votre"
	line "#MON pour vous!"
else
	text "DAY-CARE"

	para "LET US RAISE YOUR"
	line "#MON FOR YOU!"
endc

	done

Route34_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 13, 37, ROUTE_34_ILEX_FOREST_GATE, 1
	warp_event 14, 37, ROUTE_34_ILEX_FOREST_GATE, 2
	warp_event 11, 14, DAY_CARE, 1
	warp_event 11, 15, DAY_CARE, 2
	warp_event 13, 15, DAY_CARE, 3

	def_coord_events

	def_bg_events
	bg_event 12,  6, BGEVENT_READ, Route34Sign
	bg_event 13, 33, BGEVENT_READ, Route34TrainerTips
	bg_event 10, 13, BGEVENT_READ, DayCareSign
	bg_event  8, 32, BGEVENT_ITEM, Route34HiddenRareCandy
	bg_event 17, 19, BGEVENT_ITEM, Route34HiddenSuperPotion

	def_object_events
	object_event  9, 11, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event 16, 25, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event  8, 22, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_0_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	
	object_event 12, 32, SPRITE_OFFICER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event 15, 36, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event  6, 49, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event  8,  6, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_1_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	
	object_event  7, 10, SPRITE_OFFICER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event 11, 18, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 0, PoliceTrainer, -1
	object_event 11, 35, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event 15, 30, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_RIGHT, 2, 1, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_2_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	
	object_event  9, 16, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_Y, 0, 2, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event  6,  9, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 4, PoliceTrainer, -1
	object_event 14, 23, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_X, 2, 0, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	object_event 12,  6, SPRITE_OFFICER, SPRITEMOVEDATA_PATROL_CIRCLE_LEFT, 1, 1, HIDE_FREE & HIDE_VACCINE_PASS, RESEARCH_3_MASK, 0, OBJECTTYPE_TRAINER, 3, PoliceTrainer, -1
	
	object_event 13,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 5, TrainerCamperTodd1, -1
	object_event 15, 32, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerYoungsterSamuel, -1
	object_event 11, 20, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerYoungsterIan, -1
	object_event 10, 26, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerPicnickerGina1, -1
	object_event 18, 28, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerPokefanmBrandon, -1
	object_event 14, 16, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DayCareManScript_Outside, EVENT_DAY_CARE_MAN_ON_ROUTE_34
	object_event 14, 18, SPRITE_DAY_CARE_MON_1, SPRITEMOVEDATA_POKEMON, 2, 2, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, DayCareMon1Script, EVENT_DAY_CARE_MON_1
	object_event 17, 19, SPRITE_DAY_CARE_MON_2, SPRITEMOVEDATA_POKEMON, 2, 2, -1, -1, PAL_NPC_ROCK, OBJECTTYPE_SCRIPT, 0, DayCareMon2Script, EVENT_DAY_CARE_MON_2
	object_event 11, 48, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 5, TrainerCooltrainerfIrene, -1
	object_event  3, 48, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerCooltrainerfJenn, -1
	object_event  6, 51, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerCooltrainerfKate, -1
	object_event  7, 30, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route34Nugget, EVENT_ROUTE_34_NUGGET
