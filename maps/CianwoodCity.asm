	object_const_def
	const CIANWOODCITY_STANDING_YOUNGSTER
	const CIANWOODCITY_POKEFAN_M
	const CIANWOODCITY_LASS
	const CIANWOODCITY_ROCK1
	const CIANWOODCITY_ROCK2
	const CIANWOODCITY_ROCK3
	const CIANWOODCITY_ROCK4
	const CIANWOODCITY_ROCK5
	const CIANWOODCITY_ROCK6
	const CIANWOODCITY_POKEFAN_F
	const CIANWOODCITY_EUSINE
	const CIANWOODCITY_SUICUNE

CianwoodCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPointAndSuicune

.FlyPointAndSuicune:
	checkflag ENGINE_FLYPOINT_CIANWOOD
	iftrue .FlyPointSequel

	readmem wJohtoAddLevel
	addval 1
	writemem wJohtoAddLevel

	setflag ENGINE_FLYPOINT_CIANWOOD
.FlyPointSequel
	checkevent EVENT_MANIA_TOOK_SHUCKIE_OR_LET_YOU_KEEP_HIM
	iftrue .continue
	setevent EVENT_GAVE_SHUCKIE_BACK
.continue	
	checkevent EVENT_FOUGHT_EUSINE
	iffalse .Done
	disappear CIANWOODCITY_EUSINE
.Done:
	endcallback

CianwoodCitySuicuneAndEusine:
	setevent EVENT_EUSINE_IN_BURNED_TOWER
	turnobject PLAYER, UP
	showemote EMOTE_SHOCK, PLAYER, 15
	pause 15
	playsound SFX_WARP_FROM
	applymovement CIANWOODCITY_SUICUNE, CianwoodCitySuicuneApproachMovement
	turnobject PLAYER, DOWN
	pause 15
	playsound SFX_WARP_FROM
	applymovement CIANWOODCITY_SUICUNE, CianwoodCitySuicuneDepartMovement
	turnobject PLAYER, RIGHT
	disappear CIANWOODCITY_SUICUNE
	pause 10
	setscene SCENE_CIANWOODCITY_NOTHING
	clearevent EVENT_SAW_SUICUNE_ON_ROUTE_42
	setmapscene ROUTE_42, SCENE_ROUTE42_SUICUNE
	checkevent EVENT_FOUGHT_EUSINE
	iftrue .Done
	setevent EVENT_FOUGHT_EUSINE
	playmusic MUSIC_MYSTICALMAN_ENCOUNTER
	appear CIANWOODCITY_EUSINE
	applymovement CIANWOODCITY_EUSINE, CianwoodCityEusineApproachMovement
	opentext
	writetext EusineSuicuneText
	waitbutton
	closetext
	winlosstext EusineBeatenText, 0
	setlasttalked CIANWOODCITY_EUSINE
	loadtrainer MYSTICALMAN, EUSINE
	startbattle
	dontrestartmapmusic
	reloadmapafterbattle
	playmusic MUSIC_MYSTICALMAN_ENCOUNTER
	opentext
	writetext EusineAfterText
	waitbutton
	closetext
	turnobject PLAYER, DOWN
	applymovement CIANWOODCITY_EUSINE, CianwoodCityEusineDepartMovement
	disappear CIANWOODCITY_EUSINE
	pause 20
	special FadeOutMusic
	playmapmusic
	pause 10
.Done:
	end

CianwoodCityChucksWife:
	faceplayer
	opentext
	checkitem HM_FLY
	iftrue .GotFly
	writetext ChucksWifeEasierToFlyText
	promptbutton
	checkevent EVENT_BEAT_CHUCK
	iftrue .BeatChuck
	writetext ChucksWifeBeatChuckText
	waitbutton
	closetext
	end

.BeatChuck:
	writetext ChucksWifeGiveHMText
	promptbutton
	verbosegiveitem HM_FLY
	iffalse .Done
	writetext ChucksWifeFlySpeechText
	promptbutton
.GotFly:
	writetext ChucksWifeChubbyText
	waitbutton
.Done:
	closetext
	end

CianwoodCityYoungster:
	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, .lockdown
	ifequal 1 << CURFEW, .lockdown
	jumptextfaceplayer CianwoodCityYoungsterText

.lockdown
	jumptextfaceplayer Cianwood_NoPoliceControlsText

CianwoodCityPokefanM:
	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, .lockdown
	ifequal 1 << CURFEW, .lockdown
	jumptextfaceplayer CianwoodCityPokefanMText

.lockdown
	jumptextfaceplayer Cianwood_FreshAirText

CianwoodCityLass:
	checkevent EVENT_JASMINE_RETURNED_TO_GYM
	iftrue .PharmacistRanAway

	readmem wCurFreedomState
	ifequal 1 << LOCKDOWN, .lockdown
	ifequal 1 << CURFEW, .lockdown

	jumptextfaceplayer CianwoodCityLassText

.PharmacistRanAway
	jumptextfaceplayer PharmacistRanAwayText

.lockdown
	jumptextfaceplayer Cianwood_NoFaceMaskText

CianwoodCitySign:
	jumptext CianwoodCitySignText

CianwoodGymSign:
	jumptext CianwoodGymSignText

CianwoodPharmacySign:
	jumptext CianwoodPharmacySignText

CianwoodPhotoStudioSign:
	jumptext CianwoodPhotoStudioSignText

CianwoodPokeSeerSign:
	jumptext CianwoodPokeSeerSignText

CianwoodPokecenterSign:
	jumpstd PokecenterSignScript

CianwoodCityRock:
	jumpstd SmashRockScript

CianwoodCityHiddenRevive:
	hiddenitem REVIVE, EVENT_CIANWOOD_CITY_HIDDEN_REVIVE

CianwoodCityHiddenMaxEther:
	hiddenitem MAX_ETHER, EVENT_CIANWOOD_CITY_HIDDEN_MAX_ETHER

CianwoodCity_SchoolDoorScript:
	jumpstd ClosedBusinessScript

CianwoodCitySuicuneApproachMovement:
	set_sliding
	fast_jump_step DOWN
	fast_jump_step DOWN
	fast_jump_step RIGHT
	remove_sliding
	step_end

CianwoodCitySuicuneDepartMovement:
	set_sliding
	fast_jump_step RIGHT
	fast_jump_step UP
	fast_jump_step RIGHT
	fast_jump_step RIGHT
	remove_sliding
	step_end

CianwoodCityEusineApproachMovement:
	step UP
	step UP
	step UP
	step RIGHT
	step RIGHT
	step UP
	step UP
	turn_head RIGHT
	step_sleep 8
	step_sleep 8
	step_sleep 8
	turn_head LEFT
	step_end

CianwoodCityEusineDepartMovement:
	step DOWN
	step DOWN
	step LEFT
	step LEFT
	step DOWN
	step DOWN
	step DOWN
	step_end

ChucksWifeEasierToFlyText: 
if DEF(_FR_FR)
	text "Tu as traversé la"
	line "mer pour venir"

	para "ici. Ca a dû être"
	line "bien dur."

	para "Ce serait plus"
	line "facile si tes"

	para "#MON savaient"
	line "voler."
else
	text "You crossed the"
	line "sea to get here?"

	para "That must have"
	line "been hard."

	para "It would be much"
	line "easier if your"

	para "#MON knew how"
	line "to FLY…"
endc

	done

ChucksWifeBeatChuckText:
if DEF(_FR_FR)
	text "Si tu bats le"
	line "CHAMPION d'ARENE"
	cont "du coin, reviens"
	cont "me voir."

	para "J'aurai un joli"
	line "cadeau pour toi!"
	done
else
	text "If you beat the"
	line "GYM LEADER here,"
	cont "come see me."

	para "I'll have a nice"
	line "gift for you."
	done
endc


ChucksWifeGiveHMText:
if DEF(_FR_FR)
	text "C'est le BADGE de"
	line "l'ARENE D'IRISIA!"

	para "Voilà pour toi:"
	line "une CS."
	done
else
	text "That's CIANWOOD's"
	line "GYM BADGE!"

	para "As our tradition"
	line "obliges, please"
	cont "take this HM."
	done
endc


ChucksWifeFlySpeechText:
if DEF(_FR_FR)
	text "Apprends VOL à ton"
	line "#MON."

	para "Tu pourras voler"
	line "tout de suite et"

	para "te rendre dans"
	line "tous les endroits"
	cont "que tu as déjà"
	cont "visités."

	para "Mais comme tu le"
	line "sais, voler est"
	cont "interdit pour"
	cont "le moment à cause"
	cont "des restrictions"
	cont "de déplacement."

	para "Si toi ou ton"
	line "#MON êtes"
	cont "contaminés,"

	para "vous pourriez"
	line "propager le virus"
	cont "au loin."

	para "Tu risques"
	line "d'être arrêté si"
	cont "tu utilises VOL."

	para "A tes risques"
	line "et périls."
	done
else
	text "Teach FLY to your"
	line "#MON."

	para "You will be able"
	line "to FLY instantly"

	para "to anywhere you "
	line "have visited."

	para "However, as you"
	line "know, it is"
	
	para "currently forbid-"
	line "den to travel by"
	cont "the air."

	para "If you or your"
	line "#MON are sick,"

	para "you could bring"
	line "the virus to far"
	cont "away places."

	para "You may get"
	line "arrested for"
	cont "using FLY."

	para "Use it at you"
	line "own risks."
	done
endc


ChucksWifeChubbyText: 
if DEF(_FR_FR)
	text "Mon mari a perdu"
	line "face à toi, il"
	cont "doit donc encore"
	cont "s'entraîner!"

	para "Ca tombe bien!"
	line "Il est un peu gros"
	cont "en ce moment."
else
	text "My husband lost to"
	line "you, so he needs"
	cont "to train harder."

	para "That's good, since"
	line "he was getting a"
	cont "little chubby."
endc

	done

CianwoodCityPokefanMText: 
if DEF(_FR_FR)
	text "Des rochers au"
	line "Nord de la ville"
	cont "peuvent être"
	cont "écrasés."

	para "Ils cachent peut-"
	line "être quelque"
	cont "chose."

	para "Ton #MON peut"
	line "utiliser ECLATE-"
	cont "ROC pour les"
	cont "détruire."
else
	text "Boulders to the"
	line "north of town can"
	cont "be crushed."

	para "They may be hiding"
	line "something."

	para "Your #MON could"
	line "use ROCK SMASH to"
	cont "break them."
endc

	done

CianwoodCityLassText: 
if DEF(_FR_FR)
	text "CHUCK, le"
	line "CHAMPION d'ARENE"

	para "s'entraîne avec"
	line "ses #MON de"
	cont "type COMBAT."
else
	text "CHUCK, the GYM"
	line "LEADER, spars with"

	para "his fighting #-"
	line "MON."
endc

	done

PharmacistRanAwayText:
if DEF(_FR_FR)
	text "On avait un"
	line "pharmacien."

	para "Mais il est"
	line "parti soudain,"
	cont "sans prévenir."
	
	para "Louche, ce type."
	done
else
	text "We used to have"
	line "a pharmacist."

	para "But he suddenly"
	line "left without a"
	cont "word. Shady dude."
	done
endc

CianwoodCityYoungsterText:
if DEF(_FR_FR)
	text "Il y a plusieurs"
	line "îles entre ici"
	cont "et OLIVILLE."

	para "Une créature"
	line "marine mythique"
	cont "vivrait là-bas."
	done
else
	text "There are several"
	line "islands between"
	cont "here and OLIVINE."

	para "A mythical sea"
	line "creature supposed-"
	cont "ly lives there."
	done
endc

EusineSuicuneText:
if DEF(_FR_FR)
	text "EUSINE: Hé!"
	line "<PLAYER>!"

	para "C'était pas"
	line "SUICUNE?"

	para "Je l'ai juste"
	line "aperçu mais j'ai"

	para "vu SUICUNE courir"
	line "sur les vagues."

	para "Les pouvoirs de"
	line "SUICUNE pourraient"
	cont "aider la recherche"
	cont "sur le vaccin"
	cont "contre le COVID."

	para "Obtenir un"
	line "échantillon de"
	cont "son eau pourrait"
	cont "sauver des"
	cont "millions de vies."

	para "Je veux voir"
	line "SUICUNE de près..."

	para "C'est décidé."

	para "Je vais t'affron-"
	line "ter pour montrer"
	cont "mon talent à"
	cont "SUICUNE!"

	para "Mais si, c'est"
	line "logique!"
	cont "COMBAT!"
	done
else
	text "EUSINE: Yo,"
	line "<PLAYER>."

	para "Wasn't that"
	line "SUICUNE just now?"

	para "I only caught a"
	line "quick glimpse, but"

	para "I thought I saw"
	line "SUICUNE running on"
	cont "the waves."

	para "SUICUNE's powers"
	line "could help with"

	para "the research on"
	line "the COVID vaccine."

	para "Obtaining some of"
	line "its water could"

	para "save millions of"
	line "lives."

	para "I need to see"
	line "SUICUNE up close…"

	para "I've decided."

	para "I'll battle you as"
	line "a trainer to earn"
	cont "SUICUNE's respect!"

	para "Come on, <PLAYER>."
	line "Let's battle now!"
	done
endc

EusineBeatenText: 
if DEF(_FR_FR)
	text "Bon d'accord."
	line "J'ai perdu."
else
	text "I hate to admit"
	line "it, but you win."
endc

	done

EusineAfterText: 
if DEF(_FR_FR)
	text "Tu es formidable,"
	line "<PLAYER>!"

	para "Les #MON"
	line "doivent t'adorer."

	para "Je comprends tout."

	para "Je vais encore"
	line "traquer le grand"
	cont "SUICUNE."

	para "On se reverra."

	para "A bientôt!"
else
	text "You're amazing,"
	line "<PLAYER>!"

	para "No wonder #MON"
	line "gravitate to you."

	para "I get it now."

	para "I'm going to keep"
	line "searching for"
	cont "SUICUNE."

	para "I'm sure we'll see"
	line "each other again."

	para "See you around!"
endc

	done

CianwoodCitySignText: 
if DEF(_FR_FR)
	text "IRISIA"

	para "Un port entouré"
	line "d'une mer bien"
	cont "déchaînée"
else
	text "CIANWOOD CITY"

	para "A Port Surrounded"
	line "by Rough Seas"
endc

	done

CianwoodGymSignText: 
if DEF(_FR_FR)
	text "CHAMPION d'ARENE"
	line "d'IRISIA: CHUCK"

	para "Ses poings parlent"
	line "pour lui"
else
	text "CIANWOOD CITY"
	line "#MON GYM"

	para "LEADER: CHUCK"

	para "His Roaring Fists"
	line "Do the Talking"
endc

	done

CianwoodPharmacySignText: 
if DEF(_FR_FR)
	text "500 ans de"
	line "Tradition"

	para "PHARMACIE d'IRISIA"

	para "Malades..."
	line "Venez nombreux!"
else
	text "500 Years of"
	line "Tradition"

	para "CIANWOOD CITY"
	line "PHARMACY"

	para "We Await Your"
	line "Medicinal Queries"
endc

	done

CianwoodPhotoStudioSignText: 
if DEF(_FR_FR)
	text "STUDIO PHOTO"
	line "D'IRISIA"

	para "Une petite photo"
	line "souvenir!"
else
	text "CIANWOOD CITY"
	line "PHOTO STUDIO"

	para "Take a Snapshot as"
	line "a Keepsake!"
endc

	done

CianwoodPokeSeerSignText: 
if DEF(_FR_FR)
	text "#DEVIN"
	line "TOUT DROIT"
else
	text "THE # SEER"
	line "AHEAD"
endc

	done

Cianwood_NoFaceMaskText:
if DEF(_FR_FR)
	text "Je porterai pas"
	line "de masque."

	para "Je n'ai jamais vu"
	line "le COVID, alors"
	cont "j'y crois pas."
	done
else
	text "I won't wear"
	line "a face mask."

	para "I've never seen"
	line "COVID, and I don't"
	cont "believe in it."
	done
endc

Cianwood_NoPoliceControlsText:
if DEF(_FR_FR)
	text "La police ne"
	line "s'embête pas à"
	cont "contrôler une"
	cont "région si reculée."

	para "Alors les gens"
	line "d'ici sortent"
	cont "à l'extérieur,"
	cont "malgré l'interdit."
	done
else
	text "The police doesn't"
	line "bother control-"
	cont "ling such a"
	cont "remote area."

	para "So people of this"
	line "town keep going"
	cont "out even though"
	cont "it's forbidden."
	done
endc

Cianwood_FreshAirText:
if DEF(_FR_FR)
	text "L'air frais"
	line "fait du bien!"

	para "Quand je pense"
	line "que tout le monde"
	cont "est enfermé, je me"
	cont "sens chanceux."

	para "(tousse)"
	done
else
	text "The fresh air"
	line "feels good!"

	para "When I think that"
	line "everyone else is"
	
	para "currently locked"
	line "inside, I'm"
	cont "feeling lucky."

	para "(cough)"
	done
endc

CianwoodCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 17, 41, MANIAS_HOUSE, 1
	warp_event  8, 43, CIANWOOD_GYM, 1
	warp_event 23, 43, CIANWOOD_POKECENTER_1F, 1
	warp_event 15, 47, CIANWOOD_PHARMACY, 1
	warp_event  9, 31, CIANWOOD_PHOTO_STUDIO, 1
	warp_event 15, 37, CIANWOOD_LUGIA_SPEECH_HOUSE, 1
	warp_event  5, 17, POKE_SEERS_HOUSE, 1

	def_coord_events
	coord_event 11, 16, CE_SCENE_ID, SCENE_CIANWOODCITY_SUICUNE_AND_EUSINE, CianwoodCitySuicuneAndEusine

	def_bg_events
	bg_event 20, 34, BGEVENT_READ, CianwoodCitySign
	bg_event  7, 45, BGEVENT_READ, CianwoodGymSign
	bg_event 24, 43, BGEVENT_READ, CianwoodPokecenterSign
	bg_event 19, 47, BGEVENT_READ, CianwoodPharmacySign
	bg_event  8, 32, BGEVENT_READ, CianwoodPhotoStudioSign
	bg_event  8, 24, BGEVENT_READ, CianwoodPokeSeerSign
	bg_event  4, 19, BGEVENT_ITEM, CianwoodCityHiddenRevive
	bg_event  5, 29, BGEVENT_ITEM, CianwoodCityHiddenMaxEther

	def_object_events
	object_event 21, 37, SPRITE_YOUNGSTER, CLAP_F | SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CianwoodCityYoungster, -1
	object_event 17, 33, SPRITE_POKEFAN_M, CLAP_F | SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodCityPokefanM, -1
	object_event 14, 42, SPRITE_LASS, CLAP_F | SPRITEMOVEDATA_WALK_UP_DOWN, 0, 2, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodCityLass, -1
	object_event  8, 16, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodCityRock, -1
	object_event  9, 17, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodCityRock, -1
	object_event  4, 25, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodCityRock, -1
	object_event  5, 29, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodCityRock, -1
	object_event 10, 27, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodCityRock, -1
	object_event  4, 19, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodCityRock, -1
	object_event 10, 46, SPRITE_POKEFAN_F, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, CianwoodCityChucksWife, -1
	object_event 11, 21, SPRITE_EUSINE, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_CIANWOOD_CITY_EUSINE
	object_event 10, 14, SPRITE_SUICUNE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_SAW_SUICUNE_AT_CIANWOOD_CITY
