	object_const_def
	const SILPHCO1F_RECEPTIONIST
	const SILPHCO1F_OFFICER
	const SILPHCO1F_NURSE

SilphCo1F_MapScripts:
	def_scene_scripts

	def_callbacks

SilphCoReceptionistScript:
	jumptextfaceplayer SilphCoReceptionistText

SilphCoOfficerScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_UP_GRADE
	iftrue .GotUpGrade
	writetext SilphCoOfficerText
	promptbutton
	verbosegiveitem UP_GRADE
	iffalse .NoRoom
	setevent EVENT_GOT_UP_GRADE
.GotUpGrade:
	writetext SilphCoOfficerText_GotUpGrade
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
	checkpokemail ReceivedAntonMailText
	ifequal POKEMAIL_WRONG_MAIL, .WrongMail
	ifequal POKEMAIL_REFUSED, .Refused
	ifequal POKEMAIL_NO_MAIL, .NoMail
	ifequal POKEMAIL_LAST_MON, .LastMon

	opentext
	farwritetext Text_Route31HandOverMailMon
	promptbutton

	writetext SilphCoNurse_ReadsText
	waitbutton
	closetext

	showemote EMOTE_SHOCK, SILPHCO1F_NURSE, 15
	pause 3

	opentext
	writetext SilphCoNurse_Reads2Text
	waitbutton
	closetext

	; anim start
	applymovement SILPHCO1F_NURSE, SilphCoNurseMovement_In1
	applymovement SILPHCO1F_OFFICER, SilphCoOfficerMovement_CallElevator
	pause 5
	applymovement SILPHCO1F_NURSE, SilphCoNurseMovement_In2

	disappear SILPHCO1F_NURSE
	playsound SFX_ENTER_DOOR
	applymovement SILPHCO1F_OFFICER, SilphCoOfficerMovement_Out
	waitsfx

	playsound SFX_ELEVATOR

	waitsfx

	
	applymovement SILPHCO1F_OFFICER, SilphCoOfficerMovement_In
	
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
	; end of anim

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

SilphCoNurseMovement_In1:
	slow_step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head UP
	step_end

SilphCoOfficerMovement_CallElevator:
	step RIGHT
	turn_head LEFT
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

ReceivedAntonMailText:
	db   "I will always"
	next "love you darling@"

SilphCoReceptionistText:
	text "Welcome. This is"
	line "SILPH CO.'s HEAD"
	cont "OFFICE BUILDING."
	done

SilphCoOfficerText:
	text "Only employees are"
	line "permitted to go"
	cont "upstairs."

	para "But since you came"
	line "such a long way,"

	para "have this neat"
	line "little souvenir."
	done

SilphCoOfficerText_GotUpGrade:
	text "It's SILPH CO.'s"
	line "latest product."

	para "It's not for sale"
	line "anywhere yet."
	done

SilphCoNurseDefaultText:
	text "SILPH CO. has"
	line "devoted hundreds"
	cont "of its researchers"
	
	para "to studying COVID"
	line "and come up with" 
	cont "a vaccine."
	done

SilphCoNurse_AntonText:
	text "You have a letter"
	line "for Mister ANTON's"
	cont "relatives?"

	para "I can help you,"
	line "I used to take"
	cont "care of him."

	para "May I see the"
	line "#MON and its"
	cont "letter?"
	done

SilphCoNurse_InsistText:
	text "If you show me the"
	line "letter, I may tell"
	
	para "you more about"
	line "MR.ANTON."
	done

SilphCoNurse_WrongMail:
	text "That's not MR."
	line "ANTON's writing."
	done

SilphCoNurse_ReadsText:
	text "Let's see what MR."
	line "ANTON has to say."

	para "…"

	para "Oh poor MR.ANTON!"
	
	para "He's getting worse"
	line "isn't he?"
	done

SilphCoNurse_Reads2Text:
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
	done

SilphCoNurse_NoRoomText:
	text "There is a lot!"
	line "You're gonna need"
	cont "to make room in"
	cont "your bag if you"
	cont "wanna take every-"
	cont "thing MR.ANTON"
	cont "gave me."
	done

SilphCoNurse_ThereYouGoText:
	text "There you go!"
	done

SilphCoNurse_CandiesText:
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
	done

SilphCoNurse_SayHiText:
	text "Next time you see"
	line "MR.ANTON, tell him"
	cont "his old nurse"
	cont "says hi!"
	done

SilphCo1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, SAFFRON_CITY, 7
	warp_event  3,  7, SAFFRON_CITY, 7

	def_coord_events

	def_bg_events

	def_object_events
	object_event  4,  2, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SilphCoReceptionistScript, -1
	object_event 13,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SilphCoOfficerScript, -1
	object_event 10,  2, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, SilphCoNurseScript, EVENT_SICK_GENTLEMAN_DIED
