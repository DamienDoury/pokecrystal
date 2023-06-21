mon_prob: MACRO
; percent, index
	db \1, \2 * 2
ENDM

GrassMonProbTableRegular:
	table_width 2, GrassMonProbTableRegular
	mon_prob 30 percent,  0 ; 30% chance
	mon_prob 60 percent,  1 ; 30% chance
	mon_prob 80 percent,  2 ; 20% chance
	mon_prob 90 percent,  3 ; 10% chance
	mon_prob 95 percent,  4 ;  5% chance
	mon_prob 99 percent,  5 ;  4% chance
	mon_prob 100 percent, 6 ;  1% chance
	assert_table_length NUM_GRASSMON

GrassMonProbTableRare:
	table_width 2, GrassMonProbTableRegular
	mon_prob 15 percent,  2 ; 15% chance
	mon_prob 40 percent,  3 ; 25% chance
	mon_prob 60 percent,  4 ; 20% chance
	mon_prob 80 percent,  5 ; 20% chance
	mon_prob 100 percent, 6 ; 20% chance
	;assert_table_length NUM_GRASSMON

WaterMonProbTable:
	table_width 2, WaterMonProbTable
	mon_prob 60 percent,  0 ; 60% chance
	mon_prob 90 percent,  1 ; 30% chance
	mon_prob 100 percent, 2 ; 10% chance
	assert_table_length NUM_WATERMON
