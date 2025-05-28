	object_const_def
	const LAKEOFRAGEMAGIKARPHOUSE_FISHING_GURU

LakeOfRageMagikarpHouse_MapScripts:
	def_scene_scripts

	def_callbacks

MagikarpLengthRaterScript:
	faceplayer
	opentext
	checkevent EVENT_LAKE_OF_RAGE_ELIXIR_ON_STANDBY
	iftrue .GetReward
	checkevent EVENT_LAKE_OF_RAGE_ASKED_FOR_MAGIKARP
	iftrue .AskedForMagikarp
	checkevent EVENT_CLEARED_ROCKET_HIDEOUT
	iftrue .ClearedRocketHideout
	checkevent EVENT_LAKE_OF_RAGE_EXPLAINED_WEIRD_MAGIKARP
	iftrue .ExplainedHistory
	writetext MagikarpLengthRaterText_LakeOfRageHistory
	waitbutton
	closetext
	setevent EVENT_LAKE_OF_RAGE_EXPLAINED_WEIRD_MAGIKARP
	end

.ExplainedHistory:
	writetext MagikarpLengthRaterText_MenInBlack
	waitbutton
	closetext
	end

.ClearedRocketHideout:
	writetext MagikarpLengthRaterText_WorldsLargestMagikarp
	waitbutton
	closetext
	setevent EVENT_LAKE_OF_RAGE_ASKED_FOR_MAGIKARP
	end

.AskedForMagikarp:
	setval MAGIKARP
	special FindPartyMonThatSpecies
	iffalse .ClearedRocketHideout
	writetext MagikarpLengthRaterText_YouHaveAMagikarp
	waitbutton
	special CheckMagikarpLength
	ifequal MAGIKARPLENGTH_NOT_MAGIKARP, .NotMagikarp
	ifequal MAGIKARPLENGTH_REFUSED, .Refused
	ifequal MAGIKARPLENGTH_TOO_SHORT, .TooShort
	; MAGIKARPLENGTH_BEAT_RECORD
	sjump .GetReward

.GetReward:
	writetext MagikarpLengthRaterText_Memento
	promptbutton
	verbosegiveitem ELIXER
	iffalse .NoRoom
	writetext MagikarpLengthRaterText_Bonus
	waitbutton
	closetext
	clearevent EVENT_LAKE_OF_RAGE_ELIXIR_ON_STANDBY
	end

.NoRoom:
	closetext
	setevent EVENT_LAKE_OF_RAGE_ELIXIR_ON_STANDBY
	end

.TooShort:
	writetext MagikarpLengthRaterText_TooShort
	waitbutton
	closetext
	end

.NotMagikarp:
	writetext MagikarpLengthRaterText_NotMagikarp
	waitbutton
	closetext
	end

.Refused:
	writetext MagikarpLengthRaterText_Refused
	waitbutton
	closetext
	end

MagikarpHouseBookshelf:
	jumpstd DifficultBookshelfScript

MagikarpLengthRaterText_LakeOfRageHistory: 
if DEF(_FR_FR)
	text "Le LAC COLERE est"
	line "en fait un cratère"

	para "créé par le"
	line "déchaînement des"
	cont "LEVIATOR."

	para "Le cratère s'est"
	line "peu à peu rempli"

	para "d'eau de pluie et"
	line "un LAC s'est"
	cont "formé."

	para "Cette histoire se"
	line "transmet de géné-"

	para "ration en géné-"
	line "ration. Elle vient"
	cont "d'un de mes"
	cont "grands-pères."

	para "On pouvait attra-"
	line "per de vrais"

	para "MAGICARPE en"
	line "pleine forme ici!"

	para "Je ne comprends"
	line "pas ce qu'il se"
	cont "passe."
else
	text "LAKE OF RAGE is"
	line "actually a crater"

	para "made by rampaging"
	line "GYARADOS."

	para "The crater filled"
	line "up with rainwater"

	para "and the LAKE was"
	line "formed."

	para "That's the story"
	line "passed on from my"

	para "Grandpa's great-"
	line "great-grandpa."

	para "It used to be that"
	line "you could catch"

	para "lively MAGIKARP"
	line "there, but…"

	para "I don't understand"
	line "what's happening."
endc

	done

MagikarpLengthRaterText_MenInBlack: 
if DEF(_FR_FR)
	text "Ce LAC n'est plus"
	line "normal depuis"

	para "l'arrivée des"
	line "hommes en noir."
else
	text "The LAKE hasn't"
	line "been normal since"

	para "those men wearing"
	line "black arrived."
endc

	done

MagikarpLengthRaterText_WorldsLargestMagikarp: 
if DEF(_FR_FR)
	text "Le LAC COLERE est"
	line "redevenu normal."

	para "Les MAGICARPE sont"
	line "de retour."

	para "Mon rêve se"
	line "réalise enfin:"
	cont "voir un monde"
	cont "plein de"
	cont "MAGICARPE."

	para "As-tu une CANNE?"
	line "Aide-moi si tu en"
	cont "as une."
else
	text "LAKE OF RAGE is"
	line "back to normal."

	para "The MAGIKARP have"
	line "returned."

	para "I may yet realize"
	line "my dream of see-"
	cont "ing the world's"
	cont "largest MAGIKARP."

	para "Do you have a ROD?"
	line "Please help me if"
	cont "you do."
endc

	done

MagikarpLengthRaterText_YouHaveAMagikarp: 
if DEF(_FR_FR)
	text "Ah, tu as un"
	line "MAGICARPE! Laisse-"

	para "moi voir sa"
	line "taille."
else
	text "Ah, you have a"
	line "MAGIKARP! Let's"

	para "see how big that"
	line "baby is."
endc

	done

MagikarpLengthRaterText_Memento: 
if DEF(_FR_FR)
	text "Whaou! Celui-ci"
	line "est démesuré!"

	para "Je te tire mon"
	line "chapeau!"

	para "Accepte ceci en"
	line "récompense!"
else
	text "Wow! This one is"
	line "outstanding!"

	para "I tip my hat to"
	line "you!"

	para "Take this as a"
	line "memento!"
endc

	done

MagikarpLengthRaterText_Bonus: 
if DEF(_FR_FR)
	text "Ce qui est impor-"
	line "tant, c'est d'épa-"

	para "ter les autres!"
	line "Suis mes conseils!"
else
	text "The record is the"
	line "important thing."

	para "Think of that as"
	line "a bonus!"
endc

	done

MagikarpLengthRaterText_TooShort: 
if DEF(_FR_FR)
	text "Whaou! C'est pas"
	line "mal du tout!"

	para "...J'aimerais pou-"
	line "voir te dire ça"

	para "mais j'en ai déjà"
	line "vu des plus gros."
else
	text "Wow! This one is"
	line "outstanding!"

	para "…I wish I could"
	line "say that, but I've"

	para "seen a bigger one"
	line "before."
endc

	done

MagikarpLengthRaterText_NotMagikarp: 
if DEF(_FR_FR)
	text "Quoi? Ce n'est pas"
	line "un MAGICARPE!"
else
	text "What? That's not a"
	line "MAGIKARP!"
endc

	done

MagikarpLengthRaterText_Refused: 
if DEF(_FR_FR)
	text "Alors... Tu n'as"
	line "rien pris qui"

	para "vaille la peine"
	line "d'être montré?"
	cont "Peut-être la"
	cont "prochaine fois!"
else
	text "Oh… So you didn't"
	line "get one good"

	para "enough to show me?"
	line "Maybe next time."
endc

	done

LakeOfRageMagikarpHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  7, LAKE_OF_RAGE, 2
	warp_event  3,  7, LAKE_OF_RAGE, 2

	def_coord_events

	def_bg_events
	bg_event  0,  1, BGEVENT_READ, MagikarpHouseBookshelf
	bg_event  1,  1, BGEVENT_READ, MagikarpHouseBookshelf

	def_object_events
	object_event  2,  3, SPRITE_FISHING_GURU, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, MagikarpLengthRaterScript, -1
