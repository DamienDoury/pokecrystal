SandstormSpDefBoost::
; First, check if Sandstorm is active.
    ld a, [wBattleWeather]
    cp WEATHER_SANDSTORM
    ret nz

; Then, check the opponent's types.
    ld hl, wEnemyMonType1
    ldh a, [hBattleTurn]
    and a
    jr z, .ok
    ld hl, wBattleMonType1
.ok
    ld a, [hli]
    cp ROCK
    jr z, HailDefBoost.start_boost
    ld a, [hl]
    cp ROCK
    ret nz

    jr HailDefBoost.start_boost

HailDefBoost::
    ; First, check if Hail is active.
    ld a, [wBattleWeather]
    cp WEATHER_HAIL
    ret nz

; Then, check the opponent's types.
    ld hl, wEnemyMonType1
    ldh a, [hBattleTurn]
    and a
    jr z, .ok
    ld hl, wBattleMonType1
.ok
    ld a, [hli]
    cp ICE
    jr z, .start_boost
    ld a, [hl]
    cp ICE
    ret nz

.start_boost
    ld h, b
    ld l, c
    srl b
    rr c
    add hl, bc
    ld b, h
    ld c, l
    ret