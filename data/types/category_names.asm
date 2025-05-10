CategoryNames:
	dw .Physical
	dw .Special
	dw .Status

if DEF(_FR_FR)
.Physical: db "PHYSIQUE@"
.Special:  db "SPECIAL@"
.Status:   db "STATUT@"
else
.Physical: db "PHYSICAL@"
.Special:  db "SPECIAL@"
.Status:   db "STATUS@"
endc