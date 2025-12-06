	object_const_def
	const TINTOWER1F_SUICUNE
	const TINTOWER1F_RAIKOU
	const TINTOWER1F_ENTEI
	const TINTOWER1F_EUSINE
	const TINTOWER1F_SAGE1
	const TINTOWER1F_SAGE2
	const TINTOWER1F_SAGE3
	const TINTOWER1F_SAGE4
	const TINTOWER1F_SAGE5
	const TINTOWER1F_SAGE6

TinTower1F_MapScripts:
	def_scene_scripts
	scene_script .FaceSuicune ; SCENE_DEFAULT
	scene_script .DummyScene ; SCENE_FINISHED

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .NPCsCallback
	callback MAPCALLBACK_TILES, .StairsCallback

.FaceSuicune:
	prioritysjump .SuicuneBattle
	end

.DummyScene:
	end

.NPCsCallback:
	checkevent EVENT_GOT_RAINBOW_WING
	iftrue .GotRainbowWing
	checkevent EVENT_BEAT_ELITE_FOUR
	iffalse .FaceBeasts
	special BeastsCheck
	iffalse .FaceBeasts
	clearevent EVENT_TIN_TOWER_1F_WISE_TRIO_2
	setevent EVENT_TIN_TOWER_1F_WISE_TRIO_1
.GotRainbowWing:
	checkevent EVENT_EUSINE_IN_CELADON
	iffalse .Done ; If Eusine is in Celadon, he can't be here at the same time.
	checkevent EVENT_FOUGHT_HO_OH
	iffalse .Done
	appear TINTOWER1F_EUSINE
.Done:
	endcallback

.FaceBeasts:
	checkevent EVENT_FOUGHT_SUICUNE
	iftrue .FoughtSuicune
	appear TINTOWER1F_SUICUNE
	checkevent EVENT_CAUGHT_RAIKOU
	iftrue .NoRaikou
	appear TINTOWER1F_RAIKOU
	sjump .CheckEntei

.NoRaikou:
	disappear TINTOWER1F_RAIKOU
.CheckEntei:
	checkevent EVENT_CAUGHT_ENTEI
	iftrue .NoEntei
	appear TINTOWER1F_ENTEI
	sjump .BeastsDone

.NoEntei:
	disappear TINTOWER1F_ENTEI
.BeastsDone:
	endcallback

.FoughtSuicune:
	disappear TINTOWER1F_SUICUNE
	disappear TINTOWER1F_RAIKOU
	disappear TINTOWER1F_ENTEI
	clearevent EVENT_TIN_TOWER_1F_WISE_TRIO_1
	setevent EVENT_TIN_TOWER_1F_WISE_TRIO_2
	endcallback

.StairsCallback:
	checkevent EVENT_GOT_RAINBOW_WING
	iftrue .DontHideStairs
	changeblock 10, 2, $09 ; floor
.DontHideStairs:
	endcallback

.SuicuneBattle:
	applymovement PLAYER, TinTower1FPlayerEntersMovement
	pause 15
	checkevent EVENT_CAUGHT_RAIKOU
	iftrue .Next1 ; if player caught Raikou, it doesn't appear in Tin Tower
	applymovement TINTOWER1F_RAIKOU, TinTower1FRaikouApproachesMovement
	turnobject PLAYER, LEFT
	cry RAIKOU
	pause 10
	playsound SFX_WARP_FROM
	applymovement TINTOWER1F_RAIKOU, TinTower1FRaikouLeavesMovement
	disappear TINTOWER1F_RAIKOU
	playsound SFX_EXIT_BUILDING
	waitsfx
.Next1:
	checkevent EVENT_CAUGHT_ENTEI
	iftrue .Next2 ; if player caught Entei, it doesn't appear in Tin Tower
	applymovement TINTOWER1F_ENTEI, TinTower1FEnteiApproachesMovement
	turnobject PLAYER, RIGHT
	cry ENTEI
	pause 10
	playsound SFX_WARP_FROM
	applymovement TINTOWER1F_ENTEI, TinTower1FEnteiLeavesMovement
	disappear TINTOWER1F_ENTEI
	playsound SFX_EXIT_BUILDING
	waitsfx
.Next2:
	turnobject PLAYER, UP
	pause 10
	applymovement PLAYER, TinTower1FPlayerBacksUpMovement
	applymovement TINTOWER1F_SUICUNE, TinTower1FSuicuneApproachesMovement
	cry SUICUNE
	pause 20
	loadwildmon SUICUNE, 50
	loadvar VAR_BATTLETYPE, BATTLETYPE_SUICUNE
	startbattle
	dontrestartmapmusic
	disappear TINTOWER1F_SUICUNE
	setevent EVENT_FOUGHT_SUICUNE
	setevent EVENT_SAW_SUICUNE_ON_ROUTE_42
	setmapscene ROUTE_42, SCENE_ROUTE42_NOTHING
	setevent EVENT_SAW_SUICUNE_ON_ROUTE_36
	setmapscene ROUTE_36, SCENE_ROUTE36_NOTHING
	setevent EVENT_SAW_SUICUNE_AT_CIANWOOD_CITY
	setmapscene CIANWOOD_CITY, SCENE_CIANWOODCITY_NOTHING
	setscene SCENE_FINISHED
	clearevent EVENT_EUSINE_IN_CELADON
	reloadmapafterbattle
	pause 20
	applymovement PLAYER, TinTower1FPlayerStandsBackMovement
	playmusic MUSIC_MYSTICALMAN_ENCOUNTER
	playsound SFX_ENTER_DOOR
	moveobject TINTOWER1F_EUSINE, 10, 15
	appear TINTOWER1F_EUSINE
	applymovement TINTOWER1F_EUSINE, TinTower1FEusineEntersMovement
	playsound SFX_ENTER_DOOR
	moveobject TINTOWER1F_SAGE1, 9, 15
	appear TINTOWER1F_SAGE1
	applymovement TINTOWER1F_SAGE1, TinTower1FSage1EntersMovement
	playsound SFX_ENTER_DOOR
	moveobject TINTOWER1F_SAGE2, 9, 15
	appear TINTOWER1F_SAGE2
	applymovement TINTOWER1F_SAGE2, TinTower1FSage2EntersMovement
	playsound SFX_ENTER_DOOR
	moveobject TINTOWER1F_SAGE3, 9, 15
	appear TINTOWER1F_SAGE3
	applymovement TINTOWER1F_SAGE3, TinTower1FSage3EntersMovement
	moveobject TINTOWER1F_SAGE1, 7, 13
	moveobject TINTOWER1F_SAGE2, 9, 13
	moveobject TINTOWER1F_SAGE3, 11, 13
	turnobject PLAYER, RIGHT
	opentext
	writetext TinTower1FEusineSuicuneText
	waitbutton
	closetext
	applymovement TINTOWER1F_EUSINE, TinTower1FEusineLeavesMovement
	playsound SFX_EXIT_BUILDING
	disappear TINTOWER1F_EUSINE
	waitsfx
	special FadeOutMusic
	pause 20
	playmapmusic
	end

TinTower1FSage1Script:
	jumptextfaceplayer TinTower1FSage1Text

TinTower1FSage2Script:
	jumptextfaceplayer TinTower1FSage2Text

TinTower1FSage3Script:
	jumptextfaceplayer TinTower1FSage3Text

TinTower1FSage4Script:
	checkevent EVENT_FOUGHT_HO_OH
	iftrue .FoughtHoOh
	jumptextfaceplayer TinTower1FSage4Text1

.FoughtHoOh:
	jumptextfaceplayer TinTower1FSage4Text2

TinTower1FSage5Script:
	faceplayer
	opentext
	checkevent EVENT_FOUGHT_HO_OH
	iftrue .FoughtHoOh
	checkevent EVENT_GOT_RAINBOW_WING
	iftrue .GotRainbowWing
	writetext TinTower1FSage5Text1
	promptbutton
	verbosegiveitem RAINBOW_WING
	closetext
	refreshscreen
	earthquake 72
	waitsfx
	playsound SFX_STRENGTH
	changeblock 10, 2, $20 ; stairs
	reloadmappart
	setevent EVENT_GOT_RAINBOW_WING
	closetext
	opentext
.GotRainbowWing:
	writetext TinTower1FSage5Text2
	waitbutton
	closetext
	end

.FoughtHoOh:
	writetext TinTower1FSage5Text3
	waitbutton
	closetext
	end

TinTower1FSage6Script:
	checkevent EVENT_FOUGHT_HO_OH
	iftrue .FoughtHoOh
	jumptextfaceplayer TinTower1FSage6Text1

.FoughtHoOh:
	jumptextfaceplayer TinTower1FSage6Text2

TinTower1FEusine:
	faceplayer
	opentext
	writetext TinTower1FEusineHoOhText
	promptbutton
	writetext TinTower1FEusineHoOhSequelText
	waitbutton
	closetext
	end

TinTower1FPlayerEntersMovement:
	slow_step UP
	slow_step UP
	slow_step UP
	slow_step UP
	step_end

TinTower1FRaikouApproachesMovement:
	set_sliding
	fast_jump_step DOWN
	remove_sliding
	step_end

TinTower1FRaikouLeavesMovement:
	set_sliding
	fast_jump_step DOWN
	fast_jump_step RIGHT
	fast_jump_step DOWN
	remove_sliding
	step_end

TinTower1FEnteiApproachesMovement:
	set_sliding
	fast_jump_step DOWN
	remove_sliding
	step_end

TinTower1FEnteiLeavesMovement:
	set_sliding
	fast_jump_step DOWN
	fast_jump_step LEFT
	fast_jump_step DOWN
	remove_sliding
	step_end

TinTower1FSuicuneApproachesMovement:
	set_sliding
	fast_jump_step DOWN
	remove_sliding
	step_end

TinTower1FPlayerBacksUpMovement:
	fix_facing
	big_step DOWN
	remove_fixed_facing
	step_end

TinTower1FPlayerStandsBackMovement:
	step UP
	turn_head DOWN
	step_end

TinTower1FEusineEntersMovement:
	step UP
	step UP
	step RIGHT
	step UP
	step UP
	turn_head LEFT
	step_end

TinTower1FEusineLeavesMovement:
	step DOWN
	step LEFT
	step DOWN
	step DOWN
	step DOWN
	step_end

TinTower1FSage1EntersMovement:
	step UP
	step UP
	step LEFT
	step LEFT
	turn_head UP
	step_end

TinTower1FSage2EntersMovement:
	step UP
	step UP
	step_end

TinTower1FSage3EntersMovement:
	step UP
	step RIGHT
	step RIGHT
	step UP
	step_end

TinTower1FEusineSuicuneText:
if DEF(_FR_FR)
	text "EUSINE: Bravo!"
	line "Trop fort!"
	
	para "SUICUNE est fort,"
	line "mais tu l'es"

	para "encore plus,"
	line "<PLAYER>."

	para "Pendant ton combat"
	line "j'ai pu prélever"
	
	para "l'eau légendaire"
	line "de SUICUNE!"
	
	para "Le vaccin est"
	line "peut-être à portée"
	
	para "de main grâce à"
	line "ton aide!"
	
	para "On dit que SUICUNE"
	line "a le pouvoir d'in-"

	para "voquer un #MON"
	line "aux couleurs de"
	cont "l'arc-en-ciel."

	para "Peut-être, on ne"
	line "sait jamais, ce"

	para "qu'il vient de se"
	line "passer le fera"
	cont "apparaître..."
	
	para "Je me hâte vers"
	line "le centre de"	
	cont "recherche de KANTO"
	
	para "pour livrer cet"
	line "échantillon poten-"
	cont "tiellement salva-"
	cont "teur."
	
	para "Le monde entier"
	line "te doit un grand"
	cont "merci."
	
	para "A très bientôt,"
	line "<PLAYER>!"
else
	text "EUSINE: Awesome!"
	line "Too awesome, even!"

	para "SUICUNE was tough,"
	line "but you were even"

	para "more incredible,"
	line "<PLAYER>."

	para "During your battle"
	line "I've been able to"

	para "sample SUICUNE's"
	line "legendary water!"

	para "We may be able to"
	line "discover a vaccine"

	para "thanks to your"
	line "actions <PLAYER>."

	para "Also, I heard SUI-"
	line "CUNE's mystic power"

	para "summons a rainbow-"
	line "colored #MON."

	para "Maybe, just maybe,"
	line "what went on today"

	para "will cause that"
	line "#MON to appear."

	para "I must now hurry"
	line "to the research"

	para "facility in KANTO,"
	line "to deliver this"

	para "potentially life"
	line "saving sample."

	para "The whole world"
	line "owes you a big"
	cont "thank you."

	para "Later, <PLAYER>!"
endc
	done

TinTower1FSage1Text: 
if DEF(_FR_FR)
	text "Selon la"
	line "légende..."

	para "Lorsque les âmes"
	line "des #MON et des"

	para "humains se réunis-"
	line "sent, un #MON"

	para "aux couleurs de"
	line "l'arc-en-ciel des-"
	cont "cend des cieux..."

	para "Est-il possible"
	line "que les #MON"

	para "légendaires met-"
	line "tent les humains"
	cont "à l'épreuve?"
else
	text "According to"
	line "legend…"

	para "When the souls of"
	line "#MON and humans"

	para "commune, from the"
	line "heavens descends a"

	para "#MON of rainbow"
	line "colors…"

	para "Could it mean the"
	line "legendary #MON"

	para "are testing us"
	line "humans?"
endc

	done

TinTower1FSage2Text: 
if DEF(_FR_FR)
	text "Lorsque la TOUR de"
	line "CUIVRE brûla,"

	para "trois #MON sans"
	line "nom ont, paraît-"

	para "il, péri dans les"
	line "flammes..."

	para "Toutefois..."

	para "Un #MON couleur"
	line "arc-en-ciel..."

	para "Ou plus précisé-"
	line "ment..."

	para "HO-OH, descendit"
	line "du ciel et redonna"

	para "la vie aux trois"
	line "#MON."

	para "Ils se nomment..."

	para "SUICUNE, ENTEI et"
	line "RAIKOU."

	para "Et voilà ce qu'on"
	line "raconte."
else
	text "When the BRASS"
	line "TOWER burned down,"

	para "three nameless"
	line "#MON were said"

	para "to have perished."
	line "It was tragic."

	para "However…"

	para "A rainbow-colored"
	line "#MON…"

	para "In other words…"

	para "HO-OH descended"
	line "from the sky and"

	para "gave new life to"
	line "the three #MON."

	para "They are…"

	para "SUICUNE, ENTEI and"
	line "RAIKOU."

	para "That is what they"
	line "say."
endc

	done

TinTower1FSage3Text: 
if DEF(_FR_FR)
	text "On dit que les"
	line "deux TOURS furent"

	para "construites pour"
	line "sceller l'amitié"

	para "entre #MON et"
	line "humains."

	para "C'était il y a"
	line "700 ans, mais"

	para "l'idée reste la"
	line "même aujourd'hui."
else
	text "The two TOWERS are"
	line "said to have been"

	para "built to foster"
	line "friendship and"

	para "hope between #-"
	line "MON and people."

	para "That was 700 years"
	line "ago, but the ideal"

	para "still remains"
	line "important today."
endc

	done

TinTower1FSage4Text1: 
if DEF(_FR_FR)
	text "HO-OH a dû arriver"
	line "ici, à la TOUR"
	cont "FERRAILLE!"
else
	text "HO-OH appears to"
	line "have descended"

	para "upon this, the TIN"
	line "TOWER!"
endc

	done

TinTower1FSage5Text1: 
if DEF(_FR_FR)
	text "Ceci te protégera."
else
	text "This will protect"
	line "you. Take it."
endc

	done

TinTower1FSage5Text2: 
if DEF(_FR_FR)
	text "Va."
else
	text "Now, go."
endc

	done

TinTower1FSage6Text1: 
if DEF(_FR_FR)
	text "Je crois que l'on"
	line "te met à l'épreu-"
	cont "ve."

	para "Avance l'esprit"
	line "clair."
else
	text "I believe you are"
	line "being tested."

	para "Free your mind"
	line "from uncertainty,"
	cont "and advance."
endc

	done

TinTower1FEusineHoOhText: 
if DEF(_FR_FR)
	text "Je le savais."

	para "Je savais que tu"
	line "verrais le #MON"

	para "arc-en-ciel,"
	line "<PLAYER>."

	para "Je l'avais prédit."

	para "Je suis pas trop"
	line "mauvais, moi."
else
	text "I knew it."

	para "I knew you'd get"
	line "to see the #MON"

	para "of rainbow colors,"
	line "<PLAYER>."

	para "It happened just"
	line "as I envisioned."

	para "My research isn't"
	line "bad, I might say."
endc

	done

TinTower1FEusineHoOhSequelText::
if DEF(_FR_FR)
	text "Je vais continuer"
	line "à étudier pour"

	para "être un célèbre"
	line "#MANIAC!"
else
	text "I'm going to keep"
	line "studying #MON"

	para "to become a famous"
	line "#MANIAC!"
endc
	done

TinTower1FSage4Text2: 
if DEF(_FR_FR)
	text "Les #MON légen-"
	line "daires sont censés"

	para "posséder trois"
	line "pouvoirs..."

	para "La foudre qui a"
	line "frappé la TOUR."

	para "Le feu qui a brûlé"
	line "la TOUR."

	para "Et la pluie qui a"
	line "éteint le feu..."
else
	text "The legendary"
	line "#MON are said"

	para "to embody three"
	line "powers…"

	para "The lightning that"
	line "struck the TOWER."

	para "The fire that"
	line "burned the TOWER."

	para "And the rain that"
	line "put out the fire…"
endc

	done

TinTower1FSage5Text3: 
if DEF(_FR_FR)
	text "Lorsque les #-"
	line "MON légendaires"
	cont "sont apparus..."

	para "Ils pétrifièrent"
	line "de terreur les"
	cont "témoins de leur"
	cont "réveil..."

	para "Et..."

	para "Certains ont même"
	line "cru bon de les"
	cont "attaquer..."

	para "Les #MON légen-"
	line "daires, conscients"

	para "de leur puissance,"
	line "ont préféré fuir."
else
	text "When the legendary"
	line "#MON appeared…"

	para "They struck terror"
	line "in those who saw"
	cont "their rise."

	para "And…"

	para "Some even took to"
	line "futile attacks."

	para "The legendary"
	line "#MON, knowing"

	para "their own power,"
	line "fled, ignoring the"
	cont "frightened people."
endc

	done

TinTower1FSage6Text2: 
if DEF(_FR_FR)
	text "On dit que le"
	line "#MON légendai-"

	para "re SUICUNE est le"
	line "plus proche de"
	cont "HO-OH."

	para "Il y aurait aussi"
	line "un lien avec les"

	para "#MON connus"
	line "sous le nom de..."
	cont "ZARBI."

	para "Les ZARBI et"
	line "SUICUNE doivent"

	para "être liés en un"
	line "sens..."
else
	text "Of the legendary"
	line "#MON, SUICUNE"

	para "is said to be the"
	line "closest to HO-OH."

	para "I hear there may"
	line "also be a link to"

	para "#MON known as"
	line "UNOWN."

	para "The #MON UNOWN"
	line "must be sharing a"

	para "cooperative bond"
	line "with SUICUNE."
endc

	done

TinTower1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  9, 15, ECRUTEAK_CITY, 12
	warp_event 10, 15, ECRUTEAK_CITY, 12
	warp_event 10,  2, TIN_TOWER_2F, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  9,  9, SPRITE_SUICUNE, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TIN_TOWER_1F_SUICUNE
	object_event  7,  9, SPRITE_RAIKOU, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_TREE, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TIN_TOWER_1F_RAIKOU
	object_event 12,  9, SPRITE_ENTEI, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_TIN_TOWER_1F_ENTEI
	object_event  8,  3, SPRITE_EUSINE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, TinTower1FEusine, EVENT_TIN_TOWER_1F_EUSINE
	object_event  5,  9, SPRITE_SAGE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TinTower1FSage1Script, EVENT_TIN_TOWER_1F_WISE_TRIO_1
	object_event 11, 11, SPRITE_SAGE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TinTower1FSage2Script, EVENT_TIN_TOWER_1F_WISE_TRIO_1
	object_event 14,  6, SPRITE_SAGE, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TinTower1FSage3Script, EVENT_TIN_TOWER_1F_WISE_TRIO_1
	object_event  4,  2, SPRITE_SAGE, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TinTower1FSage4Script, EVENT_TIN_TOWER_1F_WISE_TRIO_2
	object_event  9,  1, SPRITE_SAGE, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TinTower1FSage5Script, EVENT_TIN_TOWER_1F_WISE_TRIO_2
	object_event 14,  2, SPRITE_SAGE, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TinTower1FSage6Script, EVENT_TIN_TOWER_1F_WISE_TRIO_2
