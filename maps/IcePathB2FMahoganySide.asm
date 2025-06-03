	object_const_def
	const ICEPATHB2FMAHOGANYSIDE_BOULDER1
	const ICEPATHB2FMAHOGANYSIDE_BOULDER2
	const ICEPATHB2FMAHOGANYSIDE_BOULDER3
	const ICEPATHB2FMAHOGANYSIDE_BOULDER4
	const ICEPATHB2FMAHOGANYSIDE_POKE_BALL1
	const ICEPATHB2FMAHOGANYSIDE_POKE_BALL2
	const ICEPATHB2FMAHOGANYSIDE_POKE_BALL3

IcePathB2FMahoganySide_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .Checks

.Checks:
	checkevent EVENT_BEAT_LORELEI
	iftrue .skip_bonus_talk

	checkitem TM_HAIL
	iffalse .skip_bonus_talk

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
.skip_bonus_talk
	checkevent EVENT_LORELEI_WANTS_TO_TALK
	iftrue .show_lorelei

	checkevent EVENT_RED_BEATEN
	iftrue .hide_lorelei ; If Red hasn't been beaten yet, Lorelei needs to be hidden.

	checkitem TM_HAIL
	iffalse .show_lorelei

.hide_lorelei
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2 ; Hide Lorelei.
.show_lorelei ; Lorelei is shown by default, as EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2 is 0 when entering the map.
	endcallback

TrainerLorelei:
	trainer LORELEI, LORELEI1, EVENT_BEAT_LORELEI, LoreleiSeenText, LoreleiBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext LoreleiAfterBattleText
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iffalse .closetext

	promptbutton
	writetext LoreleiHailText
	
.closetext
	clearevent EVENT_LORELEI_WANTS_TO_TALK
	waitbutton
	closetext
	end

IcePathB2FMahoganySideDewgong:
	opentext
	writetext IcePathB2FMahoganySideDewgongText
	cry DEWGONG
	waitbutton
	closetext
	turnobject PLAYER, UP
	end

IcePathB2FMahoganySideBoulder:
	jumptext IcePathB2FMahoganySideBoulderText

IcePathB2FMahoganySideFullHeal:
	itemball FULL_HEAL

IcePathB2FMahoganySideMaxPotion:
	itemball MAX_POTION

IcePathB2FMahoganySideTMHail:
	itemball TM_HAIL

IcePathB2FMahoganySideHiddenCarbos:
	hiddenitem CARBOS, EVENT_ICE_PATH_B2F_MAHOGANY_SIDE_HIDDEN_CARBOS

IcePathB2FMahoganySideBoulderText: 
if DEF(_FR_FR)
	text "C'est bloqué dans"
	line "la glace."
else
	text "It's immovably"
	line "imbedded in ice."
endc

	done

IcePathB2FMahoganySideDewgongText:
if DEF(_FR_FR)
	text "LAMANTINE: Tine!"
else
	text "DEWGONG: Gong!"
endc

	done

LoreleiSeenText:
if DEF(_FR_FR)
	text "Tu fais quoi dans"
	line "dans ma cachette?"
else
	text "What are you doing"
	line "in my hideout?"
endc

	done

LoreleiBeatenText:
if DEF(_FR_FR)
	text "Je veux qu'on me"
	line "laisse seule."
else
	text "I want to be"
	line "left alone."
endc

	done

LoreleiAfterBattleText:
if DEF(_FR_FR)
	text "C'est dur"
	line "de perdre ses amis"
	cont "à cause du COVID."
	
	para "J'étais présente"
	line "quand AGATHA"
	cont "a rendu son"
	cont "dernier souffle."

	para "Elle a fait partie"
	line "des premiers à"
	cont "en mourir."

	para "Ca me fait encore"
	line "froid dans le dos"
	cont "de repenser à"
	cont "MARION pleurer..."

	para "Avec le recul, je"
	line "suis persuadée que"
	cont "c'est RED qui a"
	cont "contaminé AGATHA."
	
	para "Je sais qu'il ne"
	line "pouvait pas s'en"
	cont "douter."

	para "Mais je n'ai jamais"
	line "pu m'empêcher"
	cont "d'avoir du"
	cont "ressentiment"
	cont "contre lui."

	para "Je me sens mieux"
	line "de savoir que le"
	cont "nouveau MAITRE,"
	cont "c'est toi."
else
	text "It's hard to lose"
	line "friends to COVID."

	para "I was there when"
	line "AGATHA took her"
	cont "last breath."

	para "She was among the"
	line "first ones to"
	cont "die from it."

	para "It still sends"
	line "shivers down my"
	cont "spine when I"
	cont "remember KAREN"
	cont "crying…"

	para "Now that I think"
	line "about it, I'm"
	cont "pretty sure that"
	cont "it's RED that"
	cont "contaminated"
	cont "AGATHA."

	para "I know he couldn't"
	line "have known."

	para "But I could never"
	line "stop myself from"
	cont "feeling resentment"
	cont "toward him."

	para "I feel better"
	line "knowing that you"
	cont "are the new"
	cont "CHAMPION."
endc

	done

LoreleiHailText:
if DEF(_FR_FR)
	text "C'est toi qui a"
	line "pris la CT GRELE"
	cont "que j'avais"
	cont "caché ici?"

	para "Je n'en attendais"
	line "pas moins du"
	cont "MAITRE #MON!"
else
	text "Was it you that"
	line "took the HAIL TM"
	cont "I hide in here?"

	para "I didn't expect"
	line "less from the"
	cont "CHAMPION!"
endc

	done

IcePathB2FMahoganySide_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 17,  1, ICE_PATH_B1F, 2
	warp_event  9, 11, ICE_PATH_B3F, 1
	warp_event 10,  3, ICE_PATH_B1F, 3
	warp_event  4,  6, ICE_PATH_B1F, 4
	warp_event  4, 12, ICE_PATH_B1F, 5
	warp_event 12, 12, ICE_PATH_B1F, 6

	def_coord_events

	def_bg_events
	bg_event  0, 17, BGEVENT_ITEM, IcePathB2FMahoganySideHiddenCarbos

	def_object_events
	object_event 11,  3, SPRITE_BOULDER, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, IcePathB2FMahoganySideBoulder, EVENT_BOULDER_IN_ICE_PATH_1A
	object_event  4,  7, SPRITE_BOULDER, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, IcePathB2FMahoganySideBoulder, EVENT_BOULDER_IN_ICE_PATH_2A
	object_event  3, 12, SPRITE_BOULDER, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, IcePathB2FMahoganySideBoulder, EVENT_BOULDER_IN_ICE_PATH_3A
	object_event 12, 13, SPRITE_BOULDER, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, IcePathB2FMahoganySideBoulder, EVENT_BOULDER_IN_ICE_PATH_4A
	object_event  8,  9, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, IcePathB2FMahoganySideFullHeal, EVENT_ICE_PATH_B2F_MAHOGANY_SIDE_FULL_HEAL
	object_event  0,  2, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, IcePathB2FMahoganySideMaxPotion, EVENT_ICE_PATH_B2F_MAHOGANY_SIDE_MAX_POTION
	object_event 13, 13, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, IcePathB2FMahoganySideTMHail, EVENT_ICE_PATH_B2F_MAHOGANY_SIDE_TM_HAIL
	object_event 13,  4, SPRITE_LORELEI, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerLorelei, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	object_event 14,  6, SPRITE_DEWGONG, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, IcePathB2FMahoganySideDewgong, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
