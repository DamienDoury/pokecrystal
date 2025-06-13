AbilityDescriptions:
; entries correspond to ability ids (see constants/ability_constants.asm)
	table_width 2, AbilityDescriptions
	dw NoAbilityDesc
	dw ChlorophyllDesc
	dw SolarPowerDesc
	dw RainDishDesc
	dw ShieldDustDesc
	dw ShedSkinDesc
	dw CompoundEyesDesc
	dw SniperDesc
	dw KeenEyeDesc
	dw RunAwayDesc
	dw IntimidateDesc
	dw LightningRodDesc
	dw SandRushDesc
	dw HustleDesc
	dw CuteCharmDesc
	dw FlashFireDesc
	dw DroughtDesc
	dw InnerFocusDesc
	dw StenchDesc
	dw EffectSporeDesc
	dw SandForceDesc
	dw PickupDesc
	dw LimberDesc
	dw CloudNineDesc
	dw DefiantDesc
	dw SwiftSwimDesc
	dw SynchronizeDesc
	dw GutsDesc
	dw LiquidOozeDesc
	dw SturdyDesc
	dw FlameBodyDesc
	dw OwnTempoDesc
	dw EarlyBirdDesc
	dw ThickFatDesc
	dw ShellArmorDesc
	dw LevitateDesc
	dw InsomniaDesc
	dw StaticDesc
	dw HarvestDesc
	dw RockHeadDesc
	dw NaturalCureDesc
	dw RegeneratorDesc
	dw TechnicianDesc
	dw MoxieDesc
	dw HydrationDesc
	dw ImposterDesc
	dw WaterAbsorbDesc
	dw VoltAbsorbDesc
	dw TraceDesc
	dw WeakArmorDesc
	dw PressureDesc
	dw MultiscaleDesc
	dw LeafGuardDesc
	dw SheerForceDesc
	dw SuperLuckDesc
	dw HugePowerDesc
	dw DrizzleDesc
	dw SpeedBoostDesc
	dw ShadowTagDesc
	dw SapSipperDesc
	dw ImmunityDesc
	dw PoisonPointDesc
	dw MoodyDesc
	dw SandStreamDesc
	assert_table_length NUM_ABILITIES

NoAbilityDesc:
if DEF(_FR_FR)
	db   "Aucun effet.@"
else
	db   "No effect.@"
endc

ChlorophyllDesc:
if DEF(_FR_FR)
	db   "VITESSE doublée"
	next "sous le soleil.@"
else
	db   "SPEED is doubled"
	next "in the sun.@"
endc

SolarPowerDesc:
if DEF(_FR_FR)
	db   "×1.5 ATQ.SPE. mais"
	next "-1/8 PV max / tour"
	next "sous le soleil.@"
else
	db   "×1.5 SP.ATK in the"
	next "sun, but lose 1/8"
	next "max HP per turn.@"
endc

RainDishDesc:
if DEF(_FR_FR)
	db   "Sous la pluie,"
	next "soigne 1/16 PV max"
	next "chaque tour.@"
else
	db   "During rain,"
	next "regain 1/16 max"
	next "HP per turn.@"
endc

ShieldDustDesc:
if DEF(_FR_FR)
	db   "Bloque les effets"
	next "secondaires des"
	next "attaques reçues.@"
else
	db   "Block the addi-"
	next "tional effects of"
	next "attacks taken.@"
endc

ShedSkinDesc:
if DEF(_FR_FR)
	db   "Chaque tour,"
	next "1 chance sur 3 de"
	next "soigner le statut.@"
else
	db   "Each turn, 1/3"
	next "chance of curing a"
	next "status condition.@"
endc

CompoundEyesDesc:
if DEF(_FR_FR)
	db   "x1,3 PRECISION"
	next "à vos capacités.@"
else
	db   "Moves get a 30<PERCENT>"
	next "accuracy boost.@"
endc

SniperDesc:
if DEF(_FR_FR)
	db   "Dégâts critiques"
	next "augmentés de 50<PERCENT>.@"
else
	db   "Critical hit"
	next "damage increased"
	next "by 50<PERCENT>.@"
endc

KeenEyeDesc:
if DEF(_FR_FR)
	db   "La PRECISION ne"
	next "peut pas baisser.@"
else
	db   "Accuracy can't"
	next "be reduced.@"
endc

RunAwayDesc:
if DEF(_FR_FR)
	db   "Fuite assurée face"
	next "à un #MON"
	next "sauvage.@"
else
	db   "You can always run"
	next "away from a"
	next "wild #MON.@"
endc

IntimidateDesc:
if DEF(_FR_FR)
	db   "En entrant au"
	next "combat, réduit ATQ"
	next "ennemie d'un cran.@"
else
	db   "Lower the foe's"
	next "ATK upon entering"
	next "battle.@"
endc

LightningRodDesc:
if DEF(_FR_FR)
	db   "Immunité ELECTRIK,"
	next "attire ces capa.,"
	next "et ▲ ATQ.SPE.@"
else
	db   "Draw in ELECTRIC"
	next "moves to boost"
	next "SP.ATK.@"
endc

SandRushDesc:
if DEF(_FR_FR)
	db   "VITESSE doublée"
	next "sous TEMPETESABLE.@"
else
	db   "SPEED is doubled"
	next "during sandstorms.@"
endc

HustleDesc:
if DEF(_FR_FR)
	db   "Attaques physiques"
	next "gagnent ×1.5 ATQ"
	next "et ×0.8 PRECISION.@"
else
	db   "Physical moves get"
	next "×1.5 ATK"
	next "×0.8 ACCURACY.@"
endc

CuteCharmDesc:
if DEF(_FR_FR)
	db   "30<PERCENT> de chance de"
	next "charmer l'ennemi"
	next "s'il vous touche.@"
else
	db   "30<PERCENT> odds to infa-"
	next "tuate the foe when"
	next "they make contact.@"
endc

FlashFireDesc:
if DEF(_FR_FR)
	db   "Dmg FEU reçus sont"
	next "annulés & boostent"
	next "les vôtres x1.5.@"
else
	db   "Negate FIRE moves"
	next "and boost yours by"
	next "×1.5 when hit.@"
endc

DroughtDesc:
if DEF(_FR_FR)
	db   "Invoque chaleur"
	next "intense en entrant"
	next "au combat.@"
else
	db   "Turn the sunlight"
	next "harsh upon"
	next "entering battle.@"
endc

InnerFocusDesc:
if DEF(_FR_FR)
	db   "Jamais apeuré.@"
else
	db   "Can't flinch.@"
endc

StenchDesc:
if DEF(_FR_FR)
	db   "10<PERCENT> de chance"
	next "d'apeurer l'ennemi"
	next "en le touchant.@"
else
	db   "10<PERCENT> of making the"
	next "target flinch"
	next "on hit.@"
endc

EffectSporeDesc:
if DEF(_FR_FR)
	db   "Peut PSN, PAR, SOM"
	next "l'ennemi quand il"
	next "entre en contact.@"
else
	db   "May PRZ, SLP, PSN"
	next "the foe when they"
	next "make contact.@"
endc

SandForceDesc:
if DEF(_FR_FR)
	db   "+30<PERCENT> dmg aux capa."
	next "SOL, ROCHE & ACIER"
	next "sous TEMPETESABLE.@"
else
	db   "+30<PERCENT> dmg to STEEL,"
	next "ROCK, GROUND moves"
	next "during sandstorms.@"
endc

PickupDesc:
if DEF(_FR_FR)
	db   "Récupère l'objet"
	next "utilisé après"
	next "un combat.@"
else
	db   "Recover used item"
	next "after a battle.@"
endc

LimberDesc:
if DEF(_FR_FR)
	db   "Immunise contre"
	next "PAR.@"
else
	db   "Prevent PRZ.@"
endc

CloudNineDesc:
if DEF(_FR_FR)
	db   "Annule les effets"
	next "du climat.@"
else
	db   "Weather effects"
	next "are eliminated.@"
endc

DefiantDesc:
if DEF(_FR_FR)
	db   "▲▲ ATQ à chaque"
	next "réduction de vos"
	next "stats.@"
else
	db   "+2 ATK stages each"
	next "time stats are"
	next "lowered.@"
endc

SwiftSwimDesc:
if DEF(_FR_FR)
	db   "VITESSE doublée"
	next "sous la PLUIE.@"
else
	db   "SPEED is doubled"
	next "in the rain.@"
endc

SynchronizeDesc:
if DEF(_FR_FR)
	db   "Copie votre statut"
	next "sur l'ennemi.@"
else
	db   "Status conditions"
	next "are copied onto"
	next "the opponent.@"
endc

GutsDesc:
if DEF(_FR_FR)
	db   "+50<PERCENT> ATQ quand"
	next "votre statut est"
	next "altéré.@"
else
	db   "+50<PERCENT> ATK when you"
	next "have a status"
	next "condition.@"
endc

LiquidOozeDesc:
if DEF(_FR_FR)
	db   "Voler vos PV"
	next "blesse l'ennemi.@"
else
	db   "Draining you deals"
	next "damage rather than"
	next "heal.@"
endc

SturdyDesc:
if DEF(_FR_FR)
	db   "Survie aux KO en"
	next "1 coup avec 1 PV.@"
else
	db   "Survive One-Hit KO"
	next "with 1 HP.@"
endc

FlameBodyDesc:
if DEF(_FR_FR)
	db   "30<PERCENT> de chance de"
	next "BRU l'ennemi quand"
	next "il vous contacte.@"
else
	db   "30<PERCENT> chance to BRN"
	next "the opponent when"
	next "they make contact.@"
endc

OwnTempoDesc:
if DEF(_FR_FR)
	db   "Bloque confusion"
	next "et INTIMIDATION.@"
else
	db   "Prevent confusion"
	next "and INTIMIDATE.@"
endc

EarlyBirdDesc:
if DEF(_FR_FR)
	db   "Réduit de moitié"
	next "la durée de SOM.@"
else
	db   "Wake up twice as"
	next "fast.@"
endc

ThickFatDesc:
if DEF(_FR_FR)
	db   "Divise par 2 les"
	next "dommages FEU et"
	next "GLACE reçus.@"
else
	db   "Halve FIRE & ICE"
	next "damage you take.@"
endc

ShellArmorDesc:
if DEF(_FR_FR)
	db   "Protège contre les"
	next "coups critiques.@"
else
	db   "Protect from"
	next "critical hits.@"
endc

LevitateDesc:
if DEF(_FR_FR)
	db   "Immunise contre"
	next "les dommages SOL.@"
else
	db   "Immune to GROUND-"
	next "type damage.@"
endc

InsomniaDesc:
if DEF(_FR_FR)
	db   "Immunise contre"
	next "SOM. Rend REPOS"
	next "impossible.@"
else
	db   "Can't be put to"
	next "sleep."
	next "REST fails.@"
endc

StaticDesc:
if DEF(_FR_FR)
	db   "30<PERCENT> de chance de"
	next "PAR l'ennemi quand"
	next "il vous touche.@"
else
	db   "30<PERCENT> chance to PRZ"
	next "the opponent when"
	next "they make contact.@"
endc

HarvestDesc:
if DEF(_FR_FR)
	db   "50% chance récup."
	next "baie après conso."
	next "100% sous soleil.@"
else
	db   "May recover berry"
	next "after using one."
	next "Certain under sun.@"
endc

RockHeadDesc:
if DEF(_FR_FR)
	db   "Immunise contre"
	next "les dommages de"
	next "recul.@"
else
	db   "Can't take recoil"
	next "damage.@"
endc

NaturalCureDesc:
if DEF(_FR_FR)
	db   "Soigne statut"
	next "au switch.@"
else
	db   "Status condition"
	next "is healed upon"
	next "switching out.@"
endc

RegeneratorDesc:
if DEF(_FR_FR)
	db   "Soigne 1/3 des PV"
	next "max au switch.@"
else
	db   "Regain 1/3 max HP"
	next "upon switching"
	next "out.@"
endc

TechnicianDesc:
if DEF(_FR_FR)
	db   "Les capa. avec une"
	next "puis. de 60 ou -"
	next "gagnent +50<PERCENT> dmg.@"
else
	db   "Moves with 60 POW"
	next "or less gain +50<PERCENT>"
	next "damage.@"
endc

MoxieDesc:
if DEF(_FR_FR)
	db   "Booste d'un niveau"
	next "l'ATQ à chaque"
	next "KO d'un ennemi.@"
else
	db   "+1 ATK boost"
	next "after each KO.@"
endc

HydrationDesc:
if DEF(_FR_FR)
	db   "Statut soigné sous"
	next "la pluie.@"
else
	db   "Status conditions"
	next "are healed in"
	next "the rain.@"
endc

ImposterDesc:
if DEF(_FR_FR)
	db   "Lance MORPHING"
	next "en entrant"
	next "au combat.@"
else
	db   "TRANSFORM upon"
	next "entering battle.@"
endc

WaterAbsorbDesc:
if DEF(_FR_FR)
	db   "Les dmg EAU vous"
	next "soignent de 25<PERCENT>"
	next "des PV max.@"
else
	db   "WATER-type moves"
	next "hitting you heal"
	next "25<PERCENT> max HP.@"
endc

VoltAbsorbDesc:
if DEF(_FR_FR)
	db   "Les dmg ELECTRIK"
	next "vous soignent de"
	next "25<PERCENT> des PV max.@"
else
	db   "ELECTRIC-type"
	next "moves hitting you"
	next "heal 25<PERCENT> max HP.@"
endc

TraceDesc:
if DEF(_FR_FR)
	db   "Copie le talent"
	next "de l'ennemi en"
	next "entrant au combat.@"
else
	db   "Copy the foe's"
	next "ABILITY upon"
	next "entering battle.@"
endc

WeakArmorDesc:
if DEF(_FR_FR)
	db   "Dmg phys. reçus:"
	next "▲▲ VIT et ▼ DEF.@"
else
	db   "Physical dmg taken"
	next "highly ups SPEED"
	next "but lowers DEF.@"
endc

PressureDesc:
if DEF(_FR_FR)
	db   "La consommation de"
	next "PP de l'ennemi"
	next "est doublée.@"
else
	db   "Foes consume twice"
	next "as many PP.@"
endc

MultiscaleDesc:
if DEF(_FR_FR)
	db   "Dmg reçus réduits"
	next "de moitié lorsque"
	next "PV sont aux max.@"
else
	db   "When at full HP,"
	next "damage taken from"
	next "moves is halved.@"
endc

LeafGuardDesc:
if DEF(_FR_FR)
	db   "Status soigné sous"
	next "chaleur intense.@"
else
	db   "Status conditions"
	next "are healed under"
	next "harsh sunlight.@"
endc

SheerForceDesc:
if DEF(_FR_FR)
	db   "Annule vos effets"
	next "secondaires mais"
	next "booste dmg de 30<PERCENT>.@"
else
	db   "Added effects are"
	next "removed, but ups"
	next "move dmg by 30<PERCENT>.@"
endc

SuperLuckDesc:
if DEF(_FR_FR)
	db   "Chance de coup"
	next "critique augmentée"
	next "d'un niveau.@"
else
	db   "Critical hit"
	next "chance increased"
	next "by 1 stage.@"
endc

HugePowerDesc:
if DEF(_FR_FR)
	db   "L'ATQ est doublée.@"
else
	db   "ATK is doubled.@"
endc

DrizzleDesc:
if DEF(_FR_FR)
	db   "Invoque la pluie"
	next "en entrant au"
	next "combat.@"
else
	db   "Summon rain upon"
	next "entering battle.@"
endc

SpeedBoostDesc:
if DEF(_FR_FR)
	db   "Booste la VITESSE"
	next "d'un niveau chaque"
	next "tour.@"
else
	db   "SPEED is increased"
	next "by 1 stage after"
	next "each turn.@"
endc

ShadowTagDesc:
if DEF(_FR_FR)
	db   "Empêche l'ennemi"
	next "de fuir.@"
else
	db   "Prevent the foe"
	next "from escaping.@"
endc

SapSipperDesc:
if DEF(_FR_FR)
	db   "Toute capa. PLANTE"
	next "reçue est annulée"
	next "et ▲ ATQ.@"
else
	db   "Negate GRASS moves"
	next "that hit you, and"
	next "gain +1 ATK stage.@"
endc

ImmunityDesc:
if DEF(_FR_FR)
	db   "Immunise contre"
	next "PSN.@"
else
	db   "Immune to PSN.@"
endc

PoisonPointDesc:
if DEF(_FR_FR)
	db   "30<PERCENT> de chance de"
	next "PSN l'ennemi quand"
	next "il vous touche.@"
else
	db   "30<PERCENT> chance to PSN"
	next "the opponent when"
	next "they make contact.@"
endc

MoodyDesc:
if DEF(_FR_FR)
	db   "Chaque tour: +2"
	next "niveaux à une stat"
	next "et -1 à une autre.@"
else
	db   "Each turn, highly"
	next "up a stat & lower"
	next "another at random.@"
endc

SandStreamDesc:
if DEF(_FR_FR)
	db   "Invoque TEMPETE-"
	next "SABLE en entrant"
	next "au combat.@"
else
	db   "Summon a sandstorm"
	next "upon entering"
	next "battle.@"
endc
	