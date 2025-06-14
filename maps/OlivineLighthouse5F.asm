	object_const_def
	const OLIVINELIGHTHOUSE5F_SAILOR
	const OLIVINELIGHTHOUSE5F_YOUNGSTER
	const OLIVINELIGHTHOUSE5F_POKE_BALL1
	const OLIVINELIGHTHOUSE5F_POKE_BALL2
	const OLIVINELIGHTHOUSE5F_POKE_BALL3

OlivineLighthouse5F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback
	
.EnterCallback:
	readmem wFreedomStateWhenEntered
	ifnotequal 1 << CURFEW, .EndCallback

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1

.EndCallback:
	endcallback

TrainerBirdKeeperDenis:
	trainer BIRD_KEEPER, DENIS, EVENT_BEAT_BIRD_KEEPER_DENIS, BirdKeeperDenisSeenText, BirdKeeperDenisBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BirdKeeperDenisAfterBattleText

TrainerSailorErnest:
	trainer SAILOR, ERNEST, EVENT_BEAT_SAILOR_ERNEST, SailorErnestSeenText, SailorErnestBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SailorErnestAfterBattleText

OlivineLighthouse5FRareCandy:
	itemball RARE_CANDY

OlivineLighthouse5FSuperRepel:
	itemball SUPER_REPEL

OlivineLighthouse5FTMSwagger:
	itemball TM_SWAGGER

OlivineLighthouse5FHiddenHyperPotion:
	hiddenitem HYPER_POTION, EVENT_OLIVINE_LIGHTHOUSE_5F_HIDDEN_HYPER_POTION

SailorErnestSeenText: 
if DEF(_FR_FR)
	text "Je voulais défier"
	line "JASMINE mais ce"

	para "n'est pas le mo-"
	line "ment. Et toi, ça"
	cont "te tente?"
else
	text "I wanted to battle"
	line "JASMINE, but she's"

	para "not up to it now."
	line "So, how about you?"
endc

	done

SailorErnestBeatenText: 
if DEF(_FR_FR)
	text "Fouiiii!"
	line "T'es trop, toi!"
else
	text "Whoa, whoa. You're"
	line "overwhelming!"
endc

	done

SailorErnestAfterBattleText: 
if DEF(_FR_FR)
	text "Un CHAMPION n'est"
	line "pas seulement fort"

	para "mais il se doit"
	line "d'être aussi"
	cont "compatissant."
else
	text "A GYM LEADER isn't"
	line "just about being"

	para "strong. A LEADER"
	line "also needs to be"
	cont "compassionate."
endc

	done

BirdKeeperDenisSeenText: 
if DEF(_FR_FR)
	text "C'est haut ici!"
	line "Mes #MON"

	para "oiseaux sont en"
	line "super forme."
else
	text "We're pretty high"
	line "up here. My bird"

	para "#MON are in"
	line "prime form."
endc

	done

BirdKeeperDenisBeatenText: 
if DEF(_FR_FR)
	text "Mayday!"
	line "Mayday!"
else
	text "Oops…They crashed…"
endc

	done

BirdKeeperDenisAfterBattleText: 
if DEF(_FR_FR)
	text "Mon #MON a"
	line "appris VOL à"
	cont "IRISIA."

	para "Et puisque j'ai"
	line "perdu, je vais"
	cont "VOLER autre part!"
else
	text "My #MON learned"
	line "how to use FLY in"
	cont "CIANWOOD."

	para "Well, since I'm a"
	line "loser, I'll FLY"
	cont "across the sea…"
endc

	done

OlivineLighthouse5F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9, 15, OLIVINE_LIGHTHOUSE_6F, 1
	warp_event  3,  5, OLIVINE_LIGHTHOUSE_4F, 2
	warp_event  9,  7, OLIVINE_LIGHTHOUSE_4F, 3
	warp_event 16,  7, OLIVINE_LIGHTHOUSE_4F, 9
	warp_event 17,  7, OLIVINE_LIGHTHOUSE_4F, 10
	warp_event 16,  5, OLIVINE_LIGHTHOUSE_6F, 2
	warp_event 17,  5, OLIVINE_LIGHTHOUSE_6F, 3

	def_coord_events

	def_bg_events
	bg_event  3, 13, BGEVENT_ITEM, OlivineLighthouse5FHiddenHyperPotion

	def_object_events
	object_event  8, 11, SPRITE_SAILOR, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerSailorErnest, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  8,  3, SPRITE_YOUNGSTER, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 4, TrainerBirdKeeperDenis, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event 15, 12, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, OlivineLighthouse5FRareCandy, EVENT_OLIVINE_LIGHTHOUSE_5F_RARE_CANDY
	object_event  6, 15, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, OlivineLighthouse5FSuperRepel, EVENT_OLIVINE_LIGHTHOUSE_5F_SUPER_REPEL
	object_event  2, 13, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, OlivineLighthouse5FTMSwagger, EVENT_OLIVINE_LIGHTHOUSE_5F_TM_SWAGGER
