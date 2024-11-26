POSTER_PRICE EQU 4000

	object_const_def
	const AKIBA2F_SELLER
	const AKIBA2F_POSTER_2
	const AKIBA2F_POSTER_3
	const AKIBA2F_POSTER_4

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
	ifequal AKIBA2F_POSTER_2 - 1, .pikachu
	ifequal AKIBA2F_POSTER_3 - 1, .clefairy
	ifequal AKIBA2F_POSTER_4 - 1, .jigglypuff

; No poster was looked at.
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
	end

.pikachu
	setval PIKACHU
	sjump .offer

.clefairy
	setval CLEFAIRY
	sjump .offer

.jigglypuff
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
	setlasttalked AKIBA2F_SELLER
.end
	end

Akiba2F_PikachuPosterScript:
	jumptext Akiba2F_PikachuPosterText

Akiba2F_ClefairyPosterScript:
	jumptext Akiba2F_ClefairyPosterText

Akiba2F_JigglypuffPosterScript:
	jumptext Akiba2F_JigglypuffPosterText

Akiba2F_PikachuPosterText:
	text "An energizing pos-"
	line "ter of a PIKACHU."
	done

Akiba2F_ClefairyPosterText:
	text "A cute poster"
	line "of a CLEFAIRY."
	done

Akiba2F_JigglypuffPosterText:
	text "A relaxing poster"
	line "of a JIGGLYPUFF."
	done
	
Akiba2F_PosterOfferText:
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

Akiba2F_WelcomeText:
	text "Welcome to our"
	line "exhibition!"
	done

Akiba2F_LookAroundText:
	text "Please admire our"
	line "magnificient art,"

	para "so we can talk"
	line "about it."
	done

Akiba2F_SoldOutText:
	text "All our posters"
	line "are sold out!"
	done

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
	object_event  0,  7, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
	object_event  6,  7, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba2F_PikachuPosterScript, EVENT_DECO_POSTER_2
	object_event  2,  3, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba2F_ClefairyPosterScript, EVENT_DECO_POSTER_3
	object_event  8,  3, SPRITE_INVISIBLE_WALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba2F_JigglypuffPosterScript, EVENT_DECO_POSTER_4
