	object_const_def
	const AKIBA2F_SELLER
	const AKIBA2F_POSTER_1
	const AKIBA2F_POSTER_2
	const AKIBA2F_POSTER_3

Akiba2F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .DisplayPosters

.DisplayPosters:
; pikachu poster
	checkevent EVENT_DECO_POSTER_2
	iffalse .clefairy_poster

	changeblock 6, 6, $44 ; empty wall

.clefairy_poster
	checkevent EVENT_DECO_POSTER_3
	iffalse .jigglypuff_poster

	changeblock 2, 2, $44 ; empty wall

.jigglypuff_poster
	checkevent EVENT_DECO_POSTER_4
	iffalse .end

	changeblock 8, 2, $44 ; empty wall

.end
	endcallback

Akiba2F_SellerScript:
	setevent EVENT_DECO_POSTER_4
	end

Akiba2F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event 11,  0, AKIBA_1F, 3
	warp_event  0,  0, AKIBA_3F, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  0,  7, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba2F_SellerScript, -1
