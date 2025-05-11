StatNames:
; entries correspond to stat ids
	list_start StatNames
if DEF(_FR_FR)
	li "ATTAQUE"
	li "DEFENSE"
	li "VITESSE"
	li "ATQ.SPE."
	li "DEF.SPE."
	li "PRECISION"
	li "ESQUIVE"
	li "APTITUDE" ; used for BattleCommand_Curse
else
	li "ATTACK"
	li "DEFENSE"
	li "SPEED"
	li "SPCL.ATK"
	li "SPCL.DEF"
	li "ACCURACY"
	li "EVASION"
	li "stats" ; used for BattleCommand_Curse
endc
	assert_list_length NUM_LEVEL_STATS
