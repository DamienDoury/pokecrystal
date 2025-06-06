	object_const_def
	const ROUTE41_OLIVINE_RIVAL1
	const ROUTE41_OLIVINE_RIVAL2
	const ROUTE41_OLIVINE_RIVAL3
	const ROUTE41_OLIVINE_RIVAL4
	const ROUTE41_OLIVINE_RIVAL5
	const ROUTE41_SWIMMER_GIRL1
	const ROUTE41_SWIMMER_GIRL2
	const ROUTE41_SWIMMER_GIRL3
	const ROUTE41_SWIMMER_GIRL4
	const ROUTE41_SWIMMER_GIRL5

Route41_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerSwimmerfKaylee:
	trainer SWIMMERF, KAYLEE, EVENT_BEAT_SWIMMERF_KAYLEE, SwimmerfKayleeSeenText, SwimmerfKayleeBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmerfKayleeAfterBattleText

TrainerSwimmerfSusie:
	trainer SWIMMERF, SUSIE, EVENT_BEAT_SWIMMERF_SUSIE, SwimmerfSusieSeenText, SwimmerfSusieBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmerfSusieAfterBattleText

TrainerSwimmerfDenise:
	trainer SWIMMERF, DENISE, EVENT_BEAT_SWIMMERF_DENISE, SwimmerfDeniseSeenText, SwimmerfDeniseBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmerfDeniseAfterBattleText

TrainerSwimmerfKara:
	trainer SWIMMERF, KARA, EVENT_BEAT_SWIMMERF_KARA, SwimmerfKaraSeenText, SwimmerfKaraBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmerfKaraAfterBattleText

TrainerSwimmerfWendy:
	trainer SWIMMERF, WENDY, EVENT_BEAT_SWIMMERF_WENDY, SwimmerfWendySeenText, SwimmerfWendyBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmerfWendyAfterBattleText

TrainerSwimmermCharlie:
	trainer SWIMMERM, CHARLIE, EVENT_BEAT_SWIMMERM_CHARLIE, SwimmermCharlieSeenText, SwimmermCharlieBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmermCharlieAfterBattleText

TrainerSwimmermGeorge:
	trainer SWIMMERM, GEORGE, EVENT_BEAT_SWIMMERM_GEORGE, SwimmermGeorgeSeenText, SwimmermGeorgeBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmermGeorgeAfterBattleText

TrainerSwimmermBerke:
	trainer SWIMMERM, BERKE, EVENT_BEAT_SWIMMERM_BERKE, SwimmermBerkeSeenText, SwimmermBerkeBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmermBerkeAfterBattleText

TrainerSwimmermKirk:
	trainer SWIMMERM, KIRK, EVENT_BEAT_SWIMMERM_KIRK, SwimmermKirkSeenText, SwimmermKirkBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmermKirkAfterBattleText

TrainerSwimmermMathew:
	trainer SWIMMERM, MATHEW, EVENT_BEAT_SWIMMERM_MATHEW, SwimmermMathewSeenText, SwimmermMathewBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SwimmermMathewAfterBattleText

Route41HiddenMaxEther:
	hiddenitem MAX_ETHER, EVENT_ROUTE_41_HIDDEN_MAX_ETHER

SwimmermCharlieSeenText: 
if DEF(_FR_FR)
	text "L'eau est bonne"
	line "par ici."

	para "Tu veux combattre?"
	line "Pas de problème!"
else
	text "The water's warm"
	line "here. I'm loose"
	cont "and limber."

	para "Sure, I'll take"
	line "you on!"
endc

	done

SwimmermCharlieBeatenText: 
if DEF(_FR_FR)
	text "J'suis tout fripé!"
else
	text "Yikes! I've got"
	line "prune skin!"
endc

	done

SwimmermCharlieAfterBattleText: 
if DEF(_FR_FR)
	text "C'est trop relax"
	line "de faire la plan-"
	cont "che!"
else
	text "Isn't it relaxing"
	line "just floating like"
	cont "this?"
endc

	done

SwimmermGeorgeSeenText: 
if DEF(_FR_FR)
	text "J'suis fatigué."
	line "Si je gagne, tu me"
	cont "prêtes tes #-"
	cont "MON, OK?"
else
	text "I'm a bit tired."
	line "If I win, lend me"
	cont "your #MON."
endc

	done

SwimmermGeorgeBeatenText: 
if DEF(_FR_FR)
	text "Pfff...pff..."
else
	text "Pant, pant…"
endc

	done

SwimmermGeorgeAfterBattleText: 
if DEF(_FR_FR)
	text "IRISIA est si"
	line "loin."

	para "Mais retourner à"
	line "OLIVILLE... Ca"
	cont "fait une trotte!"

	para "Que faire?"
else
	text "It's so far to"
	line "CIANWOOD."

	para "But it's no easy"
	line "return trip to"
	cont "OLIVINE either."

	para "What should I do?"
endc

	done

SwimmermBerkeSeenText: 
if DEF(_FR_FR)
	text "Tu vois ces îles"
	line "bloquées par des"
	cont "siphons?"

	para "Il doit y avoir"
	line "quelque chose de"
	cont "secret!"
else
	text "See those islands"
	line "that are blocked"
	cont "by whirlpools?"

	para "There just has to"
	line "be a secret!"
endc

	done

SwimmermBerkeBeatenText: 
if DEF(_FR_FR)
	text "Pourquoi t'es"
	line "cool, toi?"
else
	text "What's the secret"
	line "to your strength?"
endc

	done

SwimmermBerkeAfterBattleText: 
if DEF(_FR_FR)
	text "Par une nuit noire"
	line "et profonde..."

	para "J'ai vu ce #MON"
	line "géant voler depuis"
	cont "les îles."

	para "Il répandait ses"
	line "plumes de ses"
	cont "ailes d'argent."
else
	text "It was a dark and"
	line "stormy night…"

	para "I saw this giant"
	line "#MON flying"
	cont "from the islands."

	para "It was scattering"
	line "feathers from its"
	cont "silver wings."
endc

	done

SwimmermKirkSeenText: 
if DEF(_FR_FR)
	text "Les vagues sont"
	line "dangereuses ici."

	para "Elles empêchent de"
	line "nager calmement."
else
	text "The waves are wild"
	line "here."

	para "They tire you out"
	line "while you swim."
endc

	done

SwimmermKirkBeatenText: 
if DEF(_FR_FR)
	text "J'suis crevé!"
else
	text "I'm beat!"
endc

	done

SwimmermKirkAfterBattleText: 
if DEF(_FR_FR)
	text "Les courants m'em-"
	line "pêchent d'attein-"
	cont "dre cette île."
else
	text "The currents keep"
	line "me from reaching"
	cont "that island."
endc

	done

SwimmermMathewSeenText: 
if DEF(_FR_FR)
	text "Tu cherches le"
	line "secret des"
	cont "TOURB'ILES?"
else
	text "Are you seeking"
	line "the secrets of"
	cont "WHIRL ISLANDS?"
endc

	done

SwimmermMathewBeatenText: 
if DEF(_FR_FR)
	text "Ooh!!! Quelle"
	line "endurance!"
else
	text "Ooh, you've got"
	line "great endurance!"
endc

	done

SwimmermMathewAfterBattleText: 
if DEF(_FR_FR)
	text "Il y a un secret"
	line "aux TOURB'ILES..."

	para "Il y fait noir!"
	line "Ca c'est sûr!"
else
	text "A secret about"
	line "WHIRL ISLANDS…"

	para "It's pitch-black"
	line "inside!"
endc

	done

SwimmerfKayleeSeenText: 
if DEF(_FR_FR)
	text "Je vais aux"
	line "TOURB'ILES."

	para "Je vais les explo-"
	line "rer avec un ami."
else
	text "I'm on my way to"
	line "WHIRL ISLANDS."

	para "I'm going explor-"
	line "ing with friends."
endc

	done

SwimmerfKayleeBeatenText: 
if DEF(_FR_FR)
	text "C'est tout?"
else
	text "Is that how you do"
	line "it?"
endc

	done

SwimmerfKayleeAfterBattleText: 
if DEF(_FR_FR)
	text "On dit qu'il y a"
	line "un gros #MON"
	cont "au fond des"
	cont "TOURB'ILES."

	para "Je me demande ce"
	line "que c'est..."
else
	text "There's supposed"
	line "to be a big #-"
	cont "MON deep beneath"
	cont "WHIRL ISLANDS."

	para "I wonder what it"
	line "could be?"
endc

	done

SwimmerfSusieSeenText: 
if DEF(_FR_FR)
	text "Cool, t'es à dada"
	line "sur ton #MON."
else
	text "You look so ele-"
	line "gant, riding your"
	cont "#MON."
endc

	done

SwimmerfSusieBeatenText: 
if DEF(_FR_FR)
	text "Tout perdu..."
else
	text "I'm crushed…"
endc

	done

SwimmerfSusieAfterBattleText: 
if DEF(_FR_FR)
	text "Ca fait quel effet"
	line "de monter sur un"
	cont "#MON?"
else
	text "Wasn't there a hit"
	line "song about a boy"
	cont "riding a LAPRAS?"
endc

	done

SwimmerfDeniseSeenText: 
if DEF(_FR_FR)
	text "Il fait si beau!"
	line "C'est la fête!"
	cont "Youkiii!"
else
	text "The weather is so"
	line "beautiful, I'm in"
	cont "a daze!"
endc

	done

SwimmerfDeniseBeatenText: 
if DEF(_FR_FR)
	text "Ohhh!"
else
	text "Ohhh!"
endc

	done

SwimmerfDeniseAfterBattleText: 
if DEF(_FR_FR)
	text "Un coup de soleil"
	line "est vite arrivé."

	para "Moi je mets pas"
	line "de crème."

	para "Je veux garder"
	line "l'eau propre."
else
	text "A sunburn is the"
	line "worst for skin."

	para "But I don't use a"
	line "sunblock."

	para "I won't pollute"
	line "the water."
endc

	done

SwimmerfKaraSeenText: 
if DEF(_FR_FR)
	text "Si tu es naze,"
	line "fais la planche!"

	para "Bon..."
	line "On s'bat?"
else
	text "If you need to"
	line "rest, just tread"
	cont "water."

	para "You'll get your"
	line "wind back, so you"

	para "can keep on going"
	line "strong."
endc

	done

SwimmerfKaraBeatenText: 
if DEF(_FR_FR)
	text "Oh! Tu en as de"
	line "l'énergie, toi."
else
	text "Oh! You have more"
	line "energy than I do."
endc

	done

SwimmerfKaraAfterBattleText: 
if DEF(_FR_FR)
	text "J'entends des cris"
	line "venant des ILES."
else
	text "I heard roars from"
	line "deep inside the"
	cont "ISLANDS."
endc

	done

SwimmerfWendySeenText: ; TO TRANSLATE
	text "At night, CHINCHOU"
	line "gather near the"
	cont "water's surface."
	done

SwimmerfWendyBeatenText: 
if DEF(_FR_FR)
	text "Oh..."
else
	text "Oh, dear…"
endc

	done

SwimmerfWendyAfterBattleText: ; TO TRANSLATE
	text "The clusters of"
	line "CHINCHOU light up"
	cont "at the same time."

	para "It's so beautiful,"
	line "it's scary."
	done

Route41_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 12, 17, WHIRL_ISLAND_NW, 1
	warp_event 36, 19, WHIRL_ISLAND_NE, 1
	warp_event 12, 37, WHIRL_ISLAND_SW, 1
	warp_event 36, 45, WHIRL_ISLAND_SE, 1

	def_coord_events

	def_bg_events
	bg_event  9, 35, BGEVENT_ITEM, Route41HiddenMaxEther

	def_object_events
	object_event 32,  6, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerSwimmermCharlie, -1
	object_event 46,  8, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerSwimmermGeorge, -1
	object_event 20, 26, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerSwimmermBerke, -1
	object_event 32, 30, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerSwimmermKirk, -1
	object_event 19, 46, SPRITE_SWIMMER_GUY, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerSwimmermMathew, -1
	object_event 17,  4, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerSwimmerfKaylee, -1
	object_event 23, 19, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerSwimmerfSusie, -1
	object_event 27, 34, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 3, TrainerSwimmerfDenise, -1
	object_event 44, 28, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 4, TrainerSwimmerfKara, -1
	object_event  9, 50, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_LOCKDOWN & HIDE_CURFEW, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 2, TrainerSwimmerfWendy, -1
