	object_const_def
	const MOUNTMOON_SILVER
	const MOUNTMOON_BURGLAR

MountMoon_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .EnterCallback

.EnterCallback:
	checkevent EVENT_MT_MOON_RIVAL
	iftrue .EndCallback

	readvar VAR_XCOORD
	ifgreater 4, .SkipMapVarReset

	loadmem wRivalSpokeToPlayer, FALSE
.SkipMapVarReset:
	readmem wRivalSpokeToPlayer ; Limits the rival cutscene to happens only once per play session in Mount Moon.
	ifequal TRUE, .EndCallback

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; Activates the coord event (rival cutscene).
.EndCallback:
	endcallback

MountMoonRivalSurpriseScript:
	faceobject PLAYER, MOUNTMOON_SILVER
	showemote EMOTE_SHOCK, PLAYER, 15
	special FadeOutMusic
	pause 15
	playmusic MUSIC_RIVAL_ENCOUNTER
	end

MountMoonMeetRivalFromTop:
	scall MountMoonRivalSurpriseScript
	applymovement PLAYER, MountMoonSilverNoNameIdeaMovement
	sjump MountMoonMeetRival

MountMoonMeetRivalFromLeft2:
	scall MountMoonRivalSurpriseScript
	applymovement PLAYER, MountMoonSilverStepLeftMovement
	sjump MountMoonMeetRival

MountMoonMeetRivalFromLeft:
	scall MountMoonRivalSurpriseScript
MountMoonMeetRival:
	setlasttalked MOUNTMOON_SILVER
	turnobject PLAYER, RIGHT
MountMoonRivalBattle:
	faceplayer
	opentext
	
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	clearevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1 ; This doesn't override the result of the previous checkevent.
	ifequal FALSE, .GetMoreBadges

	writetext MountMoonSilverTextBefore
	promptbutton

	readvar VAR_BADGES
	ifless 12, .RefuseFight

	writetext MountMoonSilverTextStartBattle

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
	setevent EVENT_BEAT_RIVAL_IN_MT_MOON
	farscall AugmentKantoDifficultyLevel
.FadeOutMusic:
	musicfadeout MUSIC_MT_MOON, 8
	end

.RefuseFight:
	writetext MountMoonSilverTextMadeProgress
	promptbutton
.GetMoreBadges:
	writetext MountMoonSilverTextRefuseFight
	waitbutton
	closetext

	readmem wRivalSpokeToPlayer
	loadmem wRivalSpokeToPlayer, TRUE
	iffalse .FadeOutMusic
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

MountMoonSilverMovementAfter:
	step UP
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step_end

MountMoonSilverStepLeftMovement:
	fix_facing
	slow_step LEFT
	remove_fixed_facing
	step_end

MountMoonSilverNoNameIdeaMovement:
	step LEFT
	step LEFT
	step DOWN
	step_end

MountMoonSilverTextBefore: ; TO TRANSLATE
	text "<……> <……> <……>"

	para "It's been a while,"
	line "<PLAYER>."

	para "…Since I lost to"
	line "you, I thought"

	para "about what I was"
	line "lacking with my"
	cont "#MON…"
	done

MountMoonSilverTextMadeProgress: ; TO TRANSLATE
	text "Since then, we"
	line "have made great"
	cont "progress!"

	para "We won 4 badges"
	line "from this region."

	para "But apparently"
	line "you don't…"
	done

MountMoonSilverTextRefuseFight: ; TO TRANSLATE
	text "I want us to fight"
	line "on equal terms."

	para "Go earn more"
	line "badges."
	done

MountMoonSilverTextStartBattle: ; TO TRANSLATE
	text "And we came up"
	line "with an answer."

	para "<PLAYER>, now we'll"
	line "show you!"
	done

MountMoonSilverTextWin: 
if DEF(_FR_FR)
	text "<……> <……> <……>"

	para "Je pensais avoir"
	line "élevé mes #MON"

	para "au max de leurs"
	line "capacités..."

	para "...Mais ce n'était"
	line "pas suffisant..."
else
	text "<……> <……> <……>"

	para "I thought I raised"
	line "my #MON to be"

	para "the best they"
	line "could be…"

	para "…But it still "
	line "wasn't enough…"
endc

	done

MountMoonSilverTextAfter: ; TO TRANSLATE
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

	para "I'll keep training"
	line "in JOHTO and I'll"

	para "try to take on"
	line "the ELITE 4."

	para "This is where you"
	line "will find me."
	done

MountMoonSilverTextLoss: 
if DEF(_FR_FR)
	text "<……> <……> <……>"

	para "Yahahaha!"
	line "Vengeance!"

	para "Avec mes #MON,"
	line "je vais battre le"

	para "CHAMPION et être"
	line "le plus grand des"
	cont "dresseurs."
else
	text "<……> <……> <……>"

	para "I've repaid my"
	line "debt to you."

	para "With my #MON,"
	line "I'm going to beat"

	para "the CHAMPION and"
	line "become the world's"
	cont "greatest trainer."
endc

	done

BurglarBonesSeenText: ; TO TRANSLATE
	text "My shovel and I"
	line "came for the rare"
	cont "stones!"
	done

BurglarBonesBeatenText: ; TO TRANSLATE
	text "All right, let's"
	line "stop playing."
	done

BurglarBonesAfterBattleText: ; TO TRANSLATE
	text "I didn't find any"
	line "rare stones here."
	
	para "I need to find"
	line "another way to"
	cont "make money…"
	
	para "Perhaps I could"
	line "become a cook?"
	done

BurglarBonesGivesLootText: ; TO TRANSLATE
	text "Yes! This is a"
	line "great plan!"

	para "I should get rid"
	line "of my loot then."
	done

BurglarBonesLightenPackText: ; TO TRANSLATE
	text "Go lighten your"
	line "pack, before I"
	cont "do it for you."
	done

BurglarBonesOriginText: ; TO TRANSLATE
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
	coord_event 15, 14, CE_EVENT_FLAG_SET, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1, MountMoonMeetRivalFromTop
	coord_event 14, 15, CE_EVENT_FLAG_SET, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1, MountMoonMeetRivalFromLeft2
	coord_event 13, 15, CE_EVENT_FLAG_SET, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1, MountMoonMeetRivalFromLeft

	def_bg_events

	def_object_events
	object_event 15, 15, SPRITE_SILVER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MountMoonRivalBattle, EVENT_MT_MOON_RIVAL
	object_event 12,  4, SPRITE_PHARMACIST, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 5, TrainerBurglarBones, -1
