NonTrainerCallerNames:
; entries correspond to PHONECONTACT_* constants (see constants/trainer_constants.asm)
	table_width 2, NonTrainerCallerNames
	dw .none
	dw .mom
	dw .bikeshop
	dw .bill
	dw .elm
	dw .hospital
	dw .creator
	dw .buena
	assert_table_length NUM_NONTRAINER_PHONECONTACTS + 1

.none:     db "----------@"
.mom:      db "MOM:@"
.bill:     db "BILL:@"
.elm:      db "PROF.ELM:@"
.bikeshop: db "BIKE SHOP:@"
.hospital: db "NURSE JOY:<LF>      HOSPITAL@"
.creator:  db "HIDDEN NUMBER:@"
.buena:    db "BUENA:<LF>   DISC JOCKEY@"
