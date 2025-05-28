	object_const_def
	const ROUTE10SOUTH_POKEFAN_M1
	const ROUTE10SOUTH_POKEFAN_M2

Route10South_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback

.EnterCallback:
	checkevent EVENT_GOT_COVID_ON_ROUTE_10
	iftrue .end

	loadmem wBattlePokerusSeed, TRUE ; Forcing Covid from enemy during the next battle, wherever that battle happens.

.end
	endcallback

TrainerHikerJim:
	trainer HIKER, JIM, EVENT_BEAT_HIKER_JIM, HikerJimSeenText, HikerJimBeatenText, 0, .Script

.Script:
	checkevent EVENT_GOT_COVID_ON_ROUTE_10
	iftrue .NoNotification

	setevent EVENT_CONTACT_TRACING_NOTIFICATION
.NoNotification
	setevent EVENT_GOT_COVID_ON_ROUTE_10

	endifjustbattled
	opentext
	writetext HikerJimAfterBattleText
	waitbutton
	closetext
	end

TrainerPokefanmRobert:
	trainer POKEFANM, ROBERT, EVENT_BEAT_POKEFANM_ROBERT, PokefanmRobertSeenText, PokefanmRobertBeatenText, 0, .Script

.Script:
	checkevent EVENT_GOT_COVID_ON_ROUTE_10
	iftrue .NoNotification
	
	setevent EVENT_CONTACT_TRACING_NOTIFICATION
.NoNotification
	setevent EVENT_GOT_COVID_ON_ROUTE_10

	endifjustbattled
	opentext
	writetext PokefanmRobertAfterBattleText
	waitbutton
	closetext
	end

Route10Sign:
	jumptext Route10SignText

Route10MaxEther:
	hiddenitem MAX_ETHER, EVENT_ROUTE_10_HIDDEN_MAX_ETHER

HikerJimSeenText: 
if DEF(_FR_FR)
	text "Hahahah!"
else
	text "Hahahah!"
endc

	done

HikerJimBeatenText: 
if DEF(_FR_FR)
	text "Hahaha-atchaa!"
else
	text "Hahaha-hachoo!"
endc

	done

HikerJimAfterBattleText: 
if DEF(_FR_FR)
	text "J'ai le rhume des"
	line "foins..."
	cont "Ahahah-TCHAAA!"
else
	text "Hay fever is"
	line "making me sneeze!"
	cont "Ahahah-CHOO!"
endc

	done

PokefanmRobertSeenText: 
if DEF(_FR_FR)
	text "T'aimes les #-"
	line "MON? Et ben..."

	para "Moi aussi!"
else
	text "You like #MON,"
	line "don't you?"

	para "Me too!"
endc

	done

PokefanmRobertBeatenText: 
if DEF(_FR_FR)
	text "J'aime pas perdre."
	line "Mais pas du tout."
else
	text "I'd have to say"
	line "that's my loss."
endc

	done

PokefanmRobertAfterBattleText: 
if DEF(_FR_FR)
	text "Regarde ce que"
	line "t'as fait à mes"
	cont "#MON..."

	para "J'l'oublierai pas!"
	line "Jamais!"
else
	text "Look what you did"
	line "to my #MON…"

	para "I won't forget"
	line "this…"
endc

	done

Route10SignText: 
if DEF(_FR_FR)
	text "ROUTE 10"

	para "AZURIA -"
	line "LAVANVILLE"
else
	text "ROUTE 10"

	para "CERULEAN CITY -"
	line "LAVENDER TOWN"
endc

	done

Route10South_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  6,  3, ROCK_TUNNEL_1F, 2

	def_coord_events

	def_bg_events
	bg_event  5,  5, BGEVENT_READ, Route10Sign
	bg_event 16,  3, BGEVENT_ITEM, Route10MaxEther

	def_object_events
	object_event 17,  5, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 3, TrainerHikerJim, -1
	object_event 10, 12, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerPokefanmRobert, -1
