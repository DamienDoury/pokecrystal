; Output: carry is it is currently clapping time, within a clapping area (town).
; Clobbers B.
IsClappingAuthorized::
    ld a, [wEnvironment]
    cp INDOOR + 1
    ret nc

    cp ROUTE
    jr z, .return_false

    ; Valid environments: TOWN and INDOOR. As well as $0, but it doesn't exist.

    ldh a, [hHours]
    cp 20
    jr nz, .return_false
    
    ld a, [wYearMonth] ; Upper nibble = year (0 = 2020), lower nibble = month (0 = january).
    cp $07 ; August 2020.
    ret nc

    sub $02 ; March 2020.
    add a
    ld b, a
    ld a, 10
    sub b
    ld b, a

    ldh a, [hMinutes]
    cp b
    ret

    ; 0. january  = return
    ; 1. february = return
    ; 2. march    = 10 minutes of clapping (from minute 0:00 to 9:59)
    ; 3. april    = 8 minutes
    ; 4. may      = 6 minutes
    ; 5. june     = 4 minutes
    ; 6. july     = 2 minutes
    ; 7. august   = return

.return_false
    xor a
    ret
