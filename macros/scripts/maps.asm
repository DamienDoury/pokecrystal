map_id: MACRO
;\1: map id
	assert DEF(GROUP_\1) && DEF(MAP_\1), \
		"Missing 'map_const \1' in constants/map_constants.asm"
	db GROUP_\1, MAP_\1
ENDM

object_const_def EQUS "const_def 2"

def_scene_scripts: MACRO
if DEF(_NUM_SCENE_SCRIPTS)
	PURGE _NUM_SCENE_SCRIPTS
endc
_NUM_SCENE_SCRIPTS EQUS "_NUM_SCENE_SCRIPTS_\@"
	db _NUM_SCENE_SCRIPTS
_NUM_SCENE_SCRIPTS = 0
ENDM

scene_script: MACRO
;\1: script pointer
	dw \1
_NUM_SCENE_SCRIPTS = _NUM_SCENE_SCRIPTS + 1
ENDM

def_callbacks: MACRO
if DEF(_NUM_CALLBACKS)
	PURGE _NUM_CALLBACKS
endc
_NUM_CALLBACKS EQUS "_NUM_CALLBACKS_\@"
	db _NUM_CALLBACKS
_NUM_CALLBACKS = 0
ENDM

callback: MACRO
;\1: type: a MAPCALLBACK_* constant
;\2: script pointer
	dbw \1, \2
_NUM_CALLBACKS = _NUM_CALLBACKS + 1
ENDM

def_warp_events: MACRO
if DEF(_NUM_WARP_EVENTS)
	PURGE _NUM_WARP_EVENTS
endc
_NUM_WARP_EVENTS EQUS "_NUM_WARP_EVENTS_\@"
	db _NUM_WARP_EVENTS
_NUM_WARP_EVENTS = 0
ENDM

warp_event: MACRO
;\1: x: left to right, starts at 0
;\2: y: top to bottom, starts at 0
;\3: map id: from constants/map_constants.asm
;\4: warp destination: starts at 1
if _NARG == 3 ; map_id is useless when using a DYNAMIC_WARP_*.
	db \2, \1, \3
	map_id NEW_BARK_TOWN ; ignoring map_id 
else
	db \2, \1, \4
	map_id \3
endc
_NUM_WARP_EVENTS = _NUM_WARP_EVENTS + 1
ENDM

def_coord_events: MACRO
if DEF(_NUM_COORD_EVENTS)
	PURGE _NUM_COORD_EVENTS
endc
_NUM_COORD_EVENTS EQUS "_NUM_COORD_EVENTS_\@"
	db _NUM_COORD_EVENTS
_NUM_COORD_EVENTS = 0
ENDM

coord_event: MACRO
; Three params means there is no condition to this coord_event: it must always be played.
;\1: x: left to right, starts at 0
;\2: y: top to bottom, starts at 0
;\3: script pointer
if _NARG == 3
	db \1 + 4, \2 + 4
	db CE_ALWAYS
	db 0
	dw \3
else
; Five params = conditionnal coord_event.
;\1: x: left to right, starts at 0
;\2: y: top to bottom, starts at 0
;\3: coord event type (must fit within a nibble)
;\4: id: a SCENE_* constant (controlled by setscene/setmapscene), of event flag, or item ID
;\5: script pointer
	db \1 + 4, \2 + 4
	dw (LOW(\3) & $f) | (HIGH(\4) << 4) | (LOW(\4) << 8)
	dw \5
endc
_NUM_COORD_EVENTS = _NUM_COORD_EVENTS + 1
ENDM

def_bg_events: MACRO
if DEF(_NUM_BG_EVENTS)
	PURGE _NUM_BG_EVENTS
endc
_NUM_BG_EVENTS EQUS "_NUM_BG_EVENTS_\@"
	db _NUM_BG_EVENTS
_NUM_BG_EVENTS = 0
ENDM

bg_event: MACRO
;\1: x: left to right, starts at 0
;\2: y: top to bottom, starts at 0
;\3: function: a BGEVENT_* constant
;\4: script pointer
	db \2, \1, \3
	dw \4
_NUM_BG_EVENTS = _NUM_BG_EVENTS + 1
ENDM

def_object_events: MACRO
if DEF(_NUM_OBJECT_EVENTS)
	PURGE _NUM_OBJECT_EVENTS
endc
_NUM_OBJECT_EVENTS EQUS "_NUM_OBJECT_EVENTS_\@"
	db _NUM_OBJECT_EVENTS
_NUM_OBJECT_EVENTS = 0
ENDM

object_event: MACRO
;\1: x: left to right, starts at 0
;\2: y: top to bottom, starts at 0
;\3: sprite: a SPRITE_* constant
;\4: movement function: a SPRITEMOVEDATA_* constant
;\5, \6: movement radius: x, y
;\7, \8: hour limits: h1, h2 (0-23)
;  * if h1 < h2, the object_event will only appear from h1 to h2
;  * if h1 > h2, the object_event will not appear from h2 to h1
;  * if h1 == h2, the object_event will always appear
;  * if h1 == -1, h2 is treated as a time-of-day value:
;    a combo of MORN, DAY, and/or NITE, or -1 to always appear
;\9: color: a PAL_NPC_* constant, or 0 for sprite default
;\10: function: a OBJECTTYPE_* constant
;\11: sight range: applies to OBJECTTYPE_TRAINER
;\12: script pointer
;\13: event flag: an EVENT_* constant, or -1 to always appear
	db \3, \2 + 4, \1 + 4, \4
	dn \6, \5
	db \7, \8
	shift
	dn \8, \9
	shift
	db \9
	shift
	dw \9
	shift
	dw \9
_NUM_OBJECT_EVENTS = _NUM_OBJECT_EVENTS + 1
ENDM

trainer: MACRO
;\1: trainer group
;\2: trainer id
;\3: flag: an EVENT_BEAT_* constant
;\4: seen text
;\5: win text
;\6: loss text
;\7: after-battle text
	dw \3
	db \1, \2
	dw \4, \5, \6, \7
ENDM

itemball: MACRO
;\1: item: from constants/item_constants.asm
;\2: quantity: default 1
if _NARG == 1
	itemball \1, 1
else
	db \1, \2
endc
ENDM

hiddenitem: MACRO
;\1: item: from constants/item_constants.asm
;\2: flag: an EVENT_* constant
	dwb \2, \1
ENDM

elevfloor: MACRO
;\1: floor: a FLOOR_* constant
;\2: warp destination: starts at 1
;\3: map id
	db \1, \2
	map_id \3
ENDM

conditional_event: MACRO
;\1: flag: an EVENT_* constant
;\2: script pointer
	dw \1, \2
ENDM

cmdqueue: MACRO
;\1: type: a CMDQUEUE_* constant
;\2: data pointer
	dbw \1, \2
	dw 0 ; filler
ENDM

stonetable: MACRO
;\1: warp id
;\2: object_event id
;\3: script pointer
	dbbw \1, \2, \3
ENDM

sokobanparams: MACRO
;\1: amount of targets
;\2: targets X start coord
;\3: targets X end coord
;\4: targets Y start coord
;\5: targets Y end coord
;\6: script pointer
	db \1, \2, \3, \4, \5
	dw \6
ENDM
	