	object_const_def
	const GOLDENRODUNDERGROUNDWAREHOUSE_ROCKET1
	const GOLDENRODUNDERGROUNDWAREHOUSE_ROCKET2
	const GOLDENRODUNDERGROUNDWAREHOUSE_ROCKET3
	const GOLDENRODUNDERGROUNDWAREHOUSE_GENTLEMAN
	const GOLDENRODUNDERGROUNDWAREHOUSE_POKE_BALL1
	const GOLDENRODUNDERGROUNDWAREHOUSE_POKE_BALL2
	const GOLDENRODUNDERGROUNDWAREHOUSE_POKE_BALL3

GoldenrodUndergroundWarehouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .ResetSwitches

.ResetSwitches:
	clearevent EVENT_SWITCH_1
	clearevent EVENT_SWITCH_2
	clearevent EVENT_SWITCH_3
	clearevent EVENT_EMERGENCY_SWITCH
	clearevent EVENT_SWITCH_4
	clearevent EVENT_SWITCH_5
	clearevent EVENT_SWITCH_6
	clearevent EVENT_SWITCH_7
	clearevent EVENT_SWITCH_8
	clearevent EVENT_SWITCH_9
	clearevent EVENT_SWITCH_10
	clearevent EVENT_SWITCH_11
	clearevent EVENT_SWITCH_12
	clearevent EVENT_SWITCH_13
	clearevent EVENT_SWITCH_14
	setval 0
	writemem wUndergroundSwitchPositions
	endcallback

TrainerGruntM24:
	trainer GRUNTM, GRUNTM_24, EVENT_BEAT_ROCKET_GRUNTM_24, GruntM24SeenText, GruntM24BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GruntM24AfterBattleText

TrainerGruntM14:
	trainer GRUNTM, GRUNTM_14, EVENT_BEAT_ROCKET_GRUNTM_14, GruntM14SeenText, GruntM14BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GruntM14AfterBattleText

TrainerGruntM15:
	trainer GRUNTM, GRUNTM_15, EVENT_BEAT_ROCKET_GRUNTM_15, GruntM15SeenText, GruntM15BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GruntM15AfterBattleText

GoldenrodUndergroundWarehouseDirectorScript:
	faceplayer
	opentext
	checkevent EVENT_RECEIVED_CARD_KEY
	iftrue .GotCardKey
	writetext DirectorIntroText
	promptbutton
	verbosegiveitem CARD_KEY
	setevent EVENT_RECEIVED_CARD_KEY
	setevent EVENT_GOLDENROD_DEPT_STORE_B1F_LAYOUT_1
	clearevent EVENT_GOLDENROD_DEPT_STORE_B1F_LAYOUT_2
	clearevent EVENT_GOLDENROD_DEPT_STORE_B1F_LAYOUT_3
	writetext DirectorCardKeyText
	promptbutton
.GotCardKey:
	writetext DirectorAfterText
	waitbutton
	closetext
	end

GoldenrodUndergroundWarehouseMaxEther:
	itemball MAX_ETHER

GoldenrodUndergroundWarehouseTMSleepTalk:
	itemball TM_SLEEP_TALK

GoldenrodUndergroundWarehouseUltraBall:
	itemball ULTRA_BALL

GruntM24SeenText:
if DEF(_FR_FR)
	text "Un intrus?"
	
	para "Pourquoi tu"
	line "t'opposes à"
	cont "notre cause?"
else
	text "An intruder?"

	para "Why would you"
	line "oppose our cause?"
endc
	done

GruntM24BeatenText:
if DEF(_FR_FR)
	text "Je ne te"
	line "comprends pas."
else
	text "I can't understand"
	line "you."
endc
	done

GruntM24AfterBattleText:
if DEF(_FR_FR)
	text "S'opposer à la"
	line "TEAM ROCKET, c'est"
	cont "être l'ennemi de"
	cont "la liberté."

	para "On fera tout ce"
	line "qu'il faudra."
else
	text "Opposing TEAM"
	line "ROCKET's cause is"
	cont "being the enemy"
	cont "of liberty."

	para "We'll do whatever"
	line "it takes."
endc
	done

GruntM14SeenText:
if DEF(_FR_FR)
	text "On est là pour"
	line "libérer le peuple!"
	
	para "Et on a enlevé le"
	line "DIRECTEUR."
else
	text "We're here to free"
	line "the people!"

	para "And we abducted"
	line "the DIRECTOR."
endc
	done

GruntM14BeatenText:
if DEF(_FR_FR)
	text "Attends, je suis"
	line "confus..."
else
	text "Wait, I'm"
	line "confused…"
endc
	done

GruntM14AfterBattleText:
if DEF(_FR_FR)
	text "Attends, on est là"
	line "pour capturer ou"
	cont "libérer les gens?"
else
	text "Wait, are we"
	line "capturing people"
	cont "or freeing them?"
endc
	done

GruntM15SeenText: 
if DEF(_FR_FR)
	text "Gnyak Gnyak Gnyak!"
	line "J'me souviens de"

	para "toi! Tu m'as battu"
	line "à notre planque!"
else
	text "Hyuck-hyuck-hyuck!"
	line "I remember you!"

	para "You got me good"
	line "at our hideout!"
endc

	done

GruntM15BeatenText: 
if DEF(_FR_FR)
	text "Gnyak!"
	line "Heu? Encore??"
else
	text "Hyuck-hyuck-hyuck!"
	line "So, that's how?"
endc

	done

GruntM15AfterBattleText: 
if DEF(_FR_FR)
	text "Gnyaaaaaak!"
	line "J'me souviendrai"
	cont "de toi!"
else
	text "Hyuck-hyuck-hyuck!"
	line "That was a blast!"
	cont "I'll remember you!"
endc

	done

DirectorIntroText: 
if DEF(_FR_FR)
	text "DIRECTEUR: Qui?"
	line "Quoi? Tu es là"
	cont "pour me sauver?"

	para "Merci!"

	para "La TOUR RADIO!"

	para "Que se passe-t-il"
	line "là-bas?"

	para "Contrôlée par la"
	line "TEAM ROCKET?"

	para "Tiens. Prends"
	line "cette CARTE MAGN."
else
	text "DIRECTOR: Who?"
	line "What? You came to"
	cont "rescue me?"

	para "Thank you!"

	para "The RADIO TOWER!"

	para "What's happening"
	line "there?"

	para "Taken over by TEAM"
	line "ROCKET?"

	para "Here. Take this"
	line "CARD KEY."
endc

	done

DirectorCardKeyText: 
if DEF(_FR_FR)
	text "DIRECTEUR: Utilise"
	line "cette carte pour"
	cont "ouvrir les volets"
	cont "du 2ème."
else
	text "DIRECTOR: Use that"
	line "to open the shut-"
	cont "ters on 3F."
endc

	done

DirectorAfterText:
if DEF(_FR_FR)
	text "Je t'en supplie..."
	line "Aide-nous."

	para "Qui sait ce qu'ils"
	line "feront en control-"
	cont "lant l'émetteur."

	para "Tu es mon seul"
	line "espoir."

	para "Sauve la TOUR"
	line "RADIO..."

	para "Et tous les gens"
	line "du pays!"
else
	text "I'm begging you to"
	line "help."

	para "There's no telling"
	line "what they'll do if"

	para "they control the"
	line "transmitter."

	para "You're the only"
	line "one I can call on."

	para "Please save the"
	line "RADIO TOWER…"

	para "And all the people"
	line "nationwide!"
endc
	done

GoldenrodUndergroundWarehouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2, 12, GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES, 2
	warp_event  3, 12, GOLDENROD_UNDERGROUND_SWITCH_ROOM_ENTRANCES, 3
	warp_event 17,  2, GOLDENROD_DEPT_STORE_B1F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  9,  8, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerGruntM24, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  8, 15, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerGruntM14, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 14,  3, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 4, TrainerGruntM15, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 12,  8, SPRITE_GENTLEMAN, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, GoldenrodUndergroundWarehouseDirectorScript, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 18, 15, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, GoldenrodUndergroundWarehouseMaxEther, EVENT_GOLDENROD_UNDERGROUND_WAREHOUSE_MAX_ETHER
	object_event 13,  9, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, GoldenrodUndergroundWarehouseTMSleepTalk, EVENT_GOLDENROD_UNDERGROUND_WAREHOUSE_TM_SLEEP_TALK
	object_event  2,  1, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, GoldenrodUndergroundWarehouseUltraBall, EVENT_GOLDENROD_UNDERGROUND_WAREHOUSE_ULTRA_BALL
