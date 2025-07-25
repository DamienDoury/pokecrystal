	object_const_def
	const BILLSFAMILYSHOUSE_BILL
	const BILLSFAMILYSHOUSE_POKEFAN_F
	const BILLSFAMILYSHOUSE_TWIN

BillsFamilysHouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .TilesLoad
	callback MAPCALLBACK_OBJECTS, .CheckClapping

.CheckClapping:
	callasm IsClappingAuthorizedScript
	iffalse .end

	moveobject BILLSFAMILYSHOUSE_POKEFAN_F, 5, 1
	loadmem wMap2ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_UP
.end
	endcallback

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
	clearevent EVENT_CONTACT_TRACING_NOTIFICATION_DISPLAY ; The device couldn't receive notifications before it was installed.
	sjump .endText

.refused
	writetext BillPrivacyConcernsText
	waitbutton
.endText
	closetext
	end

.contactTracingCardText
if DEF(_FR_FR)
	db "TRAçAGE CONTACTS@"
else
	db "CONTACT TRACING@"
endc

BillsMomScript:
	checkevent EVENT_MET_BILL
	iffalse .HaventMetBill

	jumptextfaceplayer BillsMomText_BeforeEcruteak

.HaventMetBill:
	jumptextfaceplayer BillsMomText_AfterEcruteak

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
if DEF(_FR_FR)
	text "LEO: Salut"
	line "<PLAYER>!"

	para "As-tu remarqué que"
	line "le PC ne restaure"
	cont "plus les PP de"
	cont "tes #MON?"

	para "J'ai dû couper"
	line "cette routine"
	cont "pour éviter que"
	cont "le COVID ne se"
	cont "propage dans le"
	cont "PC."

	para "Je ne sais pas"
	line "si c'est vraiment"
	cont "efficace, mais je"
	cont "ne veux courir"
	cont "aucun risque!"
	done
else
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
endc

BillsMomText_BeforeEcruteak:
if DEF(_FR_FR)
	text "Tu collectionnes"
	line "les #MON?"
	cont "Mon fils LEO est"
	cont "un expert."

	para "Il est allé au"
	line "CENTRE #MON"
	cont "de ROSALIA."
else
	text "Oh, you collect"
	line "#MON? My son"
	cont "BILL is an expert."

	para "He just got called"
	line "to the #MON"

	para "CENTER in ECRUTEAK"
	line "CITY."
	done
endc

BillsMomText_AfterEcruteak: 
if DEF(_FR_FR)
	text "Mon tendre époux"
	line "était jadis un"

	para "#MANIAC."
	line "LEO doit tenir"
	cont "de lui."
else
	text "My husband was"
	line "once known as a"

	para "#MANIAC."
	line "BILL must have"

	para "taken after his"
	line "father."
endc

	done

BillsSisterUsefulNumberText: 
if DEF(_FR_FR)
	text "Es-tu dresseur?"

	para "J'ai un numéro de"
	line "téléphone utile"
	cont "pour toi."
else
	text "Are you a trainer?"

	para "I've got a useful"
	line "phone number for"
	cont "you."
endc

	done

RecordedBillsNumberText: 
if DEF(_FR_FR)
	text "<PLAYER> enregistre"
	line "le numéro de télé-"
	cont "phone de LEO."
else
	text "<PLAYER> recorded"
	line "BILL's number."
endc

	done

BillsSisterRefusedNumberText: 
if DEF(_FR_FR)
	text "Mon frère a créé"
	line "un système de"
	cont "stockage pour les"
	cont "#MON par PC."

	para "J'allais te donner"
	line "le numéro de télé-"
	cont "phone de LEO..."
else
	text "My brother made"
	line "the PC #MON"
	cont "storage system."

	para "I was going to"
	line "give you BILL's"
	cont "number…"
endc

	done

BillsSisterPhoneFullText: 
if DEF(_FR_FR)
	text "Mais tu ne peux"
	line "plus enregistrer"
	cont "de numéros!"
else
	text "You can't record"
	line "any more numbers."
endc

	done

BillsSisterStorageSystemText: 
if DEF(_FR_FR)
	text "Mon grand frère"
	line "LEO a fait un"

	para "super système de"
	line "stockage de #-"
	cont "MON par PC."
else
	text "My big brother"
	line "BILL made the PC"

	para "#MON storage"
	line "system."
endc

	done

BillsComputerText:
if DEF(_FR_FR)
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

	para "C'est quoi ce"
	line "langage extra-"
	cont "terrestre?"
	done
else
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
endc

BillAskForCardText:
if DEF(_FR_FR)
	text "LEO: Yo <PLAYER>!"
	
	para "Tu viens chercher"
	line "un COUPON TRAçAGE?"
	done
else
	text "BILL: Yo <PLAYER>!"
	
	para "Are you coming to"
	line "get a CONTACT"
	cont "TRACING CARD?"
	done
endc


BillAllYouHadToSayText:
if DEF(_FR_FR)
	text "Y'a qu'à demander!"
	done
else
	text "It's all you"
	line "had to say."
	done
endc

BillPrivacyConcernsText:
if DEF(_FR_FR)
	text "Est-ce une menace"
	line "pour ta vie"
	cont "privée?"
	
	para "Toutes les données"
	line "sont anonymisées,"
	cont "ne t'en fais pas."
	done
else
	text "Is it a privacy"
	line "concern?"
	
	para "All the data is"
	line "anonymized, don't"
	cont "worry about it."
	done
endc

BillAutomaticText:
if DEF(_FR_FR)
	text "Pas besoin de"
	line "manuel."
	
	para "Tout est"
	line "automatique!"
	done
else
	text "No manual needed."
	line "It's all automated!"
	done
endc

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
	object_event  5,  3, SPRITE_POKEFAN_F, CLAP_F | SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BillsMomScript, -1
	object_event  5,  4, SPRITE_TWIN, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, BillsSisterScript, -1
	object_event  3,  3, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, BillsComputerScript, EVENT_MET_BILL
