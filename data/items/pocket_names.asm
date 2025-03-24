ItemPocketNames:
; entries correspond to item type constants
	table_width 2, ItemPocketNames
	dw .Item
	dw .Key
	dw .Ball
	dw .TM
	dw .Meds
	dw .Berries
	assert_table_length NUM_ITEM_TYPES

if DEF(_FR_FR)
.Item: 		db "POCHE OBJETS@"
.Key:  		db "POCHE RARES@"
.Ball: 		db "POCHE BALLS@"
.TM:   		db "POCHE CT/CS@"
.Meds:      db "POCHE MEDIC@"
.Berries:   db "POCHE BAIES@"
else
.Item: 		db "ITEM POCKET@"
.Key:  		db "KEY POCKET@"
.Ball: 		db "BALL POCKET@"
.TM:   		db "TM POCKET@"
.Meds:      db "MEDIC. POCKET@"
.Berries:   db "BERRY POCKET@"
endc