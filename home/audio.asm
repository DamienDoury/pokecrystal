; Audio interfaces.

InitSound::
	push hl
	push de
	push bc
	push af

	ldh a, [hROMBank]
	push af
	ld a, BANK(_InitSound)
	ldh [hROMBank], a
	ld [MBC3RomBank], a

	call _InitSound

	pop af
	ldh [hROMBank], a
	ld [MBC3RomBank], a

	pop af
	pop bc
	pop de
	pop hl
	ret

UpdateSound::
	push hl
	push de
	push bc
	push af

	ldh a, [hROMBank]
	push af
	ld a, BANK(_UpdateSound)
	ldh [hROMBank], a
	ld [MBC3RomBank], a

	call _UpdateSound

	pop af
	ldh [hROMBank], a
	ld [MBC3RomBank], a

	pop af
	pop bc
	pop de
	pop hl
	ret

_LoadMusicByte::
; [wCurMusicByte] = [a:de]
	ldh [hROMBank], a
	ld [MBC3RomBank], a

	ld a, [de]
	ld [wCurMusicByte], a
	ld a, BANK(LoadMusicByte)

	ldh [hROMBank], a
	ld [MBC3RomBank], a
	ret

PlayMusic::
; Play music de.

	push hl
	push de
	push bc
	push af

	ldh a, [hInMenu]
	and a
	jr z, .do_it

	ld b, CHECK_FLAG
	push de
	ld de, EVENT_CINNABAR_RAVE_PARTY
	call EventFlagAction
	pop de
	ld a, c
	and a
	jr nz, .end_now

.do_it
	ldh a, [hROMBank]
	push af
	ld a, BANK(_PlayMusic) ; aka BANK(_InitSound)
	ldh [hROMBank], a
	ld [MBC3RomBank], a

	ld a, e
	and a
	jr z, .nomusic

	call _PlayMusic
	jr .end

.nomusic
	call _InitSound

.end
	pop af
	ldh [hROMBank], a
	ld [MBC3RomBank], a
.end_now
	pop af
	pop bc
	pop de
	pop hl
	ret

PlayMusic2::
; Stop playing music, then play music de.

	push hl
	push de
	push bc
	push af

	ldh a, [hROMBank]
	push af
	ld a, BANK(_PlayMusic)
	ldh [hROMBank], a
	ld [MBC3RomBank], a

	push de
	ld de, MUSIC_NONE
	call _PlayMusic
	call DelayFrame
	pop de
	call _PlayMusic

	pop af
	ldh [hROMBank], a
	ld [MBC3RomBank], a

	pop af
	pop bc
	pop de
	pop hl
	ret

PlayCry::
; Play cry de.

	push hl
	push de
	push bc
	push af

	ldh a, [hROMBank]
	push af

	; Cries are stuck in one bank.
	ld a, BANK(PokemonCries)
	ldh [hROMBank], a
	ld [MBC3RomBank], a

	ld hl, PokemonCries
rept MON_CRY_LENGTH
	add hl, de
endr

	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl

	ld a, [hli]
	ld [wCryPitch], a
	ld a, [hli]
	ld [wCryPitch + 1], a
	ld a, [hli]
	ld [wCryLength], a
	ld a, [hl]
	ld [wCryLength + 1], a

	ld a, BANK(_PlayCry)
	ldh [hROMBank], a
	ld [MBC3RomBank], a

	call _PlayCry

	pop af
	ldh [hROMBank], a
	ld [MBC3RomBank], a

	pop af
	pop bc
	pop de
	pop hl
	ret

WaitPlaySFX::
	call WaitSFX
	; fallthrough.

PlaySFX::
; Play sound effect de.
; Sound effects are ordered by priority (highest to lowest)

	push hl
	push de
	push bc
	push af

	; Is something already playing?
	call CheckSFX
	jr nc, .play

	; Does it have priority?
	ld a, [wCurSFX]
	cp SFX_CLAP_1
	jr z, .play

	cp SFX_CLAP_2
	jr z, .play

	cp SFX_CLAP_3
	jr z, .play
	
	cp e
	jr c, .done

.play
	ldh a, [hROMBank]
	push af
	ld a, BANK(_PlaySFX)
	ldh [hROMBank], a
	ld [MBC3RomBank], a

	ld a, e
	ld [wCurSFX], a
	call _PlaySFX

	pop af
	ldh [hROMBank], a
	ld [MBC3RomBank], a

.done
	pop af
	pop bc
	pop de
	pop hl
	ret

WaitSFX::
; infinite loop until sfx is done playing
	push hl
	push af
	ld a, [wCurSFX]
	cp SFX_CHEERING
	jr z, .exit

.wait
	ld hl, wChannel5Flags1
	bit 0, [hl]
	jr nz, .wait
	ld hl, wChannel6Flags1
	bit 0, [hl]
	jr nz, .wait
	ld hl, wChannel7Flags1
	bit 0, [hl]
	jr nz, .wait
	ld hl, wChannel8Flags1
	bit 0, [hl]
	jr nz, .wait

.exit
	pop af
	pop hl
	ret

IsSFXPlaying::
; Return carry if no sound effect is playing.
; The inverse of CheckSFX.
	push hl

	ld hl, wChannel5Flags1
	bit 0, [hl]
	jr nz, .playing
	ld hl, wChannel6Flags1
	bit 0, [hl]
	jr nz, .playing
	ld hl, wChannel7Flags1
	bit 0, [hl]
	jr nz, .playing
	ld hl, wChannel8Flags1
	bit 0, [hl]
	jr nz, .playing

	pop hl
	scf
	ret

.playing
	pop hl
	and a
	ret

MaxVolume::
	ld a, MAX_VOLUME
	ld [wVolume], a
	ret

LowVolume::
	ld a, $33 ; 50%
	ld [wVolume], a
	ret

MinVolume::
	xor a
	ld [wVolume], a
	ret

FadeInToMusic::
	ld a, 4 | (1 << MUSIC_FADE_IN_F)
	ld [wMusicFade], a
	ret

SkipMusic::
; Skip a frames of music.
.loop
	and a
	ret z
	dec a
	call UpdateSound
	jr .loop

FadeToMapMusic::
	push hl
	push de
	push bc
	push af

	call GetMapMusic_MaybeSpecial
	ld a, [wMapMusic]
	cp e
	jr z, .done

	ld a, 8
	ld [wMusicFade], a
	ld a, e
	ld [wMusicFadeID], a
	ld a, d
	ld [wMusicFadeID + 1], a
	ld a, e
	ld [wMapMusic], a

.done
	pop af
	pop bc
	pop de
	pop hl
	ret

PlayMapMusic::
	push hl
	push de
	push bc
	push af

	call GetMapMusic_MaybeSpecial
	ld a, [wMapMusic]
	cp e
	jr z, .done

	push de
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	pop de
	ld a, e
	ld [wMapMusic], a
	call PlayMusic

.done
	pop af
	pop bc
	pop de
	pop hl
	ret

PlayMapMusicBike::
; If the player's on a bike, play the bike music instead of the map music
	push hl
	push de
	push bc
	push af

	; during the rave party, we don't play the bike music!
	ld a, [wMapGroup]
	cp GROUP_CINNABAR_ISLAND
	jr nz, .skip_rave_party
	ld a, [wMapNumber]
	cp MAP_CINNABAR_ISLAND
	jr nz, .skip_rave_party

	; check the rave party event flag.
	ld b, CHECK_FLAG
	ld de, EVENT_CINNABAR_RAVE_PARTY
	call EventFlagAction ; Returns the result of the check in c.
	ld a, c
	and a
	jr z, .skip_rave_party	; false.
	; true.
	call PlayMapMusic
	jr .quit_function

.skip_rave_party
	; We don't play the bike music in cerulean cave.
	ld a, [wMapGroup]
	cp GROUP_CERULEAN_CAVE_ENTRANCE
	jr nz, .skip_cerulean_cave

	ld a, [wMapNumber]
	cp MAP_CERULEAN_CAVE_ENTRANCE
	jr c, .skip_cerulean_cave

	cp MAP_CERULEAN_CAVE_B3F + 1
	jr nc, .skip_cerulean_cave

	call PlayMapMusic
	jr .quit_function ; true.

.skip_cerulean_cave
	xor a
	ld [wDontPlayMapMusicOnReload], a
	ld de, MUSIC_BICYCLE
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	jr z, .play
	call GetMapMusic_MaybeSpecial
.play
	push de
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	pop de

	ld a, e
	ld [wMapMusic], a
	call PlayMusic

.quit_function
	pop af
	pop bc
	pop de
	pop hl
	ret

TryRestartMapMusic::
	ld a, [wDontPlayMapMusicOnReload]
	and a
	jr z, RestartMapMusic
	xor a
	ld [wMapMusic], a
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	xor a
	ld [wDontPlayMapMusicOnReload], a
	ret

RestartMapMusic::
	push hl
	push de
	push bc
	push af
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	ld a, [wMapMusic]
	ld e, a
	ld d, 0
	call PlayMusic
	pop af
	pop bc
	pop de
	pop hl
	ret

GetMapMusic_MaybeSpecial::
	farcall SpecialMapMusic
	ret c
	jmp GetMapMusic

CheckSFX::
; Return carry if any SFX channels are active.
	ld a, [wChannel5Flags1]
	bit 0, a
	jr nz, .playing
	ld a, [wChannel6Flags1]
	bit 0, a
	jr nz, .playing
	ld a, [wChannel7Flags1]
	bit 0, a
	jr nz, .playing
	ld a, [wChannel8Flags1]
	bit 0, a
	jr nz, .playing
	and a
	ret
.playing
	scf
	ret

TerminateExpBarSound::
	xor a
	ld [wChannel5Flags1], a
	ld [wPitchSweep], a
	ldh [rNR10], a
	ldh [rNR11], a
	ldh [rNR12], a
	ldh [rNR13], a
	ldh [rNR14], a
	ret

ChannelsOff::
; Quickly turn off music channels
	xor a
	ld [wChannel1Flags1], a
	ld [wChannel2Flags1], a
	ld [wChannel3Flags1], a
	ld [wChannel4Flags1], a
	ld [wPitchSweep], a
	ret

SFXChannelsOff::
; Quickly turn off sound effect channels
	xor a
	ld [wChannel5Flags1], a
	ld [wChannel6Flags1], a
	ld [wChannel7Flags1], a
	ld [wChannel8Flags1], a
	ld [wPitchSweep], a
	ret
