	object_const_def
	const ROUTE14_POKEFAN_M1
	const ROUTE14_YOUNGSTER
	const ROUTE14_POKEFAN_M2
	const ROUTE14_KIM

Route14_MapScripts:
	def_scene_scripts

	def_callbacks

Kim:
	faceplayer
	opentext
	trade NPC_TRADE_KIM
	waitbutton
	closetext
	end

TrainerPokefanmCarter:
	trainer POKEFANM, CARTER, EVENT_BEAT_POKEFANM_CARTER, PokefanmCarterSeenText, PokefanmCarterBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PokefanmCarterAfterBattleText
	waitbutton
	closetext
	end

TrainerBirdKeeperRoy:
	trainer BIRD_KEEPER, ROY, EVENT_BEAT_BIRD_KEEPER_ROY, BirdKeeperRoySeenText, BirdKeeperRoyBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext BirdKeeperRoyAfterBattleText
	waitbutton
	closetext
	end

TrainerPokefanmTrevor:
	trainer POKEFANM, TREVOR, EVENT_BEAT_POKEFANM_TREVOR, PokefanmTrevorSeenText, PokefanmTrevorBeatenText, 0, .Script

.Script:
	endifjustbattled
	opentext
	writetext PokefanmTrevorAfterBattleText
	waitbutton
	closetext
	end

PokefanmCarterSeenText: 
if DEF(_FR_FR)
	text "J'ai eu du mal à"
	line "attraper mes #-"

	para "MON rares et super"
	line "jolis."
else
	text "Let me tell you,"
	line "I had a hard time"

	para "catching my prized"
	line "#MON."
endc

	done

PokefanmCarterBeatenText: 
if DEF(_FR_FR)
	text "Awaaah!"
else
	text "Awaaah!"
endc

	done

PokefanmCarterAfterBattleText: ; TO TRANSLATE
	text "SQUIRTLE, CHARMAN-"
	line "DER and BULBASAUR…"

	para "I found them"
	line "around in KANTO."

	para "But they're"
	line "very rare!"
	done

BirdKeeperRoySeenText: 
if DEF(_FR_FR)
	text "Je rêve de voler"
	line "avec mes amis les"
	cont "#MON oiseaux."
else
	text "My dream is to fly"
	line "with my beloved"
	cont "bird #MON."
endc

	done

BirdKeeperRoyBeatenText: 
if DEF(_FR_FR)
	text "Je rêve mais je ne"
	line "volerai jamais..."
else
	text "I can dream, but I"
	line "can't ever fly…"
endc

	done

BirdKeeperRoyAfterBattleText: 
if DEF(_FR_FR)
	text "Tu as des #MON"
	line "qui ont appris la"

	para "CS VOL, non? Tu as"
	line "trop de chance."
else
	text "You have #MON"
	line "that know the HM"

	para "move FLY, don't"
	line "you? I envy you."
endc

	done

PokefanmTrevorSeenText: 
if DEF(_FR_FR)
	text "Le savais-tu?"

	para "Les #MON sont"
	line "plus amicaux s'ils"

	para "sont entraînés"
	line "dans un endroit"
	cont "familier."
else
	text "Hi. Did you know…?"

	para "#MON get more"
	line "friendly if you"

	para "train them in a"
	line "place that they"
	cont "remember."
endc

	done

PokefanmTrevorBeatenText: 
if DEF(_FR_FR)
	text "Où ai-je rencontré"
	line "ce PSYKOKWAK?"
else
	text "Where did I meet"
	line "this PSYDUCK?"
endc

	done

PokefanmTrevorAfterBattleText: 
if DEF(_FR_FR)
	text "Y a-t-il un moyen"
	line "de savoir où l'on"

	para "a trouvé nos"
	line "#MON?"
else
	text "If only there were"
	line "an easy way to"

	para "identify where I"
	line "got my #MON…"
endc

	done

Route14_MapEvents:
	db 0, 0 ; filler

	def_warp_events

	def_coord_events

	def_bg_events

	def_object_events
	object_event 12, 15, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 4, TrainerPokefanmCarter, -1
	object_event 11, 27, SPRITE_YOUNGSTER, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 3, TrainerBirdKeeperRoy, -1
	object_event  6, 11, SPRITE_POKEFAN_M, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerPokefanmTrevor, -1
	object_event  7,  5, SPRITE_TEACHER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 4, Kim, -1
