	object_const_def
	const LAVRADIOTOWER1F_RECEPTIONIST
	const LAVRADIOTOWER1F_OFFICER
	const LAVRADIOTOWER1F_SUPER_NERD1
	const LAVRADIOTOWER1F_GENTLEMAN
	const LAVRADIOTOWER1F_SUPER_NERD2

LavRadioTower1F_MapScripts:
	def_scene_scripts

	def_callbacks

LavRadioTower1FReceptionistScript:
	jumptextfaceplayer LavRadioTower1FReceptionistText

LavRadioTower1FOfficerScript:
	jumptextfaceplayer LavRadioTower1FOfficerText

LavRadioTower1FSuperNerd1Script:
	jumptextfaceplayer LavRadioTower1FSuperNerd1Text

LavRadioTower1FGentlemanScript:
	faceplayer
	opentext
	checkflag ENGINE_EXPN_CARD
	iftrue .GotExpnCard
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .ReturnedMachinePart
	writetext LavRadioTower1FGentlemanText
	waitbutton
	closetext
	end

.ReturnedMachinePart:
	writetext LavRadioTower1FGentlemanText_ReturnedMachinePart
	promptbutton

	checkflag ENGINE_RADIO_CARD
	iffalse .GoFetchRadioCard

	getstring STRING_BUFFER_4, .expncardname
	scall .receiveitem
	setflag ENGINE_EXPN_CARD
	
.GotExpnCard:
	clearevent EVENT_FETCH_RADIO_CARD
	writetext LavRadioTower1FGentlemanText_GotExpnCard
	waitbutton
	closetext
	end

.GoFetchRadioCard:
	closetext
	pause 5
	showemote EMOTE_QUESTION, LAVRADIOTOWER1F_GENTLEMAN, 15
	pause 5
	opentext
	writetext LavRadioTower1FGentlemanText_GiveRadioCard
	waitbutton
	closetext
	setevent EVENT_FETCH_RADIO_CARD
	end

.receiveitem:
	jumpstd ReceiveItemScript

.expncardname 
if DEF(_FR_FR)
	db "CPN EXPAN.@"

else
	db "EXPN CARD@"

endc

.RadioCardText:
if DEF(_FR_FR)
	db "COUPON RADIO@"
else
	db "RADIO CARD@"
endc

LavRadioTower1FSuperNerd2Script:
	faceplayer
	opentext
	checkflag ENGINE_EXPN_CARD
	iftrue .GotExpnCard
	writetext LavRadioTower1FSuperNerd2Text
	waitbutton
	closetext
	end

.GotExpnCard:
	writetext LavRadioTower1FSuperNerd2Text_GotExpnCard
	waitbutton
	closetext
	end

LavRadioTower1FDirectory:
	jumptext LavRadioTower1FDirectoryText

LavRadioTower1FPokeFluteSign:
	jumptext LavRadioTower1FPokeFluteSignText

LavRadioTower1FReceptionistText: 
if DEF(_FR_FR)
	text "Bienvenue!"
	line "Tu peux visiter"

	para "cet étage tant que"
	line "tu le veux."
else
	text "Welcome!"
	line "Feel free to look"

	para "around anywhere on"
	line "this floor."
endc

	done

LavRadioTower1FOfficerText: 
if DEF(_FR_FR)
	text "Seul le rez-de-"
	line "chaussée est à"
	cont "visiter."

	para "Depuis l'attaque"
	line "de la TOUR RADIO"

	para "de JOHTO par un"
	line "gang criminel, on"

	para "a renforcé les me-"
	line "sures de sécurité."
else
	text "Sorry, but you can"
	line "only tour the"
	cont "ground floor."

	para "Ever since JOHTO's"
	line "RADIO TOWER was"

	para "taken over by a"
	line "criminal gang, we"

	para "have had to step"
	line "up our security."
endc

	done

LavRadioTower1FSuperNerd1Text: 
if DEF(_FR_FR)
	text "Les gens travail-"
	line "lent dur ici, à"
	cont "la TOUR RADIO."

	para "Ils se donnent à"
	line "fond pour faire"
	cont "de bonnes émis-"
	cont "sions."
else
	text "Many people are"
	line "hard at work here"

	para "in the RADIO"
	line "TOWER."

	para "They must be doing"
	line "their best to put"
	cont "on good shows."
endc

	done

LavRadioTower1FGentlemanText: 
if DEF(_FR_FR)
	text "Oh, non, non, non!"

	para "Nous ne sommes"
	line "plus à l'antenne"

	para "depuis la fermetu-"
	line "re de la CENTRALE."

	para "Je cours à la ca-"
	line "tastrophe si je ne"
	cont "peux plus émettre!"

	para "J'suis ruiné!"
else
	text "Oh, no, no, no!"

	para "We've been off the"
	line "air ever since the"

	para "POWER PLANT shut"
	line "down."

	para "All my efforts to"
	line "start this station"

	para "would be wasted if"
	line "I can't broadcast."

	para "I'll be ruined!"
endc

	done

LavRadioTower1FGentlemanText_ReturnedMachinePart: 
if DEF(_FR_FR)
	text "Ah! C'est toi"
	line "<PLAY_G> qui a"

	para "réparé la"
	line "CENTRALE?"

	para "Grâce à toi, j'ai"
	line "pu garder mon job."
	cont "Tu es trop cool!"

	para "Prends ça!"
else
	text "Ah! So you're the"
	line "<PLAY_G> who solved"

	para "the POWER PLANT's"
	line "problem?"

	para "Thanks to you, I"
	line "never lost my job."

	para "I tell you, you're"
	line "a real lifesaver!"

	para "Please take this"
	line "as my thanks."
endc

	done

LavRadioTower1FGentlemanText_GiveRadioCard: ; TO TRANSLATE
	text "Your #GEAR"
	line "doesn't have the"
	cont "radio?"

	para "It saddens me."

	para "Go get it!"
	line "There's an elec-"
	cont "tronics shop at"

	para "NEON TOWN in"
	line "SAFFRON CITY."

	para "Tell the owner you"
	line "were sent by me."
	done

LavRadioTower1FGentlemanText_GotExpnCard: 
if DEF(_FR_FR)
	text "Avec ceci, tu peux"
	line "écouter la radio"
	cont "depuis KANTO."

	para "Gahahahaha!"
else
	text "With that thing,"
	line "you can tune into"

	para "the radio programs"
	line "here in KANTO."

	para "Gahahahaha!"
endc

	done

LavRadioTower1FSuperNerd2Text: 
if DEF(_FR_FR)
	text "Hé toi!"

	para "Je suis le"
	line "DIRECTEUR MUSICAL!"

	para "Hein? Ton #-"
	line "MATOS ne peut pas"

	para "capter les émis-"
	line "sions de radio..."
	cont "Quel dommage!"

	para "Avec un CPN EXPAN,"
	line "tu peux améliorer"

	para "ton matériel!"
	line "Va en trouver un!"
else
	text "Hey there!"

	para "I am the super"
	line "MUSIC DIRECTOR!"

	para "Huh? Your #GEAR"
	line "can't tune into my"

	para "music programs."
	line "How unfortunate!"

	para "If you get an EXPN"
	line "CARD upgrade, you"

	para "can tune in. You'd"
	line "better get one!"
endc

	done

LavRadioTower1FSuperNerd2Text_GotExpnCard: 
if DEF(_FR_FR)
	text "Hé toi!"

	para "Je suis le"
	line "DIRECTEUR MUSICAL!"

	para "Je suis à l'origi-"
	line "ne des belles mé-"

	para "lodies diffusées"
	line "à l'antenne."

	para "Alors écoute bien"
	line "nos belles"
	cont "émissions!"
else
	text "Hey there!"

	para "I am the super"
	line "MUSIC DIRECTOR!"

	para "I'm responsible"
	line "for the gorgeous"

	para "melodies that go"
	line "out over the air."

	para "Don't be square."
	line "Grab your music"
	cont "off the air!"
endc

	done

LavRadioTower1FDirectoryText: 
if DEF(_FR_FR)
	text "RDC  RECEPTION"
	line "1ER  VENTES"

	para "2EME PERSONNEL"
	line "3EME PRODUCTION"

	para "4EME BUREAU"
	line "     DIRECTION"
else
	text "1F RECEPTION"
	line "2F SALES"

	para "3F PERSONNEL"
	line "4F PRODUCTION"

	para "5F DIRECTOR'S"
	line "   OFFICE"
endc

	done

LavRadioTower1FPokeFluteSignText: 
if DEF(_FR_FR)
	text "Animez vos #MON"
	line "avec des sons de"

	para "# FLUTE sur"
	line "l'ANTENNE 20"
else
	text "Perk Up #MON"
	line "with Mellow Sounds"

	para "of the # FLUTE"
	line "on CHANNEL 20"
endc

	done

LavRadioTower1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, LAVENDER_TOWN, 7
	warp_event  3,  7, LAVENDER_TOWN, 7

	def_coord_events

	def_bg_events
	bg_event 11,  0, BGEVENT_READ, LavRadioTower1FDirectory
	bg_event  5,  0, BGEVENT_READ, LavRadioTower1FPokeFluteSign

	def_object_events
	object_event  6,  6, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, LavRadioTower1FReceptionistScript, -1
	object_event 15,  1, SPRITE_OFFICER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, LavRadioTower1FOfficerScript, -1
	object_event  1,  3, SPRITE_SUPER_NERD, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, LavRadioTower1FSuperNerd1Script, -1
	object_event  9,  1, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LavRadioTower1FGentlemanScript, -1
	object_event 14,  6, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, LavRadioTower1FSuperNerd2Script, -1
