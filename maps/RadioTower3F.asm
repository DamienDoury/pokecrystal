	object_const_def
	const RADIOTOWER3F_SUPER_NERD
	const RADIOTOWER3F_GYM_GUIDE
	const RADIOTOWER3F_COOLTRAINER_F
	const RADIOTOWER3F_ROCKET1
	const RADIOTOWER3F_ROCKET2
	const RADIOTOWER3F_ROCKET3
	const RADIOTOWER3F_SCIENTIST

RadioTower3F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .CardKeyShutterCallback

.CardKeyShutterCallback:
	checkevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	iftrue .Change
	endcallback

.Change:
	changeblock 14, 2, $2a ; open shutter
	changeblock 14, 4, $01 ; floor
	endcallback

RadioTower3FSuperNerdScript:
	checkevent EVENT_GOT_CLEAR_BELL
	iftrue .TeamRocketOpinion
	jumptextfaceplayer RadioTower3FSuperNerdText

.TeamRocketOpinion
	jumptextfaceplayer RadioTower3FSuperNerdTROpinionText

RadioTower3FGymGuideScript:
	faceplayer
	opentext
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .NoRockets
	writetext RadioTower3FGymGuideText_Rockets
	waitbutton
	closetext
	end

.NoRockets:
	writetext RadioTower3FGymGuideText
	waitbutton
	closetext
	end

RadioTower3FCooltrainerFScript:
	faceplayer
	opentext
	checkitem TM_SUNNY_DAY
	iftrue .GotSunnyDay
	checkevent EVENT_CLEARED_RADIO_TOWER
	iftrue .NoRockets
	checkevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	iftrue .UsedCardKey
	writetext RadioTower3FCooltrainerFPleaseSaveDirectorText
	waitbutton
	closetext
	end

.UsedCardKey:
	writetext RadioTower3FCooltrainerFIsDirectorSafeText
	waitbutton
	closetext
	end

.NoRockets:
	writetext RadioTower3FCooltrainerFYoureMyHeroText
	promptbutton
	verbosegiveitem TM_SUNNY_DAY
	writetext RadioTower3FCooltrainerFItsSunnyDayText
	waitbutton
	closetext
	end

.GotSunnyDay:
	writetext RadioTower3FCooltrainerFYouWereMarvelousText
	waitbutton
	closetext
	end

TrainerGruntM7:
	trainer GRUNTM, GRUNTM_7, EVENT_BEAT_ROCKET_GRUNTM_7, GruntM7SeenText, GruntM7BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GruntM7AfterBattleText

TrainerGruntM8:
	trainer GRUNTM, GRUNTM_8, EVENT_BEAT_ROCKET_GRUNTM_8, GruntM8SeenText, GruntM8BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GruntM8AfterBattleText

TrainerGruntM9:
	trainer GRUNTM, GRUNTM_9, EVENT_BEAT_ROCKET_GRUNTM_9, GruntM9SeenText, GruntM9BeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer GruntM9AfterBattleText

TrainerScientistMarc:
	trainer SCIENTIST, MARC, EVENT_BEAT_SCIENTIST_MARC, ScientistMarcSeenText, ScientistMarcBeatenText, 0, .Script

.Script:
	endifjustbattled
	jumptextfaceplayer ScientistMarcAfterBattleText

CardKeySlotScript::
	opentext
	writetext RadioTower3FCardKeySlotText
	waitbutton
	checkevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	iftrue .UsedCardKey
	checkitem CARD_KEY
	iftrue .HaveCardKey
.UsedCardKey:
	closetext
	end

.HaveCardKey:
	writetext InsertedTheCardKeyText
	waitbutton
	setevent EVENT_USED_THE_CARD_KEY_IN_THE_RADIO_TOWER
	playsound SFX_ENTER_DOOR
	changeblock 14, 2, $2a ; open shutter
	changeblock 14, 4, $01 ; floor
	reloadmappart
	closetext
	waitsfx
	end

RadioTower3FPersonnelSign:
	jumptext RadioTower3FPersonnelSignText

RadioTower3FPokemonMusicSign:
	jumptext RadioTower3FPokemonMusicSignText

RadioTower3FSuperNerdText: 
if DEF(_FR_FR)
	text "Nous avons un "
	line "enregistrement de"

	para "tous les cris de"
	line "#MON connus."

	para "Nous en avons près"
	line "de 200 différents."
else
	text "We have recordings"
	line "of the cries of"

	para "all #MON that"
	line "have been found."

	para "We must have about"
	line "200 kinds."
endc

	done

RadioTower3FSuperNerdTROpinionText:
if DEF(_FR_FR)
	text "Je peux comprendre"
	line "le point de vue de"
	cont "la TEAM ROCKET."

	para "Je ne supporte pas"
	line "de porter un"
	cont "masque. Son"
	cont "efficacité a-t-"
	cont "elle été prouvée"
	cont "au moins?"
else
	text "I kinda understand"
	line "TEAM ROCKET's point"
	cont "of view."

	para "I can't stand"
	line "wearing a face"
	cont "mask. Has its"
	cont "effectiveness"
	cont "even been proven?"
endc
	done

RadioTower3FGymGuideText_Rockets:
if DEF(_FR_FR)
	text "Le COVID infecte"
	line "de plus en plus de"

	para "gens et de #MON"
	line "chaque jour, et"

	para "certains en"
	line "meurent."

	para "Ce serait terrible"
	line "si les gens adhé-"
	cont "raient à l'idéolo-"
	cont "gie de la TEAM"
	cont "ROCKET et commen-"
	cont "çaient à abandon-"
	cont "ner les gestes"
	cont "barrières."
else
	text "COVID infects more"
	line "people and #MON"
	cont "every second,"

	para "and some are"
	line "dying from it."

	para "It would be"
	line "terrible if people"
	cont "agreed with"
	cont "TEAM ROCKET's"
	cont "ideology and start"
	cont "bypassing sanitary"
	cont "measures."
endc
	done

RadioTower3FGymGuideText: 
if DEF(_FR_FR)
	text "Nous diffusons des"
	line "émissions distray-"

	para "antes sans jamais"
	line "nous arrêter."

	para "Je vais essayer de"
	line "garder le micro"
	cont "24 heures sur 24!"
else
	text "We run 24 hours a"
	line "day to broadcast"

	para "entertaining pro-"
	line "grams."

	para "I'll do my best to"
	line "run around the"
	cont "clock too!"
endc

	done

RadioTower3FCooltrainerFPleaseSaveDirectorText: 
if DEF(_FR_FR)
	text "Le chef de la TEAM"
	line "ROCKET s'est en-"
	cont "fermé."

	para "Mais le DIRECTEUR"
	line "peut ouvrir."

	para "Il est au"
	line "quatrième."

	para "Sauve-le! Pitié!"
else
	text "The TEAM ROCKET"
	line "boss has locked"
	cont "himself in."

	para "But the DIRECTOR"
	line "can open it."

	para "He's up on the"
	line "fifth floor."

	para "Please save him!"
endc

	done

RadioTower3FCooltrainerFIsDirectorSafeText: 
if DEF(_FR_FR)
	text "Le DIRECTEUR est-"
	line "il en sécurité?"
else
	text "Is the DIRECTOR"
	line "safe?"
endc

	done

RadioTower3FCooltrainerFYoureMyHeroText: 
if DEF(_FR_FR)
	text "Merci!"
	line "Tu es trop cool!"

	para "Prends ceci en"
	line "récompense."
else
	text "Thank you!"
	line "You're my hero!"

	para "This is a token of"
	line "my appreciation."
endc

	done

RadioTower3FCooltrainerFItsSunnyDayText: 
if DEF(_FR_FR)
	text "C'est le ZENITH."
	line "Il renforce les"
	cont "attaques de FEU"
	cont "pendant un moment."
else
	text "It's SUNNY DAY."
	line "It powers up fire-"
	cont "type moves for a"
	cont "while."
endc

	done

RadioTower3FCooltrainerFYouWereMarvelousText: 
if DEF(_FR_FR)
	text "Tu es cool!"
	line "COOOOOOL!"
else
	text "You were simply"
	line "marvelous!"
endc

	done

GruntM7SeenText: 
if DEF(_FR_FR)
	text "On m'a donné des"
	line "ordres précis."

	para "Je dois casser"
	line "tous ceux qui sont"
	cont "contre la ROCKET!"
else
	text "I've been given"
	line "strict orders."

	para "I'm to crush any-"
	line "one who challenges"
	cont "TEAM ROCKET!"
endc

	done

GruntM7BeatenText: 
if DEF(_FR_FR)
	text "De quoi?!"
else
	text "What?!"
endc

	done

GruntM7AfterBattleText: 
if DEF(_FR_FR)
	text "J'ai échoué..."
	line "Quel déshonneur."

	para "Je vais me faire"
	line "virer, c'est sûr."
else
	text "I failed in my"
	line "duties…"

	para "I'll be docked pay"
	line "for this…"
endc

	done

GruntM8SeenText:
if DEF(_FR_FR)
	text "Ca fait du bien de"
	line "voir le monde au"
	cont "delà des quatre"
	cont "murs de mon"
	cont "appartement."

	para "Personne ne me"
	line "privera plus"
	cont "jamais de ma"
	cont "liberté."
else
	text "It feels great"
	line "to explore the"

	para "world outside the"
	line "four walls of my"
	cont "apartment."

	para "No one will ever"
	line "take my freedom."
endc
	done

GruntM8BeatenText:
if DEF(_FR_FR)
	text "Je suis libre de"
	line "perdre ce combat!"
else
	text "I chose to loose"
	line "because I'm free!"
endc
	done

GruntM8AfterBattleText:
if DEF(_FR_FR)
	text "S'il te plaît, ne"
	line "sers plus de ta"
	cont "liberté pour me"
	cont "battre."

	para "Je me rends!"
else
	text "Please don't use"
	line "any more of your"
	cont "freedom to beat"
	cont "me up."

	para "I submit!"
endc
	done

GruntM9SeenText: 
if DEF(_FR_FR)
	text "Pourquoi le truc"
	line "s'est ouvert?"

	para "C'est toi qui as"
	line "fait ça?"
else
	text "Why did the shut-"
	line "ter open? Did you"

	para "have something to"
	line "do with this?"
endc

	done

GruntM9BeatenText: 
if DEF(_FR_FR)
	text "J'suis fichu!"
else
	text "I'm done for!"
endc

	done

GruntM9AfterBattleText: 
if DEF(_FR_FR)
	text "Quoi?! Tu as"
	line "échappé à nos hom-"
	cont "mes du SOUTERRAIN?"

	para "Comment t'as fait?"
else
	text "What?! You made it"
	line "past our men in"
	cont "the UNDERGROUND?"

	para "How could you?"
endc

	done

ScientistMarcSeenText: 
if DEF(_FR_FR)
	text "Quelqu'un qui se"
	line "balade?"

	para "T'es qui toi?"
else
	text "An unknown child"
	line "wandering here?"

	para "Who are you?"
endc

	done

ScientistMarcBeatenText: 
if DEF(_FR_FR)
	text "Psss! J'faisais"
	line "pas attention!"
else
	text "Tch! I took you"
	line "too lightly!"
endc

	done

ScientistMarcAfterBattleText: 
if DEF(_FR_FR)
	text "Bwahahaha..."

	para "Je peux donner"
	line "l'alarme d'ici..."
	cont "Malin, non?"
else
	text "Bwahahaha…"

	para "I can transmit as"
	line "strong a signal as"
	cont "I need from here."
endc

	done

RadioTower3FCardKeySlotText: 
if DEF(_FR_FR)
	text "Un lecteur de"
	line "CARTE MAGN."
else
	text "It's the CARD KEY"
	line "slot."
endc

	done

InsertedTheCardKeyText: 
if DEF(_FR_FR)
	text "<PLAYER> insère"
	line "la CARTE MAGN."
else
	text "<PLAYER> inserted"
	line "the CARD KEY."
endc

	done

RadioTower3FPersonnelSignText: 
if DEF(_FR_FR)
	text "2EME PERSONNEL"
else
	text "3F PERSONNEL"
endc

	done

RadioTower3FPokemonMusicSignText: 
if DEF(_FR_FR)
	text "MUSIQUE #MON"
	line "avec DJ BEN"
else
	text "#MON MUSIC with"
	line "Host DJ BEN"
endc

	done

RadioTower3F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  0,  0, RADIO_TOWER_2F, 1
	warp_event  7,  0, RADIO_TOWER_4F, 2
	warp_event 17,  0, RADIO_TOWER_4F, 4

	def_coord_events

	def_bg_events
	bg_event  3,  0, BGEVENT_READ, RadioTower3FPersonnelSign
	bg_event  9,  0, BGEVENT_READ, RadioTower3FPokemonMusicSign
	bg_event 14,  2, BGEVENT_UP, CardKeySlotScript

	def_object_events
	object_event  7,  4, SPRITE_SUPER_NERD, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, RadioTower3FSuperNerdScript, EVENT_RADIO_TOWER_CIVILIANS_AFTER
	object_event  3,  4, SPRITE_GYM_GUIDE, SPRITEMOVEDATA_SPINRANDOM_FAST, 0, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, RadioTower3FGymGuideScript, -1
	object_event 11,  3, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, RadioTower3FCooltrainerFScript, -1
	object_event  5,  1, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 2, TrainerGruntM7, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  6,  2, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerGruntM8, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event 16,  6, SPRITE_ROCKET, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_TRAINER, 3, TrainerGruntM9, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
	object_event  9,  5, SPRITE_SCIENTIST, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_TRAINER, 4, TrainerScientistMarc, EVENT_RADIO_TOWER_ROCKET_TAKEOVER
