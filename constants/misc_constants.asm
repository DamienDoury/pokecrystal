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
POKERUS_TEST_MASK EQU %00010000 ; The nurse sets this bit once she positively test a Pokémon to covid. It changes what's written on the status screen. Also, when testing, the nurse has a chance to declare a negative result (other disease that's not the virus) and cure the pokémon.
POKERUS_INVERSED_TEST_MASK EQU %11101111

POKERUS_DISOBEDIENCE_DISEASE_MASK EQU %10000000
POKERUS_XP_DISEASE_MASK EQU %01000000
POKERUS_WEAKNESS_DISEASE_MASK EQU %00100000

POKERUS_VACCINE_STRAIN EQU %00000000 ; For a Pokémon to be vaccinated, along with this strain (000), it must have a test bit activated, and a duration between 0 and POKERUS_IMMUNITY_DURATION (both excluded, ideally set it to 1).
POKERUS_VACCINE_SIGNATURE EQU %00010001 ; The exact signature of a vaccine. 000 strain + test bit set + 1 remaining day of immunity.
POKERUS_DISEASE_STRAIN_FLOOR EQU %01100000
POKERUS_IMMUNITY_DURATION EQU 10 ; days
POKERUS_SYMPTOMS_DURATION EQU 3 ; days
POKERUS_SYMPTOMS_START EQU 13 ; days

