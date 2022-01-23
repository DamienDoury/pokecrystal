; Putting it in ROM 0 is ugly. 
; Based on this tutorial: https://github.com/pret/pokecrystal/wiki/Grant-Grass-type-Pok%C3%A9mon-immunity-to-Powder-Spore-based-moves
PowderMoves::
	db POISONPOWDER
	db SLEEP_POWDER
	db SPORE
	db COTTON_SPORE
	db STUN_SPORE
	db -1