	object_const_def
	const POKEMONFANCLUB_CHAIRMAN
	const POKEMONFANCLUB_RECEPTIONIST
	const POKEMONFANCLUB_CLEFAIRY_GUY
	const POKEMONFANCLUB_TEACHER
	const POKEMONFANCLUB_FAIRY
	const POKEMONFANCLUB_ODDISH

PokemonFanClub_MapScripts:
	def_scene_scripts

	def_callbacks

PokemonFanClubChairmanScript:
	faceplayer
	opentext
	checkevent EVENT_LISTENED_TO_FAN_CLUB_PRESIDENT
	iftrue .HeardSpeech
	checkevent EVENT_LISTENED_TO_FAN_CLUB_PRESIDENT_BUT_BAG_WAS_FULL
	iftrue .HeardSpeechButBagFull
	writetext PokemonFanClubChairmanDidYouVisitToHearAboutMyMonText
	yesorno
	iffalse .NotListening
	writetext PokemonFanClubChairmanRapidashText
	promptbutton
.HeardSpeechButBagFull:
	writetext PokemonFanClubChairmanIWantYouToHaveThisText
	promptbutton
	verbosegiveitem RARE_CANDY
	iffalse .BagFull
	setevent EVENT_LISTENED_TO_FAN_CLUB_PRESIDENT
	writetext PokemonFanClubChairmanItsARareCandyText
	waitbutton
	closetext
	end

.HeardSpeech:
	writetext PokemonFanClubChairmanMoreTalesToTellText
	waitbutton
	closetext
	end

.NotListening:
	writetext PokemonFanClubChairmanHowDisappointingText
	waitbutton
.BagFull:
	closetext
	end

PokemonFanClubReceptionistScript:
	jumptextfaceplayer PokemonFanClubReceptionistText

PokemonFanClubClefairyGuyScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_LOST_ITEM_FROM_FAN_CLUB
	iftrue .GotLostItem
	checkevent EVENT_RETURNED_MACHINE_PART
	iftrue .FoundClefairyDoll
	writetext PokemonFanClubClefairyGuyClefairyIsSoAdorableText
	waitbutton
	closetext
	end

.FoundClefairyDoll:
	writetext PokemonFanClubClefairyGuyMakingDoWithADollIFoundText
	checkevent EVENT_MET_COPYCAT_FOUND_OUT_ABOUT_LOST_ITEM
	iftrue .MetCopycat
	waitbutton
	closetext
	end

.MetCopycat:
	promptbutton
	writetext PokemonFanClubClefairyGuyTakeThisDollBackToGirlText
	promptbutton
	waitsfx
	giveitem LOST_ITEM
	iffalse .NoRoom
	disappear POKEMONFANCLUB_FAIRY
	writetext PokemonFanClubPlayerReceivedDollText
	playsound SFX_KEY_ITEM
	waitsfx
	itemnotify
	setevent EVENT_GOT_LOST_ITEM_FROM_FAN_CLUB
	closetext
	end

.GotLostItem:
	writetext PokemonFanClubClefairyGuyGoingToGetARealClefairyText
	waitbutton
	closetext
	end

.NoRoom:
	writetext PokemonFanClubClefairyGuyPackIsJammedFullText
	waitbutton
	closetext
	end

PokemonFanClubTeacherScript:
	jumptextfaceplayer PokemonFanClubTeacherText

PokemonFanClubClefairyDollScript:
	jumptext PokemonFanClubClefairyDollText

PokemonFanClubChikoritaScript:
	opentext
	writetext PokemonFanClubChikoritaText
	cry CHIKORITA
	waitbutton
	closetext
	end

PokemonFanClubListenSign:
	jumptext PokemonFanClubListenSignText

PokemonFanClubBraggingSign:
	jumptext PokemonFanClubBraggingSignText

PokemonFanClubChairmanDidYouVisitToHearAboutMyMonText: 
if DEF(_FR_FR)
	text "Je suis le PRESI-"
	line "DENT du FAN CLUB"
	cont "#MON."

	para "J'ai élevé plus de"
	line "150 #MON."

	para "Je suis très dif-"
	line "ficile quand il"
	cont "s'agit de"
	cont "#MON."

	para "Tu es ici pour"
	line "en apprendre plus"
	cont "sur mes #MON?"
else
	text "I'm the CHAIRMAN"
	line "of the #MON FAN"
	cont "CLUB."

	para "I've raised over"
	line "150 #MON."

	para "I'm very fussy"
	line "when it comes to"
	cont "#MON."

	para "Did you visit just"
	line "to hear about my"
	cont "#MON?"
endc

	done

PokemonFanClubChairmanRapidashText: 
if DEF(_FR_FR)
	text "Bien!"
	line "Alors, écoute!"

	para "Mon préféré..."
	line "GALOPA..."

	para "Il est mignon..."
	line "beau...rapide..."
	cont "élégant...en feu."
	cont "Il fait pataclop,"
	cont "pataclop...quand"
	cont "il court...c'est"
	cont "super non?"
	cont "Je l'aime...!"

	para "Je lui fais...des"
	line "câlins...des..."
	cont "poutoux...des..."
	cont "gnangnans...des"
	cont "zigouzigoux..."
	cont "...Oups! Regarde"
	cont "l'heure! Je crois"
	cont "qu'il est temps"
	cont "d'y aller!"
else
	text "Good!"
	line "Then listen up!"

	para "So… my favorite"
	line "RAPIDASH…"

	para "It… cute… lovely…"
	line "smart… unbearably…"
	cont "plus… amazing… oh…"
	cont "you think so?…"
	cont "Too much… wild…"
	cont "beautiful… kindly…"
	cont "love it!"

	para "Hug it… when…"
	line "sleeping… warm and"
	cont "cuddly… Oh, and…"
	cont "spectacular…"
	cont "ravishing… simply"
	cont "divine…"
	cont "Oops! Look at the"
	cont "time! I've kept"
	cont "you too long!"
endc

	done

PokemonFanClubChairmanIWantYouToHaveThisText: 
if DEF(_FR_FR)
	text "Merci de m'avoir"
	line "écouté..."
	cont "Voilà pour toi!"
else
	text "Thanks for hearing"
	line "me out. I want you"
	cont "to have this!"
endc

	done

PokemonFanClubChairmanItsARareCandyText: 
if DEF(_FR_FR)
	text "C'est un SUPER"
	line "BONBON qui rend"
	cont "les #MON plus"
	cont "forts."

	para "Moi je préfère les"
	line "renforcer en fai-"

	para "sant des combats."
	line "Il est pour toi."
else
	text "It's a RARE CANDY"
	line "that makes #MON"
	cont "stronger."

	para "I prefer making my"
	line "#MON stronger"

	para "by battling, so"
	line "you can have it."
endc

	done

PokemonFanClubChairmanMoreTalesToTellText: 
if DEF(_FR_FR)
	text "Salut, <PLAY_G>!"

	para "Tu es ici pour en"
	line "apprendre encore"
	cont "sur mes #MON?"

	para "Non? Oh..."
	line "J'avais de belles"
	cont "histoires..."
else
	text "Hello, <PLAY_G>!"

	para "Did you come see"
	line "me about my #-"
	cont "MON again?"

	para "No? Oh… I had more"
	line "tales to tell…"
endc

	done

PokemonFanClubChairmanHowDisappointingText: 
if DEF(_FR_FR)
	text "Dommage..."

	para "Reviens me voir"
	line "vite."
else
	text "How disappointing…"

	para "Come back if you"
	line "want to listen."
endc

	done

PokemonFanClubReceptionistText: 
if DEF(_FR_FR)
	text "Notre PRESIDENT"
	line "parle un peu trop"
	cont "de ses #MON..."
else
	text "Our CHAIRMAN is"
	line "very vocal when it"
	cont "comes to #MON…"
endc

	done

PokemonFanClubClefairyGuyClefairyIsSoAdorableText: 
if DEF(_FR_FR)
	text "J'aime quand"
	line "MELOFEE gigote son"

	para "doigt quand il"
	line "utilise son"

	para "METRONOME."
	line "C'est adorable!"
else
	text "I love the way"
	line "CLEFAIRY waggles"

	para "its finger when"
	line "it's trying to use"

	para "METRONOME."
	line "It's so adorable!"
endc

	done

PokemonFanClubClefairyGuyMakingDoWithADollIFoundText: 
if DEF(_FR_FR)
	text "J'aime MELOFEE,"
	line "mais je ne pourrai"

	para "jamais en attraper"
	line "un... Alors je"

	para "m'amuse avec cette"
	line "# POUPEE."
else
	text "I love CLEFAIRY,"
	line "but I could never"

	para "catch one. So I'm"
	line "making do with a"

	para "# DOLL that I"
	line "found."
endc

	done

PokemonFanClubClefairyGuyTakeThisDollBackToGirlText: 
if DEF(_FR_FR)
	text "Oh, je vois. La"
	line "fille qui a perdu"

	para "sa # POUPEE"
	line "est triste..."

	para "OK. Peux-tu porter"
	line "cette # POUPEE"

	para "à la pauvre petite"
	line "fille triste?"

	para "Je trouverai un"
	line "vrai MELOFEE..."
else
	text "Oh, I see now. The"
	line "girl who lost this"

	para "# DOLL is sad…"

	para "OK. Could you take"
	line "this # DOLL"

	para "back to that poor"
	line "little girl?"

	para "I'll befriend a"
	line "real CLEFAIRY on"

	para "my own one day."
	line "No worries!"
endc

	done

PokemonFanClubPlayerReceivedDollText: 
if DEF(_FR_FR)
	text "<PLAYER> reçoit"
	line "la # POUPEE."
else
	text "<PLAYER> received"
	line "# DOLL."
endc

	done

PokemonFanClubClefairyGuyGoingToGetARealClefairyText: 
if DEF(_FR_FR)
	text "J'attraperai un"
	line "MELOFEE et il sera"

	para "mon ami pour la"
	line "vie."
else
	text "You watch. I'm"
	line "going to get a"

	para "real CLEFAIRY as"
	line "my friend."
endc

	done

PokemonFanClubClefairyGuyPackIsJammedFullText: 
if DEF(_FR_FR)
	text "Ton SAC est plein."
else
	text "Your PACK is"
	line "jammed full."
endc

	done

PokemonFanClubTeacherText:
if DEF(_FR_FR)
	text "Regarde donc mon"
	line "GERMIGNON!"

	para "La feuille sur sa"
	line "tête est mignonne!"
else
	text "Look at my darling"
	line "CHIKORITA!"

	para "The leaf on its"
	line "head is so cute!"
endc
	done

PokemonFanClubClefairyDollText: 
if DEF(_FR_FR)
	text "C'est un MELOFEE!"
	line "Hein?"

	para "Ah, d'accord."
	line "C'est une #"
	cont "POUPEE d'un"
	cont "MELOFEE."
else
	text "It's a CLEFAIRY!"
	line "Huh?"

	para "Oh, right. It's a"
	line "CLEFAIRY #"
	cont "DOLL."
endc

	done

PokemonFanClubChikoritaText:
if DEF(_FR_FR)
	text "GERMIGNON: Mi"
	line "miiii!"
else
	text "CHIKORITA: Chi"
	line "chiii!"
endc
	done

PokemonFanClubListenSignText: 
if DEF(_FR_FR)
	text "Ecoutons tous"
	line "les autres"
	cont "dresseurs."
else
	text "Let's all listen"
	line "politely to other"
	cont "trainers."
endc

	done

PokemonFanClubBraggingSignText: 
if DEF(_FR_FR)
	text "Si quelqu'un se"
	line "vante, vante-toi"
	cont "à ton tour!"
else
	text "If someone brags,"
	line "brag right back!"
endc

	done

PokemonFanClub_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, VERMILION_CITY, 3
	warp_event  3,  7, VERMILION_CITY, 3

	def_coord_events

	def_bg_events
	bg_event  7,  0, BGEVENT_READ, PokemonFanClubListenSign
	bg_event  9,  0, BGEVENT_READ, PokemonFanClubBraggingSign

	def_object_events
	object_event  4,  1, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PokemonFanClubChairmanScript, -1
	object_event  5,  1, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, PokemonFanClubReceptionistScript, -1
	object_event  2,  3, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PokemonFanClubClefairyGuyScript, -1
	object_event  7,  2, SPRITE_TEACHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PokemonFanClubTeacherScript, -1
	object_event  2,  4, SPRITE_CLEFAIRY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, PokemonFanClubClefairyDollScript, EVENT_VERMILION_FAN_CLUB_DOLL
	object_event  7,  3, SPRITE_CHIKORITA, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, PokemonFanClubChikoritaScript, -1
