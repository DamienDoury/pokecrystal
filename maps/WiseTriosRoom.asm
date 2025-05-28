	object_const_def
	const WISETRIOSROOM_SAGE1
	const WISETRIOSROOM_SAGE2
	const WISETRIOSROOM_SAGE3
	const WISETRIOSROOM_SAGE4
	const WISETRIOSROOM_SAGE5
	const WISETRIOSROOM_SAGE6

WiseTriosRoom_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .WiseTrioCallback

.WiseTrioCallback:
	checkevent EVENT_FOUGHT_SUICUNE
	iftrue .NoWiseTrio
	checkevent EVENT_KOJI_ALLOWS_YOU_PASSAGE_TO_TIN_TOWER
	iftrue .WiseTrio2
	checkitem CLEAR_BELL
	iftrue .WiseTrio2
	clearevent EVENT_WISE_TRIOS_ROOM_WISE_TRIO_1
	setevent EVENT_WISE_TRIOS_ROOM_WISE_TRIO_2
	endcallback

.WiseTrio2:
	setevent EVENT_WISE_TRIOS_ROOM_WISE_TRIO_1
	clearevent EVENT_WISE_TRIOS_ROOM_WISE_TRIO_2
	endcallback

.NoWiseTrio:
	setevent EVENT_WISE_TRIOS_ROOM_WISE_TRIO_1
	setevent EVENT_WISE_TRIOS_ROOM_WISE_TRIO_2
	endcallback

WiseTriosRoomSage1Script:
	faceplayer
	jumptext WiseTriosRoomSage1Text

WiseTriosRoomSage2Script:
	faceplayer
	jumptext WiseTriosRoomSage2Text

WiseTriosRoomSage3Script:
	faceplayer
	jumptext WiseTriosRoomSage3Text

WiseTriosRoom_CannotEnterTinTowerScript:	
	turnobject WISETRIOSROOM_SAGE3, UP
	turnobject PLAYER, DOWN
	showemote EMOTE_SHOCK, WISETRIOSROOM_SAGE3, 20
	follow PLAYER, WISETRIOSROOM_SAGE3
	applymovement PLAYER, WiseTriosRoomSageBlocksPlayerMovement
	stopfollow
	turnobject PLAYER, RIGHT
	applymovement WISETRIOSROOM_SAGE3, WiseTriosRoomWalkRightMovement
	opentext
	writetext WiseTriosRoomSage3BlocksExitText
	waitbutton
	closetext
	applymovement WISETRIOSROOM_SAGE3, WiseTriosRoomSageReturnsMovement
	end

TrainerSageGaku:
	trainer SAGE, GAKU, EVENT_BEAT_SAGE_GAKU, SageGakuSeenText, SageGakuBeatenText, 0, .Script

.Script:
	opentext
	writetext SageGakuAfterBattleText
	waitbutton
	closetext
	end

TrainerSageMasa:
	trainer SAGE, MASA, EVENT_BEAT_SAGE_MASA, SageMasaSeenText, SageMasaBeatenText, 0, .Script

.Script:
	opentext
	writetext SageMasaAfterBattleText
	waitbutton
	closetext
	end

TrainerSageKoji:
	trainer SAGE, KOJI, EVENT_BEAT_SAGE_KOJI, SageKojiSeenText, SageKojiBeatenText, 0, .Script

.Script:
	checkevent EVENT_KOJI_ALLOWS_YOU_PASSAGE_TO_TIN_TOWER
	iftrue .KojiAllowsPassage
	pause 10
	showemote EMOTE_SHOCK, WISETRIOSROOM_SAGE6, 20
	opentext
	writetext SageKojiAfterBattleQuestionText
	promptbutton
	writetext SageKojiAfterBattleSpeechText
	waitbutton
	closetext
	setevent EVENT_KOJI_ALLOWS_YOU_PASSAGE_TO_TIN_TOWER
	end

.KojiAllowsPassage:
	opentext
	writetext SageKojiAfterBattleFinalText
	waitbutton
	closetext
	end

WiseTriosRoomSageBlocksPlayerMovement:
	step LEFT
	step LEFT
	step_end

WiseTriosRoomWalkRightMovement:
	step RIGHT
	turn_head LEFT
	step_end

WiseTriosRoomSageReturnsMovement:
	step DOWN
	turn_head LEFT
	step_end

WiseTriosRoomSage1Text: 
if DEF(_FR_FR)
	text "Dingue..."

	para "SUICUNE, ENTEI et"
	line "RAIKOU se sont"
	cont "réveillés..."

	para "La légende est-"
	line "elle vraie?"
else
	text "Astounding…"

	para "SUICUNE, ENTEI and"
	line "RAIKOU have arisen"
	cont "from their sleep…"

	para "Is the legend"
	line "coming true?"
endc

	done

WiseTriosRoomSage2Text: 
if DEF(_FR_FR)
	text "On s'entraîne à la"
	line "TOUR CENDREE mais"

	para "on n'a jamais vu"
	line "de trou s'ouvrir"

	para "jusqu'à présent."
	line "Quelqu'un doit en"

	para "être le"
	line "responsable."
else
	text "We train at the"
	line "BURNED TOWER, but"

	para "we've never heard"
	line "of a hole opening"

	para "up there before."
	line "It must have been"

	para "deliberately made"
	line "by someone."
endc

	done

WiseTriosRoomSage3BlocksExitText: 
if DEF(_FR_FR)
	text "La TOUR FERRAILLE"
	line "est accessible aux"

	para "porteurs du BADGE"
	line "de ROSALIA."

	para "Toutefois, depuis"
	line "le réveil de"
	cont "SUICUNE, RAIKOU"

	para "et d'ENTEI, je ne"
	line "peux pas vous"
	cont "laisser entrer!"
else
	text "TIN TOWER may be"
	line "entered by those"

	para "bearing ECRUTEAK's"
	line "GYM BADGE."

	para "However, now that"
	line "SUICUNE, RAIKOU"

	para "and ENTEI have"
	line "arisen, I ask you"

	para "to refrain from"
	line "entering!"
endc

	done

WiseTriosRoomSage3Text: 
if DEF(_FR_FR)
	text "Nous, le TRIO des"
	line "SAGES, sommes les"

	para "gardiens des #-"
	line "MON légendaires."
else
	text "We, the WISE TRIO,"
	line "are the protectors"

	para "of the legendary"
	line "#MON."
endc

	done

SageGakuSeenText: 
if DEF(_FR_FR)
	text "La légende dit"
	line "que la venue d'un"

	para "dresseur pouvant"
	line "toucher l'âme des"

	para "#MON, un"
	line "#MON viendra"

	para "mettre ce dresseur"
	line "à l'épreuve dans"
	cont "la TOUR FERRAILLE."

	para "La légende s'est"
	line "réalisée!"

	para "Le #MON"
	line "légendaire SUICUNE"
	cont "est arrivé!"

	para "Nous, le TRIO des"
	line "SAGES, te mettons"
	cont "au défi d'entrer!"
else
	text "Legend has it that"
	line "upon the emergence"

	para "of a trainer who"
	line "has the ability to"

	para "touch the souls of"
	line "#MON, a #MON"

	para "will come forth to"
	line "put that trainer"

	para "to test at the TIN"
	line "TOWER."

	para "The legend has"
	line "come true!"

	para "The legendary"
	line "#MON SUICUNE"
	cont "has arrived!"

	para "We, the WISE TRIO,"
	line "shall test your"

	para "worthiness to go"
	line "inside!"
endc

	done

SageGakuBeatenText: 
if DEF(_FR_FR)
	text "Trop de puissance!"
else
	text "Stronger than we"
	line "thought? Perhaps…"
endc

	done

SageGakuAfterBattleText: 
if DEF(_FR_FR)
	text "Tu prétends donc"
	line "avoir vu SUICUNE,"
	cont "ENTEI et RAIKOU"
	cont "endormis?"

	para "Incroyable!"

	para "La légende dit"
	line "bien qu'on ne peut"
	cont "pas les voir"
	cont "dormir..."
else
	text "Ah, so it is you"
	line "who claim to have"

	para "seen SUICUNE,"
	line "ENTEI and RAIKOU"
	cont "while they slept?"

	para "Unbelievable!"

	para "Legend has it that"
	line "they can't be seen"
	cont "while they sleep…"
endc

	done

SageMasaSeenText: 
if DEF(_FR_FR)
	text "Doit-on te faire"
	line "confiance?"

	para "Je dois te mettre"
	line "à l'épreuve."
else
	text "Can you be trusted"
	line "with the truth?"

	para "I must ascertain"
	line "your worthiness."
endc

	done

SageMasaBeatenText: 
if DEF(_FR_FR)
	text "...Je dirai la"
	line "vérité..."
else
	text "…I will tell you"
	line "the truth…"
endc

	done

SageMasaAfterBattleText: 
if DEF(_FR_FR)
	text "Il y a longtemps,"
	line "il y avait deux"
	cont "tours ici."

	para "La TOUR de CUIVRE,"
	line "qui pouvait éveil-"

	para "ler les #MON,"
	line "et la TOUR FER-"

	para "RAILLE, où les"
	line "#MON se"
	cont "reposaient."

	para "La vue depuis le"
	line "sommet des TOURS"

	para "devait être"
	line "magnifique."

	para "En ce temps-là, un"
	line "immense #MON"

	para "argenté avait fait"
	line "son nid en haut de"
	cont "la TOUR de CUIVRE."

	para "Toutefois..."

	para "Il y a 150 ans,"
	line "un éclair frappa"
	cont "l'une des TOURS."

	para "Elle prit feu et"
	line "brûla pendant"
	cont "trois jours."

	para "Et puis une pluie"
	line "violente eut"
	cont "raison du brasier."

	para "Voici comment la"
	line "TOUR CENDREE est"
	cont "née."
else
	text "In the past, there"
	line "were two nine-tier"
	cont "towers here."

	para "The BRASS TOWER,"
	line "which was said to"

	para "awaken #MON,"
	line "and the TIN TOWER,"

	para "where #MON were"
	line "said to rest."

	para "The view from the"
	line "tops of the TOWERS"

	para "must have been"
	line "magnificent."

	para "At the time, an"
	line "immense, silver-"

	para "colored #MON"
	line "was said to make"

	para "its roost atop the"
	line "BRASS TOWER."

	para "However…"

	para "About 150 years"
	line "ago, a lightning"

	para "bolt struck one of"
	line "the TOWERS."

	para "It was engulfed in"
	line "flames that raged"
	cont "for three days."

	para "A sudden downpour"
	line "finally put out"
	cont "the blaze."

	para "And that is how"
	line "the BURNED TOWER"
	cont "came to be."
endc

	done

SageKojiSeenText: 
if DEF(_FR_FR)
	text "Montre-moi ta"
	line "force!"
else
	text "Let me see your"
	line "power!"
endc

	done

SageKojiBeatenText: 
if DEF(_FR_FR)
	text "Trop de puissance!"
	line "Pourquoi?"
else
	text "Too strong!"
	line "Why?"
endc

	done

SageKojiAfterBattleQuestionText: 
if DEF(_FR_FR)
	text "Toi... Es-tu là"
	line "pour les #MON"
	cont "légendaires?"
else
	text "You… Are you the"
	line "trainer who is"

	para "awaited by the"
	line "legendary #MON?"
endc

	done

SageKojiAfterBattleSpeechText: 
if DEF(_FR_FR)
	text "Je vois..."

	para "Nous, le TRIO des"
	line "SAGES, avons le"

	para "devoir de protéger"
	line "les #MON légen-"

	para "daires. "
	line "Nous ne laissons"

	para "passer que ceux"
	line "au coeur pur."

	para "Entre et découvre"
	line "la TOUR FERRAILLE."

	para "SUICUNE te mettra"
	line "à l'épreuve."
else
	text "I see…"

	para "We, the WISE TRIO,"
	line "have been given "

	para "the responsibility"
	line "of protecting the"

	para "legendary #MON."
	line "We are to allow"

	para "passage only to"
	line "those people who"

	para "possess the power"
	line "and soul of truth."

	para "Please, do go on"
	line "and enter the TIN"
	cont "TOWER ahead."

	para "SUICUNE will put"
	line "you to the test."
endc

	done

SageKojiAfterBattleFinalText: 
if DEF(_FR_FR)
	text "Va."

	para "SUICUNE te mettra"
	line "à l'épreuve."
else
	text "Please, do go on."

	para "SUICUNE will put"
	line "you to the test."
endc

	done

WiseTriosRoom_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  7,  4, ECRUTEAK_CITY, 4
	warp_event  7,  5, ECRUTEAK_CITY, 5
	warp_event  1,  4, ECRUTEAK_TIN_TOWER_ENTRANCE, 5

	def_coord_events
	coord_event  7,  4, CE_EVENT_FLAG_CLEARED, EVENT_KOJI_ALLOWS_YOU_PASSAGE_TO_TIN_TOWER, WiseTriosRoom_CannotEnterTinTowerScript

	def_bg_events

	def_object_events
	object_event  6,  2, SPRITE_SAGE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, WiseTriosRoomSage1Script, EVENT_WISE_TRIOS_ROOM_WISE_TRIO_1
	object_event  6,  7, SPRITE_SAGE, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, WiseTriosRoomSage2Script, EVENT_WISE_TRIOS_ROOM_WISE_TRIO_1
	object_event  7,  5, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, WiseTriosRoomSage3Script, EVENT_WISE_TRIOS_ROOM_WISE_TRIO_1
	object_event  4,  2, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerSageGaku, EVENT_WISE_TRIOS_ROOM_WISE_TRIO_2
	object_event  4,  6, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerSageMasa, EVENT_WISE_TRIOS_ROOM_WISE_TRIO_2
	object_event  6,  4, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerSageKoji, EVENT_WISE_TRIOS_ROOM_WISE_TRIO_2
