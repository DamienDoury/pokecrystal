; Boolean checks
FALSE EQU 0
TRUE  EQU 1

; genders
MALE   EQU 0
FEMALE EQU 1

; FlagAction arguments (see home/flag.asm)
	const_def
	const RESET_FLAG
	const SET_FLAG
	const CHECK_FLAG

; G/S version ID: 0 = Gold, 1 = Silver (used by checkver)
; Mystery Gift uses incremented values 1 and 2
GS_VERSION EQU 0
; Pokémon Pikachu 2, a step counter / virtual pet device (used by Mystery Gift)
POKEMON_PIKACHU_2_VERSION EQU 3
RESERVED_GAME_VERSION EQU 4

; save file corruption check values
SAVE_CHECK_VALUE_1 EQU 99
SAVE_CHECK_VALUE_2 EQU 127

; RTC halted check value
RTC_HALT_VALUE EQU $1234

; time of day boundaries
MORN_HOUR EQU 4  ; 4 AM
DAY_HOUR  EQU 10 ; 10 AM
NITE_HOUR EQU 18 ; 6 PM
NOON_HOUR EQU 12 ; 12 PM
MAX_HOUR  EQU 24 ; 12 AM

; significant money values
START_MONEY EQU 3000
MOM_MONEY   EQU 2300
MAX_MONEY   EQU 999999
MAX_COINS   EQU 9999

; link record
MAX_LINK_RECORD EQU 9999

; day-care
MAX_DAY_CARE_EXP EQU $500000

; hall of fame
HOF_MASTER_COUNT EQU 200

; Pokerus immunity duration, added by Damien
POKERUS_DURATION_MASK EQU %00001111
POKERUS_INVERSED_DURATION_MASK EQU %11110000
POKERUS_STRAIN_MASK EQU %11100000
POKERUS_TEST_MASK EQU %00010000 ; The nurse sets this bit once she positively tests a Pokémon to covid. It changes what's written on the status screen. Also, when testing, the nurse has a chance to declare a negative result (other disease that's not the virus) and cure the pokémon.
POKERUS_INVERSED_TEST_MASK EQU %11101111

POKERUS_DISOBEDIENCE_DISEASE_MASK EQU %10000000
POKERUS_XP_DISEASE_MASK EQU %01000000
POKERUS_WEAKNESS_DISEASE_MASK EQU %00100000

POKERUS_FIRST_SHOT_SIGNATURE EQU %00010001
POKERUS_SECOND_SHOT_SIGNATURE EQU %00010010

POKERUS_IMMUNITY_DURATION EQU 10 ; days. The 10th day is included within the immunity period.
POKERUS_SYMPTOMS_START EQU 13 ; days. The 13th day is included within the covid period.

POKERUS_ALPHA_STRAIN EQU POKERUS_XP_DISEASE_MASK | POKERUS_WEAKNESS_DISEASE_MASK
POKERUS_DELTA_STRAIN EQU POKERUS_DISOBEDIENCE_DISEASE_MASK | POKERUS_XP_DISEASE_MASK | POKERUS_WEAKNESS_DISEASE_MASK
POKERUS_BA2_STRAIN EQU POKERUS_DISOBEDIENCE_DISEASE_MASK | POKERUS_WEAKNESS_DISEASE_MASK
POKERUS_BA5_STRAIN EQU POKERUS_DISOBEDIENCE_DISEASE_MASK | POKERUS_XP_DISEASE_MASK


HOSPITALIZATION_DURATION EQU 3 ; Number of days a Pokémon stays in the Emergency Room.
MAX_HAPPINESS_IN_HOSPITAL EQU 200
LOST_HAPPINESS_WHEN_HOSPITALIZED EQU 128
HAPPINESS_GAINED_WHEN_VISITED EQU 60

; Liberty flags
; Réflexion : de base, le byte hour et timeofday valent -1, soit tous les bits à 1. Si on a pas à changer ça, c'est cool. 
; On dit donc que si le bit est à 1, alors l'objet doit s'afficher. Il faudra quand même faire une repasse globale, pour les objets à activation temporaire.

	const_def
	const FREE				;0
	const VACCINE_PASSPORT	;1
	const LOCKDOWN			;2

FREE_F 				EQU %100000 << FREE
VACCINE_PASSPORT_F 	EQU %100000 << VACCINE_PASSPORT
LOCKDOWN_F 			EQU %100000 << LOCKDOWN

; Research level. They work as flags, as you may want to make a NPC appear at several levels, but not all, in order to make the landmark diverse.
	const_def
	const RESEARCH_0	;0
	const RESEARCH_1	;1
	const RESEARCH_2	;2
	const RESEARCH_3	;3
	const_next 7
	const RESEARCH_ANY	;7

RESEARCH_0_MASK   	EQU %00011111
RESEARCH_1_MASK 	EQU %00111111
RESEARCH_2_MASK 	EQU %01011111
RESEARCH_3_MASK 	EQU %01111111

HIDE_FREE				EQU %11011111
HIDE_VACCINE_PASS	EQU %10111111
HIDE_LOCKDOWN			EQU %01111111

WAVE_TILES_AMOUNT EQU 12

HOSPITAL_CORRIDOR_LENGTH EQU 4

VITAMIN_STAT_EXP_CAP EQU $64 ; $6400 is 25600, which is the max value after which Protein and other booster items will stop working.

VIRIDIAN_VERTICAL_WARP_COUNT   EQU 8
VIRIDIAN_HORIZONTAL_WARP_COUNT EQU 4

FONT_REGULAR   EQU 1
FONT_OVERWORLD EQU 2