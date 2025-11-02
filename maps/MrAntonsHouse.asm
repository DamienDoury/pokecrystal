    object_const_def

MrAntonsHouse_MapScripts:
    def_scene_scripts

    def_callbacks
    callback MAPCALLBACK_TILES, .EnterCallback

.EnterCallback:
	changeblock  2,  0, $03 ; Regular wall.
	endcallback

MrAntonsHouseCandyFactory:
    opentext
    checkevent EVENT_SICK_GENTLEMAN_QUEST_ONGOING
    iftrue .knowledge
    writetext MrAntonsHouseCandyFactoryText
    sjump .sequel

.knowledge
    writetext MrAntonsHouseCandyFactoryKnowledgeText
.sequel
    promptbutton
    writetext MrAntonsHouseCandyFactorySequelText
.end
    waitbutton
    closetext
    end

MrAntonsHouseNursePicture:
    opentext
    checkevent EVENT_SICK_GENTLEMAN_QUEST_ONGOING
    iftrue .knowledge
    writetext MrAntonsHouseNursePictureText
    sjump .sequel

.knowledge
    writetext MrAntonsHouseNursePictureKnowledgeText
.sequel
    promptbutton
    writetext MrAntonsHouseNursePictureSequelText
    sjump MrAntonsHouseCandyFactory.end

MrAntonsHouseCandyFactoryText:
if DEF(_FR_FR)
	text "Une photo d'un"
	line "homme dans la"
    cont "trentaine, dans"
	cont "une usine de"
	cont "bonbons."
else
    text "A picture of a man"
    line "in his 30s in a"
    cont "candy factory."
endc
	done

MrAntonsHouseCandyFactorySequelText:
if DEF(_FR_FR)
	text "On dirait ce"
	line "film célèbre."

	para "Il est avec une"
	line "femme aux cheveux"
	cont "roses en robe de"
	cont "mariée blanche."

	para "Ils ont l'air du"
	line "même âge."
else
    text "Looks like this"
    line "famous movie."

    para "He is with a pink-"
    line "haired woman wear-"
    cont "ing a white gown."

    para "They are both of"
    line "the same age."
endc
	done

MrAntonsHouseCandyFactoryKnowledgeText:
if DEF(_FR_FR)
	text "Une photo de MR."
    line "ANTON plus jeune,"
	cont "dans une immense"
	cont "usine de bonbons."
else
    text "A picture of a"
    line "younger MR.ANTON"
    cont "in a giant candy"
    cont "factory."
endc
	done

MrAntonsHouseNursePictureText:
if DEF(_FR_FR)
	text "Photo d'un vieil"
	line "homme avec un"
	cont "haut-de-forme à"
else
    text "A picture of an"
    line "old man wearing a"
    cont "top hat next to a"
endc
	done

MrAntonsHouseNursePictureSequelText:
if DEF(_FR_FR)
	text "côté d'une femme"
	line "plus jeune aux"
	cont "cheveux roses en"
	cont "blouse blanche."
else
    text "pink-haired young-"
    line "er woman wearing"
    cont "a white uniform."
endc
	done


MrAntonsHouseNursePictureKnowledgeText:
if DEF(_FR_FR)
	text "Photo récente de"
	line "MR.ANTON assis à"
else
    text "A recent picture"
    line "of MR.ANTON"
    cont "sitting next to a"
endc
	done

MrAntonsHouseRareCandy:
    hiddenitem RARE_CANDY, EVENT_MR_ANTONS_HOUSE_RARE_CANDY

    MrAntonsHouse_MapEvents:
    db 0, 0 ; filler

    def_warp_events
	warp_event  2,  7, SAFFRON_CITY, 16
	warp_event  3,  7, SAFFRON_CITY, 16

    def_coord_events

    def_bg_events
	bg_event  9,  7, BGEVENT_ITEM, MrAntonsHouseRareCandy
	bg_event  7,  0, BGEVENT_READ, MrAntonsHouseCandyFactory
	bg_event  9,  0, BGEVENT_READ, MrAntonsHouseNursePicture

    def_object_events
