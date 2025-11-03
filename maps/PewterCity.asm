	object_const_def
	const PEWTERCITY_COOLTRAINER_F
	const PEWTERCITY_BUG_CATCHER
	const PEWTERCITY_GRAMPS
	const PEWTERCITY_FRUIT_TREE1
	const PEWTERCITY_FRUIT_TREE2
	const PEWTERCITY_FRUIT_TREE3
	const PEWTERCITY_MUSEUM_DOOR
	const PEWTERCITY_MUSEUM_BACKDOOR

PewterCity_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .FlyPoint

.FlyPoint:
	setflag ENGINE_FLYPOINT_PEWTER
	endcallback

PewterCityCooltrainerFScript:
	jumptextfaceplayer PewterCityCooltrainerFText

PewterCityBugCatcherScript:
	checkitem SILVER_WING
	iftrue .GotSilverWing

	jumptextfaceplayer PewterCityBugCatcherJustSavedText

.GotSilverWing
	jumptextfaceplayer PewterCityBugCatcherText

PewterCityGrampsScript:
	faceplayer
	;giveitem MUSEUM_KEY
	checkitem MUSEUM_KEY
	iftrue .GotMuseumKey
	checkevent EVENT_FOUGHT_ZAPDOS
	iftrue .GiveMuseumKey
	jumptext PewterCityGrampsLostGrandKidText

.GiveMuseumKey:
	opentext
	writetext PewterCityGrampsText
	promptbutton
	verbosegiveitem MUSEUM_KEY
	;verbosegiveitem SILVER_WING
	;setevent EVENT_GOT_SILVER_WING
	closetext
	end

.GotMuseumKey:
	jumptext PewterCityGrampsText_GotMuseumKey

PewterCitySign:
	jumptext PewterCitySignText

PewterGymSign:
	jumptext PewterGymSignText

PewterMuseumSign:
	jumptext PewterMuseumSignText

PewterCityMtMoonGiftShopSign:
	jumptext PewterCityMtMoonGiftShopSignText

PewterCityWelcomeSign:
	jumptext PewterCityWelcomeSignText

PewterCityPokecenterSign:
	jumpstd PokecenterSignScript

PewterCityMartSign:
	jumpstd MartSignScript

PewterCityFruitTree1:
	fruittree FRUITTREE_PEWTER_CITY_1

PewterCityFruitTree2:
	fruittree FRUITTREE_PEWTER_CITY_2
	
PewterCityFruitTree3:
	fruittree FRUITTREE_PEWTER_CITY_3

PewterCity_Door1Script:
	opentext
	writetext PewterMuseumHeavyChainText
	checkitem MUSEUM_KEY
	iffalse .end

	promptbutton
	writetext PewterMuseumKeyDoesntFitText
.end
	waitbutton
	closetext
	end

PewterCity_Door2Script:
	opentext
	writetext PewterMuseumHeavyChainText
	checkitem MUSEUM_KEY
	iffalse .end

	promptbutton
	waitsfx
	playsound SFX_ENTER_DOOR
	waitsfx
	disappear PEWTERCITY_MUSEUM_BACKDOOR
	writetext PewterMuseumKeySuccessText
.end
	waitbutton
	closetext
	end

PewterCityCooltrainerFText:
if DEF(_FR_FR)
	text "Des jeunes ont"
	line "organisé une fête"
	cont "illégale dans"
	cont "notre précieux"
	cont "MUSEE."

	para "Quel manque de"
	line "respect!"

	para "Depuis, on a"
	line "scellé les portes"
	cont "avec des chaînes."
else
	text "Young people had"
	line "organized an il-"
	cont "legal party in our"
	cont "beloved MUSEUM."
	
	para "How disrespectful!"

	para "Now the doors have"
	line "been locked with"
	cont "chains."
endc
	done

PewterCityBugCatcherJustSavedText:
if DEF(_FR_FR)
	text "Merci d'avoir"
	line "réglé le problème"
	cont "de la forêt."

	para "J'ai vraiment cru"
	line "que j'allais y"
	cont "rester coincé"
	cont "pour toujours..."

	para "Mon papi veut"
	line "te remercier."

	para "Il se promène"
	line "dans la ville."
else
	text "Thank you for"
	line "“fixing” the"
	cont "forest."

	para "I really thought I"
	line "was going to live"
	cont "there forever…"

	para "My grandpa wants"
	line "to thank you."

	para "He's walking around"
	line "in the city."
endc
	done

PewterCityBugCatcherText:
if DEF(_FR_FR)
	text "La nuit, les"
	line "MELOFEE sortent"
	cont "jouer au MONT"
	cont "SELENITE."

	para "Mais pas toutes"
	line "les nuits."

	para "Mais je n'irai pas."
	line "J'ai peur d'encore"
	cont "me perdre."
else
	text "At night, CLEFAIRY"
	line "come out to play"
	cont "at MT.MOON."

	para "Though not every"
	line "night."

	para "But I won't go."
	line "I'm afraid to get"
	cont "lost once again."
endc
	done

PewterCityGrampsLostGrandKidText:
if DEF(_FR_FR)
	text "Mon petit-fils est"
	line "allé cueillir des"
	cont "baies dans la"
	cont "FORET DE JADE, et"
	cont "n'est jamais"
	cont "revenu..."

	para "Toi! Tu es"
	line "dresseur #MON!"

	para "Va le chercher,"
	line "je t'en supplie!"
else
	text "My grand-kid went"
	line "picking berries"
	cont "in VIRIDIAN FOREST"
	cont "and never came"
	cont "back…"

	para "You! You are a"
	line "trainer!"

	para "Please go search"
	line "my grand-kid,"
	cont "I'm begging you!"
endc
	done

PewterCityGrampsText:
if DEF(_FR_FR)
	text "Ah, c'est toi qui"
	line "as résolu le"
	cont "mystère de la"
	cont "forêt."

	para "Grâce à toi, mon"
	line "petit-fils s'en"
	cont "est sorti vivant."

	para "Je te suis"
	line "redevable."

	para "Comment te"
	line "remercier?"

	para "Oh, j'ai trouvé!"

	para "Les gens appréci-"
	line "aient le MUSEE"
	cont "DES SCIENCES."

	para "C'est moi qui l'ai"
	line "condamné."

	para "Voici un doublon"
	line "de la clé. Je te"
	cont "fais confiance"
	cont "pour refermer en"
	cont "partant."
else
	text "Ah, you're the one"
	line "that solved the"
	cont "forest's mystery."

	para "Thanks to you, my"
	line "grand-kid made it"
	cont "out alive."

	para "I am in debt to"
	line "you. How can I"
	cont "repay you?"

	para "Oh, I know!"

	para "People loved the"
	line "MUSEUM OF SCIENCE."

	para "I am the one who"
	line "locked it down."
	
	para "Take my spare key."
	line "I trust you to"
	cont "close the place"
	cont "when you leave."
endc
	done

PewterCityGrampsText_GotMuseumKey:
if DEF(_FR_FR)
	text "Quand tu étais"
	line "dans la FORET DE"
	cont "JADE, j'ai pu"

	para "apercevoir le"
	line "#MON mythique"
	cont "de la foudre"

	para "plonger dans la"
	line "forêt depuis le"
	cont "ciel. Puis une"

	para "autre créature"
	line "féerique s'enfuir"
	cont "de la forêt en"
	
	para "flottant dans les"
	line "airs vers l'Ouest."

	para "Est-ce que le"
	line "premier #MON"
	cont "gardait le second"
	cont "prisonnier?"
	
	para "Ou bien est-ce que"
	line "le premier #MON"
	cont "est venu à la"
	cont "rescousse du"
	cont "second?"

	para "Difficile à"
	line "dire..."
else
	text "When you were into"
	line "VIRIDIAN FOREST,"

	para "I could see the"
	line "mythical thunder"

	para "#MON dive into"
	line "the forest from"
	
	para "the sky. Then this"
	line "other fairy-like"
	
	para "#MON flew out"
	line "of the forest"
	cont "to the west."

	para "Was the first one"
	line "keeping the other"
	cont "captive?"
	
	para "Or did the first"
	line "one come to prot-"
	cont "ect the other one?"

	para "It's hard to tell…"
endc
	done

PewterCitySignText: 
if DEF(_FR_FR)
	text "ARGENTA"
	line "Grise comme le roc"
else
	text "PEWTER CITY"
	line "A Stone Gray City"
endc

	done

PewterGymSignText: 
if DEF(_FR_FR)
	text "CHAMPION d'ARENE"
	line "d'ARGENTA:"
	cont "PIERRE"

	para "Le dresseur dur"
	line "comme la roche"
else
	text "PEWTER CITY"
	line "#MON GYM"
	cont "LEADER: BROCK"

	para "The Rock Solid"
	line "#MON Trainer"
endc

	done

PewterMuseumSignText:
if DEF(_FR_FR)
	text "Un affiche est"
	line "placardée..."

	para "Nous sommes au"
	line "regret de vous"
	
	para "informer qu'en"
	line "raison du manque"

	para "de clients durant"
	line "les confinements,"

	para "le MUSEE DES"
	line "SCIENCES D'ARGENTA"

	para "a déposé le bilan."
else
	text "There's a notice"
	line "here…"

	para "We are sorry to"
	line "inform you that"
	
	para "due to the lack of"
	line "customers during"
	
	para "the lockdowns,"
	line "PEWTER MUSEUM OF"

	para "SCIENCE has filed"
	line "for bankruptcy."
endc
	done

PewterMuseumHeavyChainText:
if DEF(_FR_FR)
	text "Une lourde chaîne"
	line "garde la porte"
	cont "verrouillée."
else
	text "A heavy chain"
	line "keeps the door"
	cont "locked."
endc
	done

PewterMuseumKeyDoesntFitText:
if DEF(_FR_FR)
	text "La CLE DU MUSEE"
	line "ne rentre pas dans"
	cont "ce cadenas."
else
	text "The MUSEUM KEY"
	line "doesn't fit into"
	cont "the padlock."
endc
	done

PewterMuseumKeySuccessText:
if DEF(_FR_FR)
	text "La CLE DU MUSEE"
	line "a déverrouillé la"
	cont "chaîne."
else
	text "The MUSEUM KEY"
	line "unlocked the"
	cont "chain."
endc
	done

PewterCityMtMoonGiftShopSignText: 
if DEF(_FR_FR)
	text "Il y a une affiche"
	line "ici..."

	para "La BOUTIQUE de"
	line "SOUVENIRS du MONT"
	cont "SELENITE est"
	cont "ouverte!"
else
	text "There's a notice"
	line "here…"

	para "MT.MOON GIFT SHOP"
	line "NOW OPEN!"
endc

	done

PewterCityWelcomeSignText: 
if DEF(_FR_FR)
	text "Bienvenue à"
	line "ARGENTA!"
else
	text "WELCOME TO"
	line "PEWTER CITY!"
endc

	done

PewterCity_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 29, 13, PEWTER_NIDORAN_SPEECH_HOUSE, 1
	warp_event 16, 17, PEWTER_GYM, 1
	warp_event 23, 17, PEWTER_MART, 2
	warp_event 13, 25, PEWTER_POKECENTER_1F, 1
	warp_event  7, 29, PEWTER_SNOOZE_SPEECH_HOUSE, 1
	warp_event 19,  5, PEWTER_MUSEUM_1F, 1

	def_coord_events

	def_bg_events
	bg_event 25, 23, BGEVENT_READ, PewterCitySign
	bg_event 11, 17, BGEVENT_READ, PewterGymSign
	bg_event 15,  9, BGEVENT_READ, PewterMuseumSign
	bg_event 33, 19, BGEVENT_READ, PewterCityMtMoonGiftShopSign
	bg_event 19, 29, BGEVENT_READ, PewterCityWelcomeSign
	bg_event 14, 25, BGEVENT_READ, PewterCityPokecenterSign
	bg_event 24, 17, BGEVENT_READ, PewterCityMartSign

	def_object_events
	object_event 19, 11, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, PewterCityCooltrainerFScript, -1
	object_event 14, 29, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_WANDER, 2, 2, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, PewterCityBugCatcherScript, EVENT_VIRIDIAN_FOREST_GUY_SAVED
	object_event 29, 17, SPRITE_GRAMPS, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, PewterCityGrampsScript, -1
	object_event 32,  3, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PewterCityFruitTree1, -1
	object_event 30,  3, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PewterCityFruitTree2, -1
	object_event  7,  3, SPRITE_FRUIT_TREE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PewterCityFruitTree3, -1
	object_event 14,  7, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PewterCity_Door1Script, -1
	object_event 19,  5, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, PewterCity_Door2Script, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
