	object_const_def
	const ICEPATHB3F_POKE_BALL
	const ICEPATHB3F_ROCK

IcePathB3F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_NEWMAP, .EnterCallback

.EnterCallback:
	clearevent EVENT_MAHOGANY_MART_OWNERS ; The player can only reach Ice Path B3F once they have Strength, which is obtained after clearing the Rocket hideout. Therefore, there is no sequence break.

	checkevent EVENT_ICE_PATH_EXPLORED
	iftrue .end

	setevent EVENT_ICE_PATH_EXPLORED
	farscall CheckRocketsActivation
.end
	endcallback

IcePathB3FNevermeltice:
	itemball NEVERMELTICE

IcePathB3FRock:
	jumpstd SmashRockScript

IcePathB3F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  3,  5, ICE_PATH_B2F_MAHOGANY_SIDE, 2
	warp_event 15,  5, ICE_PATH_B2F_BLACKTHORN_SIDE, 2

	def_coord_events

	def_bg_events

	def_object_events
	object_event  5,  7, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_ITEMBALL, 0, IcePathB3FNevermeltice, EVENT_ICE_PATH_B3F_NEVERMELTICE
	object_event  6,  6, SPRITE_ROCK, SPRITEMOVEDATA_SMASHABLE_ROCK, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, IcePathB3FRock, -1
