	object_const_def
	const CINNABARISLAND_BLUE
	const CINNABARISLAND_LOVER_F
	const CINNABARISLAND_LOVER_M
	const CINNABARISLAND_ROOF_KID
	const CINNABARISLAND_SWIMMER_LOVER_F
	const CINNABARISLAND_SWIMMER_LOVER_M
	const CINNABARISLAND_SYNC_DANCER_LEFT
	const CINNABARISLAND_SYNC_DANCER_RIGHT
	const CINNABARISLAND_DRUNK
	const CINNABARISLAND_VOLCANO_SWIMMER
	const CINNABARISLAND_TEACHER
	const CINNABARISLAND_KID
	const CINNABARISLAND_SHY

CinnabarIsland_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint
	callback MAPCALLBACK_OBJECTS, .RaveParty

.FlyPoint:
	setflag ENGINE_FLYPOINT_CINNABAR
	endcallback

.RaveParty:
	clearevent EVENT_CINNABAR_RAVE_PARTY
	disappear CINNABARISLAND_LOVER_F
	disappear CINNABARISLAND_LOVER_M
	disappear CINNABARISLAND_ROOF_KID
	disappear CINNABARISLAND_SWIMMER_LOVER_F
	disappear CINNABARISLAND_SWIMMER_LOVER_M
	disappear CINNABARISLAND_SYNC_DANCER_LEFT
	disappear CINNABARISLAND_SYNC_DANCER_RIGHT
	disappear CINNABARISLAND_VOLCANO_SWIMMER
	disappear CINNABARISLAND_TEACHER
	disappear CINNABARISLAND_KID
	disappear CINNABARISLAND_SHY

	readvar VAR_WEEKDAY
	ifnotequal THURSDAY, .NoRaveForYou
	checktime NITE
	iffalse .NoRaveForYou

	setevent EVENT_CINNABAR_RAVE_PARTY
	appear CINNABARISLAND_LOVER_F
	appear CINNABARISLAND_LOVER_M
	appear CINNABARISLAND_ROOF_KID
	appear CINNABARISLAND_SWIMMER_LOVER_F
	appear CINNABARISLAND_SWIMMER_LOVER_M
	appear CINNABARISLAND_SYNC_DANCER_LEFT
	appear CINNABARISLAND_SYNC_DANCER_RIGHT
	appear CINNABARISLAND_VOLCANO_SWIMMER
	appear CINNABARISLAND_TEACHER
	appear CINNABARISLAND_KID
	appear CINNABARISLAND_SHY

.NoRaveForYou:
	endcallback

CinnabarIslandBlue:
	faceplayer
	opentext
	writetext CinnabarIslandBlueText
	waitbutton
	closetext
	playsound SFX_WARP_TO
	applymovement CINNABARISLAND_BLUE, CinnabarIslandBlueTeleport
	disappear CINNABARISLAND_BLUE
	clearevent EVENT_VIRIDIAN_GYM_BLUE
	end

CinnabarIslandLovers:
	pause 5
	showemote EMOTE_HEART, CINNABARISLAND_LOVER_M, 15
	pause 15
	showemote EMOTE_HEART, CINNABARISLAND_LOVER_F, 15
	end

CinnabarIslandPartyScript:
	jumptextfaceplayer CinnabarIslandPartyText

CinnabarIslandVolcanoSwimmingScript:
	checkevent EVENT_CINNABAR_SWIM_CHEAT
	iftrue .volcano_cheat
	setevent EVENT_CINNABAR_SWIM_CHEAT
	jumptextfaceplayer CinnabarIslandVolcanoSwimmingText

.volcano_cheat:
	opentext
	writetext CinnabarIslandVolcanoSwimmingSequelText
	pause 20
	closetext
	end

CinnabarIslandSickScript:
	opentext
	checkevent EVENT_CINNABAR_AMULET_COIN
	iftrue .ready_to_party

	checkevent EVENT_CINNABAR_MAX_REVIVE
	iftrue .buy_silence

	checkevent EVENT_CINNABAR_GAVE_WATER
	iftrue .couldnt_take_max_revive

	writetext CinnabarIslandSickText
	waitbutton
	checkitem FRESH_WATER
	iftrue .take_water
	closetext
	end

.couldnt_take_max_revive:
	faceplayer
	writetext CinnabarIslandSickMaxReviveBisText
	promptbutton
	sjump .gave_water

.take_water:
	takeitem FRESH_WATER
	setevent EVENT_CINNABAR_GAVE_WATER
	writetext CinnabarIslandGiveWaterText
	promptbutton
	faceplayer
	opentext
	writetext CinnabarIslandSickWaterText
	promptbutton
.gave_water:
	verbosegiveitem MAX_REVIVE
	iffalse .make_room_max_revive
	setevent EVENT_CINNABAR_MAX_REVIVE

.buy_silence:
	faceplayer
	writetext CinnabarIslandSickBuySilenceText
	promptbutton
	writetext CinnabarIslandSickBuySilenceBisText
	promptbutton
	verbosegiveitem AMULET_COIN
	iffalse .make_room_amulet
	setevent EVENT_CINNABAR_AMULET_COIN

.ready_to_party:
	faceplayer
	writetext CinnabarIslandSickBetterText
	waitbutton
	closetext
	end

.make_room_max_revive:
	writetext CinnabarIslandSickMakeRoomText
	waitbutton
	closetext
	end

.make_room_amulet:
	writetext CinnabarIslandSickMakeRoom2Text
	waitbutton
	closetext
	end

CinnabarIslandSign:
	jumptext CinnabarIslandSignText

CinnabarIslandPokecenterSign:
	jumpstd PokecenterSignScript

CinnabarIslandHiddenRareCandy:
	hiddenitem RARE_CANDY, EVENT_CINNABAR_ISLAND_HIDDEN_RARE_CANDY

CinnabarIslandBlueTeleport:
	teleport_from
	step_end

CinnabarIslandBlueText:
	text "Who are you?"

	para "Well, it's plain"
	line "to see that you're"
	cont "a trainer…"

	para "My name's BLUE."

	para "I was once the"
	line "CHAMPION, although"

	para "it was for only a"
	line "short time…"

	para "That meddling RED"
	line "did me in…"

	para "Anyway, what do"
	line "you want? You want"

	para "to challenge me or"
	line "something?"

	para "…I hate to say"
	line "it, but I'm not in"

	para "the mood for a"
	line "battle now."

	para "Take a good look"
	line "around you…"

	para "A volcano erupts,"
	line "and just like"

	para "that, a whole town"
	line "disappears."

	para "We can go on win-"
	line "ning and losing in"

	para "#MON. But if"
	line "nature so much as"

	para "twitches, we can"
	line "lose in a second."

	para "…"

	para "That's the way it"
	line "is…"

	para "But, anyway, I'm"
	line "still a trainer."

	para "If I see a strong"
	line "opponent, it makes"
	cont "me want to battle."

	para "If you want to"
	line "battle me, come to"
	cont "the VIRIDIAN GYM."

	para "I'll take you on"
	line "then."
	done

CinnabarIslandPartyText:
	text "PAR-TAAAY!!"
	done

CinnabarIslandVolcanoSwimmingText:
	text "WOOHOO! I'm swim-"
	line "ming in a f*cking"
	cont "volcano baby!"
	done

CinnabarIslandVolcanoSwimmingSequelText:
	text "Let me tell you"
	line "a secret, my dear:"

	para "I'm wearing"
	line "nothing!"
	done

CinnabarIslandSickText:
	text "(burp)"

	para "I'm not feeling"
	line "well. Please"
	cont "give me something"
	cont "(burp) refreshing"
	cont "to drink…"
	done

CinnabarIslandGiveWaterText:
	text "<PLAYER> gives"
	line "FRESH WATER."
	done

CinnabarIslandSickWaterText:
	text "(drinks)"

	para "…"

	para "Wouuh!"

	para "I'm starting to"
	line "feel better."

	para "I was on"
	line "the edge…"

	para "A few seconds"
	line "more, and I would"
	cont "have needed to"
	cont "use this…"
	done

CinnabarIslandSickMaxReviveBisText:
	text "I don't need"
	line "this anymore,"
	cont "please take it."
	done

CinnabarIslandSickMakeRoomText:
	text "Empty your bag"
	line "then come back."
	done

CinnabarIslandSickMakeRoom2Text:
	text "You can't take it?"
	
	para "I won't trust you"
	line "until you take it."

	para "Come back later."
	done

CinnabarIslandSickBuySilenceText:
	text "By the way…"

	para "Don't you EVER"
	line "tell ANYONE that"
	cont "I've been in such"
	cont "a shape."
	done

CinnabarIslandSickBuySilenceBisText:
	text "I would like to"
	line "buy your silence."

	para "Take this as"
	line "your payment."
	done

CinnabarIslandSickBetterText:
	text "Give me a minute,"
	line "then let's"
	cont "PAR-TAY!"
	cont "(burp)!"
	done

CinnabarIslandSignText:
	text "CINNABAR ISLAND"

	para "The Fiery Town of"
	line "Burning Desire"
	done

CinnabarIsland_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 11, 11, CINNABAR_POKECENTER_1F, 1
	warp_event 8,   5, SEAFOAM_GYM, 1

	def_coord_events

	def_bg_events
	bg_event 12, 11, BGEVENT_READ, CinnabarIslandPokecenterSign
	bg_event  7,  7, BGEVENT_READ, CinnabarIslandSign
	bg_event  9,  1, BGEVENT_ITEM, CinnabarIslandHiddenRareCandy

	def_object_events
	object_event  9,  6, SPRITE_BLUE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CinnabarIslandBlue, EVENT_BLUE_IN_CINNABAR
	object_event  7,  8, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CinnabarIslandLovers, 0
	object_event  8,  8, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CinnabarIslandLovers, 0
	object_event 11,  8, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CinnabarIslandPartyScript, 0
	object_event 10, 16, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, CinnabarIslandPartyScript, 0
	object_event 12, 16, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, CinnabarIslandPartyScript, 0
	object_event  8,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_PATROL_X, 1, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, CinnabarIslandPartyScript, 0
	object_event  9,  4, SPRITE_YOUNGSTER, SPRITEMOVEDATA_PATROL_X, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CinnabarIslandPartyScript, 0
	object_event  4, 11, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, CinnabarIslandPartyScript, 0
	object_event 14,  4, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SWIMPATROL_CIRCLE_LEFT, 0, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CinnabarIslandVolcanoSwimmingScript, 0
	object_event  6, 13, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, CinnabarIslandSickScript, 0
	object_event  5,  6, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CinnabarIslandPartyScript, 0
	object_event 15, 13, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, CinnabarIslandPartyScript, 0
