	object_const_def
	const DANCETHEATRE_KIMONO_GIRL1
	const DANCETHEATRE_VP_CONTROLLER
	const DANCETHEATRE_KIMONO_GIRL2
	const DANCETHEATRE_KIMONO_GIRL3
	const DANCETHEATRE_KIMONO_GIRL4
	const DANCETHEATRE_KIMONO_GIRL5
	const DANCETHEATRE_GENTLEMAN
	const DANCETHEATRE_RHYDON
	const DANCETHEATRE_COOLTRAINER_M
	const DANCETHEATRE_GRANNY

DanceTheatre_MapScripts:
	def_scene_scripts
	scene_script .VaccinePassport ; SCENE_ALWAYS

	def_callbacks

.VaccinePassport:
	jumpstd VaccinePassCheckpoint

TrainerKimonoGirlNaoko:
	trainer KIMONO_GIRL, NAOKO, EVENT_BEAT_KIMONO_GIRL_NAOKO, KimonoGirlNaokoSeenText, KimonoGirlNaokoBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext KimonoGirlNaokoAfterBattleText
	waitbutton
	closetext
	end

TrainerKimonoGirlSayo:
	trainer KIMONO_GIRL, SAYO, EVENT_BEAT_KIMONO_GIRL_SAYO, KimonoGirlSayoSeenText, KimonoGirlSayoBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext KimonoGirlSayoAfterBattleText
	waitbutton
	closetext
	end

TrainerKimonoGirlZuki:
	trainer KIMONO_GIRL, ZUKI, EVENT_BEAT_KIMONO_GIRL_ZUKI, KimonoGirlZukiSeenText, KimonoGirlZukiBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext KimonoGirlZukiAfterBattleText
	waitbutton
	closetext
	end

TrainerKimonoGirlKuni:
	trainer KIMONO_GIRL, KUNI, EVENT_BEAT_KIMONO_GIRL_KUNI, KimonoGirlKuniSeenText, KimonoGirlKuniBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext KimonoGirlKuniAfterBattleText
	waitbutton
	closetext
	end

TrainerKimonoGirlMiki:
	trainer KIMONO_GIRL, MIKI, EVENT_BEAT_KIMONO_GIRL_MIKI, KimonoGirlMikiSeenText, KimonoGirlMikiBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext KimonoGirlMikiAfterBattleText
	waitbutton
	closetext
	end

DanceTheaterWhirlpoolGuy:
	faceplayer
	opentext
	writetext WhirlpoolGuyNeverLeftAScratchText
	promptbutton
	checkevent EVENT_GOT_HM06_WHIRLPOOL
	iftrue WhirlpoolGuyAlreadyGaveWhirlpool
	checkevent EVENT_BEAT_KIMONO_GIRL_NAOKO
	iffalse .KimonoGirlsUndefeated
	checkevent EVENT_BEAT_KIMONO_GIRL_SAYO
	iffalse .KimonoGirlsUndefeated
	checkevent EVENT_BEAT_KIMONO_GIRL_ZUKI
	iffalse .KimonoGirlsUndefeated
	checkevent EVENT_BEAT_KIMONO_GIRL_KUNI
	iffalse .KimonoGirlsUndefeated
	checkevent EVENT_BEAT_KIMONO_GIRL_MIKI
	iffalse .KimonoGirlsUndefeated
	sjump .GetWhirlpool

.KimonoGirlsUndefeated:
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .PlayerIsFemale
	writetext WhirlpoolGuyLadGiftText
	waitbutton
	closetext
	end

.PlayerIsFemale:
	writetext WhirlpoolGuyLassieGiftText
	waitbutton
	closetext
	end

.GetWhirlpool:
	writetext WhirlpoolGuyLikeADanceText
	promptbutton
	verbosegiveitem HM_WHIRLPOOL
	setevent EVENT_GOT_HM06_WHIRLPOOL
	writetext WhirlpoolGuyWhirlpoolExplanationText
	waitbutton
	closetext
	end

WhirlpoolGuyAlreadyGaveWhirlpool:
	writetext WhirlpoolGuyElegantKimonoGirlsText
	waitbutton
	closetext
	end

DanceTheaterRhydon:
	opentext
	writetext RhydonText
	cry RHYDON
	waitbutton
	closetext
	end

DanceTheatreCooltrainerMScript:
	jumptextfaceplayer DanceTheatreCooltrainerMText

DanceTheatreGrannyScript:
	jumptextfaceplayer DanceTheatreGrannyText

DanceTheatreFancyPanel:
	jumptext DanceTheatreFancyPanelText

KimonoGirlNaokoSeenText: 
if DEF(_FR_FR)
	text "Tu as de jolis"
	line "#MON. On peut"
	cont "voir c'que ça"
	cont "donne en combat?"
else
	text "You have lovely"
	line "#MON. May I see"
	cont "them in battle?"
endc

	done

KimonoGirlNaokoBeatenText: 
if DEF(_FR_FR)
	text "Oh, bravo les"
	line "biscotos!!"
else
	text "Oh, you are very"
	line "strong."
endc

	done

KimonoGirlNaokoAfterBattleText: 
if DEF(_FR_FR)
	text "J'ai apprécié la"
	line "petite baston. On"
	cont "peut se revoir?"
else
	text "I enjoyed that"
	line "bout. I would like"
	cont "to see you again."
endc

	done

KimonoGirlSayoSeenText: 
if DEF(_FR_FR)
	text "Je danse toujours"
	line "avec mes #MON."

	para "Bien sûr, je les"
	line "entraîne aussi."
else
	text "I always dance"
	line "with my #MON."

	para "Of course, I also"
	line "train them."
endc

	done

KimonoGirlSayoBeatenText: 
if DEF(_FR_FR)
	text "Oh, presque!"
	line "J'ai failli"
	cont "t'avoir."
else
	text "Oh, so close!"
	line "I almost had you."
endc

	done

KimonoGirlSayoAfterBattleText: 
if DEF(_FR_FR)
	text "Le rythme, c'est"
	line "un truc super"

	para "important pour la"
	line "danse et pour les"
	cont "#MON."
else
	text "Rhythm is impor-"
	line "tant for both"

	para "dancing and #-"
	line "MON."
endc

	done

KimonoGirlZukiSeenText: 
if DEF(_FR_FR)
	text "Elle est pas belle"
	line "ma barrette?"

	para "Oh! Un combat de"
	line "#MON?"
else
	text "Isn't my barrette"
	line "pretty?"

	para "Oh. A #MON"
	line "battle?"
endc

	done

KimonoGirlZukiBeatenText: 
if DEF(_FR_FR)
	text "Je n'ai plus de"
	line "#MON..."
else
	text "I don't have any"
	line "#MON left…"
endc

	done

KimonoGirlZukiAfterBattleText: 
if DEF(_FR_FR)
	text "Tous les mois je"
	line "change de fleur"
	cont "pour ma barrette."
	cont "Bon des fois elle"
	cont "fane avant!"
else
	text "I put a different"
	line "flower in my bar-"
	cont "rette every month."
endc

	done

KimonoGirlKuniSeenText: 
if DEF(_FR_FR)
	text "Oh, t'es tout"
	line "mimi comme"
	cont "dresseur! Un petit"
	cont "combat en tête à"
	cont "tête?"
else
	text "Oh, you're a cute"
	line "trainer. Would you"
	cont "like to battle?"
endc

	done

KimonoGirlKuniBeatenText: 
if DEF(_FR_FR)
	text "Tu es plus cool"
	line "que tu n'en n'as"
	cont "pas l'air."
else
	text "You're stronger"
	line "than you look."
endc

	done

KimonoGirlKuniAfterBattleText: 
if DEF(_FR_FR)
	text "Je me suis entraî-"
	line "née d'arrache-pied"

	para "et je pensais être"
	line "au niveau. Et bah"
	cont "non..."
else
	text "I trained a lot,"
	line "so I thought I was"

	para "a capable trainer."
	line "I guess I'm not."
endc

	done

KimonoGirlMikiSeenText: 
if DEF(_FR_FR)
	text "Tu aimes mes pas"
	line "de danse? La pure"
	cont "classe, non?"
	cont "Mais je suis aussi"
	cont "forte en #MON."
else
	text "Do you like my"
	line "dancing? I'm good"
	cont "at #MON too."
endc

	done

KimonoGirlMikiBeatenText: 
if DEF(_FR_FR)
	text ".... Heu... T'es"
	line "pas naze non"
	cont "plus toi!"
else
	text "Ooh, you're good"
	line "at #MON too."
endc

	done

KimonoGirlMikiAfterBattleText: 
if DEF(_FR_FR)
	text "Je continue de"
	line "danser! Les gens"
	cont "adorent ça!"

	para "Mes #MON aussi."
else
	text "I can keep dancing"
	line "because there are"

	para "people who enjoy"
	line "what I do."

	para "My #MON keep my"
	line "spirits up too."
endc

	done

WhirlpoolGuyNeverLeftAScratchText: ; TO TRANSLATE
	text "Not only are the"
	line "KIMONO GIRLS great"

	para "dancers, they're"
	line "also skilled at"
	cont "#MON."

	para "I always challenge"
	line "them, but I've"

	para "never even left a"
	line "scratch…"
	done

WhirlpoolGuyLadGiftText: ; TO TRANSLATE
	text "Lad! If you can"
	line "defeat all the"

	para "KIMONO GIRLS, I'll"
	line "give you a gift."
	done

WhirlpoolGuyLassieGiftText: ; TO TRANSLATE
	text "Lassie, if you can"
	line "defeat all the"

	para "KIMONO GIRLS, I'll"
	line "give you a gift."
	done

WhirlpoolGuyLikeADanceText: ; TO TRANSLATE
	text "The way you bat-"
	line "tled, it was like"
	cont "watching a dance."

	para "It was a rare"
	line "treat to see!"

	para "I want you to have"
	line "this. Don't worry"
	cont "--take it!"
	done

WhirlpoolGuyWhirlpoolExplanationText: ; TO TRANSLATE
	text "That's WHIRLPOOL."

	para "It's a move that"
	line "whirls and twirls"
	
	para "just like the"
	line "KIMONO GIRLS."
	done

WhirlpoolGuyElegantKimonoGirlsText: ; TO TRANSLATE
	text "I wish my #MON"
	line "were as elegant as"
	cont "the KIMONO GIRLS…"
	done

RhydonText: 
if DEF(_FR_FR)
	text "RHINOFEROS: Ross!"
	line "Férrroosss!"
else
	text "RHYDON: Gugooh"
	line "gugogooh!"
endc

	done

DanceTheatreCooltrainerMText: ; TO TRANSLATE
	text "That man's always"
	line "with his RHYDON."

	para "Says he wishes his"
	line "#MON could"
	cont "dance."
	done

DanceTheatreGrannyText:
if DEF(_FR_FR)
	text "Les KIMONO sont"
	line "très belles..."

	para "Mais elles doivent"
	line "suivre un"
	cont "entraînement de"
	cont "titan."

	para "Elles doivent"
	line "apprendre à suivre"

	para "des règles avant"
	line "de se montrer en"
	cont "public."

	para "Mais quand tu"
	line "aimes quelque"
	cont "chose, tout est"
	cont "possible."
else
	text "The KIMONO GIRLS"
	line "are so beautiful…"

	para "But they have to"
	line "go through rigor-"
	cont "ous training."

	para "And they have to"
	line "learn to follow"

	para "customs before ap-"
	line "pearing in public."

	para "But if you love"
	line "something, any-"
	cont "thing is possible."
endc

	done


DanceTheatreFancyPanelText:
if DEF(_FR_FR)
	text "C'est un joli"
	line "paravent décoré de"
	cont "fleurs."
else
	text "It's a fancy panel"
	line "that's decorated"
	cont "with flowers."
endc

	done

DanceTheatre_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5, 13, ECRUTEAK_CITY, 8
	warp_event  6, 13, ECRUTEAK_CITY, 8

	def_coord_events

	def_bg_events
	bg_event  5,  6, BGEVENT_UP, DanceTheatreFancyPanel
	bg_event  6,  6, BGEVENT_UP, DanceTheatreFancyPanel

	def_object_events
	object_event  0,  2, SPRITE_KIMONO_GIRL, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 0, TrainerKimonoGirlNaoko, -1
	object_event  3, 13, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_FREE & HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, VaccinePassportController, -1 ; Should always be at the second spot in the list.
	object_event  2,  1, SPRITE_KIMONO_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 0, TrainerKimonoGirlSayo, -1
	object_event  6,  2, SPRITE_KIMONO_GIRL, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 0, TrainerKimonoGirlZuki, -1
	object_event  9,  1, SPRITE_KIMONO_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 0, TrainerKimonoGirlKuni, -1
	object_event 11,  2, SPRITE_KIMONO_GIRL, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 0, TrainerKimonoGirlMiki, -1
	object_event  7, 10, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, DanceTheaterWhirlpoolGuy, -1
	object_event  6,  8, SPRITE_RHYDON, SPRITEMOVEDATA_POKEMON, 0, 0, HIDE_CURFEW, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, DanceTheaterRhydon, -1
	object_event 10, 10, SPRITE_COOLTRAINER_M, CLAP_F | SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, DanceTheatreCooltrainerMScript, -1
	object_event  3,  6, SPRITE_GRANNY, CLAP_F | SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_CURFEW, -1, 0, OBJECTTYPE_SCRIPT, 0, DanceTheatreGrannyScript, -1
