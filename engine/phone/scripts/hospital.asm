HospitalCalleeScript:
HospitalCallerScript:
	readvar VAR_SPECIALPHONECALL
	ifequal SPECIALCALL_RECOVER_HOSPITAL, .recover
	ifequal SPECIALCALL_BOOSTER_SHOT_AVAILABLE, .second_shot_available
	ifequal SPECIALCALL_CONTACT_TRACING_AVAILABLE, .contact_tracing_available

	farwritetext HospitalPhoneReleaseText
	specialphonecall SPECIALCALL_NONE
	end

.recover
	farwritetext HospitalPhoneRecoverText
	specialphonecall SPECIALCALL_NONE
	end

.second_shot_available
	setevent EVENT_PLAYER_CAN_GET_ITS_SECOND_SHOT
	farwritetext HospitalSecondShotAvailableText
	specialphonecall SPECIALCALL_NONE
	end

.contact_tracing_available
	setevent EVENT_CONTACT_TRACING_MODULE_AVAILABLE
	specialphonecall SPECIALCALL_NONE
	writetext .HospitalContactTracingAvailableText
	promptbutton
	checkevent EVENT_MET_BILL
	iffalse .metBill
	writetext .HospitalContactTracingAvailableEcruteakText
	end

.metBill
	writetext .HospitalContactTracingAvailableGoldenrodText
	end

.HospitalContactTracingAvailableText
if DEF(_FR_FR)
	text "Bonne nouvelle"
	line "<PLAYER>!"

	para "Nous avons une"
	line "arme nouvelle"
	cont "contre la"
	cont "pandémie!"

	para "Un génie nommé LEO"
	line "a créé un nouveau"
	cont "module pour le"
	cont "#GEAR."

	para "Une fois installé,"
	line "il enregistre ton"
	cont "trajet toute la"
	cont "journée."

	para "Si une personne"
	line "ou son #MON est"
	cont "détectée comme"
	cont "contaminée,"

	para "l'appli retrace"
	line "le trajet de"
	cont "l'utilisateur"
	cont "pour trouver"

	para "les autres"
	line "utilisateurs"
	cont "croisés."

	para "Ces personnes"
	line "pourront alors"
	cont "être prévenues."

	para "C'est ce qu'on"
	line "appelle le TRAçAGE"
	cont "DES CONTACTS."

	para "Plus nous sommes"
	line "nombreux à"
	cont "l'utiliser, plus"
	cont "c'est efficace."

	para "Tu devrais récu-"
	line "pérer ce nouveau"
	cont "COUPON pour ton"
	cont "#GEAR."
	done
else
	text "Good news <PLAYER>!"
	line "We have a new"
	cont "weapon against"
	cont "the pandemic!"

	para "A genius named"
	line "BILL developed a"
	cont "new #GEAR CARD."

	para "Once installed, it"
	line "tracks your path"
	cont "all day long and"
	cont "stores the info."

	para "If a person or"
	line "their #MON is"
	cont "found to have been"
	cont "contaminated,"

	para "the app will trace"
	line "back the user's"
	cont "journey to find"
	
	para "the other users"
	line "they've been in"
	cont "contact with."

	para "Those people can"
	line "then be notified."

	para "This is called"
	line "CONTACT TRACING."

	para "It becomes more"
	line "effective as it"
	cont "gets more use."

	para "You should get"
	line "this CARD."
	done
endc

.HospitalContactTracingAvailableEcruteakText
if DEF(_FR_FR)
	text "LEO travaille"
	line "actuellement à"
	cont "ROSALIA."
	done
else
	text "BILL is currently"
	line "working in ECRU-"
	cont "TEAK CITY."
	done
endc

.HospitalContactTracingAvailableGoldenrodText
if DEF(_FR_FR)
	text "LEO séjourne à"
	line "DOUBLONVILLE."
	done
else
	text "BILL is staying in"
	line "GOLDENROD CITY."
	done
endc
