	object_const_def
	const OLIVINEPORTPASSAGE_POKEFAN_M
	const OLIVINEPORTPASSAGE_CUSTOMS

OlivinePortPassage_MapScripts:
	def_scene_scripts

	def_callbacks

OlivinePortPassagePokefanMScript:
	jumptextfaceplayer OlivinePortPassagePokefanMText

OlivinePortPassageCustomsScript:
	faceplayer
	opentext
	checkevent EVENT_PLAYER_GOT_POKEMASK
	iftrue .Delay

	writetext OlivinePortCustomsText
	promptbutton
	verbosegiveitem POKEMASK
	iffalse .NoRoom

	setevent EVENT_PLAYER_GOT_POKEMASK
	specialphonecall SPECIALCALL_POKEMASK_AFTER
	closetext
	end

.Delay:
	writetext OlivinePortCustomsInconvenienceText
	sjump .TextEnd
.NoRoom:
	writetext OlivinePortCustomsNoRoomText
.TextEnd:
	waitbutton
	closetext
	end

OlivinePortCustomsText: ; TO TRANSLATE
	text "You must be coming"
	line "for PROF.ELM's"
	cont "held parcel?"

	para "We had never seen"
	line "this item before,"
	
	para "and didn't know"
	line "what taxes should"
	cont "be applied."

	para "But it has been"
	line "arranged: there"
	cont "will be none."

	para "It's yours"
	line "to take."
	done

OlivinePortCustomsNoRoomText: ; TO TRANSLATE
	text "I'll wait for you"
	line "while you offload"
	cont "your pack."
	done

OlivinePortCustomsInconvenienceText: ; TO TRANSLATE
	text "Sorry for the"
	line "delivery delay."
	done

OlivinePortPassagePokefanMText: ; AUTOTRAD
	text "FAST SHIP S.S.AQUA"
	line "sails to KANTO on"

	para "Mondays and Fri-"
	line "days."
	done

OlivinePortPassage_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 15,  0, OLIVINE_CITY, 10
	warp_event 16,  0, OLIVINE_CITY, 11
	warp_event 15,  4, OLIVINE_PORT_PASSAGE, 4
	warp_event  3,  2, OLIVINE_PORT_PASSAGE, 3
	warp_event  3, 14, OLIVINE_PORT, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event 17,  1, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OlivinePortPassagePokefanMScript, EVENT_OLIVINE_PORT_PASSAGE_POKEFAN_M
	object_event 16,  4, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, OlivinePortPassageCustomsScript, EVENT_PLAYER_GOT_POKEMASK
