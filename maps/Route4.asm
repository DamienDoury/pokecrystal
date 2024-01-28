	object_const_def
	const ROUTE4_YOUNGSTER
	const ROUTE4_LASS1
	const ROUTE4_LASS2
	const ROUTE4_HIKER
	const ROUTE4_POKE_BALL1
	const ROUTE4_POKE_BALL2
	const ROUTE4_ROCK1
	const ROUTE4_ROCK2
	const ROUTE4_BOULDER1
	const ROUTE4_BOULDER2
	const ROUTE4_ROCKET_SOUTH
	const ROUTE4_ROCKET_NORTH
	const ROUTE4_JENNY

Route4_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerBirdKeeperHank:
	trainer BIRD_KEEPER, HANK, EVENT_BEAT_BIRD_KEEPER_HANK, BirdKeeperHankSeenText, BirdKeeperHankBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BirdKeeperHankAfterBattleText
	waitbutton
	closetext
	end

TrainerPicnickerHope:
	trainer PICNICKER, HOPE, EVENT_BEAT_PICNICKER_HOPE, PicnickerHopeSeenText, PicnickerHopeBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PicnickerHopeAfterBattleText
	waitbutton
	closetext
	end

TrainerPicnickerSharon:
	trainer PICNICKER, SHARON, EVENT_BEAT_PICNICKER_SHARON, PicnickerSharonSeenText, PicnickerSharonBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PicnickerSharonAfterBattleText
	waitbutton
	closetext
	end

TrainerHikerSammy:
	trainer HIKER, SAMMY, EVENT_BEAT_HIKER_SAMMY, HikerSammySeenText, HikerSammyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext HikerSammyAfterBattleText
	waitbutton
	closetext
	end

Route4RocketSouth:
	applymovement ROUTE4_ROCKET_SOUTH, Route4RocketTryJumpLedgeMovement
	playsound SFX_JUMP_OVER_LEDGE
	applymovement ROUTE4_ROCKET_SOUTH, Route4RocketJumpsLedgeMovement
	disappear ROUTE4_ROCKET_SOUTH

	readvar VAR_XCOORD
	ifless 25, .leftSide

	moveobject ROUTE4_JENNY, 32, 11
	appear ROUTE4_JENNY ; Also does ROUTE4_ROCKET_NORTH
	applymovement ROUTE4_JENNY, Route4JennyArrivesTooLateMovement
	end

.leftSide
	moveobject ROUTE4_JENNY, 30, 11
	appear ROUTE4_JENNY ; Also does ROUTE4_ROCKET_NORTH
	applymovement ROUTE4_JENNY, Route4JennyArrivesALittleTooLateMovement
	end

Route4Jenny:
	farsjump CeruleanCitySawThiefScript

Route4RocketNorth:
	faceplayer
	playmusic MUSIC_ROCKET_ENCOUNTER
	opentext
	writetext Route4RocketSeenText
	waitbutton
	closetext
	winlosstext Route4RocketBeatenText, -1
	loadtrainer GRUNTM, GRUNTM_31
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	playmusic MUSIC_ROCKET_ENCOUNTER
	opentext
	writetext Route4RocketAfterBattleText
	promptbutton
	closetext
	pause 5
	showemote EMOTE_QUESTION, ROUTE4_ROCKET_NORTH, 20
	musicfadeout MUSIC_ROUTE_3, 8
	applymovement ROUTE4_ROCKET_NORTH, Route4SlowLeftMovement
	pause 3
	opentext
	writetext Route4RocketDisappearsText
	waitbutton
	closetext

	pause 15

	disappear ROUTE4_JENNY
	moveobject ROUTE4_JENNY, 11, 8
	appear ROUTE4_JENNY
	applymovement ROUTE4_JENNY, Route4JennyAppearsMovement

	pause 20
	musicfadeout MUSIC_HIGH_OFFICER_ENCOUNTER, 1

	opentext
	writetext Route4JennyPunchlineText
	waitbutton
	closetext

	;playmusic MUSIC_HIGH_OFFICER_ENCOUNTER

	turnobject PLAYER, DOWN
	turnobject ROUTE4_ROCKET_NORTH, DOWN
	showemote EMOTE_SHOCK, ROUTE4_ROCKET_NORTH, 20
	pause 10
	
	applymovement ROUTE4_JENNY, Route4JennyFinallyCatchesUpMovement
	faceobject ROUTE4_ROCKET_NORTH, ROUTE4_JENNY
	faceobject PLAYER, ROUTE4_JENNY

	opentext
	writetext Route4JennyJailText
	waitbutton
	closetext

	pause 3
	showemote EMOTE_SHOCK, ROUTE4_JENNY, 20
	pause 3

	opentext
	writetext Route4JennyWhatsThisText
	waitbutton
	closetext

	pause 3
	applymovement ROUTE4_JENNY, Route4StompRightMovement
	pause 3

	opentext
	readmem wPlayerGender
	ifequal 0, .Male

	writetext Route4TrainerCardFemaleText
	sjump .PlayerRetrievesTrainerCard

.Male
	writetext Route4TrainerCardMaleText

.PlayerRetrievesTrainerCard
	playsound SFX_CAUGHT_MON
	setflag ENGINE_TRAINER_CARD
	waitbutton
	waitsfx

	writetext Route4JennyThanksText
	waitbutton
	closetext

	pause 3
	applymovement ROUTE4_JENNY, Route4StompLeftMovement
	pause 3

	opentext
	writetext Route4JennyJusticeText
	waitbutton
	closetext

	pause 3
	
	follow ROUTE4_JENNY, ROUTE4_ROCKET_NORTH
	applymovement ROUTE4_JENNY, Route4JennyLeavesTriumphantMovement
	stopfollow

	musicfadeout MUSIC_ROUTE_3, 16

	disappear ROUTE4_JENNY
	disappear ROUTE4_ROCKET_NORTH
	setevent EVENT_ROCKET_THIEF_CAUGHT
	end

MtMoonSquareSign:
	jumptext MtMoonSquareSignText

Route4HPUp:
	itemball HP_UP

Route4Carbos:
	itemball CARBOS

Route4HiddenUltraBall:
	hiddenitem ULTRA_BALL, EVENT_ROUTE_4_HIDDEN_ULTRA_BALL

Route4HiddenPPUp:
	hiddenitem PP_UP, EVENT_ROUTE_4_HIDDEN_PP_UP

Route4Rock:
	jumpstd SmashRockScript

Route4Boulder:
	jumpstd StrengthBoulderScript

Route4RocketTryJumpLedgeMovement:
	fix_facing
rept 2
	slow_step DOWN
	big_step UP
	step_sleep 6
endr
	slow_step DOWN
	remove_fixed_facing
	big_step UP
	step_end

Route4JennyAppearsMovement:
	step UP
	step_end

Route4RocketJumpsLedgeMovement:
	jump_step UP
Route4JennyArrivesTooLateMovement:
	big_step LEFT
	big_step LEFT
Route4JennyArrivesALittleTooLateMovement:
rept 3
	big_step LEFT
endr
	step_end

Route4JennyFinallyCatchesUpMovement:
rept 4
	step UP
endr
	step LEFT
	step_end

Route4StompRightMovement:
	turn_step RIGHT
	step_bump
	step_end

Route4StompLeftMovement:
	turn_step LEFT
	step_bump
	step_end

Route4SlowLeftMovement:
	fix_facing
	slow_step LEFT
	remove_fixed_facing
	step_end

Route4JennyLeavesTriumphantMovement:
	slow_step RIGHT
rept 3
	slow_step DOWN
endr
rept 5
	slow_step LEFT
endr
	step_end

BirdKeeperHankSeenText:
	text "I'm raising my"
	line "#MON. Want to"
	cont "battle with me?"
	done

BirdKeeperHankBeatenText:
	text "Ack! I lost that"
	line "one…"
	done

BirdKeeperHankAfterBattleText:
	text "If you have a"
	line "specific #MON"

	para "that you want to"
	line "raise, put it out"

	para "first, then switch"
	line "it right away."

	para "That's how to do"
	line "it."
	done

PicnickerHopeSeenText:
	text "I have a feeling"
	line "that I can win."

	para "Let's see if I'm"
	line "right!"
	done

PicnickerHopeBeatenText:
	text "Aww, you are too"
	line "strong."
	done

PicnickerHopeAfterBattleText:
	text "I heard CLEFAIRY"
	line "appear at MT.MOON."

	para "But where could"
	line "they be?"
	done

PicnickerSharonSeenText:
	text "Um…"
	line "I…"
	done

PicnickerSharonBeatenText:
	text "…"
	done

PicnickerSharonAfterBattleText:
	text "……I'll go train"
	line "some more…"
	done

HikerSammySeenText:
	text "Hello fellow"
	line "HIKER!"
	done

HikerSammyBeatenText:
	text "I had a pebble in"
	line "my shoe. Not fair."
	done

HikerSammyAfterBattleText:
	text "Have you met the"
	line "crazy man that"
	cont "dug this cave?"

	para "His work is"
	line "pointless."

	para "The cave sank."
	
	para "He better try"
	line "by the water."

	para "It's what the"
	line "rumor suggests."
	done

MtMoonSquareSignText:
	text "MT.MOON SQUARE"

	para "Just go up the"
	line "stairs."
	done

Route4RocketSeenText:
	text "Hey, kid! Chasing"
	line "me you stop."

	para "Me dangerous,"
	line "okay?"
	
	para "Me am a TEAM"
	line "ROCKET member"
	cont "kind of guy!"

	para "Come from another"
	line "country, a trainer"
	cont "number one, me!"

	para "Need steal MACHINE"
	line "PART for country,"

	para "energy crisis"
	line "think of."

	para "But tired running."
	line "Leads nowhere."

	para "Hey, kid! Battle"
	line "begin we do!"
	done

Route4RocketBeatenText:
	text "Ayieeeh! No, no,"
	line "no, believe it I"
	cont "can't!"

	para "Strong very much"
	line "be you! Match I am"
	cont "not to you!"
	done

Route4RocketAfterBattleText:
	text "OK. You win."

	para "But you forget me"
	line "not!"

	para "Beat you for sure"
	line "will TEAM ROCKET."

	para "Come from JOHTO"
	line "will they, mine"

	para "friends, yes. Will"
	line "revenge they are."
	done

Route4RocketDisappearsText:
	text "…"

	para "You say what? TEAM"
	line "ROCKET bye-bye a"

	para "go-go? Broken it"
	line "is says you?"

	para "Me secret mission"
	line "is none?"

	para "Oh, no! Should I"
	line "do what now on"
	cont "from, me?"
	done

Route4JennyPunchlineText:
	text "I can tell you"
	line "what you will do."
	done

Route4JennyJailText:
	text "YOU'RE GOING"
	line "TO JAIL!!"

	para "Show me your ID."
	done

Route4JennyWhatsThisText:
	text "Hey! This TRAINER"
	line "CARD isn't yours!"
	done

Route4TrainerCardFemaleText:
	text "<PLAYER> retrieves"
	line "her TRAINER CARD!"
	done

Route4TrainerCardMaleText:
	text "<PLAYER> retrieves"
	line "his TRAINER CARD!"
	done

Route4JennyThanksText:
	text "Thanks <PLAYER>."
	line "You've been a"
	cont "great support."

	para "If you wanna stay"
	line "informed of our"
	cont "other cases,"

	para "come at CERULEAN"
	line "POLICE STATION."
	done

Route4JennyJusticeText:
	text "Let's go mister."

	para "Justice's waiting"
	line "for you."
	done

Route4_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  5, MOUNT_MOON, 2
	warp_event 22,  1, ROUTE_4_TUNNEL, 1
	warp_event 36,  3, ROUTE_4_TUNNEL, 2

	def_coord_events

	def_bg_events
	bg_event  3,  7, BGEVENT_READ, MtMoonSquareSign
	bg_event 10,  2, BGEVENT_ITEM, Route4HiddenUltraBall
	bg_event 33,  3, BGEVENT_ITEM, Route4HiddenPPUp

	def_object_events
	object_event 17,  9, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperHank, -1
	object_event  7,  8, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 5, TrainerPicnickerHope, -1
	object_event 21,  6, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 4, TrainerPicnickerSharon, -1
	object_event 29,  4, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerHikerSammy, -1
	object_event 26,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route4HPUp, EVENT_ROUTE_4_HP_UP
	object_event 29,  2, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, Route4Carbos, EVENT_ROUTE_4_CARBOS
	object_event 34,  4, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route4Rock, -1
	object_event 22,  3, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route4Rock, -1
	object_event 33,  3, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route4Boulder, -1
	object_event 33,  5, SPRITE_BOULDER, SPRITEMOVEDATA_STRENGTH_BOULDER, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route4Boulder, -1
	object_event 24, 10, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route4RocketSouth, EVENT_ROCKET_THIEF_ROUTE_4_SOUTH
	object_event 10,  3, SPRITE_ROCKET, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Route4RocketNorth, EVENT_ROCKET_THIEF_ROUTE_4_NORTH
	object_event 27, 11, SPRITE_JENNY, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Route4Jenny, EVENT_ROCKET_THIEF_ROUTE_4_NORTH
