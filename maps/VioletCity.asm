	object_const_def
	const VIOLETCITY_TRAVEL_CONTROLLER
	const VIOLETCITY_EARL
	const VIOLETCITY_LASS
	const VIOLETCITY_SUPER_NERD
	const VIOLETCITY_GRAMPS
	const VIOLETCITY_YOUNGSTER
	const VIOLETCITY_FRUIT_TREE
	const VIOLETCITY_POKE_BALL1
	const VIOLETCITY_POKE_BALL2
	const VIOLETCITY_LOCKDOWN_NPC_1
	const VIOLETCITY_LOCKDOWN_NPC_2
	const VIOLETCITY_LOCKDOWN_NPC_3
	const VIOLETCITY_LOCKDOWN_NPC_4
	const VIOLETCITY_BELLSPROUTTOWER_DOOR
	const VIOLETCITY_SCHOOL_DOOR
	const VIOLETCITY_FALSE_SWIPE_ITEMBALL
	const VIOLETCITY_ELMS_AIDE

VioletCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint
	callback MAPCALLBACK_TILES, .TilesLoad

.FlyPoint:
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	setflag ENGINE_FLYPOINT_VIOLET
	endcallback

.TilesLoad:
	readmem wCurFreedomState
	ifnotequal 1 << CURFEW, .EndTilesCallback

	changeblock  8, 16, $38

.EndTilesCallback
	endcallback

VioletCityEarlScript:
	applymovement VIOLETCITY_EARL, VioletCitySpinningEarl_MovementData
	faceplayer
	opentext
	writetext Text_EarlAsksIfYouBeatFalkner
	yesorno
	iffalse .FollowEarl

	writetext Text_VeryNiceIndeed
	waitbutton
	closetext
	end

.FollowEarl:
	writetext Text_FollowEarl
	waitbutton
	closetext
	playmusic MUSIC_SHOW_ME_AROUND

	readvar VAR_FACING
	ifequal LEFT, .PlayerWalksLeft
	applymovement PLAYER, VioletCity_PlayerWalksUpMovement
	sjump .StartFollowEarl

.PlayerWalksLeft:
	applymovement PLAYER, VioletCity_PlayerWalksLeftMovement
	sjump .StartFollowEarl

.StartFollowEarl:
	follow VIOLETCITY_EARL, PLAYER
	applymovement VIOLETCITY_EARL, VioletCityFollowEarl_MovementData
	stopfollow
	applymovement VIOLETCITY_EARL, VioletCity_PlayerWalksUpMovement
	applymovement VIOLETCITY_EARL, VioletCitySpinningEarl_MovementData
	special RestartMapMusic
	opentext
	writetext Text_HereTeacherIAm
	waitbutton
	closetext
	applymovement VIOLETCITY_EARL, VioletCitySpinningEarl_MovementData
	applymovement VIOLETCITY_EARL, VioletCityFinishFollowEarl_MovementData
	playsound SFX_ENTER_DOOR
	disappear VIOLETCITY_EARL
	clearevent EVENT_EARLS_ACADEMY_EARL
	waitsfx
	end

VioletCityLassScript:
	jumptextfaceplayer VioletCityLassText

VioletCitySuperNerdScript:
	jumptextfaceplayer VioletCitySuperNerdText

VioletCityGrampsScript:
	jumptextfaceplayer VioletCityGrampsText

VioletCityYoungsterScript:
	jumptextfaceplayer VioletCityYoungsterText

LockdownNPC1Script:
	jumptextfaceplayer LockdownNPC1Text

LockdownNPC3Script:
	jumptextfaceplayer LockdownNPC3Text

LockdownNPC4Script:
	jumptextfaceplayer LockdownNPC4Text

VioletCitySign:
	jumptext VioletCitySignText

VioletGymSign:
	jumptext VioletGymSignText

SproutTowerSign:
	jumptext SproutTowerSignText

EarlsPokemonAcademySign:
	jumptext EarlsPokemonAcademySignText

VioletCityPokecenterSign:
	jumpstd PokecenterSignScript

VioletCityMartSign:
	jumpstd MartSignScript

VioletCityPPUp:
	itemball PP_UP

VioletCityRareCandy:
	itemball RARE_CANDY

VioletCityTMFalseSwipe:
	itemball TM_FALSE_SWIPE

VioletCityFruitTree:
	fruittree FRUITTREE_VIOLET_CITY

VioletCityHiddenHyperPotion:
	hiddenitem HYPER_POTION, EVENT_VIOLET_CITY_HIDDEN_HYPER_POTION

VioletCity_DoorScript:
	jumpstd LockdownCurfewClosedDoor

VioletCity_SchoolDoorScript:
	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, .lockdown
	ifequal 1 << CURFEW, .curfew
	end

.lockdown
	jumptext VioletCity_ClosedSchoolText
.curfew
	farjumptext ClosedBusinessCurfewText

VioletElmsAideCallsPlayer:
	opentext
	writetext VioletCityElmsAide_CallText
	waitbutton
	closetext
	showemote EMOTE_SHOCK, PLAYER, 15
	end

VioletElmsAideRunningTop1Script:
	scall VioletElmsAideCallsPlayer
	turnobject PLAYER, RIGHT
	moveobject VIOLETCITY_ELMS_AIDE, 6, 8
	sjump VioletElmsAideHorizontalRun

VioletElmsAideRunningTop2Script:
	scall VioletElmsAideCallsPlayer
	turnobject PLAYER, RIGHT
	moveobject VIOLETCITY_ELMS_AIDE, 6, 9
VioletElmsAideHorizontalRun:
	appear VIOLETCITY_ELMS_AIDE
	applymovement VIOLETCITY_ELMS_AIDE, VioletCityElmsAideLeft
	sjump VioletElmsAideSpeech

VioletElmsAideRunningBottom1Script:
	scall VioletElmsAideCallsPlayer
	turnobject PLAYER, UP
	moveobject VIOLETCITY_ELMS_AIDE, 12, 26
	sjump VioletElmsAideVerticalRun

VioletElmsAideRunningBottom2Script:
	scall VioletElmsAideCallsPlayer
	turnobject PLAYER, UP
	moveobject VIOLETCITY_ELMS_AIDE, 13, 26
VioletElmsAideVerticalRun:
	appear VIOLETCITY_ELMS_AIDE
	applymovement VIOLETCITY_ELMS_AIDE, VioletCityElmsAideDown
	turnobject PLAYER, LEFT
	
VioletElmsAideSpeech:
	setevent EVENT_ELMS_AIDE_IN_VIOLET
	opentext

	writetext VioletCityElmsAide_ProfElmSentMeText
	promptbutton
	
	checkevent EVENT_BEAT_FALKNER
	iftrue .FalknerBeaten

; Falkner hasn't been beaten.
	checkevent EVENT_BEAT_SAGE_LI
	iftrue .SproutBeaten

; Sprout Tower hasn't been beaten.
	checkevent EVENT_BEAT_BIRD_KEEPER_ROD
	iffalse .NothingBeaten

	writetext VioletCityElmsAide_FailedAgainstFalknerText
	sjump .DiscourageFalknerFight

.NothingBeaten:
	writetext VioletCityElmsAide_NothingBeatenText
	sjump .DiscourageFalknerFight

.SproutBeaten:
	writetext VioletCityElmsAide_SproutBeatenText
	promptbutton

	checkevent EVENT_BEAT_BIRD_KEEPER_ROD
	iftrue .Surprised

	writetext VioletCityElmsAide_OnlySproutBeatenText
	sjump .DiscourageFalknerFight

.Surprised:
	writetext VioletCityElmsAide_SurprisedText
	sjump .DiscourageFalknerFight

.FalknerBeaten:
	writetext VioletCityElmsAide_FalknerBeatenText

	checkevent EVENT_BEAT_SAGE_LI
	iftrue VioletElmsAideDelivery

	promptbutton
	writetext VioletCityElmsAide_VisitSproutTowerText
	sjump VioletElmsAideDelivery

.DiscourageFalknerFight:
	promptbutton
	writetext VioletCityElmsAide_DontBeatFalknerText

VioletElmsAideDelivery:
	promptbutton
	writetext VioletCityElmsAide_GiveThingText
	promptbutton
	writetext VioletCityElmsAide_ByeText
	waitbutton
	closetext
	
	readvar VAR_YCOORD
	ifgreater 15, .VerticalWalk

;.HorizontalWalk:
	applymovement VIOLETCITY_ELMS_AIDE, VioletCityElmsAideRight
	disappear VIOLETCITY_ELMS_AIDE
	end
	
.VerticalWalk:
	applymovement VIOLETCITY_ELMS_AIDE, VioletCityElmsAideUp
	disappear VIOLETCITY_ELMS_AIDE
	end

VioletCity_PlayerWalksUpMovement:
	big_step UP
	step_end

VioletCity_PlayerWalksLeftMovement:
	big_step LEFT
	step_end

VioletCityFollowEarl_MovementData:
	big_step DOWN
	big_step DOWN
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	big_step DOWN
	big_step DOWN
	big_step DOWN
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	big_step RIGHT
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	big_step UP
	big_step UP
	step_end

VioletCityElmsAideUp:
	step UP
	step UP
	step UP
	step UP
VioletCityFinishFollowEarl_MovementData:
	step UP
	step_end

VioletCitySpinningEarl_MovementData:
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	turn_head LEFT
	turn_head UP
	turn_head RIGHT
	turn_head DOWN
	step_end

VioletCityElmsAideRight:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step_end

VioletCityElmsAideLeft:
	big_step LEFT
	big_step LEFT
	big_step LEFT
	big_step LEFT
	step_end

VioletCityElmsAideDown:
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step DOWN
	big_step DOWN
	turn_head RIGHT
	step_end


Text_EarlAsksIfYouBeatFalkner:
	text "Hello!"
	line "You are trainer?"

	para "Battle GYM LEADER,"
	line "win you did?"
	done

Text_VeryNiceIndeed:
	text "Ooh, la la!"
	line "Very indeed nice!"
	done

Text_FollowEarl:
	text "Is that so? Then"
	line "study shall you!"
	cont "Follow me!"
	done

Text_HereTeacherIAm:
	text "Here, teacher I"
	line "am. Good it is"
	cont "you study here!"
	done

VioletCityLassText:
	text "Ghosts are rumored"
	line "to appear in the"
	cont "BURNED TOWER."

	para "They said normal-"
	line "type #MON moves"

	para "had no effect on"
	line "ghosts."
	done

VioletCitySuperNerdText:
	text "Hey, you're a"
	line "#MON trainer?"

	para "If you beat the"
	line "GYM LEADER here,"

	para "you'll be ready"
	line "for prime time!"
	done

VioletCityGrampsText:
	text "FALKNER, from the"
	line "VIOLET #MON"

	para "GYM, is a fine"
	line "trainer!"

	para "He inherited his"
	line "father's gym and"

	para "has done a great"
	line "job with it."
	done

VioletCityYoungsterText:
	text "I saw a wiggly"
	line "tree up ahead!"

	para "If you touch it,"
	line "it squirms and"
	cont "dances! Cool!"
	done

VioletCitySignText:
	text "VIOLET CITY"

	para "The City of"
	line "Nostalgic Scents"
	done

VioletGymSignText:
	text "VIOLET CITY"
	line "#MON GYM"
	cont "LEADER: FALKNER"

	para "The Elegant Master"
	line "of Flying #MON"
	done

SproutTowerSignText:
	text "SPROUT TOWER"

	para "Experience the"
	line "Way of #MON"
	done

EarlsPokemonAcademySignText:
	text "EARL'S #MON"
	line "ACADEMY"
	done

LockdownNPC1Text:
	text "Please go on line"
	line "and wait for your"
	cont "turn."
	done

LockdownNPC3Text:
	text "I am glad every-"
	line "one respects the"

	para "queue, they have"
	line "a good education."
	done

LockdownNPC4Text:
	text "This queue is not"
	line "getting shorter!"

	para "I CAN'T STAND IT!"

	para "I'm going to jump"
	line "the queue soon!"
	done

VioletCity_ClosedSchoolText:
	text "There's a notice"
	line "on the door…"
	
	para "“The ACADEMY is"
	line "closed because of"
	cont "the pandemic."

	para "But don't rejoice"
	line "too soon, kids."
	cont "It's not a holiday!"

	para "School is now"
	line "remote: we will do"
	cont "online classes.”"
	done






VioletCityElmsAide_CallText:
	text "<PLAYER>!"
	done

VioletCityElmsAide_ProfElmSentMeText:
	text "PROF.ELM sent me"
	line "after you."
	done

VioletCityElmsAide_NothingBeatenText:
	text "Already leaving"
	line "VIOLET CITY?"

	para "You're moving fast!"

	para "Most people would"
	line "challenge FALKNER."
	done

VioletCityElmsAide_FailedAgainstFalknerText:
	text "You couldn't beat"
	line "FALKNER, hey?"

	para "Don't even worry"
	line "about it."
	done

VioletCityElmsAide_FalknerBeatenText:
	text "You have beaten"
	line "FALKNER, that's…"
	cont "That's impressive!"
	done

VioletCityElmsAide_VisitSproutTowerText:
	text "You could make"
	line "short work of"
	
	para "the SPROUT TOWER,"
	line "that's for sure!"
	done
	
VioletCityElmsAide_SproutBeatenText:
	text "Finally found you!"
	
	para "Now that you have"
	line "triumphed over the"
	cont "SPROUT TOWER,"
	done

VioletCityElmsAide_OnlySproutBeatenText:
	text "you may want to"
	line "challenge this"
	cont "city's GYM LEADER."
	done

VioletCityElmsAide_SurprisedText:
	text "I'm surprised you"
	line "haven't taken"
	cont "FALKNER down."
	done



	
	
VioletCityElmsAide_DontBeatFalknerText:
	text "Here is a personal"
	line "advice: don't spend"
	cont "too much time on"
	cont "him."
	
	para "If you can't beat"
	line "FALKNER, just move"
	cont "on to the next"
	cont "town."
	
	para "Don't forget you're"
	line "on a mission for"
	cont "PROF.ELM."
	done

VioletCityElmsAide_GiveThingText:
	text "I was sent after"
	line "you to equip"
	cont "you with this."
	done

VioletCityElmsAide_ByeText:	
	text "Acting early with"
	line "strong measures is"
	
	para "the only way to"
	line "prevent an"
	cont "epidemic."

	para "I must go back"
	line "to the lab now."

	para "Take care."
	done





VioletCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9, 17, VIOLET_MART, 2
	warp_event 18, 17, VIOLET_GYM, 1
	warp_event 30, 17, EARLS_POKEMON_ACADEMY, 1
	warp_event  3, 15, VIOLET_NICKNAME_SPEECH_HOUSE, 1
	warp_event 31, 25, VIOLET_POKECENTER_1F, 1
	warp_event 21, 29, VIOLET_KYLES_HOUSE, 1
	warp_event 23,  5, SPROUT_TOWER_1F, 1
	warp_event 39, 24, ROUTE_31_VIOLET_GATE, 1
	warp_event 39, 25, ROUTE_31_VIOLET_GATE, 2

	def_coord_events
	coord_event  0,  8, CE_EVENT_FLAG_CLEARED, EVENT_ELMS_AIDE_IN_VIOLET, VioletElmsAideRunningTop1Script
	coord_event  0,  9, CE_EVENT_FLAG_CLEARED, EVENT_ELMS_AIDE_IN_VIOLET, VioletElmsAideRunningTop2Script
	coord_event 14, 31, CE_EVENT_FLAG_CLEARED, EVENT_ELMS_AIDE_IN_VIOLET, VioletElmsAideRunningBottom1Script
	coord_event 15, 31, CE_EVENT_FLAG_CLEARED, EVENT_ELMS_AIDE_IN_VIOLET, VioletElmsAideRunningBottom2Script

	def_bg_events
	bg_event 24, 20, BGEVENT_READ, VioletCitySign
	bg_event 15, 17, BGEVENT_READ, VioletGymSign
	bg_event 24,  8, BGEVENT_READ, SproutTowerSign
	bg_event 27, 17, BGEVENT_READ, EarlsPokemonAcademySign
	bg_event 32, 25, BGEVENT_READ, VioletCityPokecenterSign
	bg_event 10, 17, BGEVENT_READ, VioletCityMartSign
	bg_event 37, 14, BGEVENT_ITEM, VioletCityHiddenHyperPotion
	bg_event  9, 17, BGEVENT_CLOSED_DOOR, VioletCity_DoorScript

	def_object_events
	object_event 33, 26, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, %11100000 | MORN | DAY, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, TravelController, EVENT_TRAVEL_CONTROL
	object_event 13, 16, SPRITE_FISHER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VioletCityEarlScript, EVENT_VIOLET_CITY_EARL
	object_event 28, 28, SPRITE_LASS, SPRITEMOVEDATA_WANDER, 2, 2, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VioletCityLassScript, -1
	object_event 24, 14, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WANDER, 1, 2, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, VioletCitySuperNerdScript, -1
	object_event 17, 20, SPRITE_GRAMPS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletCityGrampsScript, -1
	object_event  5, 18, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, VioletCityYoungsterScript, -1
	object_event 14, 29, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletCityFruitTree, -1
	object_event  4,  1, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, VioletCityPPUp, EVENT_VIOLET_CITY_PP_UP
	object_event 35,  5, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, VioletCityRareCandy, EVENT_VIOLET_CITY_RARE_CANDY
	object_event  9, 18, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, LockdownNPC1Script, EVENT_LOCKDOWN_MART_RUSH
	object_event  9, 20, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, LockdownNPC1Script, EVENT_LOCKDOWN_MART_RUSH
	object_event 11, 20, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, LockdownNPC3Script, EVENT_LOCKDOWN_MART_RUSH
	object_event 13, 20, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, LockdownNPC4Script, EVENT_LOCKDOWN_MART_RUSH
	object_event 23,  5, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletCity_DoorScript, -1
	object_event 30, 17, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, HIDE_FREE & HIDE_VACCINE_PASS, -1, 0, OBJECTTYPE_SCRIPT, 0, VioletCity_SchoolDoorScript, -1
	object_event 37, 15, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, VioletCityTMFalseSwipe, EVENT_LAKE_OF_RAGE_TM_DETECT
	object_event  0, 30, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
