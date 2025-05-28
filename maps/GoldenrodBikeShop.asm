	object_const_def
	const GOLDENRODBIKESHOP_CLERK

GoldenrodBikeShop_MapScripts:
	def_scene_scripts

	def_callbacks

.MapLoadCallback:
	checkevent GOLDENROD_BIKE_SHOP_CLOSED
	iffalse .endcallback

	disappear GOLDENRODBIKESHOP_CLERK
.endcallback
	endcallback

GoldenrodBikeShopClerkScript:
	faceplayer
	opentext
	checkevent EVENT_GOT_BICYCLE
	iftrue .GotBicycle
	writetext GoldenrodBikeShopClerkIntroText
	yesorno
	iffalse .Refused
	writetext GoldenrodBikeShopClerkAgreedText
	promptbutton
	waitsfx
	giveitem BICYCLE
	writetext BorrowedABicycleText
	playsound SFX_KEY_ITEM
	waitsfx
	itemnotify
	setflag ENGINE_BIKE_SHOP_CALL_ENABLED
	setevent EVENT_GOT_BICYCLE
.GotBicycle:
	writetext GoldenrodBikeShopClerkFirstRateBikesText
	waitbutton
	closetext
	end

.Refused:
	writetext GoldenrodBikeShopClerkRefusedText
	waitbutton
	closetext
	end

GoldenrodBikeShopBicycle:
	jumptext GoldenrodBikeShopBicycleText

GoldenrodBikeShopClerkIntroText: 
if DEF(_FR_FR)
	text "...(soupir)..."
	line "J'ai déménagé ici"

	para "mais je n'arrive"
	line "pas à vendre mes"
	cont "BICYCLETTES."
	cont "Pourquoi?"

	para "Pourrais-tu faire"
	line "de la BICYCLETTE"
	cont "et me faire de la"
	cont "pub?"
else
	text "…sigh… I moved"
	line "here, but I can't"

	para "sell my BICYCLES."
	line "Why is that?"

	para "Could you ride a"
	line "BICYCLE and adver-"
	cont "tise for me?"
endc

	done

GoldenrodBikeShopClerkAgreedText: 
if DEF(_FR_FR)
	text "Vraiment? Génial!"

	para "Donne-moi ton nom"
	line "et ton numéro de"

	para "téléphone et je te"
	line "prêterai une"
	cont "BICYCLETTE."
else
	text "Really? Great!"

	para "Give me your name"
	line "and phone number,"

	para "and I'll loan you"
	line "a BICYCLE."
endc

	done

BorrowedABicycleText: 
if DEF(_FR_FR)
	text "<PLAYER> emprunte"
	line "une BICYCLETTE."
else
	text "<PLAYER> borrowed a"
	line "BICYCLE."
endc

	done

GoldenrodBikeShopClerkFirstRateBikesText: 
if DEF(_FR_FR)
	text "Mes BICYCLETTES"
	line "sont trop bien!"

	para "Tu peux en faire"
	line "partout."
else
	text "My BICYCLES are"
	line "first-rate! You"

	para "can ride them"
	line "anywhere."
endc

	done

GoldenrodBikeShopClerkRefusedText: 
if DEF(_FR_FR)
	text "...(soupir)..."
	line "Ah, que dire de"
	cont "plus..."
else
	text "…sigh… Oh, for"
	line "the kindness of"
	cont "people…"
endc

	done

GoldenrodBikeShopBicycleText: 
if DEF(_FR_FR)
	text "C'est une sacrée"
	line "jolie BICYCLETTE!"
else
	text "It's a shiny new"
	line "BICYCLE!"
endc

	done

GoldenrodBikeShop_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, GOLDENROD_CITY, 2
	warp_event  3,  7, GOLDENROD_CITY, 2

	def_coord_events

	def_bg_events
	bg_event  1,  2, BGEVENT_READ, GoldenrodBikeShopBicycle
	bg_event  0,  3, BGEVENT_READ, GoldenrodBikeShopBicycle
	bg_event  1,  3, BGEVENT_READ, GoldenrodBikeShopBicycle
	bg_event  0,  5, BGEVENT_READ, GoldenrodBikeShopBicycle
	bg_event  1,  5, BGEVENT_READ, GoldenrodBikeShopBicycle
	bg_event  0,  6, BGEVENT_READ, GoldenrodBikeShopBicycle
	bg_event  1,  6, BGEVENT_READ, GoldenrodBikeShopBicycle
	bg_event  6,  6, BGEVENT_READ, GoldenrodBikeShopBicycle
	bg_event  7,  6, BGEVENT_READ, GoldenrodBikeShopBicycle

	def_object_events
	object_event  7,  2, SPRITE_CLERK, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, GoldenrodBikeShopClerkScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
