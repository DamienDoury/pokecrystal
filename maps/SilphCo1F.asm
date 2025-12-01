	object_const_def
	const SILPHCO1F_RECEPTIONIST
	const SILPHCO1F_OFFICER
	const SILPHCO1F_NURSE
	const SILPHCO1F_SCIENTIST

SilphCo1F_MapScripts:
	def_scene_scripts

	def_callbacks 
	callback MAPCALLBACK_TILES, .EnterCallback

.EnterCallback:
	disappear SILPHCO1F_SCIENTIST

	checkevent EVENT_SILPHCO_SCIENTIST_MET
	iftrue .move_officer
	endcallback

.move_officer:
	moveobject SILPHCO1F_OFFICER, 14, 1
	endcallback

SilphCoReceptionistScript:
	jumptextfaceplayer SilphCoReceptionistText

SilphCoOfficerScript:
	faceplayer
	opentext
	checkevent EVENT_FOUGHT_SUICUNE
	iffalse .SuicuneNotFought
	checkevent EVENT_SILPHCO_SCIENTIST_MET
	iftrue .AccessAllowed
	
	writetext SilphCoOfficerText
	promptbutton
	verbosegiveitem RARE_CANDY
	iffalse .NoRoom
	writetext SilphCoOfficerText_GotUpGrade
	waitbutton
	closetext

	playsound SFX_ELEVATOR_END
	waitsfx

	showemote EMOTE_SHOCK, SILPHCO1F_OFFICER, 15
	pause 5
	appear SILPHCO1F_SCIENTIST
	pause 5
	follow SILPHCO1F_OFFICER, SILPHCO1F_SCIENTIST
	applymovement SILPHCO1F_OFFICER, SilphCoNurseMovement_Out2
	stopfollow
	applymovement SILPHCO1F_OFFICER, SilphCoOfficerMovement_CallElevator

	setlasttalked SILPHCO1F_SCIENTIST
	pause 30
	faceplayer
	pause 10
	showemote EMOTE_SHOCK, SILPHCO1F_SCIENTIST, 15

	opentext
	writetext SilphCoScientist_HiText
	waitbutton
	closetext

	applymovement SILPHCO1F_SCIENTIST, SilphCo_HeadUpMovement

	showemote EMOTE_SHOCK, SILPHCO1F_OFFICER, 10

	readvar VAR_FACING
	ifequal LEFT, .leftfacing
	ifequal RIGHT, .rightfacing
; up facing:
	applymovement PLAYER, SilphCo_UpMovement
	sjump .follow_scientist

.leftfacing
	applymovement PLAYER, SilphCo_LeftMovement
	sjump .follow_scientist 

.rightfacing
	applymovement PLAYER, SilphCo_RightMovement	

.follow_scientist
	follow SILPHCO1F_SCIENTIST, PLAYER
	applymovement SILPHCO1F_SCIENTIST, SilphCo_UpMovement
	stopfollow
	disappear SILPHCO1F_SCIENTIST
	applymovement PLAYER, SilphCo_UpMovement
	warpcheck
	end

.SuicuneNotFought:
	writetext SilphCoOfficer_SuicuneText
	waitbutton
	sjump .NoRoom

.AccessAllowed:
	getitemname STRING_BUFFER_3, SILPH_BADGE
	writetext SilphCoOfficer_OkayText
	waitbutton
.NoRoom:
	closetext
	end

SilphCoNurseScript:
	checkevent EVENT_SICK_GENTLEMAN_DIED
	iftrue .iz_ded

	checkevent EVENT_ANTONS_NURSE_DID_LONG_SPEECH
	iftrue .skip_speech
	
	checkevent EVENT_SICK_GENTLEMAN_QUEST_ONGOING
	iffalse .default

	faceplayer
	showemote EMOTE_QUESTION, SILPHCO1F_NURSE, 15
	pause 3
	opentext
	writetext SilphCoNurse_AntonText
	yesorno
	iftrue .choose_mon

	jumptext SilphCoNurse_InsistText

.choose_mon
	checkpokemail GiftAntonMonMail
	ifequal POKEMAIL_WRONG_MAIL, .WrongMail
	ifequal POKEMAIL_REFUSED, .Refused
	ifequal POKEMAIL_NO_MAIL, .NoMail
	ifequal POKEMAIL_LAST_MON, .LastMon

	;opentext
	writetext SilphCoNurse_ReadsText
	waitbutton
	closetext

	showemote EMOTE_SHOCK, SILPHCO1F_NURSE, 15
	pause 3

	opentext
	writetext SilphCoNurse_Reads2Text
	waitbutton
	closetext

	checkevent EVENT_SILPHCO_SCIENTIST_MET
	iftrue .alternate_anim

	; default anim start
	applymovement SILPHCO1F_NURSE, SilphCoNurseMovement_In1
	applymovement SILPHCO1F_OFFICER, SilphCoOfficerMovement_CallElevator
	pause 5
	applymovement SILPHCO1F_NURSE, SilphCoNurseMovement_In2

	disappear SILPHCO1F_NURSE
	playsound SFX_ENTER_DOOR
	applymovement SILPHCO1F_OFFICER, SilphCoOfficerMovement_In
	waitsfx

	playsound SFX_ELEVATOR

	waitsfx

	
	applymovement SILPHCO1F_OFFICER, SilphCoOfficerMovement_Out
	
	pause 5
	moveobject SILPHCO1F_NURSE, 13, 0
	appear SILPHCO1F_NURSE
	applymovement SILPHCO1F_NURSE, SilphCoNurseMovement_Out1
	follow SILPHCO1F_NURSE, SILPHCO1F_OFFICER
	applymovement SILPHCO1F_NURSE, SilphCoNurseMovement_Out2
	stopfollow
	turnobject SILPHCO1F_OFFICER, DOWN
	applymovement SILPHCO1F_NURSE, SilphCoNurseMovement_Out3
	pause 2
	moveobject SILPHCO1F_NURSE, 10, 2
	sjump .after_anim
	; end of anim


.alternate_anim
	applymovement SILPHCO1F_NURSE, SilphCoNurseMovement_In1
	applymovement SILPHCO1F_NURSE, SilphCoNurseMovement_In2

	disappear SILPHCO1F_NURSE
	playsound SFX_ENTER_DOOR

	pause 15

	waitsfx

	playsound SFX_ELEVATOR

	waitsfx
	
	pause 15
	moveobject SILPHCO1F_NURSE, 13, 0
	appear SILPHCO1F_NURSE
	applymovement SILPHCO1F_NURSE, SilphCoNurseMovement_Out1
	applymovement SILPHCO1F_NURSE, SilphCoNurseMovement_Out2
	applymovement SILPHCO1F_NURSE, SilphCoNurseMovement_Out3
	pause 2
	moveobject SILPHCO1F_NURSE, 10, 2



.after_anim
	setevent EVENT_ANTONS_NURSE_DID_LONG_SPEECH	

.skip_speech:
	giveitem RARE_CANDY, 42
	iffalse .no_room

	opentext
	writetext SilphCoNurse_ThereYouGoText
	playsound SFX_ITEM
	waitbutton
	waitsfx
	itemnotify
	
	setevent EVENT_SICK_GENTLEMAN_DIED

	writetext SilphCoNurse_CandiesText
	promptbutton
	writetext SilphCoNurse_SayHiText
	waitbutton
	closetext
	end

.no_room:
	jumptext SilphCoNurse_NoRoomText

.WrongMail:
	jumptext SilphCoNurse_WrongMail

.Refused:
	jumptext SilphCoNurse_InsistText

.NoMail:
	farjumptext Text_Route31MissingMail

.LastMon:
	farjumptext Text_Route31CantTakeLastMon

.iz_ded:
	jumptext SilphCoNurse_SayHiText

.default:
	jumptextfaceplayer SilphCoNurseDefaultText

SilphCo1F_ElevatorButton:
    jumpstd ElevatorButtonScript

SilphCoNurseMovement_In1:
	slow_step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head UP
	step_end

SilphCoOfficerMovement_CallElevator:
	step LEFT
	turn_head UP
	step_end

SilphCoNurseMovement_In2:
	step UP
	step UP
	slow_step UP
	step_end

SilphCoOfficerMovement_Out:
	step LEFT
	turn_head DOWN
	step_end

SilphCoOfficerMovement_In:
	step RIGHT
	turn_head DOWN
	step_end

SilphCoNurseMovement_Out1:
	slow_step DOWN
	step_end

SilphCoNurseMovement_Out2:
	step DOWN
	step_end

SilphCoNurseMovement_Out3:
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	slow_step UP
	turn_head DOWN
	step_end

SilphCo_HeadUpMovement:
	turn_head UP
	step_end

SilphCo_UpMovement:
	step UP
	step_end

SilphCo_LeftMovement:
	step LEFT
	step_end

SilphCo_RightMovement:
	step RIGHT
	step_end

SilphCoReceptionistText: 
if DEF(_FR_FR)
	text "Bienvenue. Voici"
	line "les BUREAUX de la"
	cont "SYLPHE SARL."
else
	text "Welcome. This is"
	line "SILPH CO.'s HEAD"
	cont "OFFICE BUILDING."
endc

	done

SilphCoOfficerText: 
if DEF(_FR_FR)
	text "Seuls les employés"
	line "peuvent aller aux"
	cont "étages supérieurs."

	para "Mais comme tu"
	line "viens de loin,"

	para "voilà un petit"
	line "souvenir."
else
	text "Only employees are"
	line "permitted to go"
	cont "upstairs."

	para "But since you came"
	line "such a long way,"

	para "have this neat"
	line "little souvenir."
endc

	done

SilphCoOfficerText_GotUpGrade:
if DEF(_FR_FR)
	text "Merci de quitter"
	line "les lieux mainte-"
	cont "nant."
else
	text "Now please leave."
endc
	done

SilphCoNurseDefaultText:
if DEF(_FR_FR)
	text "La SYLPHE SARL a"
	line "assignée des cen-"
	cont "taines de ses"
	cont "chercheurs à l'"
	cont "étude du COVID,"
	
	para "afin de mettre au"
	line "point un vaccin."
else
	text "SILPH CO. has"
	line "devoted hundreds"
	cont "of its researchers"
	
	para "to studying COVID"
	line "and come up with" 
	cont "a vaccine."
endc
	done

SilphCoNurse_AntonText:
if DEF(_FR_FR)
	text "Tu as une lettre"
	line "pour la famille de"
	cont "Monsieur ANTON?"
	
	para "Je peux t'aider,"
	line "je m'occupais de"
	cont "lui autrefois."
	
	para "Puis-je voir le"
	line "#MON et sa"
	cont "lettre?"
else
	text "You have a letter"
	line "for Mister ANTON's"
	cont "relatives?"

	para "I can help you,"
	line "I used to take"
	cont "care of him."

	para "May I see the"
	line "#MON and its"
	cont "letter?"
endc
	done

SilphCoNurse_InsistText:
if DEF(_FR_FR)
	text "Si tu me montres"
	line "la lettre, je"
	cont "pourrais peut-être"
	
	para "t'en dire plus"
	line "sur M.ANTON."
else
	text "If you show me the"
	line "letter, I may tell"
	
	para "you more about"
	line "MR.ANTON."
endc
	done

SilphCoNurse_WrongMail:
if DEF(_FR_FR)
	text "Ce n'est pas"
	line "l'écriture de"
	cont "M.ANTON."
else
	text "That's not MR."
	line "ANTON's writing."
endc
	done

SilphCoNurse_ReadsText:
if DEF(_FR_FR)
	text "Voyons ce que MR."
	line "ANTON raconte."
	
	para "..."
	
	para "Oh, pauvre"
	line "M.ANTON!"
	
	para "Son état empire,"
	line "n'est-ce pas?"
else
	text "Let's see what MR."
	line "ANTON has to say."

	para "…"

	para "Oh poor MR.ANTON!"
	
	para "He's getting worse"
	line "isn't he?"
endc
	done

SilphCoNurse_Reads2Text:
if DEF(_FR_FR)
	text "Attends, tu n'es"
	line "pas au courant?"
	
	para "..."
	
	para "Tu ne trouveras"
	line "pas la femme de"
	cont "M.ANTON."
	
	para "Elle est décédée"
	line "il y a plusieurs"
	cont "années."
	
	para "..."
	
	para "M.ANTON a été"
	line "diagnostiqué avec"
	cont "la maladie d'Alz-"
	cont "heimer il y a"
	cont "cinq ans."
	
	para "Sa mémoire"
	line "décline."
	
	para "Quand je m'occupais"
	line "de lui, il me"
	cont "confondait souvent"
	cont "avec sa femme."
	
	para "Il m'appelait par"
	line "son prénom."
	
	para "Hélas son état"
	line "s'est dégradé, et"
	cont "quand le COVID-19"
	cont "est arrivé,"
	
	para "il a dû être"
	line "transféré à"
	cont "l'HOPITAL NATIONAL"
	cont "de DOUBLONVILLE."
	
	para "..."
	
	para "Je garde un bon"
	line "souvenir de ce"
	cont "patient."
	
	para "Il était adorable!"
	
	para "Chaque jour il"
	line "m'offrait des"
	cont "cadeaux."
	
	para "Je n'en avais pas"
	line "l'utilité, alors je"
	cont "les ai conservés"
	cont "dans mon bureau."
	
	para "J'ai une idée!"
	line "Tu devrais les"
	cont "prendre."
	
	para "Laisse-moi aller"
	line "les chercher"
	cont "rapido."
else
	text "Wait, you don't"
	line "know?"

	para "…"

	para "You won't find"
	line "MR.ANTON's wife."

	para "She has passed "
	line "away many years"
	cont "ago."	
	
	para "…"

	para "MR.ANTON was"
	line "diagnosed with"
	cont "Alzheimer's"
	cont "disease 5 years"
	cont "ago."

	para "His memory is"
	line "failing."

	para "When I used to"
	line "take care of him,"
	
	para "he often confused"
	line "me with his wife,"
	
	para "calling me by her"
	line "name."

	para "But then it got"
	line "worse and when"
	cont "COVID-19 arrived,"
	
	para "he had to be"
	line "transferred to"

	para "GOLDENROD's"
	line "hospital."

	para "…"

	para "I have fond"
	line "memories of this"
	cont "patient."

	para "He is such a"
	line "lovely man!"

	para "He used to give me"
	line "presents everyday."

	para "Though I didn't"
	line "have a use for"
	cont "those, so I stored"
	cont "them in my office."

	para "I have an idea!"
	line "You should have"
	cont "them."

	para "Let me go fetch"
	line "them quickly."
endc
	done

SilphCoNurse_NoRoomText:
if DEF(_FR_FR)
	text "Y'en a beaucoup!"
	line "Va falloir faire"
	cont "de la place dans"
	cont "ton SAC si tu veux"
	cont "prendre tout ce"
	cont "que M.ANTON m'a"
	cont "offert."
else
	text "There is a lot!"
	line "You're gonna need"
	cont "to make room in"
	cont "your bag if you"
	cont "wanna take every-"
	cont "thing MR.ANTON"
	cont "gave me."
endc
	done

SilphCoNurse_ThereYouGoText:
if DEF(_FR_FR)
	text "Voilà pour toi!"
else
	text "There you go!"
endc
	done

SilphCoNurse_CandiesText:
if DEF(_FR_FR)
	text "J'ai compté un"
	line "total de 42 SUPER"
	cont "BONBONS."
	
	para "Je me demande"
	line "comment il a pu"
	cont "en obtenir autant."
	
	para "Les personnes avec"
	line "cette maladie ont"
	cont "tendance à voler"
	cont "des objets."
	
	para "Mais en même temps"
	line "elles ont souvent"
	cont "des difficultés à"
	cont "bouger aux stades"
	cont "avancés."
	
	para "Je soupçonne son"
	line "MIAOUSS d'être son"
	cont "complice."
	
	para "Enfin bref."
	
	para "Fin de ma pause,"
	line "je dois retourner"
	cont "bosser."
else
	text "I counted 42"
	line "RARE CANDIES."
	
	para "I wonder how he"
	line "got so many."

	para "People with this"
	line "disease tend to"
	cont "steal items."

	para "But at the same"
	line "time, they often"
	cont "have issues with"
	cont "movement in the"
	cont "advanced stages."

	para "I suspect his"
	line "MEOWTH helped him."

	para "Anyway."

	para "My break is over,"
	line "I must get back"
	cont "to work."
endc
	done

SilphCoNurse_SayHiText:
if DEF(_FR_FR)
	text "La prochaine fois"
	line "que tu verras"
	cont "M.ANTON, dis-lui"
	cont "que son ancienne"
	cont "infirmière lui"
	cont "passe le bonjour!"
else
	text "Next time you see"
	line "MR.ANTON, tell him"
	cont "his old nurse"
	cont "says hi!"
endc
	done

SilphCoScientist_HiText:
if DEF(_FR_FR)
	text "Es-tu <PLAYER>, le"
	line "MAITRE de la"
	cont "LIGUE?"
	
	para "Ta visite surprise"
	line "tombe à pic: on"
	cont "aurait bien besoin"
	cont "de l'aide de quelqu'"
	cont "un d'expérimenté"
	cont "avec les #MON."
	
	para "Viens avec moi"
	line "s'il te plaît."
else
	text "Are you <PLAYER>,"
	line "the LEAGUE"
	cont "CHAMPION?"

	para "Your surprise"
	line "visit comes at the"
	
	para "perfect time: we"
	line "could use the help"

	para "of an experienced"
	line "trainer like you."

	para "Please follow me."
endc
	done

SilphCoOfficer_SuicuneText:
if DEF(_FR_FR)
	text "Dans ce bâtiment,"
	line "les chercheurs"
	cont "essaient de créer"
	cont "un vaccin univer-"
	cont "sel pour les"
	cont "#MON."
	
	para "Mais ça n'avance"
	line "pas trop."
	
	para "Des scientifiques"
	line "viennent de loin"
	cont "pour prêter main-"
	cont "forte."
	
	para "Un homme étrange"
	line "s'est pointé l'autre"
	cont "jour. Il disait"
	cont "avoir des infos"
	cont "au sujet d'un"
	cont "#MON légendaire"
	cont "pouvant faire"
	cont "avancer la recher-"
	cont "che."
	
	para "J'ai dû le mettre"
	line "dehors."
else
	text "Reseachers are"
	line "trying to find a"
	cont "vaccine for"
	cont "#MON, in this"
	cont "building."
	
	para "But they aren't"
	line "making progress."

	para "Scientists come"
	line "from far away to"
	cont "provide help."

	para "A weird man came"
	line "the other day and"
	cont "said he knew of a"
	cont "mythical #MON"
	cont "that could help"
	cont "with the research."
	
	para "I had to kick"
	line "him out."
endc
	done

SilphCoOfficer_OkayText:
if DEF(_FR_FR)
	text "Puis-je voir votre"
	line "@"
	text_ram wStringBuffer3
	text "?"
	
	para "..."
	
	para "Vous pouvez"
	line "passer."
else
	text "May I see your"
	line "@"
	text_ram wStringBuffer3
	text "?"

	para "…"

	para "You shall pass."
endc
	done

SilphCo1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, SAFFRON_CITY, 7
	warp_event  3,  7, SAFFRON_CITY, 7
	warp_event  13, 0, SILPHCO_ELEVATOR, 2

	def_coord_events

	def_bg_events
	bg_event 12,  0, BGEVENT_READ, SilphCo1F_ElevatorButton

	def_object_events
	object_event  4,  2, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SilphCoReceptionistScript, -1
	object_event 13,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, SilphCoOfficerScript, -1
	object_event 10,  2, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, SilphCoNurseScript, EVENT_SICK_GENTLEMAN_DIED
	object_event 13,  0, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SilphCoReceptionistScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_4
