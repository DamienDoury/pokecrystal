	object_const_def
	const GOLDENRODDEPTSTORE5F_CLERK
	const GOLDENRODDEPTSTORE5F_LASS
	const GOLDENRODDEPTSTORE5F_MIKE
	const GOLDENRODDEPTSTORE5F_POKEFAN_M
	const GOLDENRODDEPTSTORE5F_RECEPTIONIST

GoldenrodDeptStore5F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .CheckIfSunday

.CheckIfSunday:
	readvar VAR_WEEKDAY
	ifequal SUNDAY, .yes
	setevent GOLDENRODDEPTSTORE5F_RECEPTIONIST
	endcallback

.yes
	clearevent GOLDENRODDEPTSTORE5F_RECEPTIONIST
	endcallback

GoldenrodDeptStore5FClerkScript:
	faceplayer
	opentext
	pokemart MARTTYPE_STANDARD, MART_GOLDENROD_5F
	closetext
	end

GoldenrodDeptStore5FReceptionistScript:
	faceplayer
	opentext
	readvar VAR_WEEKDAY
	ifnotequal SUNDAY, .EventIsOver
	checkflag ENGINE_GOLDENROD_DEPT_STORE_TM27_RETURN
	iftrue .EventIsOver
	special GetFirstPokemonHappiness
	writetext GoldenrodDeptStore5FReceptionistOhYourMonDotDotDotText
	promptbutton
	ifgreater 150 - 1, .VeryHappy
	ifgreater 50 - 1, .SomewhatHappy
	sjump .NotVeryHappy

.VeryHappy:
	writetext GoldenrodDeptStore5FReceptionistThisMoveShouldBePerfectText
	checkitem TM_RETURN
	iftrue .EndText
	promptbutton
	writetext GoldenrodDeptStore5FReceptionistThisMoveShouldBePerfectTextSequel
	promptbutton
	verbosegiveitem TM_RETURN
	setflag ENGINE_GOLDENROD_DEPT_STORE_TM27_RETURN
	closetext
	end

.SomewhatHappy:
	writetext GoldenrodDeptStore5FReceptionistItsAdorableText
.EndText
	waitbutton
	closetext
	end

.NotVeryHappy:
	writetext GoldenrodDeptStore5FReceptionistItLooksEvilHowAboutThisTMText
	checkitem TM_FRUSTRATION
	iftrue .EndText
	promptbutton
	writetext GoldenrodDeptStore5FReceptionistItLooksEvilHowAboutThisTMTextSequel
	promptbutton
	verbosegiveitem TM_FRUSTRATION
	setflag ENGINE_GOLDENROD_DEPT_STORE_TM27_RETURN
	closetext
	end

.EventIsOver:
	writetext GoldenrodDeptStore5FReceptionistThereAreTMsPerfectForMonText
	waitbutton
	closetext
	end

GoldenrodDeptStore5FLassScript:
	jumptextfaceplayer GoldenrodDeptStore5FLassText

Mike:
	faceplayer
	opentext
	trade NPC_TRADE_MIKE
	waitbutton
	closetext
	end

GoldenrodDeptStore5FPokefanMScript:
	jumptextfaceplayer GoldenrodDeptStore5FPokefanMText

GoldenrodDeptStore5FDirectory:
	jumptext GoldenrodDeptStore5FDirectoryText

GoldenrodDeptStore5FElevatorButton:
	jumpstd ElevatorButtonScript

GoldenrodDeptStore5FReceptionistOhYourMonDotDotDotText: 
if DEF(_FR_FR)
	text "Bonjour. Oh, ton"
	line "#MON..."
else
	text "Hello. Oh, your"
	line "#MON…"
endc

	done

GoldenrodDeptStore5FReceptionistThisMoveShouldBePerfectText:
if DEF(_FR_FR)
	text "Il est vraiment"
	line "attaché à toi."
	done
else
	text "It's very attached"
	line "to you."
	done
endc

GoldenrodDeptStore5FReceptionistThisMoveShouldBePerfectTextSequel:
if DEF(_FR_FR)
	text "Cette capacité"
	line "devrait tout à"
	cont "fait vous convenir"
	cont "à tous les deux."
	done
else
	text "This move should"
	line "be perfect for a"
	cont "pair like you."
	done
endc

GoldenrodDeptStore5FReceptionistItsAdorableText: 
if DEF(_FR_FR)
	text "Il est adorable!"

	para "Tu devrais lui"
	line "enseigner de"
	cont "bonnes CT."
else
	text "It's adorable!"

	para "You should teach"
	line "it good TM moves."
endc

	done

GoldenrodDeptStore5FReceptionistItLooksEvilHowAboutThisTMText:
if DEF(_FR_FR)
	text "Il a l'air un peu"
	line "méchant."
	done
else
	text "It looks evil."
	done
endc
	
GoldenrodDeptStore5FReceptionistItLooksEvilHowAboutThisTMTextSequel:
if DEF(_FR_FR)
	text "Que penses-tu de"
	line "cette CT pour lui?"
	done
else
	text "How about this"
	cont "TM for it?"
	done
endc

GoldenrodDeptStore5FReceptionistThereAreTMsPerfectForMonText: 
if DEF(_FR_FR)
	text "Je suis sûre qu'il"
	line "y a une CT par-"

	para "faitement adaptée"
	line "à ton #MON."
else
	text "There are sure to"
	line "be TMs that are"

	para "just perfect for"
	line "your #MON."
endc

	done

GoldenrodDeptStore5FLassText: 
if DEF(_FR_FR)
	text "Le dimanche, une"
	line "dame vient voir"
	cont "les #MON."

	para "Elle donne même"
	line "des CT!"
else
	text "On Sundays, a lady"
	line "comes to check out"
	cont "#MON."

	para "She even gives"
	line "away TMs!"
endc

	done

GoldenrodDeptStore5FPokefanMText: 
if DEF(_FR_FR)
	text "Tu ne peux pas"
	line "renommer un #-"
	cont "MON que tu as eu"
	cont "dans un échange."

	para "Le nom d'origine"
	line "est donné après"

	para "des années de"
	line "recherches par son"
	cont "dresseur."
else
	text "You can't rename a"
	line "#MON you get in"
	cont "a trade."

	para "The name is a re-"
	line "flection of the"

	para "original trainer's"
	line "feelings for it."
endc

	done

GoldenrodDeptStore5FDirectoryText: 
if DEF(_FR_FR)
	text "Pour personnaliser"
	line "son #MON..."

	para "4EME Y'A BON LES"
	line "     CT"
else
	text "Customize Your"
	line "#MON"

	para "5F TM CORNER"
endc

	done

GoldenrodDeptStore5F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 12,  0, GOLDENROD_DEPT_STORE_4F, 1
	warp_event 15,  0, GOLDENROD_DEPT_STORE_6F, 1
	warp_event  2,  0, GOLDENROD_DEPT_STORE_ELEVATOR, 1

	def_coord_events

	def_bg_events
	bg_event 14,  0, BGEVENT_READ, GoldenrodDeptStore5FDirectory
	bg_event  3,  0, BGEVENT_READ, GoldenrodDeptStore5FElevatorButton

	def_object_events
	object_event  8,  5, SPRITE_CLERK, CLAP_F | SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore5FClerkScript, -1
	object_event  3,  6, SPRITE_LASS, CLAP_F | SPRITEMOVEDATA_WANDER, 1, 1, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore5FLassScript, -1
	object_event  6,  3, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, Mike, -1
	object_event 13,  5, SPRITE_POKEFAN_M, CLAP_F | SPRITEMOVEDATA_WANDER, 2, 2, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore5FPokefanMScript, -1
	object_event  7,  5, SPRITE_RECEPTIONIST, CLAP_F | SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodDeptStore5FReceptionistScript, EVENT_GOLDENROD_DEPT_STORE_5F_HAPPINESS_EVENT_LADY
