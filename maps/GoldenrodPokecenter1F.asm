	object_const_def
	const GOLDENRODPOKECENTER1F_NURSE
	const GOLDENRODPOKECENTER1F_GAMEBOY_KID
	const GOLDENRODPOKECENTER1F_LASS
	const GOLDENRODPOKECENTER1F_POKEFAN_F

GoldenrodPokecenter1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .GoldenrodPokecenter1F_AntiSoftLock

.GoldenrodPokecenter1F_AntiSoftLock:
	farsjump AntiSoftLockPokeball

GoldenrodPokecenter1FNurseScript:
	jumpstd PokecenterNurseScript

GoldenrodPokecenter1FGameboyKidScript:
	faceplayer
	jumptext GoldenrodPokecenter1FGameboyKidText

GoldenrodPokecenter1FLassScript:
	jumptextfaceplayer GoldenrodPokecenter1FLassText

GoldenrodPokecenter1FPokefanF:
	faceplayer
	opentext

	checkflag ENGINE_EON_MAIL
	iftrue .Tomorrow

	writetext GoldenrodPokecenter1FPokefanFDoYouHaveEonMailText
	waitbutton
	writetext GoldenrodPokecenter1FAskGiveAwayAnEonMailText
	yesorno
	iffalse .NoEonMail
	takeitem EON_MAIL
	iffalse .NoEonMail
	writetext GoldenrodPokecenter1FPlayerGaveAwayTheEonMailText
	waitbutton
	writetext GoldenrodPokecenter1FPokefanFThisIsForYouText
	waitbutton
	verbosegiveitem REVIVE
	iffalse .NoRoom
	writetext GoldenrodPokecenter1FPokefanFDaughterWillBeDelightedText
	promptbutton
	setflag ENGINE_EON_MAIL
	sjump .Tomorrow

.NoEonMail:
	writetext GoldenrodPokecenter1FPokefanFTooBadText
	waitbutton
	closetext
	end

.Tomorrow
	writetext GoldenrodPokecenter1FPokefanFDaughterTomorrowText
	sjump .WaitButton

.NoRoom:
	giveitem EON_MAIL
	writetext GoldenrodPokecenter1FPokefanFAnotherTimeThenText

.WaitButton
	waitbutton
	closetext
	end

GoldenrodPokecenter1FGameboyKidText: 
if DEF(_FR_FR)
	text "Le COLISEE sert"
	line "à faire des com-"
	cont "bats en Link."

	para "Les records sont"
	line "affichés sur le"
	cont "mur. Perdre, c'est"
	cont "la honte!"
else
	text "The COLOSSEUM"
	line "upstairs is for"
	cont "link battles."

	para "Battle records are"
	line "posted on the"

	para "wall, so I can't"
	line "afford to lose."
endc

	done

GoldenrodPokecenter1FLassText: 
if DEF(_FR_FR)
	text "Un #MON de"
	line "niveau élevé ne"
	cont "gagnera pas à tous"
	cont "les coups."

	para "Après tout, il y a"
	line "peut-être un type"
	cont "désavantagé."

	para "Je ne crois pas"
	line "qu'il y ait un"

	para "type de #MON"
	line "qui soit le plus"
	cont "résistant."
else
	text "A higher level"
	line "#MON doesn't"
	cont "always win."

	para "After all, it may"
	line "have a type dis-"
	cont "advantage."

	para "I don't think"
	line "there is a single"

	para "#MON that is"
	line "the toughest."
endc

	done

GoldenrodPokecenter1FPokefanFDoYouHaveEonMailText: 
if DEF(_FR_FR)
	text "Ton SAC a l'air"
	line "siiiii lourd!"

	para "Oh! As-tu un truc"
	line "du nom de LETR"
	cont "EVOLI?"

	para "Ma fille en veut"
	line "une."

	para "Tu peux m'en"
	line "donner une?"
else
	text "Oh my, your pack"
	line "looks so heavy!"

	para "Oh! Do you happen"
	line "to have something"
	cont "named EON MAIL?"

	para "My daughter is"
	line "after one."

	para "You can part with"
	line "one, can't you?"
endc

	done

GoldenrodPokecenter1FAskGiveAwayAnEonMailText: 
if DEF(_FR_FR)
	text "Donner LETR EVOLI?"
else
	text "Give away an EON"
	line "MAIL?"
endc

	done

GoldenrodPokecenter1FPokefanFThisIsForYouText: 
if DEF(_FR_FR)
	text "Oh, formidable!"
	line "Merci merci!"
	cont "Voilà pour toi!"
else
	text "Oh, that's great!"
	line "Thank you, honey!"

	para "Here, this is for"
	line "you in return!"
endc

	done

GoldenrodPokecenter1FPokefanFDaughterWillBeDelightedText: 
if DEF(_FR_FR)
	text "Ma fille sera"
	line "ravie!"
else
	text "My daughter will"
	line "be delighted!"
endc

	done

GoldenrodPokecenter1FPokefanFDaughterTomorrowText: ; TO TRANSLATE
	text "Meet me here"
	line "another day,"
	
	para "my daughter may"
	line "want some more."
	done

GoldenrodPokecenter1FPokefanFTooBadText: 
if DEF(_FR_FR)
	text "Oh? Tu n'en as"
	line "pas? Dommage."
else
	text "Oh? You don't have"
	line "one? Too bad."
endc

	done

GoldenrodPokecenter1FPokefanFAnotherTimeThenText: 
if DEF(_FR_FR)
	text "Oh... Une autre"
	line "fois, alors."
else
	text "Oh… Well, another"
	line "time, then."
endc

	done

GoldenrodPokecenter1FPlayerGaveAwayTheEonMailText: 
if DEF(_FR_FR)
	text "<PLAYER> donne"
	line "la LETR EVOLI."
else
	text "<PLAYER> gave away"
	line "the EON MAIL."
endc

	done

GoldenrodPokecenter1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  7, GOLDENROD_CITY, 15
	warp_event  4,  7, GOLDENROD_CITY, 15
	warp_event  0,  6, POKECOM_CENTER_ADMIN_OFFICE_MOBILE, 1
	warp_event  0,  7, POKECENTER_2F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FNurseScript, -1
	object_event  6,  1, SPRITE_GAMEBOY_KID, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FGameboyKidScript, -1
	object_event  1,  4, SPRITE_LASS, CLAP_F | SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FLassScript, -1
	object_event  7,  5, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, HIDE_CURFEW, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, GoldenrodPokecenter1FPokefanF, -1
