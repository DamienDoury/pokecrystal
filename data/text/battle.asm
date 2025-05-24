BattleText:: ; used only for BANK(BattleText)

BattleText_PlayerPickedUpPayDayMoney:
if DEF(_FR_FR)
	text "<PLAYER> obtient"
	line "@"
	text_decimal wPayDayMoney, 3, 6
	text "¥!"
	prompt
else
	text "<PLAYER> picked up"
	line "¥@"
	text_decimal wPayDayMoney, 3, 6
	text "!"
	prompt
endc

WildPokemonAppearedText:
if DEF(_FR_FR)
	text "Un @"
	text_ram wEnemyMonNickname
	text_start
	line "sauvage apparaît!"
	prompt
else
	text "Wild @"
	text_ram wEnemyMonNickname
	text_start
	line "appeared!"
	prompt
endc

HookedPokemonAttackedText:
if DEF(_FR_FR)
	text "Le @"
	text_ram wEnemyMonNickname
	text_start
	line "pêché attaque!"
	prompt
else
	text "The hooked"
	line "@"
	text_ram wEnemyMonNickname
	text_start
	cont "attacked!"
	prompt
endc

PokemonFellFromTreeText:
if DEF(_FR_FR)
	text_ram wEnemyMonNickname
	text_start
	line "tombe de l'arbre!"
	prompt
else
	text_ram wEnemyMonNickname
	text " fell"
	line "out of the tree!"
	prompt
endc

WildCelebiAppearedText:
if DEF(_FR_FR)
	text_ram wEnemyMonNickname
	text " sauvage"
	line "apparaît!"
	prompt
else
	text "Wild @"
	text_ram wEnemyMonNickname
	text_start
	line "appeared!"
	prompt
endc

WantsToBattleText::
if DEF(_FR_FR)
	text "<ENEMY>"
	line "veut se battre!"
	prompt
else
	text "<ENEMY>"
	line "wants to battle!"
	prompt
endc

WantToBattlePluralText::
if DEF(_FR_FR)
	text "<ENEMY>"
	line "veulent se battre!"
	prompt
else
	text "<ENEMY>"
	line "want to battle!"
	prompt
endc

WantsToApprehendText::
if DEF(_FR_FR)
	text "<ENEMY>"
	line "veut vous arrêter!"
	prompt
else
	text "<ENEMY>"
	line "wants to arrest"
	cont "you!"
	prompt
endc

BattleText_WildFled:
if DEF(_FR_FR)
	text "Le @"
	text_ram wEnemyMonNickname
	text_start
	line "sauvage s'enfuit!"
	prompt
else
	text "Wild @"
	text_ram wEnemyMonNickname
	text_start
	line "fled!"
	prompt
endc

BattleText_MewtwoFled:
if DEF(_FR_FR)
	text "Le @"
	text_ram wEnemyMonNickname
	text " sauvage"
	line "semble inquiet..."
	prompt
else
	text "Wild @"
	text_ram wEnemyMonNickname
	text_start
	line "is growing uneasy…"
	prompt
endc

_ItemUsedButNopeText::
if DEF(_FR_FR)
	text "MEWTWO ne laissera"
	line "pas faire ça."
	done
else
	text "MEWTWO won't"
	line "let you use this."
	done
endc

_MewtwoRetreatText::
if DEF(_FR_FR)
	text "MEWTWO"
	line "se retire."
	done
else
	text "MEWTWO"
	line "retreats."
	done
endc

BattleText_EnemyFled:
if DEF(_FR_FR)
	text "Le @"
	text_ram wEnemyMonNickname
	text_start
	line "ennemi s'enfuit!"
	prompt
else
	text "Enemy @"
	text_ram wEnemyMonNickname
	text_start
	line "fled!"
	prompt
endc

HurtByPoisonText:
if DEF(_FR_FR)
	text "<USER>"
	line "souffre du poison!"
	prompt
else
	text "<USER>"
	line "is hurt by poison!"
	prompt
endc

HurtByBurnText:
if DEF(_FR_FR)
	text "<USER>"
	line "brûle!"
	prompt
else
	text "<USER>'s"
	line "hurt by its burn!"
	prompt
endc

LeechSeedSapsText:
if DEF(_FR_FR)
	text "VAMPIGRAINE draine"
	line "<USER>!"
	prompt
else
	text "LEECH SEED saps"
	line "<USER>!"
	prompt
endc

HasANightmareText:
if DEF(_FR_FR)
	text "<USER>"
	line "fait un cauchemar!"
	prompt
else
	text "<USER>"
	line "has a NIGHTMARE!"
	prompt
endc

HurtByCurseText:
if DEF(_FR_FR)
	text "<USER>"
	line "est MAUDIT!"
	prompt
else
	text "<USER>'s"
	line "hurt by the CURSE!"
	prompt
endc

SandstormHitsText:
if DEF(_FR_FR)
	text "La TEMPETE de"
	line "SABLE touche"
	cont "<USER>!"
	prompt
else
	text "The SANDSTORM hits"
	line "<USER>!"
	prompt
endc

PeltedByHailText:
if DEF(_FR_FR)
	text "<USER>"
	line "est blessé par"
	cont "la GRELE!"
	prompt
else
	text "<USER>"
	line "is pelted by HAIL!"
	prompt
endc

PerishCountText:
if DEF(_FR_FR)
	text "Compte REQUIEM de"
	line "<USER>"
	cont "est de @"
	text_decimal wTextDecimalByte, 1, 1
	text "!"
	prompt
else
	text "<USER>'s"
	line "PERISH count is @"
	text_decimal wTextDecimalByte, 1, 1
	text "!"
	prompt
endc

BattleText_TargetRecoveredWithItem:
if DEF(_FR_FR)
	text "<TARGET>"
	line "récupère avec"
	cont "@"
	text_ram wStringBuffer1
	text "."
	prompt
else
	text "<TARGET>"
	line "recovered with"
	cont "@"
	text_ram wStringBuffer1
	text "."
	prompt
endc

BattleText_RecoveredWithGrassyTerrain:
if DEF(_FR_FR)
	text "<TARGET>"
	line "récupère avec"
	cont "CHAMP HERBU."
	prompt
else
	text "<TARGET>"
	line "recovered with"
	cont "GRASSY TERRAIN."
	prompt
endc

BattleText_UserRecoveredPPUsing:
if DEF(_FR_FR)
	text "<USER>"
	line "récupère des PP"
	cont "avec @"
	text_ram wStringBuffer1
	text "."
	prompt
else
	text "<USER>"
	line "recovered PP using"
	cont "@"
	text_ram wStringBuffer1
	text "."
	prompt
endc

BattleText_TargetWasHitByFutureSight:
if DEF(_FR_FR)
	text "<TARGET>"
	line "est touché par la"
	cont "PRESCIENCE!"
	prompt
else
	text "<TARGET>"
	line "was hit by FUTURE"
	cont "SIGHT!"
	prompt
endc

BattleText_SafeguardFaded:
if DEF(_FR_FR)
	text "RUNE PROTECT de"
	line "<USER>"
	cont "s'évanouit!"
	prompt
else
	text "<USER>'s"
	line "SAFEGUARD faded!"
	prompt
endc

BattleText_MonsLightScreenFell:
if DEF(_FR_FR)
	text "MUR LUMIERE"
	line "@"
	text_ram wStringBuffer1
	text_start
	cont "s'évanouit!"
	prompt
else
	text_ram wStringBuffer1
	text " #MON's"
	line "LIGHT SCREEN fell!"
	prompt
endc

BattleText_MonsReflectFaded:
if DEF(_FR_FR)
	text "PROTECTION"
	line "@"
	text_ram wStringBuffer1
	text_start
	cont "s'évanouit!"
	prompt
else
	text_ram wStringBuffer1
	text " #MON's"
	line "REFLECT faded!"
	prompt
endc

BattleText_RainContinuesToFall:
if DEF(_FR_FR)
	text "La pluie continue"
	line "de tomber."
	prompt
else
	text "Rain continues to"
	line "fall."
	prompt
endc

BattleText_TheSunlightIsStrong:
if DEF(_FR_FR)
	text "La chaleur est"
	line "intense."
	prompt
else
	text "The heat is"
	line "intense."
	prompt
endc

BattleText_TheSandstormRages:
if DEF(_FR_FR)
	text "La TEMPETE de"
	line "SABLE fait rage."
	prompt
else
	text "The SANDSTORM"
	line "rages."
	prompt
endc

BattleText_HailContinuesToFall:
if DEF(_FR_FR)
	text "La GRELE continue"
	line "de tomber."
	prompt
else
	text "HAIL continues to"
	line "fall."
	prompt
endc

BattleText_TheRainStopped:
if DEF(_FR_FR)
	text "La pluie s'est"
	line "arrêtée."
	prompt
else
	text "The rain stopped."
	prompt
endc

BattleText_TheSunlightFaded:
if DEF(_FR_FR)
	text "Les rayons"
	line "disparaissent."
	prompt
else
	text "The sunlight"
	line "faded."
	prompt
endc

BattleText_TheSandstormSubsided:
if DEF(_FR_FR)
	text "La TEMPETE de"
	line "SABLE se calme."
	prompt
else
	text "The SANDSTORM"
	line "subsided."
	prompt
endc

BattleText_TheHailStopped:
if DEF(_FR_FR)
	text "La GRELE s'est"
	line "arrêtée."
else
	text "The HAIL stopped."
endc
	prompt

BattleText_EnemyMonFainted:
if DEF(_FR_FR)
	text "Le @"
	text_ram wEnemyMonNickname
	text_start
	line "ennemi est K.O!"
	prompt
else
	text "Enemy @"
	text_ram wEnemyMonNickname
	text_start
	line "fainted!"
	prompt
endc

GotMoneyForWinningText:
if DEF(_FR_FR)
	text "<PLAYER> remporte"
	line "@"
	text_decimal wBattleReward, 3, 6
	text "¥!"
	prompt
else
	text "<PLAYER> got ¥@"
	text_decimal wBattleReward, 3, 6
	text_start
	line "for winning!"
	prompt
endc

BattleText_EnemyWasDefeated:
if DEF(_FR_FR)
	text "<ENEMY>"
	line "a perdu!"
	prompt
else
	text "<ENEMY>"
	line "was defeated!"
	prompt
endc

BattleText_PluralEnemyWereDefeated:
if DEF(_FR_FR)
	text "<ENEMY>"
	line "ont perdu!"
	prompt
else
	text "<ENEMY>"
	line "were defeated!"
	prompt
endc

TiedAgainstText:
if DEF(_FR_FR)
	text "Egalité avec"
	line "<ENEMY>!"
	prompt
else
	text "Tied against"
	line "<ENEMY>!"
	prompt
endc

SentSomeToMomText:
if DEF(_FR_FR)
	text "<PLAYER> remporte"
	line "@"
	text_decimal wBattleReward, 3, 6
	text "¥!"
	cont "Une partie est"
	cont "envoyée à MAMAN!"
	prompt
else
	text "<PLAYER> got ¥@"
	text_decimal wBattleReward, 3, 6
	text_start
	line "for winning!"
	cont "Sent some to MOM!"
	prompt
endc

SentHalfToMomText:
if DEF(_FR_FR)
	text "La moitié est"
	line "envoyée à MAMAN!"
	prompt
else
	text "Sent half to MOM!"
	prompt
endc

SentAllToMomText:
if DEF(_FR_FR)
	text "Tout est envoyé"
	line "à MAMAN!"
else
	text "Sent all to MOM!"
endc
	prompt

BattleText_MonFainted:
if DEF(_FR_FR)
	text_ram wBattleMonNickname
	text_start
	line "est K.O!"
	prompt
else
	text_ram wBattleMonNickname
	text_start
	line "fainted!"
	prompt
endc

BattleText_UseNextMon:
if DEF(_FR_FR)
	text "Utiliser le"
	line "#MON suivant?"
else
	text "Use next #MON?"
endc
	done

LostAgainstText:
if DEF(_FR_FR)
	text "<ENEMY>"
	line "vous a vaincu!"
	prompt
else
	text "Lost against"
	line "<ENEMY>!"
	prompt
endc

BattleText_EnemyIsAboutToUseWillPlayerChangeMon:
if DEF(_FR_FR)
	text "<ENEMY>"
	line "va utiliser"
	cont "@"
	text_ram wEnemyMonNickname
	text "."
	
	para "Voulez-vous"
	line "changer de PKMN?"
	done
else
	text "<ENEMY>"
	line "is about to use"
	cont "@"
	text_ram wEnemyMonNickname
	text "."
	
	para "Will <PLAYER>"
	line "change #MON?"
	done
endc

BattleText_PluralEnemyAreAboutToUseWillPlayerChangeMon:
if DEF(_FR_FR)
	text "<ENEMY>"
	line "vont utiliser"
	cont "@"
	text_ram wEnemyMonNickname
	text "."
	
	para "Voulez-vous"
	line "changer de PKMN?"
	done
else
	text "<ENEMY>"
	line "are about to use"
	cont "@"
	text_ram wEnemyMonNickname
	text "."
	
	para "Will <PLAYER>"
	line "change #MON?"
	done
endc

BattleText_EnemySentOut:
if DEF(_FR_FR)
	text "<ENEMY>"
	line "envoie"
	cont "@"
	text_ram wEnemyMonNickname
	text "!"
	done
else
	text "<ENEMY>"
	line "sent out"
	cont "@"
	text_ram wEnemyMonNickname
	text "!"
	done
endc

BattleText_TheresNoWillToBattle:
if DEF(_FR_FR)
	text "Il ne veut pas"
	line "se battre!"
	prompt
else
	text "There's no will to"
	line "battle!"
	prompt
endc

BattleText_AnEGGCantBattle:
if DEF(_FR_FR)
	text "Un OEUF ne se bat"
	line "pas, voyons!"
	prompt
else
	text "An EGG can't"
	line "battle!"
	prompt
endc

BattleText_TheresNoEscapeFromTrainerBattle:
if DEF(_FR_FR)
	text "On ne s'enfuit pas"
	line "d'un combat contre"
	cont "un dresseur!"
	prompt
else
	text "No! There's no"
	line "running from a"
	cont "trainer battle!"
	prompt
endc

BattleText_GotAwaySafely:
if DEF(_FR_FR)
	text "Vous prenez la"
	line "fuite!"
	prompt
else
	text "Got away safely!"
	prompt
endc

BattleText_UserFledUsingAStringBuffer1:
if DEF(_FR_FR)
	text "<USER>"
	line "fuit en utilisant"
	cont "@"
	text_ram wStringBuffer1
	text "!"
	prompt
else
	text "<USER>"
	line "fled using a"
	cont "@"
	text_ram wStringBuffer1
	text "!"
	prompt
endc

BattleText_CantEscape:
if DEF(_FR_FR)
	text "Fuite impossible!"
	prompt
else
	text "Can't escape!"
	prompt
endc

BattleText_UserHurtBySpikes:
if DEF(_FR_FR)
	text "PICOTS frappent"
	line "<USER>!"
	prompt
else
	text "<USER>'s"
	line "hurt by SPIKES!"
	prompt
endc

BattleText_UserCaughtInStickyWeb:
if DEF(_FR_FR)
	text "<USER>"
	line "est pris dans une"
	cont "TOILE GLUANTE!"
	prompt
else
	text "<USER>'s caught"
	line "in a STICKY WEB!"
	prompt
endc

RecoveredUsingText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "récupère avec"
	cont "@"
	text_ram wStringBuffer1
	text "!"
	prompt
else
	text "<TARGET>"
	line "recovered using a"
	cont "@"
	text_ram wStringBuffer1
	text "!"
	prompt
endc

BattleText_UsersStringBuffer1Activated:
if DEF(_FR_FR)
	text_ram wStringBuffer1
	text " de"
	line "<USER>:"
	cont "activé!"
	prompt
else
	text "<USER>'s"
	line "@"
	text_ram wStringBuffer1
	text_start
	cont "activated!"
	prompt
endc

BattleText_ItemsCantBeUsedHere:
if DEF(_FR_FR)
	text "Les objets ne sont"
	line "pas équitables"
	cont "entre dresseurs."

	para "Bats-toi avec ton"
	line "talent, pas avec"
	cont "ton argent!"
	prompt
else
	text "Items aren't fair"
	line "in a trainer"
	cont "battle."
	
	para "Fight with skill,"
	line "not money!"
	prompt
endc

BattleText_MonIsAlreadyOut:
if DEF(_FR_FR)
	text_ram wBattleMonNickname
	text " est"
	line "déjà au combat."
	prompt
else
	text_ram wBattleMonNickname
	text_start
	line "is already out."
	prompt
endc

BattleText_SwitchingForbidden:
if DEF(_FR_FR)
	text "Il est interdit de"
	line "changer durant ce"
	cont "combat!"
	prompt
else
	text "Switching is"
	line "forbidden during"
	cont "this battle!"
	prompt
endc

BattleText_MonCantBeRecalled:
if DEF(_FR_FR)
	text_ram wBattleMonNickname
	text " ne"
	line "peut être rappelé!"
	prompt
else
	text_ram wBattleMonNickname
	text_start
	line "can't be recalled!"
	prompt
endc

BattleText_TheresNoPPLeftForThisMove:
if DEF(_FR_FR)
	text "Plus de PP pour"
	line "cette capacité!"
	prompt
else
	text "There's no PP left"
	line "for this move!"
	prompt
endc

BattleText_TheMoveIsDisabled:
if DEF(_FR_FR)
	text "La capacité est"
	line "ENTRAVEE!"
	prompt
else
	text "The move is"
	line "DISABLED!"
	prompt
endc

BattleText_MonHasNoMovesLeft:
if DEF(_FR_FR)
	text_ram wBattleMonNickname
	text " n'a"
	line "plus de capacités!"
	done
else
	text_ram wBattleMonNickname
	text_start
	line "has no moves left!"
	done
endc

BattleText_TargetsEncoreEnded:
if DEF(_FR_FR)
	text "ENCORE de"
	line "<TARGET>"
	cont "achevé!"
	prompt
else
	text "<TARGET>'s"
	line "ENCORE ended!"
	prompt
endc

BattleText_StringBuffer1GrewToLevel:
if DEF(_FR_FR)
	text_ram wStringBuffer1
	text " monte"
	line "au niveau @"
	text_decimal wCurPartyLevel, 1, 3
	text "!@"
	sound_dex_fanfare_50_79
	text_end
else
	text_ram wStringBuffer1
	text " grew to"
	line "level @"
	text_decimal wCurPartyLevel, 1, 3
	text "!@"
	sound_dex_fanfare_50_79
	text_end
endc

BattleText_WildMonIsEating:
if DEF(_FR_FR)
	text "Le @"
	text_ram wEnemyMonNickname
	text_start
	line "sauvage mange!"
	prompt
else
	text "Wild @"
	text_ram wEnemyMonNickname
	text_start
	line "is eating!"
	prompt
endc

BattleText_WildMonIsAngry:
if DEF(_FR_FR)
	text "Le @"
	text_ram wEnemyMonNickname
	text " est"
	line "en colère!"
	prompt
else
	text "Wild @"
	text_ram wEnemyMonNickname
	text_start
	line "is angry!"
	prompt
endc

FastAsleepText:
if DEF(_FR_FR)
	text "<USER>"
	line "dort!"
	prompt
else
	text "<USER>"
	line "is fast asleep!"
	prompt
endc

WokeUpText:
if DEF(_FR_FR)
	text "<USER>"
	line "se réveille!"
	prompt
else
	text "<USER>"
	line "woke up!"
	prompt
endc

FrozenSolidText:
if DEF(_FR_FR)
	text "<USER>"
	line "est gelé!"
	prompt
else
	text "<USER>"
	line "is frozen solid!"
	prompt
endc

FlinchedText:
if DEF(_FR_FR)
	text "<USER>"
	line "a la trouille!"
	prompt
else
	text "<USER>"
	line "flinched!"
	prompt
endc

ScaredText:
if DEF(_FR_FR)
	text "<USER> n'y voit"
	line "rien et manque"
	cont "sa cible."
	prompt
else
	text "<USER> couldn't"
	line "see and missed."
	prompt
endc

Scared2Text:
if DEF(_FR_FR)
	text "<USER> a pris"
	line "peur et échoue."
	prompt
else
	text "<USER> got"
	line "scared and missed."
	prompt
endc

MustRechargeText:
if DEF(_FR_FR)
	text "<USER>"
	line "est à plat!"
	prompt
else
	text "<USER>"
	line "must recharge!"
	prompt
endc

DisabledNoMoreText:
if DEF(_FR_FR)
	text "<USER>"
	line "n'est plus"
	cont "entravé!"
	prompt
else
	text "<USER>'s"
	line "disabled no more!"
	prompt
endc

IsConfusedText:
if DEF(_FR_FR)
	text "<USER>"
	line "est confus!"
	prompt
else
	text "<USER>"
	line "is confused!"
	prompt
endc

HurtItselfText:
if DEF(_FR_FR)
	text "Sa folie lui in-"
	line "flige des dégâts!"
	prompt
else
	text "It hurt itself in"
	line "its confusion!"
	prompt
endc

Pkrus_HurtItselfText:
if DEF(_FR_FR)
	text "La douleur est"
	line "insoutenable."
	prompt
else
	text "The ache is"
	line "unbearable."
	prompt
endc

ConfusedNoMoreText:
if DEF(_FR_FR)
	text "<USER>"
	line "n'est plus confus!"
	prompt
else
	text "<USER>'s"
	line "confused no more!"
	prompt
endc

BecameConfusedText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "devient confus!"
	prompt
else
	text "<TARGET>"
	line "became confused!"
	prompt
endc

BattleText_ItemHealedConfusion:
if DEF(_FR_FR)
	text_ram wStringBuffer1
	text_start
	line "dissipe la folie"
	cont "de"
	cont "<TARGET>."
	prompt
else
	text "A @"
	text_ram wStringBuffer1
	text " rid"
	line "<TARGET>"
	cont "of its confusion."
	prompt
endc

AlreadyConfusedText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "est déjà confus!"
	prompt
else
	text "<TARGET>'s"
	line "already confused!"
	prompt
endc

BattleText_UsersHurtByStringBuffer1:
if DEF(_FR_FR)
	text "<USER>"
	line "est blessé par"
	cont "@"
	text_ram wStringBuffer1
	text "!"
	prompt
else
	text "<USER>'s"
	line "hurt by"
	cont "@"
	text_ram wStringBuffer1
	text "!"
	prompt
endc

BattleText_UserWasReleasedFromStringBuffer1:
if DEF(_FR_FR)
	text "<USER>"
	line "est libéré de:"
	cont "@"
	text_ram wStringBuffer1
	text "!"
	prompt
else
	text "<USER>"
	line "was released from"
	cont "@"
	text_ram wStringBuffer1
	text "!"
	prompt
endc

UsedBindText:
if DEF(_FR_FR)
	text "<USER>"
	line "lance ETREINTE sur"
	cont "<TARGET>!"
	prompt
else
	text "<USER>"
	line "used BIND on"
	cont "<TARGET>!"
	prompt
endc

WhirlpoolTrapText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "est piégé!"
	prompt
else
	text "<TARGET>"
	line "was trapped!"
	prompt
endc

FireSpinTrapText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "est piégé!"
	prompt
else
	text "<TARGET>"
	line "was trapped!"
	prompt
endc

WrappedByText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "est LIGOTE par"
	cont "<USER>!"
	prompt
else
	text "<TARGET>"
	line "was WRAPPED by"
	cont "<USER>!"
	prompt
endc

ClampedByText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "dans CLAQUOIR de"
	cont "<USER>!"
	prompt
else
	text "<TARGET>"
	line "was CLAMPED by"
	cont "<USER>!"
	prompt
endc

StoringEnergyText:
if DEF(_FR_FR)
	text "<USER>"
	line "se concentre!"
	prompt
else
	text "<USER>"
	line "is storing energy!"
	prompt
endc

UnleashedEnergyText:
if DEF(_FR_FR)
	text "<USER>"
	line "envoie la sauce!"
	prompt
else
	text "<USER>"
	line "unleashed energy!"
	prompt
endc

HungOnText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "tient bon grâce à"
	cont "@"
	text_ram wStringBuffer1
	text "!"
	prompt
else
	text "<TARGET>"
	line "hung on with the"
	cont "@"
	text_ram wStringBuffer1
	text "!"
	prompt
endc

EnduredText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "est TENACE face au"
	cont "coup!"
	prompt
else
	text "<TARGET>"
	line "ENDURED the hit!"
	prompt
endc

InLoveWithText:
if DEF(_FR_FR)
	text "<USER>"
	line "est amoureux de"
	cont "<TARGET>!"
	prompt
else
	text "<USER>"
	line "is in love with"
	cont "<TARGET>!"
	prompt
endc

InfatuationText:
if DEF(_FR_FR)
	text "L'amour de"
	line "<USER>"
	cont "le paralyse!"
	prompt
else
	text "<USER>'s"
	line "infatuation kept"
	cont "it from attacking!"
	prompt
endc

DisabledMoveText:
if DEF(_FR_FR)
	text_ram wStringBuffer1
	text " de"
	line "<USER>"
	cont "est sous ENTRAVE!"
	prompt
else
	text "<USER>'s"
	line "@"
	text_ram wStringBuffer1
	text " is"
	cont "DISABLED!"
	prompt
endc

LoafingAroundText:
if DEF(_FR_FR)
	text_ram wBattleMonNickname
	text_start
	line "se promène."
	prompt
else
	text_ram wBattleMonNickname
	text " is"
	line "loafing around."
	prompt
endc

BeganToNapText:
if DEF(_FR_FR)
	text_ram wBattleMonNickname
	text_start
	line "fait la sieste!"
	prompt
else
	text_ram wBattleMonNickname
	text " began"
	line "to nap!"
	prompt
endc

WontObeyText:
if DEF(_FR_FR)
	text_ram wBattleMonNickname
	text_start
	line "n'obéit pas!"
	prompt
else
	text_ram wBattleMonNickname
	text " won't"
	line "obey!"
	prompt
endc

TurnedAwayText:
if DEF(_FR_FR)
	text_ram wBattleMonNickname
	text_start
	line "tourne le dos!"
	prompt
else
	text_ram wBattleMonNickname
	text " turned"
	line "away!"
	prompt
endc

IgnoredOrdersText:
if DEF(_FR_FR)
	text_ram wBattleMonNickname
	text_start
	line "vous ignore!"
	prompt
else
	text_ram wBattleMonNickname
	text " ignored"
	line "orders!"
	prompt
endc

IgnoredSleepingText:
if DEF(_FR_FR)
	text_ram wBattleMonNickname
	text " vous"
	line "ignore et pionce!"
	prompt
else
	text_ram wBattleMonNickname
	text " ignored"
	line "orders…sleeping!"
	prompt
endc

Pkrus_LoafingAroundText:
if DEF(_FR_FR)
	text_ram wBattleMonNickname
	text " est"
	line "épuisé..."
	prompt
else
	text_ram wBattleMonNickname
	text " is"
	line "exhausted…"
	prompt
endc

Pkrus_BeganToNapText:
if DEF(_FR_FR)
	text_ram wBattleMonNickname
	text " a"
	line "besoin de repos..."
	prompt
else
	text_ram wBattleMonNickname
	text " needs"
	line "to rest…"
	prompt
endc

Pkrus_WontObeyText:
if DEF(_FR_FR)
	text_ram wBattleMonNickname
	text " souffre"
	line "de tout son corps."
	prompt
else
	text_ram wBattleMonNickname
	text " body"
	line "is aching…"
	prompt
endc

Pkrus_TurnedAwayText:
if DEF(_FR_FR)
	text_ram wBattleMonNickname
	text " semble"
	line "fièvreux..."
	prompt
else
	text_ram wBattleMonNickname
	text " seems"
	line "to have a fever…"
	prompt
endc

Pkrus_IgnoredOrdersText:
if DEF(_FR_FR)
	text_ram wBattleMonNickname
	text " reprend"
	line "son souffle..."
	prompt
else
	text_ram wBattleMonNickname
	text " catches"
	line "its breath…"
	prompt
endc

Pkrus_IgnoredSleepingText:
if DEF(_FR_FR)
	text_ram wBattleMonNickname
	text " ne vous"
	line "a pas entendu."
	prompt
else
	text_ram wBattleMonNickname
	text " didn't"
	line "hear you."
	prompt
endc

NoPPLeftText:
if DEF(_FR_FR)
	text "Plus de PP pour"
	line "cette capacité!"
	prompt
else
	text "But no PP is left"
	line "for the move!"
	prompt
endc

HasNoPPLeftText:
if DEF(_FR_FR)
	text "<USER>"
	line "n'a plus de PP"
	cont "pour @"
	text_ram wStringBuffer2
	text "!"
	prompt
else
	text "<USER>"
	line "has no PP left for"
	cont "@"
	text_ram wStringBuffer2
	text "!"
	prompt
endc

WentToSleepText:
if DEF(_FR_FR)
	text "<USER>"
	line "s'endort!"
	done
else
	text "<USER>"
	line "went to sleep!"
	done
endc

RestedText:
if DEF(_FR_FR)
	text "<USER>"
	line "s'endort et récu-"
	cont "père son énergie!"
	done
else
	text "<USER>"
	line "fell asleep and"
	cont "became healthy!"
	done
endc

RegainedHealthText:
if DEF(_FR_FR)
	text "<USER>"
	line "récupère son"
	cont "énergie!"
	prompt
else
	text "<USER>"
	line "regained health!"
	prompt
endc

AttackMissedText:
if DEF(_FR_FR)
	text "<USER>"
	line "rate son attaque!"
	prompt
else
	text "<USER>'s"
	line "attack missed!"
	prompt
endc

AttackMissed2Text:
if DEF(_FR_FR)
	text "<USER>"
	line "rate son attaque!"
	prompt
else
	text "<USER>'s"
	line "attack missed!"
	prompt
endc

CrashedText:
if DEF(_FR_FR)
	text "<USER>"
	line "s'éclate au sol!"
	prompt
else
	text "<USER>"
	line "kept going and"
	cont "crashed!"
	prompt
endc

UnaffectedText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "n'est pas affecté!"
	prompt
else
	text "<TARGET>'s"
	line "unaffected!"
	prompt
endc

DoesntAffectText:
if DEF(_FR_FR)
	text "Aucun effet sur"
	line "<TARGET>!"
	prompt
else
	text "It doesn't affect"
	line "<TARGET>!"
	prompt
endc

CriticalHitText:
if DEF(_FR_FR)
	text "Coup critique!"
	prompt
else
	text "A critical hit!"
	prompt
endc

OneHitKOText:
if DEF(_FR_FR)
	text "K.O. en un coup!"
	prompt
else
	text "It's a one-hit KO!"
	prompt
endc

SuperEffectiveText:
if DEF(_FR_FR)
	text "C'est super"
	line "efficace!"
	prompt
else
	text "It's super-"
	line "effective!"
	prompt
endc

NotVeryEffectiveText:
if DEF(_FR_FR)
	text "Ce n'est pas très"
	line "efficace..."
	prompt
else
	text "It's not very"
	line "effective…"
	prompt
endc

ErikasSporesText:
if DEF(_FR_FR)
	text "<USER> est"
	line "entré en contact"
	cont "avec le pollen sur"
	cont "<TARGET>."
	prompt
else
	text "<USER> got in"
	line "contact with the"
	cont "pollen on"
	cont "<TARGET>…"
	prompt
endc

TookDownWithItText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "emmène au tapis"
	cont "<USER>!"
	prompt
else
	text "<TARGET>"
	line "took down with it,"
	cont "<USER>!"
	prompt
endc

RageBuildingText:
if DEF(_FR_FR)
	text "La FRENESIE de"
	line "<USER>"
	cont "augmente!"
	prompt
else
	text "<USER>'s"
	line "RAGE is building!"
	prompt
endc

GotAnEncoreText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "en a ENCORE!"
	prompt
else
	text "<TARGET>"
	line "got an ENCORE!"
	prompt
endc

SharedPainText:
if DEF(_FR_FR)
	text "Les adversaires"
	line "partagent les"
	cont "dégâts!"
	prompt
else
	text "The battlers"
	line "shared pain!"
	prompt
endc

TookAimText:
if DEF(_FR_FR)
	text "<USER>"
	line "vise!"
	prompt
else
	text "<USER>"
	line "took aim!"
	prompt
endc

AnticipatedText:
if DEF(_FR_FR)
	text "<USER>"
	line "lit l'esprit de"
	cont "son adversaire."
	prompt
else
	text "<USER>"
	line "read the enemy's"
	cont "mind."
	prompt
endc

SketchedText:
if DEF(_FR_FR)
	text "<USER>"
	line "GRIBOUILLE"
	cont "@"
	text_ram wStringBuffer1
	text "!"
	prompt
else
	text "<USER>"
	line "SKETCHED"
	cont "@"
	text_ram wStringBuffer1
	text "!"
	prompt
endc

DestinyBondEffectText:
if DEF(_FR_FR)
	text "<USER>"
	line "veut emmener son"
	cont "ennemi au tapis!"
	prompt
else
	text "<USER>'s"
	line "trying to take its"
	cont "opponent with it!"
	prompt
endc

SpiteEffectText:
if DEF(_FR_FR)
	text_ram wStringBuffer1
	text " de"
	line "<TARGET>"
	cont "baisse de @"
	text_decimal wTextDecimalByte, 1, 1
	text "!"
	prompt
else
	text "<TARGET>'s"
	line "@"
	text_ram wStringBuffer1
	text " was"
	cont "reduced by @"
	text_decimal wTextDecimalByte, 1, 1
	text "!"
	prompt
endc

BellChimedText:
if DEF(_FR_FR)
	text "Une cloche sonne!"
	line ""
	prompt
else
	text "A bell chimed!"
	line ""
	prompt
endc

FellAsleepText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "s'endort!"
	prompt
else
	text "<TARGET>"
	line "fell asleep!"
	prompt
endc

AlreadyAsleepText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "dort déjà!"
	prompt
else
	text "<TARGET>'s"
	line "already asleep!"
	prompt
endc

WasPoisonedText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "est empoisonné!"
	prompt
else
	text "<TARGET>"
	line "was poisoned!"
	prompt
endc

BadlyPoisonedText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "est gravement"
	cont "empoisonné!"
	prompt
else
	text "<TARGET>'s"
	line "badly poisoned!"
	prompt
endc

AlreadyPoisonedText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "est déjà"
	cont "empoisonné!"
	prompt
else
	text "<TARGET>'s"
	line "already poisoned!"
	prompt
endc

SuckedHealthText:
if DEF(_FR_FR)
	text "L'énergie de"
	line "<TARGET>"
	cont "est aspirée!"
	prompt
else
	text "Sucked health from"
	line "<TARGET>!"
	prompt
endc

DreamEatenText:
if DEF(_FR_FR)
	text "Le rêve de"
	line "<TARGET>"
	cont "est dévoré!"
	prompt
else
	text "<TARGET>'s"
	line "dream was eaten!"
	prompt
endc

WasBurnedText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "brûle!"
	prompt
else
	text "<TARGET>"
	line "was burned!"
	prompt
endc

DefrostedOpponentText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "est dégelé!"
	prompt
else
	text "<TARGET>"
	line "was defrosted!"
	prompt
endc

WasFrozenText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "est gelé!"
	prompt
else
	text "<TARGET>"
	line "was frozen solid!"
	prompt
endc

WontRiseAnymoreText:
if DEF(_FR_FR)
	text_ram wStringBuffer2
	text " de"
	line "<USER>"
	cont "n'augmente plus!"
	prompt
else
	text "<USER>'s"
	line "@"
	text_ram wStringBuffer2
	text " won't"
	cont "rise anymore!"
	prompt
endc

WontDropAnymoreText:
if DEF(_FR_FR)
	text_ram wStringBuffer2
	text " de"
	line "<TARGET>"
	cont "ne diminue plus!"
	prompt
else
	text "<TARGET>'s"
	line "@"
	text_ram wStringBuffer2
	text " won't"
	cont "drop anymore!"
	prompt
endc

FledFromBattleText::
if DEF(_FR_FR)
	text "<USER>"
	line "s'enfuit!"
	prompt
else
	text "<USER>"
	line "fled from battle!"
	prompt
endc

FledInFearText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "a peur et fuit!"
	prompt
else
	text "<TARGET>"
	line "fled in fear!"
	prompt
endc

BlownAwayText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "est soufflé!"
	prompt
else
	text "<TARGET>"
	line "was blown away!"
	prompt
endc

PlayerHitTimesText:
if DEF(_FR_FR)
	text "Touché @"
	text_decimal wPlayerDamageTaken, 1, 1
	text " fois!"
	prompt
else
	text "Hit @"
	text_decimal wPlayerDamageTaken, 1, 1
	text " times!"
	prompt
endc

EnemyHitTimesText:
if DEF(_FR_FR)
	text "Touché @"
	text_decimal wEnemyDamageTaken, 1, 1
	text " fois!"
	prompt
else
	text "Hit @"
	text_decimal wEnemyDamageTaken, 1, 1
	text " times!"
	prompt
endc

MistText:
if DEF(_FR_FR)
	text "<USER>"
	line "s'entoure d'une"
	cont "BRUME!"
	prompt
else
	text "<USER>'s"
	line "shrouded in MIST!"
	prompt
endc

ProtectedByMistText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "est protégé par"
	cont "la BRUME!"
	prompt
else
	text "<TARGET>'s"
	line "protected by MIST."
	prompt
endc

GettingPumpedText:
if DEF(_FR_FR)
	text_pause
	text "<USER>"
	line "se concentre!"
	prompt
else
	text_pause
	text "<USER>'s"
	line "getting pumped!"
	prompt
endc

RecoilText:
if DEF(_FR_FR)
	text "<USER>"
	line "se blesse en"
	cont "frappant!"
	prompt
else
	text "<USER>'s"
	line "hit with recoil!"
	prompt
endc

MadeSubstituteText:
if DEF(_FR_FR)
	text "<USER>"
	line "crée un CLONE!"
	prompt
else
	text "<USER>"
	line "made a SUBSTITUTE!"
	prompt
endc

HasSubstituteText:
if DEF(_FR_FR)
	text "<USER>"
	line "a un CLONE!"
	prompt
else
	text "<USER>"
	line "has a SUBSTITUTE!"
	prompt
endc

TooWeakSubText:
if DEF(_FR_FR)
	text "Trop faible pour"
	line "créer un CLONE!"
	prompt
else
	text "Too weak to make"
	line "a SUBSTITUTE!"
	prompt
endc

SubTookDamageText:
if DEF(_FR_FR)
	text "Le CLONE prend"
	line "les dégâts pour"
	cont "<TARGET>!"
	prompt
else
	text "The SUBSTITUTE"
	line "took damage for"
	cont "<TARGET>!"
	prompt
endc

SubFadedText:
if DEF(_FR_FR)
	text "Le CLONE de"
	line "<TARGET>"
	cont "s'évanouit!"
	prompt
else
	text "<TARGET>'s"
	line "SUBSTITUTE faded!"
	prompt
endc

MimicLearnedMoveText:
if DEF(_FR_FR)
	text "<USER>"
	line "apprend"
	cont "@"
	text_ram wStringBuffer1
	text "!"
	prompt
else
	text "<USER>"
	line "learned"
	cont "@"
	text_ram wStringBuffer1
	text "!"
	prompt
endc

WasSeededText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "est infecté!"
	prompt
else
	text "<TARGET>"
	line "was seeded!"
	prompt
endc

EvadedText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "évite l'attaque!"
	prompt
else
	text "<TARGET>"
	line "evaded the attack!"
	prompt
endc

WasDisabledText:
if DEF(_FR_FR)
	text_ram wStringBuffer1
	text " de"
	line "<TARGET>"
	cont "est sous ENTRAVE!"
	prompt
else
	text "<TARGET>'s"
	line "@"
	text_ram wStringBuffer1
	text " was"
	cont "DISABLED!"
	prompt
endc

CoinsScatteredText:
if DEF(_FR_FR)
	text "Une pluie de"
	line "pièces!"
	prompt
else
	text "Coins scattered"
	line "everywhere!"
	prompt
endc

TransformedTypeText:
if DEF(_FR_FR)
	text "<USER>"
	line "se change en type"
	cont "@"
	text_ram wStringBuffer1
	text "!"
	prompt
else
	text "<USER>"
	line "transformed into"
	cont "the @"
	text_ram wStringBuffer1
	text "-type!"
	prompt
endc

EliminatedStatsText:
if DEF(_FR_FR)
	text "Tout changement de"
	line "statut éliminé!"
	prompt
else
	text "All stat changes"
	line "were eliminated!"
	prompt
endc

TransformedText:
if DEF(_FR_FR)
	text "<USER>"
	line "se transforme en"
	cont "@"
	text_ram wStringBuffer1
	text "!"
	prompt
else
	text "<USER>"
	line "TRANSFORMED into"
	cont "@"
	text_ram wStringBuffer1
	text "!"
	prompt
endc

LightScreenEffectText:
if DEF(_FR_FR)
	text "La DEF.SPE. de"
	line "<USER>"
	cont "augmente!"
	prompt
else
	text "<USER>'s"
	line "SPCL.DEF rose!"
	prompt
endc

ReflectEffectText:
if DEF(_FR_FR)
	text "La DEFENSE de"
	line "<USER>"
	cont "augmente!"
	prompt
else
	text "<USER>'s"
	line "DEFENSE rose!"
	prompt
endc

NothingHappenedText:
if DEF(_FR_FR)
	text "Mais rien ne se"
	line "passe."
	prompt
else
	text "But nothing"
	line "happened."
	prompt
endc

ButItFailedText:
if DEF(_FR_FR)
	text "Mais cela échoue!"
	prompt
else
	text "But it failed!"
	prompt
endc

ItFailedText:
if DEF(_FR_FR)
	text "Ca ne marche pas!"
	prompt
else
	text "It failed!"
	prompt
endc

DidntAffectText:
if DEF(_FR_FR)
	text "Ca n'affecte pas"
	line "<TARGET>!"
	prompt
else
	text "It didn't affect"
	line "<TARGET>!"
	prompt
endc

HPIsFullText:
if DEF(_FR_FR)
	text "Points de Vie de"
	line "<USER>"
	cont "au max!"
	prompt
else
	text "<USER>'s"
	line "HP is full!"
	prompt
endc

DraggedOutText:
if DEF(_FR_FR)
	text "<USER>"
	line "est traîné de"
	cont "force au combat!"
	prompt
else
	text "<USER>"
	line "was dragged out!"
	prompt
endc

ParalyzedText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "paralysé! Il peut"
	cont "ne pas attaquer!"
	prompt
else
	text "<TARGET>'s"
	line "paralyzed! Maybe"
	cont "it can't attack!"
	prompt
endc

FullyParalyzedText:
if DEF(_FR_FR)
	text "<USER>"
	line "est totalement"
	cont "paralysé!"
	prompt
else
	text "<USER>'s"
	line "fully paralyzed!"
	prompt
endc

AlreadyParalyzedText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "est déjà paralysé!"
	prompt
else
	text "<TARGET>'s"
	line "already paralyzed!"
	prompt
endc

ProtectedByText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "est protégé par"
	cont "@"
	text_ram wStringBuffer1
	text "!"
	prompt
else
	text "<TARGET>'s"
	line "protected by"
	cont "@"
	text_ram wStringBuffer1
	text "!"
	prompt
endc

MirrorMoveFailedText:
if DEF(_FR_FR)
	text "La MIMIQUE a"
	next "échoué!"
	prompt
else
	text "The MIRROR MOVE"
	next "failed!"
	prompt
endc

StoleText:
if DEF(_FR_FR)
	text "<USER>"
	line "vole @"
	text_ram wStringBuffer1
	text_start
	cont "à son ennemi!"
	prompt
else
	text "<USER>"
	line "stole @"
	text_ram wStringBuffer1
	text_start
	cont "from its foe!"
	prompt
endc

CantEscapeNowText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "ne peut pas"
	cont "s'échapper!"
	prompt
else
	text "<TARGET>"
	line "can't escape now!"
	prompt
endc

StartedNightmareText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "commence à"
	cont "CAUCHEMARDER!"
	prompt
else
	text "<TARGET>"
	line "started to have a"
	cont "NIGHTMARE!"
	prompt
endc

WasDefrostedText:
if DEF(_FR_FR)
	text "<USER>"
	line "est dégelé!"
	prompt
else
	text "<USER>"
	line "was defrosted!"
	prompt
endc

PutACurseText:
if DEF(_FR_FR)
	text "<USER>"
	line "sacrifie ses PV..."
	
	para "...et MAUDIT"
	line "<TARGET>!"
	prompt
else
	text "<USER>"
	line "cut its own HP and"
	
	para "put a CURSE on"
	line "<TARGET>!"
	prompt
endc

ProtectedItselfText:
if DEF(_FR_FR)
	text "<USER>"
	line "se met à l'ABRI!"
	prompt
else
	text "<USER>"
	line "PROTECTED itself!"
	prompt
endc

ProtectingItselfText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "s'ABRITE!"
	done
else
	text "<TARGET>'s"
	line "PROTECTING itself!"
	done
endc

AnticipatedAndAvoidedText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "l'a anticipé, et"
	cont "esquive!"
	prompt
else
	text "<TARGET>"
	line "foresaw it and"
	cont "avoided!"
	prompt
endc

SpikesText:
if DEF(_FR_FR)
	text "Des PICOTS s'épar-"
	line "pillent autour de"
	cont "<TARGET>!"
	prompt
else
	text "SPIKES scattered"
	line "all around"
	cont "<TARGET>!"
	prompt
endc

IdentifiedText:
if DEF(_FR_FR)
	text "<USER>"
	line "identifie"
	cont "<TARGET>!"
	prompt
else
	text "<USER>"
	line "identified"
	cont "<TARGET>!"
	prompt
endc

StartPerishText:
if DEF(_FR_FR)
	text "Les deux #MON"
	line "sont K.O. dans..."
	cont "3 tours!!!"
	prompt
else
	text "Both #MON will"
	line "faint in 3 turns!"
	prompt
endc

SandstormBrewedText:
if DEF(_FR_FR)
	text "Une TEMPETE de"
	line "SABLE se prépare!"
	prompt
else
	text "A SANDSTORM"
	line "brewed!"
	prompt
endc

ItStartedToHailText:
if DEF(_FR_FR)
	text "La GRELE commence"
	line "à tomber!"
	prompt
else
	text "It started"
	line "to HAIL!"
	prompt
endc

BracedItselfText:
if DEF(_FR_FR)
	text "<USER>"
	line "rassemble ses"
	cont "forces!"
	prompt
else
	text "<USER>"
	line "braced itself!"
	prompt
endc

FellInLoveText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "est amoureux!"
	prompt
else
	text "<TARGET>"
	line "fell in love!"
	prompt
endc

CoveredByVeilText:
if DEF(_FR_FR)
	text "<USER>"
	line "est sous un voile!"
	prompt
else
	text "<USER>'s"
	line "covered by a veil!"
	prompt
endc

SafeguardProtectText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "est protégé par"
	cont "RUNE PROTECT!"
	prompt
else
	text "<TARGET>"
	line "is protected by"
	cont "SAFEGUARD!"
	prompt
endc

MagnitudeText:
if DEF(_FR_FR)
	text "Ampleur @"
	text_decimal wTextDecimalByte, 1, 1
	text "!"
	prompt
else
	text "Magnitude @"
	text_decimal wTextDecimalByte, 1, 1
	text "!"
	prompt
endc

ReleasedByText:
if DEF(_FR_FR)
	text "<USER>"
	line "est relâché par"
	cont "<TARGET>!"
	prompt
else
	text "<USER>"
	line "was released by"
	cont "<TARGET>!"
	prompt
endc

ShedLeechSeedText:
if DEF(_FR_FR)
	text "<USER>"
	line "lance VAMPIGRAINE!"
	prompt
else
	text "<USER>"
	line "shed LEECH SEED!"
	prompt
endc

BlewSpikesText:
if DEF(_FR_FR)
	text "<USER>"
	line "lance les PICOTS!"
	prompt
else
	text "<USER>"
	line "blew away SPIKES!"
	prompt
endc

RippedStickyWebText:
if DEF(_FR_FR)
	text "<USER> déchire"
	line "la TOILE GLUANTE!"
	prompt
else
	text "<USER> ripped"
	line "off STICKY WEB!"
	prompt
endc

DownpourText:
if DEF(_FR_FR)
	text "Une forte pluie"
	line "commence!"
	prompt
else
	text "A downpour"
	line "started!"
	prompt
endc

SunGotBrightText:
if DEF(_FR_FR)
	text "Le soleil brille!"
	prompt
else
	text "The sunlight got"
	line "bright!"
	prompt
endc

BellyDrumText:
if DEF(_FR_FR)
	text "<USER>"
	line "sacrifie ses PV et"
	cont "monte son ATTAQUE"
	cont "au max!"
	prompt
else
	text "<USER>"
	line "cut its HP and"
	cont "maximized ATTACK!"
	prompt
endc

CopiedStatsText:
if DEF(_FR_FR)
	text "<USER>"
	line "copie les change-"
	
	para "ments de statut de"
	line "<TARGET>!"
	prompt
else
	text "<USER>"
	line "copied the stat"
	
	para "changes of"
	line "<TARGET>!"
	prompt
endc

ForesawAttackText:
if DEF(_FR_FR)
	text "<USER>"
	line "prévoit une"
	cont "attaque!"
	prompt
else
	text "<USER>"
	line "foresaw an attack!"
	prompt
endc

BeatUpAttackText:
if DEF(_FR_FR)
	text "Attaque de"
	line "@"
	text_ram wStringBuffer1
	text "!"
	done
else
	text_ram wStringBuffer1
	text "'s"
	line "attack!"
	done
endc

PresentFailedText:
if DEF(_FR_FR)
	text "<TARGET>"
	line "ne veut pas"
	cont "le cadeau!"
	prompt
else
	text "<TARGET>"
	line "refused the gift!"
	prompt
endc

IgnoredOrders2Text:
if DEF(_FR_FR)
	text "<USER>"
	line "ignore les ordres!"
	prompt
else
	text "<USER>"
	line "ignored orders!"
	prompt
endc

BattleText_LinkErrorBattleCanceled:
if DEF(_FR_FR)
	text "Erreur Link..."

	para "Le combat est"
	line "annulé..."
	prompt
else
	text "Link error…"
	
	para "The battle has"
	line "been canceled…"
	prompt
endc

WildPokemonAssaultText:
if DEF(_FR_FR)
	text "Quoi? Le"
	line "@"
	text_ram wEnemyMonNickname
	text " sauvage"
	cont "vous agresse!"
	prompt
else
	text "What?"
	line "Wild @"
	text_ram wEnemyMonNickname
	text_start
	cont "assaulted you!"
	prompt
endc