	object_const_def
	const ECRUTEAKPOKECENTER1F_NURSE
	const ECRUTEAKPOKECENTER1F_POKEFAN_M
	const ECRUTEAKPOKECENTER1F_COOLTRAINER_F
	const ECRUTEAKPOKECENTER1F_GYM_GUIDE
	const ECRUTEAKPOKECENTER1F_BILL

EcruteakPokecenter1F_MapScripts:
	def_scene_scripts
	scene_script .MeetBill ; SCENE_ALWAYS

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .EcruteakPokecenter1F_AntiSoftLock

.EcruteakPokecenter1F_AntiSoftLock:
	farsjump AntiSoftLockPokeball

.MeetBill:
	checkevent EVENT_MET_BILL
	iffalse .end
	prioritysjump .MeetBillScript
.end
	end

.DummyScene:
	end

.MeetBillScript:
	pause 30
	playsound SFX_EXIT_BUILDING
	appear ECRUTEAKPOKECENTER1F_BILL
	waitsfx
	applymovement ECRUTEAKPOKECENTER1F_BILL, EcruteakPokecenter1FBillMovement1
	applymovement PLAYER, EcruteakPokecenter1FPlayerMovement1
	turnobject ECRUTEAKPOKECENTER1F_NURSE, UP
	pause 10
	turnobject ECRUTEAKPOKECENTER1F_NURSE, DOWN
	pause 30
	turnobject ECRUTEAKPOKECENTER1F_NURSE, UP
	pause 10
	turnobject ECRUTEAKPOKECENTER1F_NURSE, DOWN
	pause 20
	turnobject ECRUTEAKPOKECENTER1F_BILL, DOWN
	pause 10
	opentext
	writetext EcruteakPokecenter1F_BillText1
	promptbutton
	writetext EcruteakPokecenter1F_BillText2
	waitbutton
	closetext
	turnobject PLAYER, DOWN
	applymovement ECRUTEAKPOKECENTER1F_BILL, EcruteakPokecenter1FBillMovement2
	playsound SFX_EXIT_BUILDING
	disappear ECRUTEAKPOKECENTER1F_BILL
	clearevent EVENT_MET_BILL
	waitsfx
	end

EcruteakPokecenter1FNurseScript:
	jumpstd PokecenterNurseScript

EcruteakPokecenter1FPokefanMScript:
	special Mobile_DummyReturnFalse
	iftrue .mobile
	jumptextfaceplayer EcruteakPokecenter1FPokefanMText

.mobile
	jumptextfaceplayer EcruteakPokecenter1FPokefanMTextMobile

EcruteakPokecenter1FCooltrainerFScript:
	jumptextfaceplayer EcruteakPokecenter1FCooltrainerFText

EcruteakPokecenter1FGymGuideScript:
	faceplayer
	jumptext EcruteakPokecenter1FGymGuideText ; No clapping animation for SPRITE_GYM_GUIDE.

EcruteakPokecenter1FBillMovement1:
	step UP
	step UP
	step UP
	step UP
	step RIGHT
	step RIGHT
	step RIGHT
	turn_head UP
	step_end

EcruteakPokecenter1FBillMovement2:
	step RIGHT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end

EcruteakPokecenter1FPlayerMovement1:
	step UP
	step UP
	step_end

EcruteakPokecenter1F_BillText1: 
if DEF(_FR_FR)
	text "Salut, je suis"
	line "LEO. Et toi qui"
	cont "es-tu?"

	para "<PLAYER>,"
	line "hein? Tu arrives"
	cont "au bon moment."
else
	text "Hi, I'm BILL. And"
	line "who are you?"

	para "Hmm, <PLAYER>, huh?"
	line "You've come at the"
	cont "right time."
endc

	done

EcruteakPokecenter1F_BillText2:
if DEF(_FR_FR)
	text "Je viens d'achever"
	line "une étude sur le"
	cont "SYSTEME de STOCK-"
	cont "AGE de #MON."

	para "J'ai analysé le"
	line "comportement du"
	cont "virus sur des"
	cont "#MON stockés."

	para "Je pensais que le"
	line "PC serait un bon"
	cont "moyen de les"
	cont "mettre en"
	cont "quarantaine."

	para "Hélas, c'est tout"
	line "le contraire."

	para "Ca gèle le virus,"
	line "ce qui rend l'in-"
	cont "fection éternelle"
	cont "dans le PC..."

	para "Seul avantage: le"
	line "virus ne se propa-"
	cont "ge pas dans le PC."

	para "Je dois vite"
	line "retourner à"
	cont "DOUBLONVILLE pour"
	cont "voir mes parents."

	para "Tchao!"
else
	text "I just finished"
	line "a study on the"
	cont "PSS, the #MON"
	cont "Storage System."

	para "I analyzed the"
	line "behaviour of the"
	cont "virus on stored"
	cont "#MON."

	para "I expected it"
	line "could be a safe"
	cont "quanrantine method"
	cont "for #MON."

	para "Unfortunately, it"
	line "is quite the"
	cont "opposite."

	para "It freezes the"
	line "the virus, making"
	cont "the infection last"
	cont "forever inside"
	cont "the PC…"

	para "The only advantage"
	line "is that it doesn't"
	cont "spread inside the"
	cont "PC."

	para "I have to hurry on"
	line "back to GOLDENROD"
	cont "and see my folks."

	para "Buh-bye!"
endc
	done

EcruteakPokecenter1FPokefanMText: 
if DEF(_FR_FR)
	text "La façon dont les"
	line "KIMONO dansent est"

	para "merveilleuse."
	line "Comme lorsqu'elles"
	cont "utilisent leurs"
	cont "#MON."
else
	text "The way the KIMONO"
	line "GIRLS dance is"

	para "marvelous. Just"
	line "like the way they"
	cont "use their #MON."
endc

	done

EcruteakPokecenter1FPokefanMTextMobile: 
if DEF(_FR_FR)
	text "Tu veux te battre"
	line "contre plus d'ad-"

	para "versaires, non?"
	line "Il y a un endroit"
	cont "fait pour toi."

	para "Où ça?"

	para "Après OLIVILLE."
else
	text "You must be hoping"
	line "to battle more"

	para "people, right?"
	line "There's apparently"

	para "some place where"
	line "trainers gather."

	para "Where, you ask?"

	para "It's a little past"
	line "OLIVINE CITY."
endc

	done

EcruteakPokecenter1FCooltrainerFText:
if DEF(_FR_FR)
	text "MORTIMER, le"
	line "CHAMPION d'ARENE"
	cont "est trooop cool."

	para "Ses #MON sont"
	line "bien balèzes."

	para "Tellement qu'il"
	line "doit utiliser un"
	cont "LIMITEUR DE FORCE,"

	para "pour que le niveau"
	line "de son équipe soit"
	cont "égal au plus haut"
	cont "niveau de son"
	cont "adversaire."

	para "Les autres"
	line "CHAMPIONS font"
	cont "ça aussi, ouais."

	para "Mais MORTIMER"
	line "reste le plus"
	cont "cool!"
else
	text "MORTY, the GYM"
	line "LEADER, is soooo"
	cont "cool."

	para "His #MON are"
	line "really tough."

	para "So much that he"
	line "has to use a"
	cont "POWER RESTRAINER,"

	para "so that his team's"
	line "level matches the"
	cont "highest level of"
	cont "his opponent."

	para "Other GYM LEADERS"
	line "do it too, yeah."

	para "But MORTY's still"
	line "the coolest!"
endc
	done

EcruteakPokecenter1FGymGuideText: 
if DEF(_FR_FR)
	text "LAC COLERE..."

	para "Là où le LEVIATOR"
	line "apparaît..."

	para "Ca sent l'em-"
	line "brouille. Je sais!"
else
	text "LAKE OF RAGE…"

	para "The appearance of"
	line "a GYARADOS swarm…"

	para "I smell a conspir-"
	line "acy. I know it!"
endc

	done

EcruteakPokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, ECRUTEAK_CITY, 6
	warp_event  4,  7, ECRUTEAK_CITY, 6
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakPokecenter1FNurseScript, -1
	object_event  7,  6, SPRITE_POKEFAN_M, CLAP_F | SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakPokecenter1FPokefanMScript, -1
	object_event  1,  4, SPRITE_COOLTRAINER_F, CLAP_F | SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, EcruteakPokecenter1FCooltrainerFScript, -1
	object_event  7,  1, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_CURFEW & HIDE_VACCINE_PASS, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, EcruteakPokecenter1FGymGuideScript, EVENT_ROUTE_43_GATE_ROCKETS
	object_event  0,  7, SPRITE_BILL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_ECRUTEAK_POKE_CENTER_BILL
