PoliceSeenTextPool::
	dw PoliceSeenText1
	dw PoliceSeenText2
	dw PoliceSeenText3
	dw PoliceSeenText4
	dw PoliceSeenText5
	dw PoliceSeenText6
	dw PoliceSeenText7
	dw PoliceSeenText8
	dw PoliceSeenText9
	dw PoliceSeenText10
	dw PoliceSeenText11
	dw PoliceSeenText12
	dw PoliceSeenText13
	dw PoliceSeenText14
	dw PoliceSeenText15
	dw PoliceSeenText16

PoliceSeenText1::
if DEF(_FR_FR)
	text "Je vous vois."
	done
else
	text "I can see you."
	done
endc


PoliceSeenText2::
if DEF(_FR_FR)
	text "Que faites-vous"
	line "ici?"
	done
else
	text "What are you"
	line "doing here?"
	done
endc


PoliceSeenText3::
if DEF(_FR_FR)
	text "Vous devriez"
	line "être confiné."
	done
else
	text "You should be"
	line "quarantined."
	done
endc


PoliceSeenText4::
if DEF(_FR_FR)
	text "Vous savez qu'il"
	line "est interdit d'être"
	
	para "à l'extérieur,"
	line "n'est-ce pas?"
	done
else
	text "You know you can't"
	line "be outside, right?"
	done
endc


PoliceSeenText5::
if DEF(_FR_FR)
	text "Vous tentiez"
	line "vraiment de"
	cont "m'éviter?"
	done
else
	text "Were you trying"
	line "to avoid me?"
	done
endc


PoliceSeenText6::
if DEF(_FR_FR)
	text "Contrôle de"
	line "police."

	para "Montrez-moi vos"
	line "papiers."
	done
else
	text "Police control."

	para "Show me your"
	line "papers."
	done
endc


PoliceSeenText7::
if DEF(_FR_FR)
	text "Les dresseurs"
	line "n'ont pas le droit"
	cont "de sortir."
	done
else
	text "Trainers have no"
	line "right to go out."
	done
endc


PoliceSeenText8::
if DEF(_FR_FR)
	text "Vous êtes en état"
	line "d'arrestation!"
	done
else
	text "I'm arresting you!"
	done
endc


PoliceSeenText9::
if DEF(_FR_FR)
	text "Plus un geste!"
	done
else
	text "Stop right there!"
	done
endc


PoliceSeenText10::
if DEF(_FR_FR)
	text "Les mains en l'air!"
	done
else
	text "Freeze!"
	done
endc


PoliceSeenText11::
if DEF(_FR_FR)
	text "Je vous emmène"
	line "avec moi."
	done
else
	text "I'm taking you"
	line "with me."
	done
endc


PoliceSeenText12::
if DEF(_FR_FR)
	text "Hey! Vous!"
	done
else
	text "Hey! You!"
	done
endc


PoliceSeenText13::
if DEF(_FR_FR)
	text "Vous devriez"
	line "être chez vous"
	cont "en ce moment."
	done
else
	text "You must be home"
	line "at the moment."
	done
endc


PoliceSeenText14::
if DEF(_FR_FR)
	text "Vous essayez de"
	line "vous cacher des"
	cont "forces de l'ordre?"
	done
else
	text "Are you trying"
	line "to hide from us?"
	done
endc


PoliceSeenText15::
if DEF(_FR_FR)
	text "Etre dehors, c'est"
	line "risquer de"
	
	para "propager le"
	line "virus."

	para "C'est un acte"
	line "irresponsable."
	done
else
	text "Being outside is a"
	line "risk of spreading"
	cont "the virus."

	para "Your act is"
	line "irresponsible."
	done
endc


PoliceSeenText16::
if DEF(_FR_FR)
	text "Un civil!"
	line "ATTRAPEZ CETTE"
	cont "PERSONNE!"
	done
else
	text "A civilian!"
	line "CATCH THIS PERSON!"
	done
endc







PoliceBeatenTextPool::
	dw PoliceBeatenText1
	dw PoliceBeatenText2
	dw PoliceBeatenText3
	dw PoliceBeatenText4
	dw PoliceBeatenText5
	dw PoliceBeatenText6
	dw PoliceBeatenText7
	dw PoliceBeatenText8
	dw PoliceBeatenText9
	dw PoliceBeatenText10
	dw PoliceBeatenText11
	dw PoliceBeatenText12
	dw PoliceBeatenText13
	dw PoliceBeatenText14
	dw PoliceBeatenText15
	dw PoliceBeatenText16

PoliceBeatenBackupText::
if DEF(_FR_FR)
	text "J'appelle"
	line "les renforts."
	done
else
	text "I'm calling"
	line "for backup."
	done
endc


PoliceBeatenText1::
if DEF(_FR_FR)
	text "C'était le dernier"
	line "avertissement."
	done
else
	text "I'm letting you off"
	line "with a warning."
	done
endc


PoliceBeatenText2::
if DEF(_FR_FR)
	text "Prétendons que je"
	line "ne vous ai pas vu."
	done
else
	text "I'll pretend"
	line "I didn't see you."
	done
endc


PoliceBeatenText3::
if DEF(_FR_FR)
	text "Vous êtes balèze."
	done
else
	text "You're a tough one."
	done
endc


PoliceBeatenText4::
if DEF(_FR_FR)
	text "Waouh! Je n'étais"
	line "pas prêt pour ça!"
	done
else
	text "Wow! I didn't"
	line "expect that!"
	done
endc


PoliceBeatenText5::
if DEF(_FR_FR)
	text "Mes collègues vous"
	line "attraperont."
	done
else
	text "My colleagues"
	line "will get you."
	done
endc


PoliceBeatenText6::
if DEF(_FR_FR)
	text "Vous ne respectez"
	line "pas l'authorité..."
	done
else
	text "You got no respect"
	line "for authority…"
	done
endc


PoliceBeatenText7::
if DEF(_FR_FR)
	text "Me résister est"
	line "hors-la-loi."
	done
else
	text "Fighting me is"
	line "against the law."
	done
endc


PoliceBeatenText8::
if DEF(_FR_FR)
	text "Repli tactique!"
	done
else
	text "Tactical retreat!"
	done
endc


PoliceBeatenText9::
if DEF(_FR_FR)
	text "La loi ne compte"
	line "pas pour toi?"
	done
else
	text "Does the law mean"
	line "anything to you?"
	done
endc


PoliceBeatenText10::
if DEF(_FR_FR)
	text "Rentrez chez vous"
	line "maintenant."
	done
else
	text "Go home now."
	done
endc


PoliceBeatenText11::
if DEF(_FR_FR)
	text "Je n'ai pas été"
	line "formé pour ça..."
	done
else
	text "I wasn't prepared"
	line "for this…"
	done
endc


PoliceBeatenText12::
if DEF(_FR_FR)
	text "Vous pourriez pro-"
	line "pager le virus..."
	done
else
	text "You may be sprea-"
	line "ding the virus…"
	done
endc


PoliceBeatenText13::
if DEF(_FR_FR)
	text "Mes collègues me"
	line "vengeront."
	done
else
	text "You can beat me."
	line "But not all of us."
	done
endc


PoliceBeatenText14::
if DEF(_FR_FR)
	text "Vous aller"
	line "regretter ça."
	done
else
	text "You'll regret this."
	done
endc


PoliceBeatenText15::
if DEF(_FR_FR)
	text "Les règles sont"
	line "pour votre bien."
	done
else
	text "Restrictions exist"
	line "for a reason."
	done
endc


PoliceBeatenText16::
if DEF(_FR_FR)
	text "Nous ne vous"
	line "laisserons fuir."
	done
else
	text "We won't let you"
	line "run away."
	done
endc
