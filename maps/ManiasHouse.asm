	object_const_def
	const MANIASHOUSE_ROCKER
	const MANIASHOUSE_SHUCKIE_BEFORE
	const MANIASHOUSE_SHUCKIE_AFTER

ManiasHouse_MapScripts:
	def_scene_scripts

	def_callbacks

ManiaScript:
	faceplayer
	opentext
	checkevent EVENT_MANIA_TOOK_SHUCKIE_OR_LET_YOU_KEEP_HIM
	iftrue .default_postevent
	checkevent EVENT_GOT_SHUCKIE
	iftrue .alreadyhaveshuckie
	writetext ManiaText_AskLookAfterShuckle
	yesorno
	iffalse .refusetotakeshuckie
	special GiveShuckle
	iffalse .partyfull
	writetext ManiaText_TakeCareOfShuckle
	promptbutton
	writetext ManiaText_GotShuckle
	waitbutton
	disappear MANIASHOUSE_SHUCKIE_BEFORE
	playsound SFX_KEY_ITEM
	waitsfx
	closetext
	setevent EVENT_GOT_SHUCKIE
	end

.alreadyhaveshuckie
	checkflag ENGINE_GOT_SHUCKIE_TODAY
	iffalse .returnshuckie
	writetext ManiaText_TakeCareOfShuckle
	waitbutton
	closetext
	end

.partyfull
	writetext ManiaText_PartyFull
	waitbutton
	closetext
	end

.refusetotakeshuckie
	writetext ManiaText_IfHeComesBack
	waitbutton
	closetext
	end

.returnshuckie
	writetext ManiaText_CanIHaveMyMonBack
	yesorno
	iffalse .refused
	special ReturnShuckie
	ifequal SHUCKIE_WRONG_MON, .wrong
	ifequal SHUCKIE_REFUSED, .refused
	ifequal SHUCKIE_HAPPY, .superhappy
	ifequal SHUCKIE_FAINTED, .nothingleft
	; SHUCKIE_RETURNED
	writetext ManiaText_ThankYou
	appear MANIASHOUSE_SHUCKIE_AFTER
	cry SHUCKLE
	waitbutton
	closetext
	clearevent EVENT_GAVE_SHUCKIE_BACK
	setevent EVENT_MANIA_TOOK_SHUCKIE_OR_LET_YOU_KEEP_HIM
	end

.wrong
	writetext ManiaText_ShuckleNotThere
	waitbutton
	closetext
	end

.superhappy
	writetext ManiaText_ShuckleLikesYou
	waitbutton
	closetext
	setevent EVENT_MANIA_TOOK_SHUCKIE_OR_LET_YOU_KEEP_HIM
	end

.refused
	writetext ManiaText_SameAsBeingRobbed
	waitbutton
	closetext
	end

.nothingleft
	writetext ManiaText_ShuckleIsYourLastMon
	waitbutton
	closetext
	end

.default_postevent
	writetext ManiaText_HappinessSpeech
	waitbutton
	closetext
	end

ShuckleBeforeScript:
	opentext
	writetext ShuckieBeforeText
	cry SHUCKLE
	waitbutton
	closetext
	end

ShuckleAfterScript:
	opentext
	writetext ShuckieAfterText
	cry SHUCKLE
	showemote EMOTE_HAPPY, MANIASHOUSE_SHUCKIE_AFTER, 20
	waitbutton
	closetext
	playsound SFX_SQUEAK
	applymovement MANIASHOUSE_SHUCKIE_AFTER, ShuckieHappyJump1
	playsound SFX_SQUEAK
	applymovement MANIASHOUSE_SHUCKIE_AFTER, ShuckieHappyJump2
	playsound SFX_SQUEAK
	applymovement MANIASHOUSE_SHUCKIE_AFTER, ShuckieHappyJump3
	playsound SFX_SQUEAK
	applymovement MANIASHOUSE_SHUCKIE_AFTER, ShuckieHappyJump4
	waitsfx
	cry SHUCKLE
	end

ManiasHouse_Radio:
	jumpstd Radio3Script

ShuckieHappyJump1:
	jump_step RIGHT
	step_end

ShuckieHappyJump2:
	jump_step UP
	step_end

ShuckieHappyJump3:
	jump_step LEFT
	step_end

ShuckieHappyJump4:
	jump_step DOWN
	step_end

ShuckieBeforeText:
if DEF(_FR_FR)
	text "NESSY: Caraaa?"
else
	text "SHUCKIE: Uuuck?"
endc
	done

ShuckieAfterText:
if DEF(_FR_FR)
	text "NESSY: Troooooooo-"
	line "ooooooooooooooooc!"
else
	text "SHUCKIE: Shuuuuuu-"
	line "uuuuuuuuuuuuuuuck!"
endc
	done

ManiaText_AskLookAfterShuckle: 
if DEF(_FR_FR)
	text "Je suis choqué!"

	para "Un garnement de"
	line "ton âge avec"

	para "l'oeil mauvais"
	line "et des cheveux"
	cont "longs, s'est in-"
	cont "filtré chez moi."

	para "Il m'a fait grand-"
	line "peur et chapardé"
	cont "mon #MON"
	cont "adoré!"

	para "Il m'en reste un"
	line "mais que faire"
	cont "s'il revient?"

	para "Tu as l'air"
	line "fort. Peux-tu"

	para "t'occuper de"
	line "mon #MON"
	cont "un petit moment?"
else
	text "I, I'm in shock!"

	para "A guy about your"
	line "age with piercing"

	para "eyes and long hair"
	line "came in."

	para "He scared me into"
	line "giving him my"
	cont "prized #MON!"

	para "I still have one"
	line "left, but what if"
	cont "he comes back?"

	para "You look strong."
	line "Could you look"

	para "after my #MON"
	line "for a while?"
endc

	done

ManiaText_TakeCareOfShuckle:
if DEF(_FR_FR)
	text "Oh, bien le merci!"

	para "Prends bien soin"
	line "de NESSY, pitié!"
else
	text "Oh, thank you!"

	para "Take good care of"
	line "SHUCKIE, please!"
endc
	done

ManiaText_GotShuckle::
	text "<PLAYER> received a"
	line "#MON."
	done

ManiaText_PartyFull: 
if DEF(_FR_FR)
	text "L'équipe #-"
	line "MON est pleine."
else
	text "Your #MON party"
	line "is full."
endc

	done

ManiaText_IfHeComesBack: 
if DEF(_FR_FR)
	text "Oh, non... Que"
	line "vais-je faire"
	cont "s'il revient?"
else
	text "Oh, no… What'll"
	line "I do if he comes"
	cont "back?"
endc

	done

ManiaText_CanIHaveMyMonBack:
if DEF(_FR_FR)
	text "Salut! Comment va"
	line "mon NESSY?"

	para "Je pense être en"
	line "sécurité main-"
	cont "tenant, serait-il"
	cont "possible de le"
	cont "récupérer?"
else
	text "Hi! How's my"
	line "SHUCKIE?"

	para "I think I'm safe"
	line "now, so may I have"
	cont "it back?"
endc
	done

ManiaText_ThankYou: 
if DEF(_FR_FR)
	text "Merci mon petit!"
else
	text "Thank you!"
endc

	done

ManiaText_ShuckleNotThere:
if DEF(_FR_FR)
	text "Hé, c'est pas"
	line "mon NESSY!"
else
	text "Hey, that's not"
	line "my SHUCKIE!"
endc
	done

ManiaText_ShuckleLikesYou: 
if DEF(_FR_FR)
	text "Mon #MON a"
	line "l'air de t'appré-"
	cont "cier."

	para "Très bien! Tu"
	line "peux le garder."

	para "Mais promets-moi"
	line "d'être sympa avec"
	cont "lui!"
else
	text "My #MON has"
	line "come to like you."

	para "All right, you"
	line "should keep it."

	para "But promise to"
	line "be good to it!"
endc

	done

ManiaText_SameAsBeingRobbed: 
if DEF(_FR_FR)
	text "Oh, non de non..."
	line "C'est la même"
	cont "chose que de se"
	cont "faire voler."
else
	text "Oh, no, no… That's"
	line "the same as being"
	cont "robbed."
endc

	done

ManiaText_HappinessSpeech: 
if DEF(_FR_FR)
	text "Pour les #MON,"
	line "c'est le bonheur"

	para "d'être avec un"
	line "gentil dresseur."
else
	text "For #MON, hap-"
	line "piness is being"

	para "with a person who"
	line "treats them well."
endc

	done

ManiaText_ShuckleIsYourLastMon: 
if DEF(_FR_FR)
	text "Si je reprends mon"
	line "#MON, avec quoi"

	para "vas-tu pouvoir"
	line "combattre?"
else
	text "If I take my #-"
	line "MON back, what are"

	para "you going to use"
	line "in battle?"
endc

	done

ManiasHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, CIANWOOD_CITY, 1
	warp_event  3,  7, CIANWOOD_CITY, 1

	def_coord_events

	def_bg_events
	bg_event  7,  1, BGEVENT_READ, ManiasHouse_Radio

	def_object_events
	object_event  2,  4, SPRITE_ROCKER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ManiaScript, -1
	object_event  2,  3, SPRITE_SHUCKLE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ShuckleBeforeScript, EVENT_GOT_SHUCKIE
	object_event  4,  5, SPRITE_SHUCKLE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ShuckleAfterScript, EVENT_GAVE_SHUCKIE_BACK
