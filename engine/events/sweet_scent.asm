SweetScentFromMenu:
	ld hl, SweetScentScript
	call QueueScript
	ld a, $1
	ld [wFieldMoveSucceeded], a
	ret

SweetScentScript::
	reloadmappart
	special UpdateTimePals
	callasm GetPartyNickname
	writetext UseSweetScentText
	waitbutton
	readvar VAR_MAPGROUP
	ifnotequal GROUP_CERULEAN_CAVE_ENTRANCE, .next_check

	readvar VAR_MAPNUMBER
	ifless MAP_CERULEAN_CAVE_ENTRANCE, .next_check

	readvar VAR_MAPNUMBER
	ifless MAP_CERULEAN_CAVE_B3F + 1, SweetScentNothing

.next_check
	callasm SweetScentEncounter
	iffalse SweetScentNothing
	checkflag ENGINE_BUG_CONTEST_TIMER
	iftrue .BugCatchingContest
	randomwildmon
	startbattle
	reloadmapafterbattle
	callasm CheckSpecialPhoneCall
	end

.BugCatchingContest:
	farsjump BugCatchingContestBattleScript

SweetScentNothing:
	writetext SweetScentNothingText
	waitbutton
	closetext
	end

SweetScentEncounter:
	farcall CanUseSweetScent
	jr nc, .no_battle
	ld hl, wStatusFlags2
	bit STATUSFLAGS2_BUG_CONTEST_TIMER_F, [hl]
	jr nz, .not_in_bug_contest
	farcall GetMapEncounterRate
	ld a, b
	and a
	jr z, .no_battle
	farcall ChooseWildEncounter
	jr nz, .no_battle
	jr .start_battle

.not_in_bug_contest
	farcall ChooseWildEncounter_BugContest

.start_battle
	ld a, $1
	ld [wScriptVar], a
	ret

.no_battle
	xor a
	ld [wScriptVar], a
	ld [wBattleType], a
	ret

UseSweetScentText:
	text_far _UseSweetScentText
	text_end

SweetScentNothingText:
	text_far _SweetScentNothingText
	text_end
