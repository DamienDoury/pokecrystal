	object_const_def
	const UNIONCAVE1F_POKEFAN_M1
	const UNIONCAVE1F_SUPER_NERD
	const UNIONCAVE1F_POKEFAN_M2
	const UNIONCAVE1F_FISHER1
	const UNIONCAVE1F_FISHER2
	const UNIONCAVE1F_POKE_BALL1
	const UNIONCAVE1F_POKE_BALL2
	const UNIONCAVE1F_POKE_BALL3
	const UNIONCAVE1F_POKE_BALL4

UnionCave1F_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerPokemaniacLarry:
	trainer POKEMANIAC, LARRY, EVENT_BEAT_POKEMANIAC_LARRY, PokemaniacLarrySeenText, PokemaniacLarryBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer PokemaniacLarryAfterBattleText

TrainerHikerRussell:
	trainer HIKER, RUSSELL, EVENT_BEAT_HIKER_RUSSELL, HikerRussellSeenText, HikerRussellBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer HikerRussellAfterBattleText

TrainerHikerDaniel:
	trainer HIKER, DANIEL, EVENT_BEAT_HIKER_DANIEL, HikerDanielSeenText, HikerDanielBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer HikerDanielAfterBattleText

TrainerFirebreatherBill:
	trainer FIREBREATHER, BILL, EVENT_BEAT_FIREBREATHER_BILL, FirebreatherBillSeenText, FirebreatherBillBeatenText, 0, .Script

.Script:
	endifjustbattled
	checkitem HM_CUT
	iftrue .lockdown_happened
	jumptextfaceplayer FirebreatherBillAfterBattleText

.lockdown_happened
	jumptextfaceplayer FirebreatherBillAfterBattle_MartRushText

TrainerFirebreatherRay:
	trainer FIREBREATHER, RAY, EVENT_BEAT_FIREBREATHER_RAY, FirebreatherRaySeenText, FirebreatherRayBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer FirebreatherRayAfterBattleText

UnionCave1FGreatBall:
	itemball GREAT_BALL

UnionCave1FXAttack:
	itemball X_ATTACK

UnionCave1FPotion:
	itemball POTION

UnionCave1FAwakening:
	itemball AWAKENING

HikerRussellSeenText: 
if DEF(_FR_FR)
	text "Tu vas à ECORCIA,"
	line "n'est-ce pas?"

	para "Voyons si tu as"
	line "les épaules..."
else
	text "You're headed to"
	line "AZALEA, are you?"

	para "Let my #MON see"
	line "if you are good"
	cont "enough to battle."
endc

	done

HikerRussellBeatenText: 
if DEF(_FR_FR)
	text "Oh, oh, oh!"
else
	text "Oh, oh, oh!"
endc

	done

HikerRussellAfterBattleText: 
if DEF(_FR_FR)
	text "Parfait! C'est"
	line "décidé..."

	para "Je vais entraîner"
	line "ici mes #MON à"
	cont "fond!"
else
	text "All right, then!"
	line "I've decided."

	para "I'm not leaving"
	line "until my #MON"
	cont "get tougher!"
endc

	done

PokemaniacLarrySeenText: 
if DEF(_FR_FR)
	text "Je parcours la"
	line "terre à la recher-"
	cont "che de #MON."

	para "Quoi? Toi aussi tu"
	line "les collectionnes?"

	para "Bah alors..."
	line "COMBAT!"
else
	text "I roam far and"
	line "wide in search of"
	cont "#MON."

	para "Are you looking"
	line "for #MON too?"

	para "Then you're my"
	line "collecting rival!"
endc

	done

PokemaniacLarryBeatenText: 
if DEF(_FR_FR)
	text "Non!!! Mes pauvres"
	line "#MON..."
else
	text "Ugh. My poor #-"
	line "MON…"
endc

	done

PokemaniacLarryAfterBattleText: 
if DEF(_FR_FR)
	text "Chaque vendredi on"
	line "peut entendre des"

	para "cris de #MON"
	line "venant de l'antre."
else
	text "Every Friday, you"
	line "can hear #MON"

	para "roars from deep"
	line "inside the cave."
endc

	done

HikerDanielSeenText: 
if DEF(_FR_FR)
	text "Whoa! Tu m'as"
	line "fait peur!"

	para "Je me croyais seul"
	line "dans le coin!"
else
	text "Whoa! What a"
	line "surprise!"

	para "I didn't expect to"
	line "see anyone here!"
endc

	done

HikerDanielBeatenText: 
if DEF(_FR_FR)
	text "Whoa! J'me suis"
	line "fait détruire!"
else
	text "Whoa! I'm beaten"
	line "big time!"
endc

	done

HikerDanielAfterBattleText: 
if DEF(_FR_FR)
	text "On m'a persuadé"
	line "d'acheter une"
	cont "QUEUE de RAMOLOSS."

	para "Mais j'ai des"
	line "remords..."
	cont "Pauvre #MON."
else
	text "I was conned into"
	line "buying a SLOWPOKE-"
	cont "TAIL."

	para "I feel sorry for"
	line "the poor #MON."
endc

	done

FirebreatherBillSeenText:
if DEF(_FR_FR)
	text "La rumeur court"
	line "qu'il y aura bien-"
	cont "tôt une annonce"
	cont "importante à la"
	cont "TV concernant"
	cont "l'épidémie."
else
	text "Rumour has it that"
	line "there will be an"
	cont "important announ-"
	cont "cement on TV about"
	cont "the epidemic soon."
endc
	done

FirebreatherBillBeatenText:
if DEF(_FR_FR)
	text "Je dois aller voir"
	line "les infos à la TV!"
else
	text "Gotta go watch the"
	line "news on TV!"
endc
	done

FirebreatherBillAfterBattleText:
if DEF(_FR_FR)
	text "Certains disent"
	line "qu'un confinement"
	cont "pourrait être"
	cont "annoncé..."
	
	para "Perso je pense que"
	line "c'est impossible."
else
	text "Some people say"
	line "that a lockdown"
	cont "could be announced"

	para "… I believe it's"
	line "impossible."
endc
	done

FirebreatherBillAfterBattle_MartRushText:
if DEF(_FR_FR)
	text "Puti j'y crois pas!"

	para "La rumeur disait"
	line "vrai!"
	
	para "Le gouvernement a"
	line "vraiment décrété"
	cont "un confinement"
	cont "national!"

	para "Ca ne s'est jamais"
	line "produit dans l'"
	cont "histoire de notre"
	cont "pays."

	para "Pas même pendant"
	line "les guerres!"
	
	para "Ce qui nous arrive"
	line "c'est lunaire!"
else
	text "Damn, I can't"
	line "believe it!"

	para "The rumors were"
	line "true!"

	para "The government"
	line "actually declared"
	cont "a nationwide"
	cont "lockdown!"

	para "This has never"
	line "happened before"
	cont "in our country's"
	cont "history."

	para "Not even during"
	line "war time!"

	para "What's happening"
	line "to us is surreal!"
endc
	done

FirebreatherRaySeenText: 
if DEF(_FR_FR)
	text "Une caverne éclai-"
	line "rée, ça fait pas"
	cont "peur."

	para "Avec du courage,"
	line "les méchants, ça"
	cont "fait pas peur."
else
	text "If it's light, a"
	line "cave isn't scary."

	para "If you're strong,"
	line "#MON aren't"
	cont "scary."
endc

	done

FirebreatherRayBeatenText: 
if DEF(_FR_FR)
	text "FLASH!"
else
	text "FLASH!"
endc

	done

FirebreatherRayAfterBattleText: 
if DEF(_FR_FR)
	text "Le feu de mon"
	line "#MON illumine"
	cont "cette caverne."
else
	text "It's my #MON's"
	line "fire that lights"
	cont "up this cave."
endc

	done

UnionCave1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  5, 19, UNION_CAVE_B1F, 3
	warp_event  3, 33, UNION_CAVE_B1F, 4
	warp_event 17, 31, ROUTE_33, 1
	warp_event 17,  3, ROUTE_32, 4

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  6, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, HIDE_CURFEW, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 2, TrainerHikerDaniel, -1
	object_event  4, 21, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_CURFEW, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerPokemaniacLarry, -1
	object_event 11,  8, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, HIDE_CURFEW, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 2, TrainerHikerRussell, -1
	object_event 15, 27, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 4, TrainerFirebreatherRay, -1
	object_event 14, 18, SPRITE_FISHER, SPRITEMOVEDATA_STANDING_UP, 0, 0, HIDE_CURFEW, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 4, TrainerFirebreatherBill, -1
	object_event 17, 21, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, UnionCave1FGreatBall, EVENT_UNION_CAVE_1F_GREAT_BALL
	object_event  4,  2, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, UnionCave1FXAttack, EVENT_UNION_CAVE_1F_X_ATTACK
	object_event  4, 17, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, UnionCave1FPotion, EVENT_UNION_CAVE_1F_POTION
	object_event 12, 33, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, UnionCave1FAwakening, EVENT_UNION_CAVE_1F_AWAKENING
