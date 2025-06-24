POSTER_PRICE EQU 4000

	object_const_def
	const AKIBA2F_SELLER
	const AKIBA2F_POSTER_2
	const AKIBA2F_POSTER_3
	const AKIBA2F_POSTER_4
	const AKIBA2F_SMEARGLE
	const AKIBA2F_CLIENT_GENTLEMAN
	const AKIBA2F_CLIENT_BEAUTY

Akiba2F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .DisplayPosters

.DisplayPosters:
	setlasttalked AKIBA2F_SELLER

; pikachu poster
	checkevent EVENT_DECO_POSTER_2
	iffalse .clefairy_poster

	scall Akiba2F_HidePikachuPoster

.clefairy_poster
	checkevent EVENT_DECO_POSTER_3
	iffalse .jigglypuff_poster

	scall Akiba2F_HideClefairyPoster

.jigglypuff_poster
	checkevent EVENT_DECO_POSTER_4
	iffalse .end

	scall Akiba2F_HideJigglypuffPoster

.end
	endcallback

Akiba2F_HidePikachuPoster:
	changeblock 6, 6, $44 ; empty wall
	end

Akiba2F_HideClefairyPoster:
	changeblock 2, 2, $44 ; empty wall
	end

Akiba2F_HideJigglypuffPoster:
	changeblock 8, 2, $44 ; empty wall
	end

Akiba2F_SaveSeenPoster:
	writemem wLastCheckedPoster
	writemem hLastTalked
	end

Akiba2F_SellerScriptFromRight:
	turnobject AKIBA2F_SELLER, RIGHT
	sjump Akiba2F_SellerScript

Akiba2F_SellerScriptFromTop:
	turnobject AKIBA2F_SELLER, UP

Akiba2F_SellerScript:
	opentext
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .skip_welcome

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	writetext Akiba2F_WelcomeText
	promptbutton

.skip_welcome
	readmem hLastTalked
.check
	ifequal AKIBA2F_POSTER_2 - 1, .pikachu
	ifequal AKIBA2F_POSTER_3 - 1, .clefairy
	ifequal AKIBA2F_POSTER_4 - 1, .jigglypuff

	readmem wLastCheckedPoster
	ifless AKIBA2F_POSTER_2 - 1, .no_poster_looked_at
	ifgreater AKIBA2F_POSTER_4 - 1, .no_poster_looked_at
	sjump .check

.no_poster_looked_at
	checkevent EVENT_DECO_POSTER_2
	iffalse .look_around

	checkevent EVENT_DECO_POSTER_3
	iffalse .look_around

	checkevent EVENT_DECO_POSTER_4
	iffalse .look_around

; Nothing else to sell.
	writetext Akiba2F_SoldOutText
	sjump .text_end

.look_around
	writetext Akiba2F_LookAroundText
.text_end
	waitbutton
	closetext
.end
	turnobject AKIBA2F_SELLER, DOWN
	end

.pikachu
	scall Akiba2F_SaveSeenPoster
	setval PIKACHU
	sjump .offer

.clefairy
	scall Akiba2F_SaveSeenPoster
	setval CLEFAIRY
	sjump .offer

.jigglypuff
	scall Akiba2F_SaveSeenPoster
	setval JIGGLYPUFF
	
.offer
	getmonname STRING_BUFFER_3, 0
	writetext Akiba2F_PosterOfferText
	setval POSTER_PRICE / 1000
	scall Akiba1F_BuyingProcess
	iffalse .end

	; If the transaction was successfull, we need to hide the poster from the wall.
	readmem hLastTalked
	ifequal AKIBA2F_POSTER_2 - 1, .hide_pikachu
	ifequal AKIBA2F_POSTER_3 - 1, .hide_clefairy
	ifequal AKIBA2F_POSTER_4 - 1, .hide_jigglypuff
	sjump .end

.hide_pikachu
	scall Akiba2F_HidePikachuPoster
	sjump .reload_map

.hide_clefairy
	scall Akiba2F_HideClefairyPoster
	sjump .reload_map

.hide_jigglypuff
	scall Akiba2F_HideJigglypuffPoster
	sjump .reload_map

.reload_map
	reloadmappart
	loadmem wLastCheckedPoster, 0
	setlasttalked AKIBA2F_SELLER
	sjump .end

Akiba2F_Client1Script:
	checkevent EVENT_DECO_POSTER_4
	iftrue .sold

	showemote EMOTE_HEART, AKIBA2F_CLIENT_GENTLEMAN, 30
	pause 5
	faceplayer
	pause 5
	opentext
	writetext Akiba2F_InLoveText
	waitbutton
	closetext
	turnobject AKIBA2F_CLIENT_GENTLEMAN, UP
	end

.sold
	jumptextfaceplayer Akiba2F_JiggGoneText

Akiba2F_Client2Script:
	jumptextfaceplayer Akiba2F_WeshText

Akiba2F_SmeargleScript:
	cry SMEARGLE
	jumptext Akiba2F_SmeargleText

Akiba2F_PikachuPosterScript:
	loadmem wLastCheckedPoster, AKIBA2F_POSTER_2 - 1
	jumptext Akiba2F_PikachuPosterText

Akiba2F_ClefairyPosterScript:
	loadmem wLastCheckedPoster, AKIBA2F_POSTER_3 - 1
	jumptext Akiba2F_ClefairyPosterText

Akiba2F_JigglypuffPosterScript:
	loadmem wLastCheckedPoster, AKIBA2F_POSTER_4 - 1
	jumptext Akiba2F_JigglypuffPosterText

Akiba2F_SmeargleText:
if DEF(_FR_FR)
	text "QUEULORIOR: ..."
	done
else
	text "SMEARGLE: …"
	done
endc

Akiba2F_PikachuPosterText:
if DEF(_FR_FR)
	text "Un poster plein"
	line "d'énergie repré-"
	cont "sentant PIKACHU."
	done
else
	text "An energizing pos-"
	line "ter of a PIKACHU."
	done
endc

Akiba2F_ClefairyPosterText:
if DEF(_FR_FR)
	text "Un poster tout"
	line "mignon d'un"
	cont "MELOFEE."
	done
else
	text "A cute poster"
	line "of a CLEFAIRY."
	done
endc

Akiba2F_JigglypuffPosterText:
if DEF(_FR_FR)
	text "Un poster relaxant"
	line "d'un RONDOUDOU."
	done
else
	text "A relaxing poster"
	line "of a JIGGLYPUFF."
	done
endc

Akiba2F_PosterOfferText:
if DEF(_FR_FR)
	text "Mmm."

	para "Je t'ai vu"
	line "contempler le"
	cont "poster @"
	text_ram wStringBuffer3
	text "."

	para "Une source de"
	line "vivacité, n'est-"
	cont "ce pas?"

	para "Tu peux l'emporter"
	line "pour {d:POSTER_PRICE}¥."
	done
else
	text "Mmm."
	para "I've seen you"
	line "admiring the"
	cont "@"
	text_ram wStringBuffer3
	text " poster,"
	cont "uh?"

	para "Lively, isn't it?"

	para "You can bring it"
	line "home for ¥{d:POSTER_PRICE}."
	done
endc

Akiba2F_WelcomeText:
if DEF(_FR_FR)
	text "Bienvenue à"
	line "notre exposition!"
	done
else
	text "Welcome to our"
	line "exhibition!"
	done
endc

Akiba2F_LookAroundText:
if DEF(_FR_FR)
	text "Admire donc nos"
	line "magnifiques"
	cont "oeuvres, afin que"

	para "nous puissions"
	line "en discuter."
	done
else
	text "Please admire our"
	line "magnificient art,"

	para "so we can talk"
	line "about it."
	done
endc

Akiba2F_SoldOutText:
if DEF(_FR_FR)
	text "Tous nos posters"
	line "sont épuisés!"
	done
else
	text "All our posters"
	line "are sold out!"
	done
endc

Akiba2F_WeshText:
if DEF(_FR_FR)
	text "Ils osent vraiment"
	line "vendre des posters"
	cont "comme de l'art?"
	done
else
	text "Are they really"
	line "advertising pos-"
	cont "ters as fine art?"
	done
endc

Akiba2F_InLoveText:
if DEF(_FR_FR)
	text "Je suis fan de"
	line "celui-ci!"
	done
else
	text "I'm in love with"
	line "this one!"
	done
endc

Akiba2F_JiggGoneText:
if DEF(_FR_FR)
	text "Mon poster préféré"
	line "a été vendu!"

	para "Son acheteur est"
	line "sans doute un"
	cont "fin connaisseur."
	done
else
	text "My favorite poster"
	line "is gone!"
	
	para "Surely its buyer"
	line "is a connoisseur."
	done
endc

Akiba2F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 11,  0, AKIBA_1F, 3
	warp_event  0,  0, AKIBA_3F, 1

	def_coord_events

	def_bg_events
	bg_event  1,  7, BGEVENT_READ, Akiba2F_SellerScriptFromRight
	bg_event  0,  6, BGEVENT_READ, Akiba2F_SellerScriptFromTop

	def_object_events
	object_event  0,  7, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
	object_event  6,  7, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba2F_PikachuPosterScript, EVENT_DECO_POSTER_2
	object_event  2,  3, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba2F_ClefairyPosterScript, EVENT_DECO_POSTER_3
	object_event  8,  3, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba2F_JigglypuffPosterScript, EVENT_DECO_POSTER_4
	object_event  0,  8, SPRITE_SMEARGLE, SPRITEMOVEDATA_POKEMON, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, Akiba2F_SmeargleScript, -1
	object_event  7,  5, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BROWN, OBJECTTYPE_SCRIPT, 0, Akiba2F_Client1Script, -1
	object_event  9,  8, SPRITE_BEAUTY, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Akiba2F_Client2Script, -1
