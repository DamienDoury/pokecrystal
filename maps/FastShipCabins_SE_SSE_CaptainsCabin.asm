	object_const_def
	const FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_CAPTAIN
	const FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_GENTLEMAN
	const FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN1
	const FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN2
	const FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_POKEFAN_M1
	const FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN3
	const FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN4
	const FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_SUPER_NERD1
	const FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_POKEFAN_M2
	const FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_POKEFAN_F
	const FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_SUPER_NERD2

FastShipCabins_SE_SSE_CaptainsCabin_MapScripts:
	def_scene_scripts

	def_callbacks

.DummyScene: ; unreferenced
	end

SSAquaCaptain:
	faceplayer
	opentext
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iftrue .LaterTrip
	writetext SSAquaCaptainExhaustingText
	waitbutton
	closetext
	end

.LaterTrip:
	writetext SSAquaCaptainHowDoYouLikeText
	waitbutton
	closetext
	end

SSAquaGranddaughterBefore:
	turnobject FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN2, RIGHT
	opentext
	writetext SSAquaGranddaughterCaptainPlayWithMeText
	waitbutton
	closetext
	faceplayer
	opentext
	writetext SSAquaGranddaughterHasToFindGrandpaText
	waitbutton
	closetext
	special FadeBlackQuickly
	special ReloadSpritesNoPalettes
	disappear FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN2
	applymovement PLAYER, SSAquaCaptainsCabinWarpsToGrandpasCabinMovement
	moveobject FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN1, 3, 19
	appear FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN1
	turnobject PLAYER, UP
	turnobject FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN1, UP
	special FadeInQuickly
	turnobject FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_GENTLEMAN, DOWN
	showemote EMOTE_SHOCK, FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_GENTLEMAN, 15
	applymovement FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN1, SSAquaGranddaughterEntersCabinMovement
	turnobject FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_GENTLEMAN, RIGHT
	checkflag ENGINE_PLAYER_IS_FEMALE
	iftrue .PlayerIsFemale
	opentext
	writetext SSAquaGranddaughterWasPlayingMText
	waitbutton
	closetext
	sjump .cont

.PlayerIsFemale:
	opentext
	writetext SSAquaGranddaughterWasPlayingFText
	waitbutton
	closetext
.cont:
	turnobject FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_TWIN2, DOWN
	applymovement FASTSHIPCABINS_SE_SSE_CAPTAINSCABIN_GENTLEMAN, SSAquaGrandpaApproachesPlayerMovement
	opentext
	writetext SSAquaEntertainedGranddaughterText
	promptbutton
	setevent EVENT_VERMILION_PORT_SAILOR_AT_GANGWAY
	setmapscene FAST_SHIP_1F, SCENE_DEFAULT
	sjump SSAquaMetalCoatAndDocking

SSAquaGrandpa:
	faceplayer
	opentext
	checkevent EVENT_GOT_METAL_COAT_FROM_GRANDPA_ON_SS_AQUA
	iftrue SSAquaGotMetalCoat
	checkevent EVENT_FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN_TWIN_2
	iftrue SSAquaFoundGranddaughter
	writetext SSAquaCantFindGranddaughterText
	waitbutton
	closetext
	setmapscene FAST_SHIP_1F, SCENE_DEFAULT
	end

SSAquaMetalCoatAndDocking:
	writetext SSAquaGrandpaHaveThisText
	promptbutton
	verbosegiveitem METAL_COAT
	iffalse .NoRoom
	setevent EVENT_GOT_METAL_COAT_FROM_GRANDPA_ON_SS_AQUA
.NoRoom:
	closetext
	waitsfx
	playsound SFX_ELEVATOR_END
	pause 30
	opentext
	writetext SSAquaHasArrivedVermilionText
	waitbutton
	checkevent EVENT_FAST_SHIP_FIRST_TIME
	iftrue .skip_power_outage_announcement
	writetext SSAquaPowerOutageText
	waitbutton
.skip_power_outage_announcement:
	setevent EVENT_FAST_SHIP_HAS_ARRIVED
	setevent EVENT_FAST_SHIP_FOUND_GIRL
	closetext
	end

SSAquaFoundGranddaughter:
	writetext SSAquaGrandpaHaveThisText
	promptbutton
	verbosegiveitem METAL_COAT
	iffalse .NoRoom
	setevent EVENT_GOT_METAL_COAT_FROM_GRANDPA_ON_SS_AQUA
.NoRoom:
	closetext
	end

SSAquaGotMetalCoat:
	writetext SSAquaGrandpaTravellingText
	waitbutton
	closetext
	end

SSAquaGranddaughterAfter:
	faceplayer
	opentext
	writetext SSAquaGranddaughterHadFunText
	waitbutton
	closetext
	end

TrainerPokefanmColin:
	trainer POKEFANM, COLIN, EVENT_BEAT_POKEFANM_COLIN, PokefanmColinSeenText, PokefanmColinBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer PokefanmColinAfterBattleText

TrainerTwinsMegandpeg1:
	trainer TWINS, MEGANDPEG1, EVENT_BEAT_TWINS_MEG_AND_PEG, TwinsMegandpeg1SeenText, TwinsMegandpeg1BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer TwinsMegandpeg1AfterBattleText

TrainerTwinsMegandpeg2:
	trainer TWINS, MEGANDPEG2, EVENT_BEAT_TWINS_MEG_AND_PEG, TwinsMegandpeg2SeenText, TwinsMegandpeg2BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer TwinsMegandpeg2AfterBattleText

TrainerPsychicRodney:
	trainer PSYCHIC_T, RODNEY, EVENT_BEAT_PSYCHIC_RODNEY, PsychicRodneySeenText, PsychicRodneyBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer PsychicRodneyAfterBattleText

TrainerPokefanmJeremy:
	trainer POKEFANM, JEREMY, EVENT_BEAT_POKEFANM_JEREMY, PokefanmJeremySeenText, PokefanmJeremyBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer PokefanmJeremyAfterBattleText

TrainerPokefanfGeorgia:
	trainer POKEFANF, GEORGIA, EVENT_BEAT_POKEFANF_GEORGIA, PokefanfGeorgiaSeenText, PokefanfGeorgiaBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer PokefanfGeorgiaAfterBattleText

TrainerSupernerdShawn:
	trainer SUPER_NERD, SHAWN, EVENT_BEAT_SUPER_NERD_SHAWN, SupernerdShawnSeenText, SupernerdShawnBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer SupernerdShawnAfterBattleText

FastShipCaptainsCabinTrashcan:
	jumpstd TrashCanScript

SSAquaCaptainsCabinWarpsToGrandpasCabinMovement:
	big_step RIGHT
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	big_step UP
	step_end

SSAquaGranddaughterEntersCabinMovement:
	step UP
	step UP
	turn_head LEFT
	step_end

SSAquaGrandpaApproachesPlayerMovement:
	turn_head DOWN
	step_end

SSAquaCaptainExhaustingText: 
if DEF(_FR_FR)
	text "Fouiii! Merci"
	line "d'être là."

	para "S'occuper de cette"
	line "petite fille est"
	cont "crevant."
else
	text "Whew! Thanks for"
	line "coming along."

	para "Keeping that lit-"
	line "tle girl amused"
	cont "was exhausting."
endc

	done

SSAquaCaptainHowDoYouLikeText: 
if DEF(_FR_FR)
	text "Tu aimes bien"
	line "l'AQUARIA?"

	para "Il vole sur les"
	line "vagues..."
else
	text "How do you like"
	line "S.S.AQUA's ride?"

	para "She practically"
	line "skates across the"
	cont "waves."
endc

	done

SSAquaCantFindGranddaughterText: 
if DEF(_FR_FR)
	text "Oh, bonjour..."

	para "Je ne trouve tou-"
	line "jours pas ma"
	cont "petite-fille."

	para "Elle peut être"
	line "assez soûlante,"

	para "j'espère qu'elle"
	line "n'embête personne."
else
	text "Oh, hello…"

	para "I still can't find"
	line "my granddaughter."

	para "If she's on the"
	line "ship, that's OK."

	para "She's an energetic"
	line "child, so she may"

	para "be bugging some-"
	line "one. I'm worried…"
endc

	done

SSAquaEntertainedGranddaughterText: 
if DEF(_FR_FR)
	text "<PLAY_G>, c'est ça?"
	line "On m'a dit que tu"
	cont "as pris soin de ma"
	cont "petite-fille."

	para "Je tiens à te"
	line "remercier."
else
	text "<PLAY_G>, was it?"
	line "I heard you enter-"
	cont "tained my grand-"
	cont "daughter."

	para "I want to thank"
	line "you for that."
endc

	done

SSAquaGrandpaHaveThisText: 
if DEF(_FR_FR)
	text "Je tiens à ce que"
	line "tu acceptes ceci!"
else
	text "I know! I'd like"
	line "you to have this!"
endc

	done

SSAquaGrandpaTravellingText: 
if DEF(_FR_FR)
	text "Nous voyageons"
	line "autour du monde."
else
	text "We're traveling"
	line "around the world."
endc

	done

SSAquaGranddaughterCaptainPlayWithMeText: 
if DEF(_FR_FR)
	text "Hé CAPITAINE! Tu"
	line "joues avec moi?"

	para "Vazy steuplait!"
	line "Vazy m'sieur!"
else
	text "CAPTAIN, play with"
	line "me, please?"

	para "I'm bored! I want"
	line "to play more!"
endc

	done

SSAquaGranddaughterHasToFindGrandpaText: 
if DEF(_FR_FR)
	text "Tu viens jouer"
	line "avec moi?"

	para "...Oh!"

	para "Pépé s'inquiète"
	line "pour moi?"

	para "J'y vais!"

	para "J'dois trouver mon"
	line "p'tit pépé!"
else
	text "Hi! Will you play"
	line "with me?"

	para "…Oh!"

	para "Grandpa's worried"
	line "about me?"

	para "I have to go!"

	para "I have to go find"
	line "Grandpa!"
endc

	done

SSAquaGranddaughterWasPlayingMText: 
if DEF(_FR_FR)
	text "Me voilà pépé!"
	line "Je jouais avec le"

	para "CAPITAINE et ce"
	line "garçon!"
else
	text "Grandpa, here I"
	line "am! I was playing"

	para "with the CAPTAIN"
	line "and this guy!"
endc

	done

SSAquaGranddaughterWasPlayingFText: 
if DEF(_FR_FR)
	text "Me voilà pépé!"
	line "Je jouais avec le"

	para "CAPITAINE et cette"
	line "fille!"
else
	text "Grandpa, here I"
	line "am! I was playing"

	para "with the CAPTAIN"
	line "and this big girl!"
endc

	done

SSAquaGranddaughterHadFunText: 
if DEF(_FR_FR)
	text "Je me suis"
	line "super amusée!"
else
	text "I had lots of fun"
	line "playing!"
endc

	done

PokefanmColinSeenText: 
if DEF(_FR_FR)
	text "Toi! Veux-tu te"
	line "battre avec moi?"
else
	text "Hey, kid! Want to"
	line "battle with me?"
endc

	done

PokefanmColinBeatenText: 
if DEF(_FR_FR)
	text "T'es balèze!"
else
	text "You're strong!"
endc

	done

PokefanmColinAfterBattleText: 
if DEF(_FR_FR)
	text "Tu voyages?"

	para "Et ta maman elle"
	line "s'inquiète pas?"
else
	text "You're traveling"
	line "all alone?"

	para "Isn't your mom"
	line "worried?"
endc

	done

TwinsMegandpeg1SeenText: 
if DEF(_FR_FR)
	text "Tu me prends pour"
	line "un bébé?"
	cont "Ouiiiin!"
else
	text "You think I'm a"
	line "baby?"
	cont "That's not fair!"
endc

	done

TwinsMegandpeg1BeatenText: 
if DEF(_FR_FR)
	text "Oh! Perdu!"
else
	text "Oh! We lost!"
endc

	done

TwinsMegandpeg1AfterBattleText: 
if DEF(_FR_FR)
	text "On est des filles!"
	line "Pas des bébés!"
	cont "Compris?"
else
	text "Baby is a rude"
	line "name to call us"
	cont "girls!"
endc

	done

TwinsMegandpeg2SeenText: 
if DEF(_FR_FR)
	text "On n'est pas des"
	line "bébés mais des"
	cont "belles dames!"
else
	text "I'm not a baby!"

	para "That's not nice to"
	line "say to a lady!"
endc

	done

TwinsMegandpeg2BeatenText: 
if DEF(_FR_FR)
	text "Oh! Perdu!"
else
	text "Oh! We lost!"
endc

	done

TwinsMegandpeg2AfterBattleText: 
if DEF(_FR_FR)
	text "Les enfants sont"
	line "plus malins que"
	cont "les adultes!"
else
	text "Sometimes, kids"
	line "are smarter than"
	cont "grown-ups!"
endc

	done

PsychicRodneySeenText: 
if DEF(_FR_FR)
	text "Silence! Mon cer-"
	line "veau capte un"
	cont "signal radio!"
else
	text "Ssh! My brain is"
	line "picking up radio"
	cont "signals!"
endc

	done

PsychicRodneyBeatenText: 
if DEF(_FR_FR)
	text "... J'entends"
	line "quelque chose!"
else
	text "…I hear some-"
	line "thing!"
endc

	done

PsychicRodneyAfterBattleText: 
if DEF(_FR_FR)
	text "Je sais: tu peux"
	line "écouter la radio"
	cont "de JOHTO sur le"
	cont "BATEAU EXPRESS."
else
	text "I get it. You can"
	line "hear JOHTO's radio"
	cont "on the FAST SHIP."
endc

	done

PokefanmJeremySeenText: 
if DEF(_FR_FR)
	text "Qu'en penses-tu?"
	line "Mes #MON sont"
	cont "beaux, non?"
else
	text "What do you think?"
	line "My #MON are"
	cont "beautiful, yes?"
endc

	done

PokefanmJeremyBeatenText: 
if DEF(_FR_FR)
	text "Oh, non! Mes beaux"
	line "#MON!"
else
	text "Oh, no! My beauti-"
	line "ful #MON!"
endc

	done

PokefanmJeremyAfterBattleText: 
if DEF(_FR_FR)
	text "Je dois aller au"
	line "SALON #MON et"
	cont "les toiletter!"
else
	text "I must go to the"
	line "#MON SALON and"
	cont "fix them up nice!"
endc

	done

PokefanfGeorgiaSeenText: 
if DEF(_FR_FR)
	text "Je vais faire mes"
	line "courses au GRAND"
	cont "MAGASIN et puis..."
else
	text "I'm going to shop"
	line "at the DEPT.STORE"
	cont "and then…"
endc

	done

PokefanfGeorgiaBeatenText: 
if DEF(_FR_FR)
	text "Qu'est-ce que je"
	line "devais faire?"
else
	text "What was I going"
	line "to do?"
endc

	done

PokefanfGeorgiaAfterBattleText: 
if DEF(_FR_FR)
	text "Ah oui! Je dois"
	line "aller chercher mon"
	cont "#MON à la"
	cont "PENSION!"
else
	text "Oh, yes! I have to"
	line "get my #MON out"
	cont "of DAY-CARE!"
endc

	done

SupernerdShawnSeenText: 
if DEF(_FR_FR)
	text "Quels types de"
	line "# BALLS as-tu"
	cont "sur toi?"
else
	text "What kinds of #"
	line "BALLS do you have"
	cont "with you?"
endc

	done

SupernerdShawnBeatenText: 
if DEF(_FR_FR)
	text "Attends! Stop!"
	line "Pitié!"
else
	text "Wait! Stop! Don't!"
	line "Please!"
endc

	done

SupernerdShawnAfterBattleText: 
if DEF(_FR_FR)
	text "Il faut utiliser"
	line "les bonnes BALLS"
	cont "en fonction de la"
	cont "situation."
else
	text "You should use the"
	line "right BALLS to fit"
	cont "the situation."
endc

	done

SSAquaHasArrivedVermilionText: 
if DEF(_FR_FR)
	text "Le BATEAU EXPRESS"
	line "AQUARIA est arrivé"
	cont "à CARMIN SUR MER."
else
	text "FAST SHIP S.S.AQUA"
	line "has arrived in"
	cont "VERMILION CITY."
endc

	done

SSAquaPowerOutageText: ; TO TRANSLATE
	text "We have a special"
	line "announcement to"
	cont "make…"

	para "We've been informed"
	line "of a massive power"
	cont "outage in KANTO."

	para "#MON CENTERS"
	line "are functioning on"
	cont "emergency power."

	para "Their healing"
	line "service is not"
	cont "affected,"

	para "but the PCs are"
	line "working in a"
	cont "limited capacity."

	para "No one could tell"
	line "us when this issue"
	cont "will be solved."

	para "As your captain,"
	line "I'm advising you to"
	cont "use the onboard PC"
	
	para "to make sure you"
	line "have everything"
	cont "you need before"

	para "you leave the"
	line "ship."

	para "Have a nice stay"
	line "in KANTO!"
	done

FastShipCabins_SE_SSE_CaptainsCabin_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, FAST_SHIP_1F, 8
	warp_event  3,  7, FAST_SHIP_1F, 8
	warp_event  2, 19, FAST_SHIP_1F, 9
	warp_event  3, 19, FAST_SHIP_1F, 9
	warp_event  2, 33, FAST_SHIP_1F, 10
	warp_event  3, 33, FAST_SHIP_1F, 10

	def_coord_events

	def_bg_events
	bg_event  4, 25, BGEVENT_READ, FastShipCaptainsCabinTrashcan

	def_object_events
	object_event  3, 25, SPRITE_CAPTAIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SSAquaCaptain, -1
	object_event  1, 17, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, SSAquaGrandpa, EVENT_FAST_SHIP_CABINS_SE_SSE_GENTLEMAN
	object_event  3, 17, SPRITE_TWIN, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SSAquaGranddaughterAfter, EVENT_FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN_TWIN_1
	object_event  2, 25, SPRITE_TWIN, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, SSAquaGranddaughterBefore, EVENT_FAST_SHIP_CABINS_SE_SSE_CAPTAINS_CABIN_TWIN_2
	object_event  5,  6, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 5, TrainerPokefanmColin, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	object_event  2,  4, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerTwinsMegandpeg1, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	object_event  3,  4, SPRITE_TWIN, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerTwinsMegandpeg2, EVENT_FAST_SHIP_PASSENGERS_FIRST_TRIP
	object_event  5,  5, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 5, TrainerPsychicRodney, EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
	object_event  2,  3, SPRITE_POKEFAN_M, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 3, TrainerPokefanmJeremy, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	object_event  5,  5, SPRITE_POKEFAN_F, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_TRAINER, 1, TrainerPokefanfGeorgia, EVENT_FAST_SHIP_PASSENGERS_WESTBOUND
	object_event  1, 15, SPRITE_SUPER_NERD, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_TRAINER, 2, TrainerSupernerdShawn, EVENT_FAST_SHIP_PASSENGERS_EASTBOUND
