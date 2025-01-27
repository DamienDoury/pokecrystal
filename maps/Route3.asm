	object_const_def
	const ROUTE3_FISHER1
	const ROUTE3_YOUNGSTER1
	const ROUTE3_YOUNGSTER2
	const ROUTE3_FISHER2
	const ROUTE3_CLEO
	const ROUTE3_CLEFAIRY
	const ROUTE3_CLEFABLE

Route3_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .ObjectCallback

.ObjectCallback
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
	;appear ROUTE3_CLEFAIRY
	;disappear ROUTE3_CLEFABLE
	endcallback

TrainerFirebreatherOtis:
	trainer FIREBREATHER, OTIS, EVENT_BEAT_FIREBREATHER_OTIS, FirebreatherOtisSeenText, FirebreatherOtisBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext FirebreatherOtisAfterBattleText
	waitbutton
	closetext
	end

TrainerYoungsterWarren:
	trainer YOUNGSTER, WARREN, EVENT_BEAT_YOUNGSTER_WARREN, YoungsterWarrenSeenText, YoungsterWarrenBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext YoungsterWarrenAfterBattleText
	waitbutton
	closetext
	end

TrainerYoungsterJimmy:
	trainer YOUNGSTER, JIMMY, EVENT_BEAT_YOUNGSTER_JIMMY, YoungsterJimmySeenText, YoungsterJimmyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext YoungsterJimmyAfterBattleText
	waitbutton
	closetext
	end

TrainerFirebreatherBurt:
	trainer FIREBREATHER, BURT, EVENT_BEAT_FIREBREATHER_BURT, FirebreatherBurtSeenText, FirebreatherBurtBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext FirebreatherBurtAfterBattleText
	waitbutton
	closetext
	end

TrainerMetronomeBattleScript:
	faceplayer
	opentext
	checkflag ENGINE_CLEO_READY_FOR_REMATCH
	iftrue .rematch_tomorrow

	checkevent EVENT_BEAT_POKEFANF_CLEO2
	iftrue .cleo2_beaten

	checkevent EVENT_BEAT_POKEFANF_CLEO1
	iftrue .cleo1_beaten

	writetext Route3CleoSeenText
	yesorno
	iffalse .refused_battle

	readvar VAR_PARTYCOUNT
	ifnotequal 1, .party_count

	writetext Route3CleoBattleAcceptedText
	loadtrainer POKEFANF, CLEO1
	scall .setup_battle
	ifnotequal WIN, .was_fun

	setflag ENGINE_CLEO_READY_FOR_REMATCH

	callasm SpecialBattle_UsedOnlyMetronome
	iffalse .cheated

; Cleo levels up.
	setevent EVENT_BEAT_POKEFANF_CLEO1
	writetext Route3CleoLevelUpText
	waitbutton
	closetext

	; animation
	pause 15
	turnobject ROUTE3_CLEO, DOWN
	waitsfx
	playsound SFX_BALL_POOF
	pause 5
	appear ROUTE3_CLEFAIRY
	reloadmappart
	waitsfx

rept 10
	playsound SFX_LEVEL_UP
	pause 15
endr

	waitsfx
	appear ROUTE3_CLEFABLE
	disappear ROUTE3_CLEFAIRY
	reloadmappart
	playsound SFX_EVOLVED
	waitsfx
	playsound SFX_POTION
	waitsfx

rept 5
	playsound SFX_FULL_HEAL
	pause 15
endr

	pause 10
	playsound SFX_BALL_POOF
	pause 10
	disappear ROUTE3_CLEFABLE
	reloadmappart
	waitsfx
	faceplayer
	pause 15

	opentext
.cleo1_beaten
	writetext Route3CleoRematchText

	readvar VAR_PARTYCOUNT
	ifnotequal 1, .party_count_prompt

	loadtrainer POKEFANF, CLEO2
	scall .setup_battle
	ifnotequal WIN, .was_fun

	setflag ENGINE_CLEO_READY_FOR_REMATCH

	callasm SpecialBattle_UsedOnlyMetronome
	iffalse .cheated

	; At this point, the player won Cleo's second battle.
	setevent EVENT_BEAT_POKEFANF_CLEO2
	clearflag ENGINE_CLEO_READY_FOR_REMATCH ; No needs to ask for a rematch, as Cleo has been fully beaten.

	; I'm the fastest around, and I also have the fastest Pokémon!
	; My CROBAT has never been outsped. You think you're faster?
	; Let's race!
	; You may be the strongest, but I'm still the fastest! I'll wait for you to show me. Come back another day.
	; I admit my defeat. Here is your price for being the fastest.

.cleo2_beaten
	writetext Route3CleoLostFairAndSquareText
	checkevent EVENT_CLEO_GAVE_VOUCHER
	iftrue .text_end

	promptbutton
	writetext Route3CleoLostFairAndSquare2Text
	promptbutton
	verbosegiveitem VOUCHER
	iffalse .close_text

	setevent EVENT_CLEO_GAVE_VOUCHER
	sjump .close_text

.cleos_purpose_filled
	writetext Route3CleoLostFairAndSquareText
	sjump .text_end

.was_fun
	setflag ENGINE_CLEO_READY_FOR_REMATCH
	writetext Route3CleoWasFunText
	sjump .text_end

.cheated
	writetext Route3CleoCheatText
	promptbutton
.rematch_tomorrow
	writetext Route3CleoRematchTomorrowText
	sjump .text_end

.party_count_prompt
	promptbutton
.party_count
	writetext Route3Cleo1v1Text
	sjump .text_end

.refused_battle
	writetext Route3CleoBattleRefusedText

.text_end
	waitbutton
.close_text
	closetext
	end

.setup_battle
	waitbutton
	closetext
	winlosstext Route3CleoWinText, Route3CleoLossText
	loadvar VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	startbattle
	reloadmap
	opentext
	callasm SpecialBattle_GetBattleResultFromScript
	end

Route3MtMoonSquareSign:
	jumptext Route3MtMoonSquareSignText

FirebreatherOtisSeenText:
	text "Ah! The weather's"
	line "as fine as ever."
	done

FirebreatherOtisBeatenText:
	text "It's sunny, but"
	line "I'm all wet…"
	done

FirebreatherOtisAfterBattleText:
	text "When it rains,"
	line "it's hard to get"
	cont "ignition…"
	done

YoungsterWarrenSeenText:
	text "Hmmm… I don't know"
	line "what to do…"
	done

YoungsterWarrenBeatenText:
	text "I knew I'd lose…"
	done

YoungsterWarrenAfterBattleText:
	text "You looked strong."

	para "I was afraid to"
	line "take you on…"
	done

YoungsterJimmySeenText:
	text "I can run like the"
	line "wind!"
	done

YoungsterJimmyBeatenText:
	text "Blown away!"
	done

YoungsterJimmyAfterBattleText:
	text "I wear shorts the"
	line "whole year round."

	para "That's my fashion"
	line "policy."
	done

FirebreatherBurtSeenText:
	text "Step right up and"
	line "take a look!"
	done

FirebreatherBurtBeatenText:
	text "Yow! That's hot!"
	done

FirebreatherBurtAfterBattleText:
	text "The greatest fire-"
	line "breather in KANTO,"
	cont "that's me."

	para "But not the best"
	line "trainer…"
	done

Route3MtMoonSquareSignText:
	text "MT.MOON SQUARE"

	para "Just go up the"
	line "stairs."
	done

Route3CleoSeenText:
	text "Hello darling!"
	line "Wanna do a 1v1"
	cont "METRONOME battle?"
	done
	
Route3Cleo1v1Text:
	text "I said 1v1! You"
	line "have too many"
	cont "#MON."
	done

Route3CleoBattleRefusedText:
	text "I wanna do this"
	line "so badly! Please!"
	done

Route3CleoBattleAcceptedText:
	text "Exciting! Let's see"
	line "who's the luckiest!"
	done

Route3CleoCheatText:
	text "You cheater! You're"
	line "supposed to only"
	cont "use METRONOME!"
	done
	
Route3CleoRematchTomorrowText:
	text "I want a rematch"
	line "tomorrow!"
	done

Route3CleoWasFunText:
	text "That was fun!"
	line "Let's have another"
	cont "one tomorrow!"
	done

Route3CleoLevelUpText:
	text "Wait that can't"
	line "happen! Let me use"
	cont "some items, then"
	cont "let's redo this."
	done

Route3CleoRematchText:
	text "I want my 1v1"
	line "METRONOME rematch!"
	done

Route3CleoLossText:
	text "I knew I was"
	line "the luckiest!"
	done

Route3CleoWinText:
	text "Oh!"
	done

Route3CleoLostFairAndSquareText:
	text "You beat me"
	line "fair and square."
	done

Route3CleoLostFairAndSquare2Text:
	text "I thought to be"
	line "the luckiest"
	cont "since I won this"
	cont "VOUCHER."

	para "Now it's yours."
	done

Route3_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 52,  1, MOUNT_MOON, 1

	def_coord_events

	def_bg_events
	bg_event 49, 13, BGEVENT_READ, Route3MtMoonSquareSign

	def_object_events
	object_event 26, 12, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 2, TrainerFirebreatherOtis, -1
	object_event 10,  7, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerYoungsterWarren, -1
	object_event 16,  3, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 1, TrainerYoungsterJimmy, -1
	object_event 49,  5, SPRITE_FISHER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerFirebreatherBurt, -1
	object_event 38, 16, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TrainerMetronomeBattleScript, -1
	object_event 38, 17, SPRITE_CLEFAIRY, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event 38, 17, SPRITE_CLEFABLE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_2
