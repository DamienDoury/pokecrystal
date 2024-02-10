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
    jr z, FiftyPercentStatBoost

    ld a, [hl]
    cp ROCK
    ret nz

    jr FiftyPercentStatBoost

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
    jr z, FiftyPercentStatBoost

    ld a, [hl]
    cp ICE
    ret nz
    ; fallthrough

FiftyPercentStatBoost::
    ld h, b
    ld l, c
    srl b
    rr c
    add hl, bc
    ld b, h
    ld c, l
    ret