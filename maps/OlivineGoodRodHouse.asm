	object_const_def
	const OLIVINEGOODRODHOUSE_FISHING_GURU

OlivineGoodRodHouse_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_OBJECTS, .CheckClapping

.CheckClapping:
	callasm IsClappingAuthorizedScript
	iffalse .end

	moveobject OLIVINEGOODRODHOUSE_FISHING_GURU, 5, 1
	loadmem wMap1ObjectMovement, CLAP_F | SPRITEMOVEDATA_STANDING_UP
.end
	endcallback

GoodRodGuru:
	faceplayer
	opentext

	callasm IsClappingAuthorizedScript
	iffalse .GoodRod

	callasm HasPlayerClappedALotInThisRoom_WithReset
	iftrue .GoodRod

	farwritetext _Clapping4Text
	sjump .text_end

.GoodRod
	checkitem GOOD_ROD
	iftrue .AlreadyGotItem
	farwritetext OfferGoodRodText
	yesorno
	iffalse .DontWantIt
	writetext GiveGoodRodText
	promptbutton
	verbosegiveitem GOOD_ROD
	writetext GaveGoodRodText
.text_end
	waitbutton
	closetext
	end

.DontWantIt:
	writetext DontWantGoodRodText
	waitbutton
	closetext
	end

.AlreadyGotItem:
	writetext HaveGoodRodText
	waitbutton
	closetext
	end


GiveGoodRodText: 
if DEF(_FR_FR)
	text "Ah, hahah!"
	line "Et voici une"
	cont "nouvelle recrue"
	cont "dans ce hobby"
	cont "formidable!"
else
	text "Ah, hahah!"
	line "We have ourselves"
	cont "a new angler!"
endc

	done

GaveGoodRodText: 
if DEF(_FR_FR)
	text "On ne trouve pas"
	line "seulement des"

	para "poissons en mer."
	line "Ils sont malins et"
	cont "vont partout où il"
	cont "y a de l'eau!"
else
	text "Fish aren't found"
	line "in the sea alone."

	para "They go wherever"
	line "there is water."
endc

	done

DontWantGoodRodText: 
if DEF(_FR_FR)
	text "Kkkoii? T'aimes"
	line "pas la pêche!?"
	cont "C'est pas bien!"
else
	text "Whaaat? You don't"
	line "like to fish!?"
	cont "Incomprehensible!"
endc

	done

HaveGoodRodText: 
if DEF(_FR_FR)
	text "Comment vont les"
	line "affaires..."
	cont "Ca roule?"
else
	text "How are things?"
	line "Land the big one?"
endc

	done

OlivineGoodRodHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, OLIVINE_CITY, 6
	warp_event  3,  7, OLIVINE_CITY, 6

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_FISHING_GURU, CLAP_F | SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, GoodRodGuru, -1
