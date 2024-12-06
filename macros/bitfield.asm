; Thanks to Rangi42/Sylvie for the original macro that was used as the base for this one.
;
; Use: 
;    def_bitfield [OPTIONAL_FIXED_LENGTH]
;    bit_value BIT_INDEX
;    end_bitfield


; Initializes the parameters of the bitfield.
MACRO def_bitfield
    if _NARG == 0
    ; Dynamic size bitfield.
        DEF _fixed_last_bit_index = 0
        DEF _last_bit_index = 0
    else
    ; Fixed size bitfield.
        DEF _fixed_last_bit_index = \1
        DEF _last_bit_index = \1
    endc
ENDM


; Sets a specific bit within the bitfield.
MACRO bit_value
    ; Fixed length constraint.
    if _fixed_last_bit_index > 0
        assert \1 <= _fixed_last_bit_index, "Bitfield length {\1} is greater than its defined fixed length of {_fixed_last_bit_index} bits."
    endc

    DEF n = \1 / 8 ; Byte offset.
    DEF i = \1 % 8 ; Bit offset within byte at offset n.

    ; Dynamic length management.
    if \1 > _last_bit_index
        DEF _last_bit_index = \1
    endc

    ; Declaration of an empty byte when we first populate it.
    if !DEF(_bitfield{d:n})
        DEF _bitfield{d:n} = 0
    endc

    ; Adding the bit entry into the byte.
    DEF _bitfield{d:n} |= 1 << i
ENDM
 

; Writes the bitfield.
MACRO end_bitfield
	for n, (_last_bit_index + 7) / 8 ; This formula rounds up the byte count, so no bit is dropped.
		if DEF(_bitfield{d:n})
            db _bitfield{d:n}
        else
            db 0 ; We must not forget about bytes that have not been populated!
        endc
	endr
ENDM
