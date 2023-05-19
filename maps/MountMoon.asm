	object_const_def
	const MOUNTMOON_SILVER
	const MOUNTMOON_BURGLAR

MountMoon_MapScripts:
	def_scene_scripts
	scene_script .RivalEncounter ; SCENE_DEFAULT
	scene_script .DummyScene ; SCENE_FINISHED

	def_callbacks

.RivalEncounter:
	prioritysjump .RivalBattle
	end

.DummyScene:
	end

.RivalBattle:
	turnobject PLAYER, RIGHT
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	pause 15
	applymovement MOUNTMOON_SILVER, MountMoonSilverMovementBefore
	playmusic MUSIC_RIVAL_ENCOUNTER
	opentext
	writetext MountMoonSilverTextBefore
	waitbutton
	closetext
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .Totodile
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .Chikorita
	winlosstext MountMoonSilverTextWin, MountMoonSilverTextLoss
	setlasttalked MOUNTMOON_SILVER
	loadtrainer RIVAL2, RIVAL2_1_TOTODILE
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .FinishBattle

.Totodile:
	winlosstext MountMoonSilverTextWin, MountMoonSilverTextLoss
	setlasttalked MOUNTMOON_SILVER
	loadtrainer RIVAL2, RIVAL2_1_CHIKORITA
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .FinishBattle

.Chikorita:
	winlosstext MountMoonSilverTextWin, MountMoonSilverTextLoss
	setlasttalked MOUNTMOON_SILVER
	loadtrainer RIVAL2, RIVAL2_1_CYNDAQUIL
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	sjump .FinishBattle

.FinishBattle:
	playmusic MUSIC_RIVAL_AFTER
	opentext
	writetext MountMoonSilverTextAfter
	waitbutton
	closetext
	applymovement MOUNTMOON_SILVER, MountMoonSilverMovementAfter
	disappear MOUNTMOON_SILVER
	setscene SCENE_FINISHED
	setevent EVENT_BEAT_RIVAL_IN_MT_MOON
	playmapmusic
	end

TrainerBurglarBones:
	trainer BURGLAR, BONES, EVENT_BEAT_BURGLAR_BONES, BurglarBonesSeenText, BurglarBonesBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BurglarBonesAfterBattleText

	checkevent EVENT_MOUNT_MOON_AMULET_COIN
	iftrue .EndDialog

	promptbutton
	writetext BurglarBonesGivesLootText
	promptbutton
	verbosegiveitem AMULET_COIN
	iffalse .make_room_amulet
	setevent EVENT_MOUNT_MOON_AMULET_COIN

	writetext BurglarBonesOriginText
	sjump .EndDialog

.make_room_amulet:
	writetext BurglarBonesLightenPackText

.EndDialog
	waitbutton
	closetext
	end

MountMoonSilverMovementBefore:
	step LEFT
	step LEFT
	step LEFT
	step_end

MountMoonSilverMovementAfter:
	step RIGHT
	step RIGHT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end

MountMoonSilverTextBefore:
	text "<……> <……> <……>"

	para "It's been a while,"
	line "<PLAYER>."

	para "…Since I lost to"
	line "you, I thought"

	para "about what I was"
	line "lacking with my"
	cont "#MON…"

	para "And we came up"
	line "with an answer."

	para "<PLAYER>, now we'll"
	line "show you!"
	done

MountMoonSilverTextWin:
	text "<……> <……> <……>"

	para "I thought I raised"
	line "my #MON to be"

	para "the best they"
	line "could be…"

	para "…But it still "
	line "wasn't enough…"
	done

MountMoonSilverTextAfter:
	text "<……> <……> <……>"

	para "…You won, fair"
	line "and square."

	para "I admit it. But"
	line "this isn't the"
	cont "end."

	para "I'm going to be"
	line "the greatest #-"
	cont "MON trainer ever."

	para "Because these guys"
	line "are behind me."

	para "…Listen, <PLAYER>."

	para "One of these days"
	line "I'm going to prove"

	para "how good I am by"
	line "beating you."
	done

MountMoonSilverTextLoss:
	text "<……> <……> <……>"

	para "I've repaid my"
	line "debt to you."

	para "With my #MON,"
	line "I'm going to beat"

	para "the CHAMPION and"
	line "become the world's"
	cont "greatest trainer."
	done

BurglarBonesSeenText:
	text "My shovel and I"
	line "came for the rare"
	cont "stones!"
	done

BurglarBonesBeatenText:
	text "All right, let's"
	line "stop playing."
	done

BurglarBonesAfterBattleText:
	text "I didn't find any"
	line "rare stones here."
	
	para "I need to find"
	line "another way to"
	cont "make money…"
	
	para "Perhaps I could"
	line "become a cook?"
	done

BurglarBonesGivesLootText:
	text "Yes! This is a"
	line "great plan!"

	para "I should get rid"
	line "of my loot then."
	done

BurglarBonesLightenPackText:
	text "Go lighten your"
	line "pack, before I"
	cont "do it for you."
	done

BurglarBonesOriginText:
	text "Got it in GOLDEN-"
	line "ROD UNDERGROUND"
	cont "WAREHOUSE."
	
	para "Now I need to"
	line "figure out how"
	cont "to cook. Where"
	cont "do I start?"
	done

MountMoon_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  3, ROUTE_3, 1
	warp_event 15, 15, ROUTE_4, 1
	warp_event 13,  3, MOUNT_MOON, 7
	warp_event 15, 11, MOUNT_MOON, 8
	warp_event 25,  5, MOUNT_MOON_SQUARE, 1
	warp_event 25, 15, MOUNT_MOON_SQUARE, 2
	warp_event 25,  3, MOUNT_MOON, 3
	warp_event 25, 13, MOUNT_MOON, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  7,  3, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_MT_MOON_RIVAL
	object_event 12,  4, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 5, TrainerBurglarBones, -1
