	object_const_def
	const CELADONGYM_ERIKA
	const CELADONGYM_GYM_GUIDE
	const CELADONGYM_LASS1
	const CELADONGYM_LASS2
	const CELADONGYM_BEAUTY
	const CELADONGYM_TWIN1
	const CELADONGYM_TWIN2

CeladonGym_MapScripts:
	def_scene_scripts
	scene_script .TeamCheck ; SCENE_ALWAYS

	def_callbacks
	callback MAPCALLBACK_TILES, .EnterCallback

.EnterCallback:
	clearevent EVENT_POKEMON_JUST_EVOLVED
	
	checkevent EVENT_CROWD_IN_VACCINATION_CENTER
	iffalse .end
	moveobject CELADONGYM_GYM_GUIDE, 4, 14
.end
	endcallback

.TeamCheck:
	checkevent EVENT_BEAT_ERIKA
	iftrue .no_check
	
	checkevent EVENT_POKEMON_JUST_EVOLVED
	iffalse .enter_check
	clearevent EVENT_POKEMON_JUST_EVOLVED
	scall CeladonGymCheckForbiddenTypes
	iffalse .enter_check

	callstd GymKickPlayerOutAfterEvolution
	sjump .player_leaves

.enter_check
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8
	iftrue .no_check
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_8

	checkevent EVENT_CROWD_IN_VACCINATION_CENTER
	iftrue .is_closed

	setval EGG
	special FindPartyMonThatSpecies
	iftrue .egg_found

	special IsWholeTeamVaccinated
	iffalse .team_not_fully_vaccinated

	scall CeladonGymCheckForbiddenTypes
	iftrue .do_check

	callstd IsVaccinePassportValid
	ifequal 0, .no_check

	jumpstd VaccinePassCheckpointCeladonGym

.team_not_fully_vaccinated
	setlasttalked CELADONGYM_GYM_GUIDE
	callstd GymGuideWalksTowardsPlayerScript
	
	opentext
	farwritetext _GymGuideNotVaccinatedText
	waitbutton
	closetext
	
	sjump .player_leaves

.egg_found
	setlasttalked CELADONGYM_GYM_GUIDE
	callstd GymGuideWalksTowardsPlayerScript
	
	opentext
	farwritetext _GymGuideEggText
	callstd GymGuideTextSequel
	
	sjump .player_leaves

.is_closed
	setlasttalked CELADONGYM_GYM_GUIDE
	
	opentext
	writetext CeladonGymGuideClosedText
	waitbutton
	closetext
	
	sjump .player_leaves

.do_check
	setlasttalked CELADONGYM_GYM_GUIDE
	callstd GymGuideWalksTowardsPlayerScript
	callstd GymGuideChecksPlayersTeamScript

.player_leaves
	callstd GymGuidePlayerLeavesScript
	warp CELADON_CITY, 10, 29
.no_check
	end

CeladonGymCheckForbiddenTypes:
	setval FIRE
	special CheckTypePresenceInParty
	iftrue .forbidden
	setval ICE
	special CheckTypePresenceInParty
	iftrue .forbidden
	setval BUG
	special CheckTypePresenceInParty
	iftrue .forbidden
	setval POISON
	special CheckTypePresenceInParty
	iftrue .forbidden
	setval FLYING
	special CheckTypePresenceInParty
	iftrue .forbidden

	setval FALSE
	end

.forbidden
	end

CeladonGymErikaScript:
	faceplayer
	opentext
	checkflag ENGINE_RAINBOWBADGE
	iftrue .GotGigaDrain
	writetext ErikaBeforeBattleText
	waitbutton
	closetext
	winlosstext ErikaBeatenText, 0
	loadtrainer ERIKA, ERIKA1
	startbattle
	reloadmapafterbattle
	setevent EVENT_BEAT_ERIKA
	setevent EVENT_BEAT_LASS_MICHELLE
	setevent EVENT_BEAT_PICNICKER_TANYA
	setevent EVENT_BEAT_BEAUTY_JULIA
	setevent EVENT_BEAT_TWINS_JO_AND_ZOE
	opentext
	writetext PlayerReceivedRainbowBadgeText
	playsound SFX_GET_BADGE
	waitsfx
	setflag ENGINE_RAINBOWBADGE
	farscall GotNewKantoBadge
	writetext ErikaExplainTMText
	promptbutton
	verbosegiveitem TM_GIGA_DRAIN
.GotGigaDrain:
	writetext ErikaAfterBattleText
	waitbutton
	closetext
	end

TrainerLassMichelle:
	trainer LASS, MICHELLE, EVENT_BEAT_LASS_MICHELLE, LassMichelleSeenText, LassMichelleBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer LassMichelleAfterBattleText

TrainerPicnickerTanya:
	trainer PICNICKER, TANYA, EVENT_BEAT_PICNICKER_TANYA, PicnickerTanyaSeenText, PicnickerTanyaBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer PicnickerTanyaAfterBattleText

TrainerBeautyJulia:
	trainer BEAUTY, JULIA, EVENT_BEAT_BEAUTY_JULIA, BeautyJuliaSeenText, BeautyJuliaBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer BeautyJuliaAfterBattleText

TrainerTwinsJoAndZoe1:
	trainer TWINS, JOANDZOE1, EVENT_BEAT_TWINS_JO_AND_ZOE, TwinsJoAndZoe1SeenText, TwinsJoAndZoe1BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer TwinsJoAndZoe1AfterBattleText

TrainerTwinsJoAndZoe2:
	trainer TWINS, JOANDZOE2, EVENT_BEAT_TWINS_JO_AND_ZOE, TwinsJoAndZoe2SeenText, TwinsJoAndZoe2BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer TwinsJoAndZoe2AfterBattleText

CeladonGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_BEAT_ERIKA
	iftrue .CeladonGymGuideWinScript
	writetext CeladonGymGuideText
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_3
	farscall GotBadgeNoTrainerCard
	waitbutton
	closetext
	end

.CeladonGymGuideWinScript:
	writetext CeladonGymGuideWinText
	waitbutton
	closetext
	end

CeladonGymStatue:
	checkflag ENGINE_RAINBOWBADGE
	iftrue .Beaten
	jumpstd GymStatue1Script
.Beaten:
	gettrainername STRING_BUFFER_4, ERIKA, ERIKA1
	jumpstd GymStatue2Script

ErikaBeforeBattleText: ; TO TRANSLATE
	text "ERIKA: Hello…"
	line "Lovely weather,"
	cont "isn't it?"

	para "It always feels"
	line "like spring in"
	cont "this climate cont-"
	cont "rolled greenhouse…"

	para "…GRASS #MON are"
	line "blooming all year"

	para "round, a true"
	line "heaven…"

	para "…Oh? All the way"
	line "from JOHTO, you"
	cont "say? How nice…"

	para "Oh. I'm sorry, I"
	line "didn't realize"

	para "that you wished to"
	line "challenge me."

	para "My name is ERIKA."
	line "I am the LEADER of"
	cont "CELADON GYM."

	para "My #MON friends"
	line "grew up it this"
	cont "garden. They are"
	cont "a part of this"
	cont "ecosystem…"

	para "Shall we begin?"
	done

ErikaBeatenText: 
if DEF(_FR_FR)
	text "ERIKA: Oh!"
	line "J'ai perdu..."

	para "Toi t'es un p'tit"
	line "tigre..."

	para "Voilà pour toi: le"
	line "BADGE PRISME..."
else
	text "ERIKA: Oh!"
	line "I concede defeat…"

	para "You are remarkably"
	line "strong…"

	para "I shall give you"
	line "RAINBOWBADGE…"
endc

	done

PlayerReceivedRainbowBadgeText: 
if DEF(_FR_FR)
	text "<PLAYER> reçoit"
	line "le BADGE PRISME."
else
	text "<PLAYER> received"
	line "RAINBOWBADGE."
endc

	done

ErikaExplainTMText: 
if DEF(_FR_FR)
	text "ERIKA: Quel beau"
	line "match."

	para "Je tiens à ce que"
	line "tu acceptes cette"
	cont "belle CT."

	para "C'est la"
	line "GIGA-SANGSUE."

	para "Cette capacité"
	line "draine la moitié"

	para "des dégâts infli-"
	line "gés pour soigner"
	cont "ton #MON."

	para "Tu verras, c'est"
	line "très utile..."
else
	text "ERIKA: That was a"
	line "delightful match."

	para "I felt inspired."
	line "Please, I wish you"
	cont "to have this TM."

	para "It is GIGA DRAIN."

	para "It is a wonderful"
	line "move that drains"

	para "half the damage it"
	line "inflicts to heal"
	cont "your #MON."

	para "Please use it if"
	line "it pleases you…"
endc

	done

ErikaAfterBattleText: 
if DEF(_FR_FR)
	text "ERIKA: Perdre"
	line "fait toujours un"
	cont "peu mal mais..."

	para "Combattre un bon"
	line "adversaire est"
	cont "stimulant..."
else
	text "ERIKA: Losing"
	line "leaves a bitter"
	cont "aftertaste…"

	para "But knowing that"
	line "there are strong"

	para "trainers spurs me"
	line "to do better…"
endc

	done

LassMichelleSeenText: 
if DEF(_FR_FR)
	text "Ca t'étonne une"
	line "ARENE remplie"
	cont "de filles?"
else
	text "Do you think a"
	line "girls-only GYM"
	cont "is rare?"
endc

	done

LassMichelleBeatenText: 
if DEF(_FR_FR)
	text "Ouiiiiin!"
else
	text "Oh, bleah!"
endc

	done

LassMichelleAfterBattleText: 
if DEF(_FR_FR)
	text "Je ne faisais pas"
	line "attention!"
else
	text "I just got care-"
	line "less, that's all!"
endc

	done

PicnickerTanyaSeenText: 
if DEF(_FR_FR)
	text "Un combat?"
	line "Heu...non."
	cont "..."
	cont "Allez, d'accord!"
else
	text "Oh, a battle?"
	line "That's kind of"
	cont "scary, but OK!"
endc

	done

PicnickerTanyaBeatenText: 
if DEF(_FR_FR)
	text "C'est fini?"
else
	text "Oh, that's it?"
endc

	done

PicnickerTanyaAfterBattleText: 
if DEF(_FR_FR)
	text "T'en as plein des"
	line "BADGES. Comment"

	para "je pouvais gagner,"
	line "moi?!"
else
	text "Oh, look at all"
	line "your BADGES. No"

	para "wonder I couldn't"
	line "win!"
endc

	done

BeautyJuliaSeenText: 
if DEF(_FR_FR)
	text "Tu regardes les"
	line "fleurs ou c'est"
	cont "moi que tu mates?"
else
	text "Were you looking"
	line "at these flowers"
	cont "or at me?"
endc

	done

BeautyJuliaBeatenText: 
if DEF(_FR_FR)
	text "C'est pas bien!"
else
	text "How annoying!"
endc

	done

BeautyJuliaAfterBattleText: 
if DEF(_FR_FR)
	text "Comment devenir"
	line "une belle fille"
	cont "comme ERIKA?"
else
	text "How do I go about"
	line "becoming ladylike"
	cont "like ERIKA?"
endc

	done

TwinsJoAndZoe1SeenText: 
if DEF(_FR_FR)
	text "ERIKA nous a ap-"
	line "pris plein de"
	cont "trucs!"
else
	text "We'll show you"
	line "#MON moves that"
	cont "ERIKA taught us!"
endc

	done

TwinsJoAndZoe1BeatenText: 
if DEF(_FR_FR)
	text "Oh... On a perdu."
else
	text "Oh… We lost…"
endc

	done

TwinsJoAndZoe1AfterBattleText: 
if DEF(_FR_FR)
	text "ERIKA!"
	line "Venge-nous!"
else
	text "ERIKA will get you"
	line "back for us!"
endc

	done

TwinsJoAndZoe2SeenText: 
if DEF(_FR_FR)
	text "On doit protéger"
	line "la grande ERIKA!"
else
	text "We're going to"
	line "protect ERIKA!"
endc

	done

TwinsJoAndZoe2BeatenText: 
if DEF(_FR_FR)
	text "Nooooonn...."
else
	text "We couldn't win…"
endc

	done

TwinsJoAndZoe2AfterBattleText: 
if DEF(_FR_FR)
	text "ERIKA est bien"
	line "plus forte!"
else
	text "ERIKA is much,"
	line "much stronger!"
endc

	done

CeladonGymGuideText: ; TO TRANSLATE
	text "Welcome, CHAMP!"

	para "(achii)"

	para "This GYM is a"
	line "greenhouse."

	para "I can't take part" 
	line "in battles because"
	cont "I keep sneezing."

	para "I'm allergic to"
	line "pollen."

	para "(achoo)"

	para "To get protected"
	line "from it, have your"
	cont "#MON wear a"
	cont "#MASK."

	para "Good luck to you!"
	done

CeladonGymGuideWinText: ; TO TRANSLATE
	text "You did…"
	para "(ACHII)"
	para "…!"
	done

CeladonGymGuideClosedText: ; TO TRANSLATE
	text "Hello sweet"
	line "trainer!"

	para "I am sorry but"
	line "ERIKA decided to"

	para "close this GYM"
	line "until a vaccine"

	para "for #MON has"
	line "been made"
	cont "available."

	para "…"
	line "(achii)"

	para "She wants to "
	line "preserve this"
	
	para "wonderful GYM and"
	line "the health of its"
	cont "trainers."

	para "Hopefully the"
	line "vaccine should be"
	cont "ready quite soon."

	para "See you later!"
	done

_GymGuideNotVaccinatedText: ; TO TRANSLATE
	text "Hello dear!"

	para "ERIKA demands that"
	line "all #MON be"
	
	para "vaccinated to"
	line "enter this GYM."

	para "I cannot allow you"
	line "in, I'm sorry."

	para "You will find the"
	line "VACCINATION"
	
	para "CENTER in SAFFRON"
	line "CITY."

	para "Take care my"
	line "friend!"
	done

CeladonGym_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 17, CELADON_CITY, 8
	warp_event  5, 17, CELADON_CITY, 8

	def_coord_events

	def_bg_events
	bg_event  3, 15, BGEVENT_READ, CeladonGymStatue
	bg_event  6, 15, BGEVENT_READ, CeladonGymStatue

	def_object_events
	object_event  5,  3, SPRITE_ERIKA, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, CeladonGymErikaScript, -1
	object_event  7, 15, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, CeladonGymGuideScript, -1
	object_event  7,  8, SPRITE_LASS, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerLassMichelle, -1
	object_event  2,  8, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_TRAINER, 2, TrainerPicnickerTanya, -1
	object_event  3,  5, SPRITE_BEAUTY, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 2, TrainerBeautyJulia, -1
	object_event  4, 10, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerTwinsJoAndZoe1, -1
	object_event  5, 10, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerTwinsJoAndZoe2, -1
