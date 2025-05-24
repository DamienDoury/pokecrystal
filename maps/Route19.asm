	object_const_def
	const ROUTE19_SWIMMER_GIRL
	const ROUTE19_SWIMMER_GUY1
	const ROUTE19_SWIMMER_GUY2
	const ROUTE19_SWIMMER_GUY3
	const ROUTE19_FISHER1
	const ROUTE19_FISHER2

Route19_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .ClearRocks

.ClearRocks:
	checkevent EVENT_CINNABAR_ROCKS_CLEARED
	iftrue .Done
	changeblock  6,  6, $7a ; rock
	changeblock  8,  6, $7a ; rock
	changeblock 10,  6, $7a ; rock
	changeblock 12,  8, $7a ; rock
	changeblock  4,  8, $7a ; rock
	changeblock 10, 10, $7a ; rock
	changeblock  6,  8, $5c ; ledge with path
.Done:
	endcallback

TrainerSwimmerfDawn:
	trainer SWIMMERF, DAWN, EVENT_BEAT_SWIMMERF_DAWN, SwimmerfDawnSeenText, SwimmerfDawnBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmerfDawnAfterBattleText

TrainerSwimmermHarold:
	trainer SWIMMERM, HAROLD, EVENT_BEAT_SWIMMERM_HAROLD, SwimmermHaroldSeenText, SwimmermHaroldBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmermHaroldAfterBattleText

TrainerSwimmermFlavien:
	trainer SWIMMERM, FLAVIEN, EVENT_BEAT_SWIMMERM_FLAVIEN, SwimmermFlavienSeenText, SwimmermFlavienBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmermFlavienAfterBattleText

TrainerSwimmermTucker:
	trainer SWIMMERM, TUCKER, EVENT_BEAT_SWIMMERM_TUCKER, SwimmermTuckerSeenText, SwimmermTuckerBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmermTuckerAfterBattleText

TrainerSwimmermGarvey:
	trainer SWIMMERM, GARVEY, EVENT_BEAT_SWIMMERM_GARVEY, SwimmermGarveySeenText, SwimmermGarveyBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmermGarveyAfterBattleText

TrainerSwimmerfVaiana:
	trainer SWIMMERF, VAIANA, EVENT_BEAT_SWIMMERF_VAIANA, SwimmerfVaianaSeenText, SwimmerfVaianaBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmerfVaianaAfterBattleText

Route19Fisher1Script:
	faceplayer
	opentext
	checkevent EVENT_CINNABAR_ROCKS_CLEARED
	iftrue .RocksCleared
	writetext Route19Fisher1Text
	waitbutton
	closetext
	end

.RocksCleared:
	writetext Route19Fisher1Text_RocksCleared
	waitbutton
	closetext
	end

Route19Fisher2Script:
	faceplayer
	opentext
	checkevent EVENT_CINNABAR_ROCKS_CLEARED
	iftrue .RocksCleared
	writetext Route19Fisher2Text
	waitbutton
	closetext
	cry ONIX
	
	
	showemote EMOTE_SHOCK, ROUTE19_FISHER2, 15 
	turnobject ROUTE19_FISHER2, DOWN
	turnobject PLAYER, DOWN
	pause 10

	playsound SFX_HEADBUTT
	earthquake 10
	waitsfx
	pause 10

	playsound SFX_STOMP
	earthquake 10
	waitsfx
	pause 20

	playsound SFX_STRENGTH
	earthquake 80
	waitsfx

	pause 15

	opentext
	writetext Route19Fisher2SequelText
	waitbutton
	closetext
	end

.RocksCleared:
	writetext Route19Fisher2Text_RocksCleared
	waitbutton
	closetext
	end

Route19Sign:
	jumptext Route19SignText

CarefulSwimmingSign:
	jumptext CarefulSwimmingSignText

SwimmermHaroldSeenText: ; AUTOTRAD
	text "Have you ever gone"
	line "swimming in the"
	cont "sea at night?"
	done

SwimmermHaroldBeatenText: ; AUTOTRAD
	text "Glub…"
	done

SwimmermHaroldAfterBattleText: ; AUTOTRAD
	text "At night, the sea"
	line "turns black. It"

	para "feels like it will"
	line "swallow you up."
	done

SwimmermTuckerSeenText: ; AUTOTRAD
	text "Pant, pant…"
	line "Just… a little…"

	para "farther… to…"
	line "FUCHSIA…"
	done

SwimmermTuckerBeatenText: ; AUTOTRAD
	text "I'm drowning!"
	done

SwimmermTuckerAfterBattleText: ; AUTOTRAD
	text "I… asked my girl-"
	line "friend to swim to"
	cont "FUCHSIA… Gasp…"
	done

SwimmermGarveySeenText: ; TO TRANSLATE
	text "My #MON is the"
	line "best surfer!"
	done

SwimmermGarveyBeatenText: ; TO TRANSLATE
	text "You got surfed."
	done

SwimmermGarveyAfterBattleText: ; TO TRANSLATE
	text "It's fun to surf"
	line "on TAUROS!"
	done

SwimmerfVaianaSeenText: ; TO TRANSLATE
	text "Just caught"
	line "what I needed!"
	done

SwimmerfVaianaBeatenText: ; TO TRANSLATE
	text "Don't hurt him!"
	done

SwimmerfVaianaAfterBattleText: ; TO TRANSLATE
	text "All I need now is"
	line "a THUNDERSTONE, a"
	cont "trip to GOLDENROD"
	cont "and I'll get myself"
	cont "a JOLTEON!"
	done

SwimmerfDawnSeenText: ; AUTOTRAD
	text "I'm disgusted by"
	line "wimpy people!"
	done

SwimmerfDawnBeatenText: ; AUTOTRAD
	text "I could beat you"
	line "at swimming…"
	done

SwimmerfDawnAfterBattleText: ; AUTOTRAD
	text "It's a quick swim"
	line "between FUCHSIA"

	para "and SEAFOAM IS-"
	line "LANDS…"

	para "Sheesh, some big"
	line "man my boyfriend"

	para "is! What a wimp!"
	done

SwimmermFlavienSeenText: ; TO TRANSLATE
	text "Swimming?"
	line "I'm lousy at it."

	para "I'm just splashing"
	line "around in these"
	cont "shallow waters."
	done

SwimmermFlavienBeatenText: ; TO TRANSLATE
	text "I thought I could"
	line "win."
	done

SwimmermFlavienAfterBattleText: ; TO TRANSLATE
	text "I might be bad at"
	line "swimming, but I"
	cont "love the sea."
	done

Route19Fisher1Text: ; TO TRANSLATE
	text "Sorry. This road"
	line "is closed for"
	cont "roadwork."

	para "If you want to get"
	line "to CINNABAR, you'd"

	para "better go south"
	line "from PALLET TOWN."
	done

Route19Fisher1Text_RocksCleared: ; AUTOTRAD
	text "I'm all sweaty."
	line "Time for a swim!"
	done

Route19Fisher2Text: ; TO TRANSLATE
	text "Who knows how long"
	line "it will take to"
	cont "clear these"
	cont "boulders…"
	done

Route19Fisher2SequelText: ; TO TRANSLATE
	text "A few days with"
	line "that ONIX at work"
	cont "I would say."
	done

Route19Fisher2Text_RocksCleared: ; TO TRANSLATE
	text "The roadwork is"
	line "finally finished"
	cont "and the workers"
	cont "went home."

	para "Now I can go"
	line "fishing again."
	done

Route19SignText: ; AUTOTRAD
	text "ROUTE 19"

	para "FUCHSIA CITY -"
	line "SEAFOAM ISLANDS"
	done

CarefulSwimmingSignText: ; AUTOTRAD
	text "Please be careful"
	line "if you are swim-"
	cont "ming to SEAFOAM"
	cont "ISLANDS."

	para "FUCHSIA POLICE"
	done

Route19_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  7,  3, ROUTE_19_FUCHSIA_GATE, 3

	def_coord_events

	def_bg_events
	bg_event 11, 13, BGEVENT_READ, Route19Sign
	bg_event 11,  1, BGEVENT_READ, CarefulSwimmingSign

	def_object_events
	object_event  9, 23, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 0, TrainerSwimmerfDawn, -1
	object_event 13, 28, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerSwimmermHarold, -1
	object_event 11, 17, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerSwimmermFlavien, -1
	object_event  8, 23, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 0, TrainerSwimmermTucker, -1
	object_event  6,  5, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 1, Route19Fisher1Script, -1
	object_event 11,  5, SPRITE_FISHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 1, Route19Fisher2Script, -1
	object_event  9,  7, SPRITE_BIG_ONIX, SPRITEMOVEDATA_BIGDOLLASYM, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Route19Fisher2Script, EVENT_CINNABAR_ROCKS_CLEARED
	object_event  8,  8, SPRITE_BROCK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, Route19Fisher2Script, EVENT_CINNABAR_ROCKS_CLEARED
	object_event  6,  9, SPRITE_ROCK, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, -1, EVENT_CINNABAR_ROCKS_CLEARED
	object_event 15, 39, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerSwimmermGarvey, -1
	object_event 16, 60, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerSwimmerfVaiana, -1
