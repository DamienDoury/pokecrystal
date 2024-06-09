SpecialMapMusic::
	; Cycling Road check.
	ld hl, wBikeFlags
	bit BIKEFLAGS_ALWAYS_ON_BIKE_F, [hl]
	jr nz, .cycling_road

	; Rave party music.
	; check the area (must be cinnabar island).
	ld a, [wMapGroup]
	cp GROUP_POKECENTER_2F
	jp z, .pokecenter_2f_special_check

	cp GROUP_CINNABAR_ISLAND
	ld a, [wMapNumber]
	jr nz, .skip_rave_party

	cp MAP_CINNABAR_ISLAND
	jr z, .further_rave_party_checks

	cp MAP_SEAFOAM_GYM 
	jr z, .further_rave_party_checks

	cp MAP_CINNABAR_POKECENTER_1F
	jr nz, .skip_rave_party
	
.further_rave_party_checks:
	; check the event flag.
	ld b, CHECK_FLAG
	ld de, EVENT_CINNABAR_RAVE_PARTY
	call EventFlagAction ; Returns the result of the check in c.
	ld a, c
	and a
	jr z, .skip_rave_party	; false.

	ld de, MUSIC_GAME_CORNER
	scf
	ret

.skip_rave_party: ; At this point, A contains [wMapNumber].
	cp MAP_CERULEAN_CAVE_ENTRANCE
	jr c, .skip_cerulean_cave

    cp MAP_CERULEAN_CAVE_B3F + 1
	jr nc, .skip_cerulean_cave

	ld a, [wMapGroup]
	cp GROUP_CERULEAN_CAVE_ENTRANCE
	jr nz, .skip_cerulean_cave

	jr .no

.skip_cerulean_cave:
	ld a, [wMapGroup]
	cp GROUP_VIRIDIAN_FOREST
	jr c, .skip_viridian_forest

	ld a, [wMapNumber]
	cp MAP_VIRIDIAN_FOREST
	jr nz, .skip_viridian_forest

	ld b, CHECK_FLAG
	ld de, EVENT_FOUGHT_ZAPDOS
	call EventFlagAction ; Returns the result of the check in c.
	ld a, c
	and a
	jr z, .skip_viridian_forest

	ld de, MUSIC_ROUTE_2
	scf
	ret

.skip_viridian_forest:
	ld a, [wPlayerState]
	cp PLAYER_SURF
	jr z, .surf
	cp PLAYER_SURF_PIKA
	jr z, .surf_pika

	ld a, [wStatusFlags2]
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, a
	jr nz, .contest

.no
	and a
	ret

.cycling_road
	ld de, MUSIC_BIKE_KANTO
	scf
	ret

.surf_pika
	ld de, MUSIC_SURFING_PIKACHU
	scf
	ret
	
.surf
	ld de, MUSIC_SURF
	scf
	ret

.contest
	ld a, [wMapGroup]
	cp GROUP_ROUTE_35_NATIONAL_PARK_GATE
	jr nz, .no
	ld a, [wMapNumber]
	cp MAP_ROUTE_35_NATIONAL_PARK_GATE
	jr z, .ranking
	cp MAP_ROUTE_36_NATIONAL_PARK_GATE
	jr nz, .no

.ranking
	ld de, MUSIC_BUG_CATCHING_CONTEST_RANKING
	scf
	ret

.pokecenter_2f_special_check
	; Specific checks for Pokécenter 2F, as this map is handled differently.
	ld a, [wBackupMapGroup]
	cp GROUP_CINNABAR_ISLAND
	jr nz, .skip_rave_party

	ld a, [wMapNumber]
	cp MAP_POKECENTER_2F
	jp nz, .skip_rave_party
	jp .further_rave_party_checks
