ItemPocketNames:
; entries correspond to item type constants
	table_width 2, ItemPocketNames
	dw .Item
	dw .Meds
	dw .Berries
	dw .Ball
	dw .TM
	dw .Key
	assert_table_length NUM_ITEM_TYPES

if DEF(_FR_FR)
.Item: 		db "POCHE OBJETS@"
.Meds:      db "POCHE MEDIC@"
.Berries:   db "POCHE BAIES@"
.Ball: 		db "POCHE BALLS@"
.TM:   		db "POCHE CT/CS@"
.Key:  		db "POCHE RARES@"
else
.Item: 		db "ITEM POCKET@"
.Meds:      db "MEDIC. POCKET@"
.Berries:   db "BERRY POCKET@"
.Ball: 		db "BALL POCKET@"
.TM:   		db "TM POCKET@"
.Key:  		db "KEY POCKET@"
endc