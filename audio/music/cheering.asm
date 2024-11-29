Music_Cheering:
	musicheader 3, 1, Music_Cheering_Ch1
	musicheader 1, 2, Music_Cheering_Ch2
	musicheader 1, 4, Music_Cheering_Ch4

	
Music_Cheering_Ch8:
	toggle_sfx
	sfx_toggle_noise 6
	sound_jump Music_Cheering_Ch4.notetype

Music_Cheering_Ch4:
	togglenoise 6
.notetype
	notetype 12
	tempo 98
Music_Cheering_Ch4_loop:
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	stereopanning $f0
	note D#, 4
	stereopanning $ff
	note E_, 4
	note C#, 4
	note E_, 4
	stereopanning $f
	note E_, 4
	stereopanning $ff
	note D_, 4
	note D#, 4
	note E_, 4
	stereopanning $f0
	note E_, 4
	stereopanning $ff
	note E_, 4
	note C#, 4
	note D#, 4
	note D#, 4
	stereopanning $f0
	note E_, 4
	stereopanning $ff
	note D_, 4
	note E_, 4
	note D#, 4
	stereopanning $f
	note C#, 4
	stereopanning $ff
	note E_, 4
	note E_, 4
	note D_, 4
	note D#, 4
	stereopanning $f0
	note E_, 4
	stereopanning $ff
	note E_, 4
	note D_, 4
	stereopanning $f0
	note E_, 4
	stereopanning $ff
	note E_, 4
	note E_, 4
	note D#, 4
	note E_, 4
	stereopanning $f
	note C#, 4
	stereopanning $ff
	note D_, 4
	note E_, 4
	note E_, 4
	note D#, 4
	stereopanning $f
	note E_, 4
	stereopanning $ff
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note D_, 4
	note E_, 4
	stereopanning $f0
	note C#, 4
	stereopanning $ff
	note D#, 4
	note E_, 4
	note E_, 4
	stereopanning $f
	note D_, 4
	stereopanning $ff
	note E_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	stereopanning $f0
	note C#, 4
	stereopanning $ff
	note D#, 4
	note E_, 4
	note E_, 4
	note E_, 4
	note D_, 4
	stereopanning $f
	note D#, 4
	note E_, 4
	stereopanning $ff
	note E_, 4
	note D_, 4
	note E_, 4
	note C#, 4
	note E_, 4
	note E_, 4
	note E_, 4
	stereopanning $f0
	note E_, 4
	stereopanning $ff
	note E_, 4
	note D_, 4
	note E_, 4
	note E_, 4
	note E_, 4
	stereopanning $f
	note D#, 4
	note C#, 4
	stereopanning $ff
	note D#, 4
	note E_, 4
	stereopanning $f0
	note E_, 4
	stereopanning $ff
	note D_, 4
	note E_, 4
	note E_, 4
	note C#, 4
	stereopanning $ff
	note E_, 4
	stereopanning $ff
	note E_, 4
	note E_, 4
	note E_, 4
	loopchannel 0, Music_Cheering_Ch4_loop


Music_Cheering_Ch1:
	tempo 98
	dutycycle $2
Music_Cheering_Ch1_loop:
	stereopanning $ff
	note __, 16
	
	callchannel Music_Cheering_Ch1_12

	pitchoffset 1, A#
	note __, 13
	note __, 16
	note __, 16
	callchannel Music_Cheering_Ch1_15
	pitchoffset 0, C_

	note __, 16
	note __, 7
	note __, 16
	note __, 16
	callchannel Music_Cheering_Ch1_15

	pitchoffset 1, A_
	note __, 16
	note __, 1
	note __, 16
	note __, 16
	callchannel Music_Cheering_Ch1_7
	pitchoffset 0, C_

	note __, 13
	note __, 16
	note __, 16
	callchannel Music_Cheering_Ch1_12
	loopchannel 0, Music_Cheering_Ch1_loop

Music_Cheering_Ch1_12:
	vibrato $08, $16
	octave 6
	notetype 12, $38
	note B_, 8
	intensity $32
	slidepitchto 1, 2, G_
	note B_, 4
	endchannel

Music_Cheering_Ch1_15:
	vibrato $08, $14
	octave 6
	notetype 12, $38
	note B_, 10
	intensity $32
	slidepitchto 1, 2, G_
	note B_, 4
	endchannel

Music_Cheering_Ch1_7:
	vibrato $08, $14
	octave 6
	notetype 12, $38
	note B_, 5
	intensity $32
	slidepitchto 1, 2, G_
	note B_, 4
	endchannel
; ==============================================================================
; ==============================================================================

Music_Cheering_Ch2:
	tempo 98
	dutycycle $2
	notetype 12, $48
Music_Cheering_Ch2_loop:
	note __, 16
	note __, 16
	note __, 7
	stereopanning $f
	callchannel Music_Cheering_Ch1_7

	stereopanning $f0
	note __, 16
	note __, 11
	note __, 16
	callchannel Music_Cheering_Ch1_12

	stereopanning $f
	note __, 16
	note __, 3
	note __, 16
	note __, 16
	callchannel Music_Cheering_Ch1_7

	stereopanning $f0
	note __, 16
	note __, 7
	note __, 16
	note __, 16
	callchannel Music_Cheering_Ch1_15

	stereopanning $f
	note __, 16
	note __, 11
	note __, 16
	callchannel Music_Cheering_Ch1_12
	note __, 16
	note __, 7
	note __, 16
	note __, 16
	loopchannel 0, Music_Cheering_Ch2_loop
	
	
;==================
;==================

Music_Cheering_NoWhistling:
	musicheader 1, 4, Music_Cheering_Ch4

	
Sfx_Cheering:
	musicheader 1, 8, Music_Cheering_Ch8
