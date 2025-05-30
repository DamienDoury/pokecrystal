; see engine/menus/naming_screen.asm

if DEF(_FR_FR)
MailEntry_Uppercase:
	db "   ABCDEFGHIJKLM   "
	db "   NOPQRSTUVWXYZ   "
	db "   1234567890 +-   "
	db "   <PK><MN><PO><KE>é♂♀¥…&?!<AT>   "
	db "   ()“”[],.':;<HASHTAG><PERCENT>   "
	db "min    EFF   FIN   "

MailEntry_Lowercase:
	db "   abcdefghijklm   "
	db "   nopqrstuvwxyz   "
	db "   1234567890 ×/   "
	db "   àèùâêîôûç       "
	db "   c'd'j'l'm'n'p's''st'u'y'    "
	db "MAJ    EFF   FIN   "
else
MailEntry_Uppercase:
	db "A B C D E F G H I J"
	db "K L M N O P Q R S T"
	db "U V W X Y Z   , ? !"
	db "1 2 3 4 5 6 7 8 9 0"
	db "<PK> <MN> <PO> <KE> é ♂ ♀ ¥ … ×"
	db "lower  DEL   END   "

MailEntry_Lowercase:
	db "a b c d e f g h i j"
	db "k l m n o p q r s t"
	db "u v w x y z   . - /"
	db "'d 'l 'm 'r 's 't 'v & ( )"
	db "“ ” [ ] ' : ; <AT> <HASHTAG> <PERCENT>"
	db "UPPER  DEL   END   "
endc
