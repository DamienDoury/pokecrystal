	object_const_def
	const MRPOKEMONSHOUSE_GENTLEMAN
	const MRPOKEMONSHOUSE_OAK

MrPokemonsHouse_MapScripts:
	def_scene_scripts
	scene_script .MeetMrPokemon ; SCENE_ALWAYS

	def_callbacks

.MeetMrPokemon:
	checkevent EVENT_MR_POKEMONS_HOUSE_OAK
	iftrue .end

	prioritysjump .MrPokemonEvent
.end
	end

.MrPokemonEvent:
	showemote EMOTE_SHOCK, MRPOKEMONSHOUSE_GENTLEMAN, 15
	turnobject MRPOKEMONSHOUSE_GENTLEMAN, DOWN
	opentext
	writetext MrPokemonIntroText1
	waitbutton
	closetext
	applymovement PLAYER, MrPokemonsHouse_PlayerWalksToMrPokemon
	opentext
	writetext MrPokemonIntroText2
	promptbutton
	waitsfx
	giveitem MYSTERY_EGG
	writetext MrPokemonsHouse_GotEggText
	playsound SFX_KEY_ITEM
	waitsfx
	itemnotify
	setevent EVENT_GOT_COVID_SAMPLE_FROM_MR_POKEMON
	blackoutmod CHERRYGROVE_CITY
	writetext MrPokemonIntroText3
	promptbutton
	turnobject MRPOKEMONSHOUSE_GENTLEMAN, RIGHT
	writetext MrPokemonIntroText4
	turnobject MRPOKEMONSHOUSE_GENTLEMAN, RIGHT
	turnobject MRPOKEMONSHOUSE_OAK, LEFT
	waitbutton
	closetext
	sjump MrPokemonsHouse_OakScript

MrPokemonsHouse_MrPokemonScript:
	faceplayer
	opentext
	checkitem RED_SCALE
	iftrue .RedScale
	checkevent EVENT_GAVE_COVID_SAMPLE_TO_ELM
	iftrue .AlwaysNewDiscoveries
	writetext MrPokemonText_ImDependingOnYou
	waitbutton
	closetext
	end

.AlwaysNewDiscoveries:
	writetext MrPokemonText_AlwaysNewDiscoveries
	waitbutton
	closetext
	end

.RedScale:
	writetext MrPokemonText_GimmeTheScale
	yesorno
	iffalse .refused
	verbosegiveitem EXP_SHARE
	iffalse .full
	takeitem RED_SCALE
	sjump .AlwaysNewDiscoveries

.refused
	writetext MrPokemonText_Disappointed
	waitbutton
.full
	closetext
	end

MrPokemonsHouse_OakScript:
	playmusic MUSIC_PROF_OAK
	applymovement MRPOKEMONSHOUSE_OAK, MrPokemonsHouse_OakWalksToPlayer
	turnobject MRPOKEMONSHOUSE_GENTLEMAN, DOWN
	turnobject PLAYER, RIGHT
	opentext
	writetext MrPokemonsHouse_OakText1
	promptbutton
	waitsfx
	writetext MrPokemonsHouse_GetDexText
	playsound SFX_ITEM
	waitsfx
	setflag ENGINE_POKEDEX
	writetext MrPokemonsHouse_OakText2
	waitbutton
	closetext
	turnobject PLAYER, DOWN
	applymovement MRPOKEMONSHOUSE_OAK, MrPokemonsHouse_OakExits
	playsound SFX_EXIT_BUILDING
	disappear MRPOKEMONSHOUSE_OAK ; Also sets EVENT_MR_POKEMONS_HOUSE_OAK.
	waitsfx
	special RestartMapMusic
	pause 15
	turnobject PLAYER, UP
	opentext
	writetext MrPokemonsHouse_MrPokemonHealText
	waitbutton
	closetext

	scall FadeBlackAndHealParty

	opentext
	writetext MrPokemonText_ImDependingOnYou
	waitbutton
	closetext
	setevent EVENT_RIVAL_NEW_BARK_TOWN
	setevent EVENT_PLAYERS_HOUSE_1F_NEIGHBOR
	clearevent EVENT_PLAYERS_NEIGHBORS_HOUSE_NEIGHBOR
	setevent EVENT_CHERRYGROVECITY_MEET_RIVAL
	setmapscene ELMS_LAB, SCENE_ELMSLAB_MEET_OFFICER
	specialphonecall SPECIALCALL_ROBBED
	clearevent EVENT_COP_IN_ELMS_LAB
	checkevent EVENT_GOT_TOTODILE_FROM_ELM
	iftrue .RivalTakesChikorita
	checkevent EVENT_GOT_CHIKORITA_FROM_ELM
	iftrue .RivalTakesCyndaquil
	setevent EVENT_TOTODILE_POKEBALL_IN_ELMS_LAB
	end

.RivalTakesChikorita:
	setevent EVENT_CHIKORITA_POKEBALL_IN_ELMS_LAB
	end

.RivalTakesCyndaquil:
	setevent EVENT_CYNDAQUIL_POKEBALL_IN_ELMS_LAB
	end

FadeBlackAndHealParty::
	special FadeBlackQuickly
	special ReloadSpritesNoPalettes
	playmusic MUSIC_HEAL
	special StubbedTrainerRankings_Healings
	special HealParty
	pause 60
	special FadeInQuickly
	special RestartMapMusic
	end

MrPokemonsHouse_ForeignMagazines:
	jumptext MrPokemonsHouse_ForeignMagazinesText

MrPokemonsHouse_BrokenComputer:
	jumptext MrPokemonsHouse_BrokenComputerText

MrPokemonsHouse_StrangeCoins:
	jumptext MrPokemonsHouse_StrangeCoinsText

MrPokemonsHouse_PlayerWalksToMrPokemon:
	step RIGHT
	step UP
	step_end

MrPokemonsHouse_OakWalksToPlayer:
	step DOWN
	step LEFT
	step_end

MrPokemonsHouse_OakExits:
	step DOWN
	step LEFT
	step LEFT
	turn_head DOWN
	step_sleep 2
	step_end

MrPokemonIntroText1: 
if DEF(_FR_FR)
	text "Hello! Tu dois"
	line "être <PLAY_G>."

	para "Le PROF.ORME a dit"
	line "que tu viendrais."
else
	text "Hello, hello! You"
	line "must be <PLAY_G>."

	para "PROF.ELM said that"
	line "you would visit."
endc

	done

MrPokemonIntroText2: 
if DEF(_FR_FR)
	text "Voilà ce que je"
	line "voudrais que le"
	cont "PROF.ORME examine."
else
	text "This is what I"
	line "want PROF.ELM to"
	cont "examine."
endc

	done

MrPokemonsHouse_GotEggText: ; TO TRANSLATE
	text "<PLAYER> received"
	line "PARCEL."
	done

MrPokemonIntroText3: ; TO TRANSLATE
	text "I recently started"
	line "working with"
	cont "PROF.ELM."

	para "For #MON VIRO-"
	line "LOGY, PROF.ELM is"
	cont "the authority."
	done

MrPokemonIntroText4: 
if DEF(_FR_FR)
	text "Même le PROF.CHEN"
	line "le reconnaît."
else
	text "Even PROF.OAK here"
	line "recognizes that."
endc

	done

MrPokemonsHouse_MrPokemonHealText: 
if DEF(_FR_FR)
	text "Tu retournes voir"
	line "le PROF.ORME?"

	para "Tiens. Tes #MON"
	line "devraient se"
	cont "reposer."
else
	text "You are returning"
	line "to PROF.ELM?"

	para "Here. Your #MON"
	line "should have some"
	cont "rest."
endc

	done

MrPokemonText_ImDependingOnYou: 
if DEF(_FR_FR)
	text "Je compte sur toi!"
else
	text "I'm depending on"
	line "you!"
endc

	done

MrPokemonText_AlwaysNewDiscoveries: 
if DEF(_FR_FR)
	text "C'est beau la vie!"
	line "Il y a toujours"

	para "quelque chose à"
	line "découvrir!"
else
	text "Life is delight-"
	line "ful! Always, new"

	para "discoveries to be"
	line "made!"
endc

	done

MrPokemonsHouse_OakText1: 
if DEF(_FR_FR)
	text "CHEN: Ahaa! C'est"
	line "toi <PLAY_G>!"

	para "Moi c'est CHEN!"
	line "Je suis un cher-"
	cont "cheur #MON."

	para "Je suis venu ren-"
	line "dre visite à mon"
	cont "vieil ami..."
	cont "M.#MON!"

	para "On m'a dit que tu"
	line "rendais service au"

	para "PROF.ORME, alors"
	line "je t'attendais."

	para "Oh! C'est quoi ça?"
	line "Un #MON rare!"

	para "Voyons..."

	para "Hmm... Je vois!"

	para "Je comprends pour-"
	line "quoi le PROF.ORME"

	para "t'a confié un"
	line "#MON pour cette"
	cont "mission."

	para "Pour des cher-"
	line "cheurs comme moi"

	para "et le PROF.ORME,"
	line "les #MON sont"
	cont "des amis."

	para "Il a tout de suite"
	line "compris que tu"

	para "ferais attention à"
	line "ton #MON."

	para "...Ah!"

	para "On peut te faire"
	line "confiance."

	para "Ca te dirait de me"
	line "rendre service?"

	para "Regarde ça: c'est"
	line "une nouvelle ver-"
	cont "sion du #DEX."

	para "Il enregistre au-"
	line "tomatiquement les"

	para "données sur les"
	line "#MON vus ou"
	cont "pris."

	para "C'est une encyclo-"
	line "pédie moderne!"
else
	text "OAK: Aha! So"
	line "you're <PLAY_G>!"

	para "I'm OAK! A #MON"
	line "researcher."

	para "I was just visit-"
	line "ing my old friend"
	cont "MR.#MON."

	para "I heard you were"
	line "running an errand"

	para "for PROF.ELM, so I"
	line "waited here."

	para "Oh! What's this?"
	line "A rare #MON!"

	para "Let's see…"

	para "Hm, I see!"

	para "I understand why"
	line "PROF.ELM gave you"

	para "a #MON for this"
	line "errand."

	para "To researchers"
	line "like PROF.ELM and"

	para "I, #MON are our"
	line "friends."

	para "He saw that you"
	line "would treat your"

	para "#MON with love"
	line "and care."

	para "…Ah!"

	para "You seem to be"
	line "dependable."

	para "How would you like"
	line "to help me out?"

	para "See? This is the"
	line "latest version of"
	cont "#DEX."

	para "It automatically"
	line "records data on"

	para "#MON you've"
	line "seen or caught."

	para "It's a hi-tech"
	line "encyclopedia!"
endc

	done

MrPokemonsHouse_GetDexText: 
if DEF(_FR_FR)
	text "<PLAYER> reçoit"
	line "le #DEX!"
else
	text "<PLAYER> received"
	line "#DEX!"
endc

	done

MrPokemonsHouse_OakText2: ; TO TRANSLATE
	text "Go meet many kinds"
	line "of #MON and"

	para "complete that"
	line "#DEX!"

	para "But I've stayed"
	line "too long."

	para "I have to get to"
	line "GOLDENROD for my"
	cont "radio show."

	para "<PLAY_G>, when you"
	line "see PROF.ELM, tell"
	cont "him to turn on the"
	cont "radio!"
	done

MrPokemonText_GimmeTheScale: 
if DEF(_FR_FR)
	text "Oh? Cette ECAILLE!"
	line "C'est quoi?"
	cont "Un LEVIATOR rouge?"

	para "C'est dingue!"
	line "Je la veux..."

	para "<PLAY_G>, veux-tu"
	line "l'échanger?"

	para "Je peux te donner"
	line "le MULTI EXP du"
	cont "PROF.CHEN."
else
	text "Hm? That SCALE!"
	line "What's that?"
	cont "A red GYARADOS?"

	para "That's rare! "
	line "I, I want it…"

	para "<PLAY_G>, would you"
	line "care to trade it?"

	para "I can offer this"
	line "EXP.SHARE I got"
	cont "from PROF.OAK."
endc

	done

MrPokemonText_Disappointed: 
if DEF(_FR_FR)
	text "C'est dommage."
	line "C'est si rare..."
else
	text "That's disappoint-"
	line "ing. That happens"
	cont "to be very rare."
endc

	done

MrPokemonsHouse_ForeignMagazinesText: 
if DEF(_FR_FR)
	text "Il y a plein de"
	line "magazines"
	cont "étrangers."

	para "On ne comprend"
	line "même pas les"
	cont "titres."
else
	text "It's packed with"
	line "foreign magazines."

	para "Can't even read"
	line "their titles…"
endc

	done

MrPokemonsHouse_BrokenComputerText: 
if DEF(_FR_FR)
	text "Un gros ordinateur"
	line "tout cassé..."
else
	text "It's a big com-"
	line "puter. Hmm. It's"
	cont "broken."
endc

	done

MrPokemonsHouse_StrangeCoinsText: 
if DEF(_FR_FR)
	text "Un tas de pièces"
	line "bizarres!"

	para "Elles sont peut-"
	line "être d'un autre"
	cont "pays..."
else
	text "A whole pile of"
	line "strange coins!"

	para "Maybe they're from"
	line "another country…"
endc

	done

MrPokemonsHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, ROUTE_30, 2
	warp_event  3,  7, ROUTE_30, 2

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, MrPokemonsHouse_ForeignMagazines
	bg_event  1,  1, BGEVENT_READ, MrPokemonsHouse_ForeignMagazines
	bg_event  6,  1, BGEVENT_READ, MrPokemonsHouse_BrokenComputer
	bg_event  7,  1, BGEVENT_READ, MrPokemonsHouse_BrokenComputer
	bg_event  6,  4, BGEVENT_READ, MrPokemonsHouse_StrangeCoins

	def_object_events
	object_event  3,  4, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MrPokemonsHouse_MrPokemonScript, -1
	object_event  6,  5, SPRITE_OAK, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_MR_POKEMONS_HOUSE_OAK
