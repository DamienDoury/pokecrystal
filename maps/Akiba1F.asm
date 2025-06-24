VIRTUAL_BOY_PRICE EQU 40000
N64_PRICE         EQU 18000
SNES_PRICE        EQU 12000
NES_PRICE         EQU 11000

	object_const_def
	const AKIBA1F_FAMICOM
	const AKIBA1F_VBOY
	const AKIBA1F_SNES
	const AKIBA1F_N64
	const AKIBA1F_SELLER
	const AKIBA1F_NOTE
	const AKIBA1F_REPAIR_N64
	const AKIBA1F_CLIENT_GRAMPS
	const AKIBA1F_CLIENT_BUG_CATCHER
	const AKIBA1F_CLIENT_LASS

Akiba1F_MapScripts:
	def_scene_scripts

	def_callbacks
	callback MAPCALLBACK_TILES, .LoadTiles

.LoadTiles:
	readvar VAR_YCOORD
	ifless 3, .skip_big_doll_selection

	loadmem wJustWonBigDoll, FALSE
	callasm GetTodaysBigDoll
.skip_big_doll_selection
	checkevent EVENT_CONSOLE_SELLER_BACK_IN_STORE
	iftrue .endcallback

	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
.endcallback
	endcallback

; Returns TRUE in wScriptVar if the transaction was successfull.
Akiba1F_BuyingProcess:
	special PlaceMoneyTopRight
	writemem wTempByteValue ; Backs up the price of the item, that will be overwritten by the result of yesorno.
	yesorno
	iffalse .refused

	; Checking the player's money.
	readmem wTempByteValue ; Retrieves the price of the item.
	checkmoney YOUR_MONEY, $ffffff
	ifequal HAVE_LESS, .cant

	; Buying.
	playsound SFX_TRANSACTION
	readmem wTempByteValue ; Retrieves the price of the item.
	takemoney YOUR_MONEY, $ffffff
	special PlaceMoneyTopRight
	waitsfx
	disappear LAST_TALKED ; This is the action that adds the item to the player's inventory.
	writetext Akiba1F_TransactionCompletedText
	setval TRUE
	sjump .text_end

.cant
	setval FALSE
	writetext Akiba1F_NotEnoughMoneyText
	sjump .text_end

.refused
	setval FALSE
	writetext Akiba1F_TransactionRefusedText
.text_end
	loadmem wTempByteValue, 0
	waitbutton
	closetext
	end

Akiba1F_GameConsoleNoSeller:
	jumptext Akiba1F_GameConsoleText

Akiba1F_VirtualBoyBuyScript:
	checkevent EVENT_CONSOLE_SELLER_BACK_IN_STORE
	iftrue Akiba1F_GameConsoleNoSeller

	applymovement AKIBA1F_SELLER, Akiba1F_Left3Movement
	opentext
	writetext Akiba1F_VirtualBoyBuyText
	setval VIRTUAL_BOY_PRICE / 1000
	scall Akiba1F_BuyingProcess
	applymovement AKIBA1F_SELLER, Akiba1F_BackToChairFromLeft3Movement
	end

Akiba1F_N64BuyScript:
	checkevent EVENT_CONSOLE_SELLER_BACK_IN_STORE
	iftrue Akiba1F_GameConsoleNoSeller

	applymovement AKIBA1F_SELLER, Akiba1F_Left1Movement
	opentext
	writetext Akiba1F_N64BuyText
	setval N64_PRICE / 1000
	scall Akiba1F_BuyingProcess
	applymovement AKIBA1F_SELLER, Akiba1F_BackToChairFromLeft1Movement
	end

Akiba1F_SNESBuyScript:
	checkevent EVENT_CONSOLE_SELLER_BACK_IN_STORE
	iftrue Akiba1F_GameConsoleNoSeller

	applymovement AKIBA1F_SELLER, Akiba1F_Right2Movement
	turnobject AKIBA1F_SELLER, DOWN
	opentext
	writetext Akiba1F_SNESBuyText
	setval SNES_PRICE / 1000
	scall Akiba1F_BuyingProcess
	applymovement AKIBA1F_SELLER, Akiba1F_BackToChairFromRightMovement
	end

Akiba1F_FamicomBuyScript:
	checkevent EVENT_CONSOLE_SELLER_BACK_IN_STORE
	iftrue Akiba1F_GameConsoleNoSeller

	applymovement AKIBA1F_SELLER, Akiba1F_Right2Movement
	opentext
	writetext Akiba1F_NESBuyText
	setval NES_PRICE / 1000
	scall Akiba1F_BuyingProcess
	applymovement AKIBA1F_SELLER, Akiba1F_BackToChairFromRightMovement
	end

Akiba1F_BeRightBackScript:
	jumptext Akiba1F_BeRightBackText

Akiba1F_Seller_Script:
	faceplayer
	opentext

	checkflag ENGINE_RADIO_CARD
	iftrue .SkipRadioGift

	checkevent EVENT_FETCH_RADIO_CARD
	iftrue .FetchRadio

.SkipRadioGift
	checkevent EVENT_DECO_FAMICOM
	iffalse .RememberMe

	checkevent EVENT_DECO_SNES
	iffalse .RememberMe

	checkevent EVENT_DECO_N64
	iffalse .RememberMe

	checkevent EVENT_DECO_VIRTUAL_BOY
	iffalse .RememberMe

; The player has bought all the consoles.
	writetext Akiba1F_Seller_BestCustomerText
	sjump .ReturnToDesk

.RememberMe
	writetext Akiba1F_Seller_HiText
	promptbutton
	writetext Akiba1F_Seller_HiEndText

.ReturnToDesk
	waitbutton
	closetext
	pause 10
	turnobject AKIBA1F_SELLER, UP
	end

.FetchRadio
	writetext Akiba1F_Seller_HiText
	promptbutton
	closetext
	pause 5
	showemote EMOTE_QUESTION, AKIBA1F_SELLER, 15
	pause 5
	opentext
	writetext Akiba1F_Seller_RadioText
	promptbutton
	getstring STRING_BUFFER_4, .RadioCardText
	callstd ReceiveItemScript
	farwritetext RadioTower1FPokegearIsARadioText
	waitbutton
	setflag ENGINE_RADIO_CARD
	clearevent EVENT_FETCH_RADIO_CARD
	closetext
	end

.RadioCardText:
if DEF(_FR_FR)
	db "COUPON RADIO@"
else
	db "RADIO CARD@"
endc

Akiba1F_PricesUpScript:
	faceplayer
	opentext
	writetext Akiba1F_PricesUpText
	waitbutton
	closetext
	turnobject AKIBA1F_CLIENT_GRAMPS, UP
	end

Akiba1F_NoClueScript:
	faceplayer
	opentext
	writetext Akiba1F_NoClueText
	waitbutton
	closetext
	turnobject AKIBA1F_CLIENT_BUG_CATCHER, DOWN
	end

Akiba1F_TrueGemsScript:
	faceplayer
	opentext
	writetext Akiba1F_GemsText
	waitbutton
	closetext
	turnobject AKIBA1F_CLIENT_LASS, RIGHT
	end

Akiba1F_Inventory1:
	jumptext Akiba1F_Inventory1Text

Akiba1F_Inventory2:
	jumptext Akiba1F_Inventory2Text

Akiba1F_Inventory3:
	jumptext Akiba1F_Inventory3Text

Akiba1F_Inventory4:
	jumptext Akiba1F_Inventory4Text

Akiba1F_Inventory5:
	jumptext Akiba1F_Inventory5Text

Akiba1F_Inventory6:
	jumptext Akiba1F_Inventory6Text

Akiba1F_Inventory7:
	jumptext Akiba1F_Inventory7Text

Akiba1F_Inventory8:
	jumptext Akiba1F_Inventory8Text

Akiba1F_Inventory9:
	cry MAGNEMITE
	jumptext Akiba1F_Inventory9Text

Akiba1F_Inventory10:
	jumptext Akiba1F_Inventory10Text

Akiba1F_Inventory11:
	jumptext Akiba1F_Inventory11Text

Akiba1F_Inventory12:
	jumptext Akiba1F_Inventory12Text

Akiba1F_Inventory13:
	jumptext Akiba1F_Inventory13Text

Akiba1F_Inventory14:
	jumptext Akiba1F_Inventory14Text

Akiba1F_Inventory15:
	jumptext Akiba1F_Inventory15Text

Akiba1F_Inventory16:
	jumptext Akiba1F_Inventory16Text

Akiba1F_Inventory17:
	jumptext Akiba1F_Inventory17Text

Akiba1F_Inventory18:
	jumptext Akiba1F_Inventory18Text
	
Akiba1F_Inventory19:
	jumptext Akiba1F_Inventory19Text

Akiba1F_Inventory20:
	jumptext Akiba1F_Inventory20Text

Akiba1F_Inventory21:
	jumptext Akiba1F_Inventory21Text

Akiba1F_Inventory22:
	jumptext Akiba1F_Inventory22Text

Akiba1F_Inventory23:
	jumptext Akiba1F_Inventory23Text

Akiba1F_Inventory24:
	jumptext Akiba1F_Inventory24Text

Akiba1F_Inventory25:
	jumptext Akiba1F_Inventory25Text

Akiba1F_Inventory26:
	jumptext Akiba1F_Inventory26Text

Akiba1F_Inventory27:
	jumptext Akiba1F_Inventory27Text

Akiba1F_Inventory28:
	jumptext Akiba1F_Inventory28Text

Akiba1F_Left3Movement:
	step LEFT
	step LEFT
Akiba1F_Left1Movement:
	step LEFT
	turn_head DOWN
	step_end

Akiba1F_Right2Movement:
	step RIGHT
	step RIGHT
	step_end

Akiba1F_BackToChairFromLeft3Movement:
	step RIGHT
	step RIGHT
Akiba1F_BackToChairFromLeft1Movement:
	step RIGHT
	turn_head UP
	step_end

Akiba1F_BackToChairFromRightMovement:
	step LEFT
	step LEFT
	turn_head UP
	step_end

Akiba1F_GameConsoleText:
if DEF(_FR_FR)
	text "Une console de"
	line "jeu. Où est"
	cont "le vendeur?"
	done
else
	text "A game console."
	line "Where's the seller?"
	done
endc

Akiba1F_NotEnoughMoneyText:
if DEF(_FR_FR)
	text "Je suis désolé,"
	line "je ne baisserai"
	cont "pas le prix de"
	cont "cet article."
	cont "Revenez avec"
	cont "assez d'argent."
	done
else
	text "I'm sorry but I"
	line "won't lower the"
	cont "price of this"
	cont "item. Come back"
	cont "with enough money."
	done
endc

Akiba1F_TransactionCompletedText:
if DEF(_FR_FR)
	text "Excellent choix!"
	line "Je l'expédie chez"
	cont "toi sans délai!"
	done
else
	text "Great choice!"
	line "I will ship it to"
	cont "your home without"
	cont "delay!"
	done
endc

Akiba1F_TransactionRefusedText:
if DEF(_FR_FR)
	text "Réfléchis-y."
	line "Ce sera peut-être"
	cont "déjà vendu"
	cont "la prochaine fois"
	cont "que tu viendras."
	done
else
	text "Think about it."
	line "It may be gone"
	cont "next time you"
	cont "come."
	done
endc

Akiba1F_VirtualBoyBuyText:
if DEF(_FR_FR)
	text "Voici un très rare"
	line "VIRTUAL BOY."

	para "Cette console"
	line "portable avait"
	cont "déjà un écran 3<BOLD_D>"
	cont "avant même que la"
	cont "Game Boy Color"
	cont "n'ait vu le jour."

	para "Seulement 770 000"
	line "unités ont été"
	cont "vendues durant son"
	cont "unique année de"
	cont "commercialisation."

	para "Rejoins le club"
	line "des privilégiés"
	cont "pour {d:VIRTUAL_BOY_PRICE}¥."
	done
else
	text "This is a super"
	line "rare VIRTUAL BOY."

	para "This portable"
	line "console got a 3<BOLD_D>"
	cont "screen before the"
	cont "Game Boy Color"
	cont "was even born."

	para "Only 770 000 units"
	line "were sold during"
	cont "its single year of"
	cont "lifetime."

	para "You can join the"
	line "happy few club"
	cont "for ¥{d:VIRTUAL_BOY_PRICE}."
	done
endc

Akiba1F_N64BuyText:
if DEF(_FR_FR)
	text "Cette NINTENDO 64"
	line "est l'édition"
	cont "spéciale Pikachu."

	para "Un design très"
	line "audacieux pour"
	cont "une console, tu"
	cont "ne trouves pas?"

	para "Les joues qui"
	line "s'illuminent sont"
	cont "un joli détail, et"
	cont "le pied qui sert"
	cont "de bouton est"
	cont "trop mignon!"

	para "Elle est à toi"
	line "pour {d:N64_PRICE}¥."
	done
else
	text "This NINTENDO 64"
	line "is the special"
	cont "Pikachu edition."

	para "A very bold design"
	line "for a game console"
	cont "don't you think?"

	para "The illuminating"
	line "cheeks are a nice"
	cont "touch, and the"
	cont "foot button is"
	cont "so cute!"

	para "It's yours for"
	line "¥{d:N64_PRICE}."
	done
endc

Akiba1F_SNESBuyText:
if DEF(_FR_FR)
	text "La SUPER NINTENDO"
	line "ENTERTAINMENT"
	cont "SYSTEM succède"
	cont "à la NES comme"
	cont "tu l'auras deviné."
	
	para "C'est une console"
	line "légendaire..."
	cont "à laquelle je n'ai"
	cont "jamais joué."
	
	para "Tu peux l'avoir"
	line "pour {d:SNES_PRICE}¥."
	done
else
	text "The SUPER NINTENDO"
	line "ENTERTAINMENT"
	cont "SYSTEM is the"
	cont "successor of the"
	cont "NES as you would"
	cont "have guessed."

	para "It's a legendary"
	line "console… that I"
	cont "never played."

	para "You can have it"
	line "for ¥{d:SNES_PRICE}."
	done
endc

Akiba1F_NESBuyText:
if DEF(_FR_FR)
	text "La Famicom est la"
	line "version japonaise"
	cont "de la NINTENDO"
	cont "ENTERTAINMENT"
	cont "SYSTEM."
	
	para "Malheureusement"
	line "je n'ai pas"
	cont "R.O.B. le robot"
	cont "qui faisait la"
	cont "pub avec."
	
	para "Je la vends"
	line "pour ¥{d:NES_PRICE}."
	done
else
	text "The Famicom is the"
	line "Japanese version"
	cont "of the NINTENDO"
	cont "ENTERTAINMENT"
	cont "SYSTEM."

	para "Unfortunately I"
	line "don't have R.O.B."
	cont "the robot it was"
	cont "advertised with."

	para "I'm selling it for"
	line "¥{d:NES_PRICE}."
	done
endc

Akiba1F_BeRightBackText:
if DEF(_FR_FR)
	text "Je suis à CELADO-"
	line "POLE, je reviens"
	cont "tout de suite."
	done
else
	text "I'm in CELADON,"
	line "I'll be right back."
	done
endc

Akiba1F_Seller_HiText:
if DEF(_FR_FR)
	text "Oh salut!"
	
	para "On s'est vu chez"
	line "GAME FREAK, tu te"
	cont "souviens de moi?"
	done
else
	text "Oh hi!"

	para "We met at "
	line "GAME FREAK's,"
	cont "remember me?"
	done
endc

Akiba1F_Seller_HiEndText:
if DEF(_FR_FR)
	text "N'hésites pas à"
	line "faire le tour"
	cont "de ma boutique!"
	done
else
	text "Feel free to snoop"
	line "around my shop!"
	done
endc

Akiba1F_Seller_BestCustomerText:
if DEF(_FR_FR)
	text "Hé! Ne serait-ce"
	line "pas mon meilleur"
	cont "client?"
	
	para "Merci de soutenir"
	line "le rétro gaming."
	
	para "J'aimerais"
	line "partager une"
	cont "pensée avec toi."
	
	para "Nous savons tous"
	line "que la matière est"
	cont "faite de pixels,"
	cont "qui interagissent"
	cont "selon les lois"
	cont "du code source"
	cont "et de ses bits."
	
	para "Mais si tout cela"
	line "était une"
	cont "simulation"
	cont "créée par des"
	cont "êtres supérieurs?"
	
	para "Comment le"
	line "saurions-nous?"
	
	para "Pourrions-nous"
	line "interagir avec"
	cont "leur réalité?"
	
	para "..."
	
	para "Je me demande."
	done
else
	text "Hey! Isn't this my"
	line "best customer?"

	para "Thank you for"
	line "supporting"
	cont "retro gaming."

	para "I'd like to share a"
	line "thought with you."

	para "We all know that"
	line "matter is made of"
	cont "pixels, which"
	cont "interact under the"
	cont "laws of the source"
	cont "code and its bits."

	para "But what if all of"
	line "it is a simulation"
	cont "created by higher"
	cont "beings?"

	para "How would we"
	line "ever know?"

	para "Could we interact"
	line "with their"
	cont "reality?"

	para "…"

	para "I wonder."
	done
endc

Akiba1F_Seller_RadioText:
if DEF(_FR_FR)
	text "Mon ami le"
	line "DIRECTEUR MUSICAL"
	cont "t'a envoyé?"
	cont "Je vois."
	
	para "Voici un COUPON"
	line "RADIO pour ton"
	cont "#GEAR, c'est"
	cont "gratuit pour toi!"
	done
else
	text "My friend the"
	line "MUSIC DIRECTOR"
	cont "sent you? I see."
	
	para "Here's a RADIO CARD"
	line "for your #GEAR,"
	cont "free of charge!"
	done
endc

Akiba1F_Inventory1Text:
if DEF(_FR_FR)
	text "Adrénaline et"
	line "testostérone:"
	
	para "Devil May Cry"
	done
else
	text "Adrenaline and"
	line "testosterone:"
	
	para "Devil may cry"
	done
endc

Akiba1F_Inventory2Text:
if DEF(_FR_FR)
	text "Golden Sun 1 & 2!"
	line "Immanquable!"
	done
else
	text "Golden Sun 1 & 2!"
	line "A must play!"
	done
endc

Akiba1F_Inventory3Text:
if DEF(_FR_FR)
	text "Des pièces de"
	line "de #GEAR."
	done
else
	text "Some #GEAR "
	line "parts."
	done
endc

Akiba1F_Inventory4Text:
if DEF(_FR_FR)
	text "Des composants"
	line "de radio."
	done
else
	text "Radio parts."
	done
endc

Akiba1F_Inventory5Text:
if DEF(_FR_FR)
	text "Des tamagotchis"
	line "en pagaille!"
	done
else
	text "Tamagotchis"
	line "everywhere!"
	done
endc

Akiba1F_Inventory6Text:
if DEF(_FR_FR)
	text "Pocket Pikachu 2!"
	line "Celui-ci se"
	cont "connecte aux jeux"
	cont "#MON sur Game"
	cont "Boy Color."
	done
else
	text "Pocket Pikachu 2!"
	line "This one connects"
	cont "with the #MON"
	cont "games on the"
	cont "Game Boy Color."
	done
endc

Akiba1F_Inventory7Text:
if DEF(_FR_FR)
	text "Le jeu PC"
	line "Impossible"
	cont "Creatures."
	done
else
	text "The PC game"
	line "Impossible"
	cont "Creatures."
	done
endc

Akiba1F_Inventory8Text:
if DEF(_FR_FR)
	text "Le Maitre de"
	line "l'Olympe: Zeus"
	cont "sur CD-ROM."
	done
else
	text "Zeus: Master of"
	line "Olympus"
	cont "on CD-ROM."
	done
endc

Akiba1F_Inventory9Text:
if DEF(_FR_FR)
	text "Un MAGNETI se"
	line "repose dans"
	cont "cette panière."
	done
else
	text "There's a MAGNEMITE"
	line "chilling in"
	cont "this bin."
	done
endc

Akiba1F_Inventory10Text:
if DEF(_FR_FR)
	text "Une cartouche de"
	line "la version finale"
	cont "de Coral Version."
	done
else
	text "A cartridge of the"
	line "final release of"
	cont "Coral Version."
	done
endc

Akiba1F_Inventory11Text:
if DEF(_FR_FR)
	text "Hé, c'est Polished"
	line "Crystal!"
	done
else
	text "Hey that's"
	line "Polished Crystal!"
	done
endc

Akiba1F_Inventory12Text:
if DEF(_FR_FR)
	text "Insaniquarium"
	line "sur CD-ROM."
	done
else
	text "Insaniquarium"
	line "on CD-ROM."
	done
endc

Akiba1F_Inventory13Text:
if DEF(_FR_FR)
	text "Morrowind"
	line "sur CD-ROM."
	done
else
	text "Morrowind"
	line "on CD-ROM."
	done
endc

Akiba1F_Inventory14Text:
if DEF(_FR_FR)
	text "Jeux Game Boy"
	line "rares à prix"
	cont "bas!"
	done
else
	text "Rare Game Boy"
	line "games for"
	cont "very cheap!"
	done
endc

Akiba1F_Inventory15Text:
if DEF(_FR_FR)
	text "Un Game & Watch"
	line "Crystal Screen"
	cont "Super Mario Bros!"
	done
else
	text "A Super Mario Bros"
	line "Crystal Screen"
	cont "Game & Watch!"
	done
endc

Akiba1F_Inventory16Text:
if DEF(_FR_FR)
	text "Plein d'accessoires"
	line "insolites pour la"
	cont "Game Boy."

	para "L'adaptateur GB"
	line "Mobile, une impri-"
	cont "mante portable, un"
	cont "lecteur de code-"
	cont "barres, un..."
	cont "sonar de pêche,"
	cont "une machine à"
	cont "coudre, et même..."

	para "...un testeur de"
	line "glycémie?"
	done
else
	text "Lots of weird"
	line "accessories for"
	cont "the Game Boy."

	para "The Mobile Adapter"
	line "GB cable, a pocket"
	cont "printer, a barcode"
	cont "reader, a…"
	cont "fishing sonar, a"
	cont "sewing machine,"
	cont "and…"

	para "…a blood sugar"
	line "tester?"
	done
endc

Akiba1F_Inventory17Text:
if DEF(_FR_FR)
	text "Cartouches de"
	line "The Legend of"
	cont "Zelda pour GB et"
	cont "GBC. Excellent."
	done
else
	text "Copies of The"
	line "Legend of Zelda"
	cont "for the Game Boy"
	cont "and Game Boy Color"
	cont "consoles. Nice."
	done
endc

Akiba1F_Inventory18Text:
if DEF(_FR_FR)
	text "Un jeu Game Boy"
	line "pour les employés"
	cont "de McDonald's?"
	done
else
	text "A Game Boy game"
	line "for McDonald's"
	cont "employees?"
	done
endc

Akiba1F_Inventory19Text:
if DEF(_FR_FR)
	text "Cartes de contrôle"
	line "de flippers!"
	done
else
	text "Pinball circuit"
	line "boards!"
	done
endc

Akiba1F_Inventory20Text:
if DEF(_FR_FR)
	text "Des vieilles puces"
	line "flash 5V"
	cont "TSOP-48 2Mo."
	done
else
	text "Some junk 5V 2MB"
	line "TSOP-48 flash"
	cont "chips."
	done
endc

Akiba1F_Inventory21Text:
if DEF(_FR_FR)
	text "Une copie de"
	line "Tetris pour"
	cont "Game Boy."
	
	para "Un jeu très commun"
	line "et pas cher."
	
	para "Son autocollant"
	line "semble anormal,"
	cont "et le 'A' normale-"
	cont "ment gravé dessus"
	cont "est manquant."
	
	para "Sans doute une"
	line "copie ratée."
	cont "Mieux vaut pas"
	cont "l'acheter."
	done
else
	text "A copy of Tetris"
	line "for the Game Boy."

	para "A very common"
	line "and cheap game."
	
	para "Its sticker looks"
	line "slightly off, and"
	cont "the engraved 'A'"
	cont "is missing."
	
	para "Must be defective."
	line "Better pass."
	done
endc

Akiba1F_Inventory22Text:
if DEF(_FR_FR)
	text "Plaques chauffante"
	line "de soudure, des"
	cont "pincettes..."
	done
else
	text "Soldering hot"
	line "plates, tweezers…"
	done
endc

Akiba1F_Inventory23Text:
if DEF(_FR_FR)
	text "Rayman 2:"
	line "The Great Escape."
	done
else
	text "Rayman 2: The"
	line "Great Escape."
	done
endc

Akiba1F_Inventory24Text:
if DEF(_FR_FR)
	text "Du fun en duel:"
	line "The Next Tetris"
	cont "sur PlayStation."
	done
else
	text "Great versus fun:"
	line "The Next Tetris"
	cont "on PlayStation."
	done
endc

Akiba1F_Inventory25Text:
if DEF(_FR_FR)
	text "Second Sight"
	line "sur PlayStation 2."
	done
else
	text "Second Sight"
	line "on PlayStation 2."
	done
endc

Akiba1F_Inventory26Text:
if DEF(_FR_FR)
	text "Ils vendent même"
	line "des jeux de"
	cont "société!"
	
	para "Ils ont Pokémon"
	line "Maitre Dresseur."
	done
else
	text "They even sell"
	line "board games!"

	para "They have Pokémon"
	line "Master Trainer."
	done
endc

Akiba1F_Inventory27Text:
if DEF(_FR_FR)
	text "3 jeux en 1:"
	line "Mega Games 2"
	cont "sur Mega Drive."
	done
else
	text "3 games in 1:"
	line "Mega Games 2"
	cont "on Mega Drive."
	done
endc

Akiba1F_Inventory28Text:
if DEF(_FR_FR)
	text "Mickey Mania."
	done
else
	text "Mickey Mania."
	done
endc

Akiba1F_PricesUpText:
if DEF(_FR_FR)
	text "J'aime mes jeux en"
	line "format physique."
	
	para "Ainsi, je les"
	line "possède vraiment."
	
	para "Aucune société"
	line "ne peut me les"
	cont "prendre."
	done
else
	text "I like my games in"
	line "physical format."
	
	para "This way, I truly"
	line "own them."
	
	para "No company can"
	line "take those from"
	cont "me."
	done
endc

Akiba1F_NoClueText:
if DEF(_FR_FR)
	text "Aucune idée"
	line "de ce que c'est..."
	done
else
	text "I have no clue"
	line "what this is…"
	done
endc

Akiba1F_GemsText:
if DEF(_FR_FR)
	text "Ici on trouve"
	line "de vraies perles!"
	done
else
	text "You can find true"
	line "gems in here!"
	done
endc

Akiba1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  6,  9, SAFFRON_CITY, 18
	warp_event  7,  9, SAFFRON_CITY, 18
	warp_event 11,  0, AKIBA_2F, 1

	def_coord_events

	def_bg_events
	bg_event 11,  5, BGEVENT_READ, Akiba1F_Inventory1
	bg_event  4,  7, BGEVENT_READ, Akiba1F_Inventory2
	bg_event 10,  9, BGEVENT_READ, Akiba1F_Inventory3
	bg_event 11,  9, BGEVENT_READ, Akiba1F_Inventory3
	bg_event  8,  9, BGEVENT_READ, Akiba1F_Inventory4
	bg_event  9,  9, BGEVENT_READ, Akiba1F_Inventory4
	bg_event  4,  9, BGEVENT_READ, Akiba1F_Inventory5
	bg_event  5,  9, BGEVENT_READ, Akiba1F_Inventory5
	bg_event  3,  9, BGEVENT_READ, Akiba1F_Inventory6
	bg_event 10,  3, BGEVENT_READ, Akiba1F_Inventory7
	bg_event 11,  3, BGEVENT_READ, Akiba1F_Inventory8
	bg_event  0,  9, BGEVENT_READ, Akiba1F_Inventory9
	bg_event  6,  7, BGEVENT_READ, Akiba1F_Inventory10
	bg_event  7,  7, BGEVENT_READ, Akiba1F_Inventory11
	bg_event 10,  2, BGEVENT_READ, Akiba1F_Inventory12
	bg_event 11,  2, BGEVENT_READ, Akiba1F_Inventory13
	bg_event  8,  7, BGEVENT_READ, Akiba1F_Inventory14
	bg_event  9,  7, BGEVENT_READ, Akiba1F_Inventory14
	bg_event  1,  9, BGEVENT_READ, Akiba1F_Inventory15
	bg_event  2,  9, BGEVENT_READ, Akiba1F_Inventory16
	bg_event  5,  7, BGEVENT_READ, Akiba1F_Inventory17
	bg_event  2,  7, BGEVENT_READ, Akiba1F_Inventory18
	bg_event  2,  5, BGEVENT_READ, Akiba1F_Inventory19
	bg_event  0,  5, BGEVENT_READ, Akiba1F_Inventory20
	bg_event  3,  7, BGEVENT_READ, Akiba1F_Inventory21
	bg_event  1,  5, BGEVENT_READ, Akiba1F_Inventory22
	bg_event  8,  5, BGEVENT_READ, Akiba1F_Inventory23
	bg_event  9,  5, BGEVENT_READ, Akiba1F_Inventory24
	bg_event 10,  5, BGEVENT_READ, Akiba1F_Inventory25
	bg_event  3,  5, BGEVENT_READ, Akiba1F_Inventory26
	bg_event  7,  5, BGEVENT_READ, Akiba1F_Inventory27
	bg_event  6,  5, BGEVENT_READ, Akiba1F_Inventory28

	def_object_events
	object_event  7,  2, SPRITE_FAMICOM, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba1F_FamicomBuyScript, EVENT_DECO_FAMICOM
	object_event  1,  3, SPRITE_VIRTUAL_BOY, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba1F_VirtualBoyBuyScript, EVENT_DECO_VIRTUAL_BOY
	object_event  6,  3, SPRITE_SNES, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba1F_SNESBuyScript, EVENT_DECO_SNES
	object_event  3,  3, SPRITE_N64, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba1F_N64BuyScript, EVENT_DECO_N64
	object_event  4,  2, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Akiba1F_Seller_Script, EVENT_CONSOLE_SELLER_BACK_IN_STORE
	object_event  5,  3, SPRITE_POKEDEX, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, Akiba1F_BeRightBackScript, EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	object_event  4,  1, SPRITE_N64, SPRITEMOVEDATA_STILL, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, ObjectEvent, EVENT_CONSOLE_SELLER_BACK_IN_STORE
	object_event 11,  6, SPRITE_GRAMPS, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, Akiba1F_PricesUpScript, EVENT_CONSOLE_SELLER_BACK_IN_STORE
	object_event  0,  4, SPRITE_BUG_CATCHER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, LOW(%11100000 | MORN | DAY), PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, Akiba1F_NoClueScript, EVENT_CONSOLE_SELLER_BACK_IN_STORE
	object_event  9,  3, SPRITE_LASS, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, LOW(%11100000 | DAY | NITE), PAL_NPC_PINK, OBJECTTYPE_SCRIPT, 0, Akiba1F_TrueGemsScript, EVENT_CONSOLE_SELLER_BACK_IN_STORE
