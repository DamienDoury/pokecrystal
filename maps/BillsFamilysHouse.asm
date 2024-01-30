	object_const_def
	const BILLSFAMILYSHOUSE_BILL
	const BILLSFAMILYSHOUSE_POKEFAN_F
	const BILLSFAMILYSHOUSE_TWIN

BillsFamilysHouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .TilesLoad

.TilesLoad
	checkevent EVENT_MET_BILL
	iftrue .HaventMetBill

	changeblock  2,  2, $36
.HaventMetBill
	endcallback

BillScript:
	faceplayer
	checkevent EVENT_CONTACT_TRACING_MODULE_AVAILABLE
	iftrue .askForCard

	jumptext BillTakeThisEeveeText

.askForCard
	opentext
	writetext BillAskForCardText
	yesorno
	iffalse .refused

	writetext BillAllYouHadToSayText
	promptbutton
	getstring STRING_BUFFER_4, .contactTracingCardText
	callstd ReceiveItemScript
	writetext BillAutomaticText
	waitbutton

	setevent EVENT_POKEGEAR_CONTACT_TRACING_MODULE
	clearevent EVENT_CONTACT_TRACING_MODULE_AVAILABLE
	clearevent EVENT_CONTACT_TRACING_NOTIFICATION ; The device couldn't receive notifications before it was installed.
	sjump .endText

.refused
	writetext BillPrivacyConcernsText
	waitbutton
.endText
	closetext
	end

.contactTracingCardText
	db "CONTACT TRACING@"

BillsMomScript:
	faceplayer
	opentext
	checkevent EVENT_MET_BILL
	iffalse .HaventMetBill
	writetext BillsMomText_BeforeEcruteak
	waitbutton
	closetext
	end

.HaventMetBill:
	writetext BillsMomText_AfterEcruteak
	waitbutton
	closetext
	end

BillsSisterScript:
	faceplayer
	opentext
	checkcellnum PHONE_BILL
	iftrue .GotBillsNumber
	writetext BillsSisterUsefulNumberText
	askforphonenumber PHONE_BILL
	ifequal PHONE_CONTACTS_FULL, .NoRoom
	ifequal PHONE_CONTACT_REFUSED, .Refused
	waitsfx
	addcellnum PHONE_BILL
	writetext RecordedBillsNumberText
	playsound SFX_REGISTER_PHONE_NUMBER
	waitsfx
	promptbutton
.GotBillsNumber:
	writetext BillsSisterStorageSystemText
	waitbutton
	closetext
	end

.Refused:
	writetext BillsSisterRefusedNumberText
	waitbutton
	closetext
	end

.NoRoom:
	writetext BillsSisterPhoneFullText
	promptbutton
	sjump .Refused

BillsComputerScript:
	jumptext BillsComputerText

BillsHouseBookshelf1:
	jumpstd PictureBookshelfScript

BillsHouseBookshelf2:
	jumpstd MagazineBookshelfScript

BillsHouseRadio:
	jumpstd Radio2Script

BillTakeThisEeveeText:
	text "BILL: Hi, <PLAYER>!"
	line "Have you noticed"
	cont "that the PSS"
	cont "doesn't restore"
	cont "the PP of your"
	cont "#MON anymore?"

	para "It's a subroutine"
	line "I had to shutdown"
	cont "to prevent COVID"
	cont "from spreading"
	cont "within the PC."

	para "I'm unsure of the" 
	line "effectiveness of"
	cont "this action, but"
	cont "I don't want to"
	cont "take any risk!"
	done

BillsMomText_BeforeEcruteak:
	text "Oh, you collect"
	line "#MON? My son"
	cont "BILL is an expert."

	para "He just got called"
	line "to the #MON"

	para "CENTER in ECRUTEAK"
	line "CITY."
	done

BillsMomText_AfterEcruteak:
	text "My husband was"
	line "once known as a"

	para "#MANIAC."
	line "BILL must have"

	para "taken after his"
	line "father."
	done

BillsSisterUsefulNumberText:
	text "Are you a trainer?"

	para "I've got a useful"
	line "phone number for"
	cont "you."
	done

RecordedBillsNumberText:
	text "<PLAYER> recorded"
	line "BILL's number."
	done

BillsSisterRefusedNumberText:
	text "My brother made"
	line "the PC #MON"
	cont "storage system."

	para "I was going to"
	line "give you BILL's"
	cont "number…"
	done

BillsSisterPhoneFullText:
	text "You can't record"
	line "any more numbers."
	done

BillsSisterStorageSystemText:
	text "My big brother"
	line "BILL made the PC"

	para "#MON storage"
	line "system."
	done

BillsComputerText:
	text "ld a, [hl]"
	line "ld e, a"
	
	cont "and <PERCENT>01010101"
	cont "ld d, a"
	
	cont "ld a, e"
	cont "srl a"
	
	cont "and <PERCENT>01010101"
	cont "and d"
	
	cont "cpl"
	cont "and <PERCENT>01010101"
	
	cont "add e"
	cont "ld [hli], a"
	
	cont "…"

	para "What are those"
	line "alien writings?"
	done

BillAskForCardText:
	text "BILL: Yo <PLAYER>!"

	para "Are you coming to"
	line "get a CONTACT"
	cont "TRACING CARD?"
	done

BillAllYouHadToSayText:
	text "It's all you"
	line "had to say."
	done

BillPrivacyConcernsText:
	text "Is it a privacy"
	line "concern?"

	para "All the data is"
	line "anonymized, don't"
	cont "worry about it."
	done

BillAutomaticText:
	text "No manual needed."
	line "It's all automated!"
	done

BillsFamilysHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 4
	warp_event  3,  7, GOLDENROD_CITY, 4

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, BillsHouseBookshelf2
	bg_event  1,  1, BGEVENT_READ, BillsHouseBookshelf1
	bg_event  7,  1, BGEVENT_READ, BillsHouseRadio

	def_object_events
	object_event  2,  3, SPRITE_BILL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BillScript, EVENT_MET_BILL
	object_event  5,  3, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BillsMomScript, -1
	object_event  5,  4, SPRITE_TWIN, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, BillsSisterScript, -1
	object_event  3,  3, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BillsComputerScript, EVENT_MET_BILL
