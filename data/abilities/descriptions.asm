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
	db   "No effect.@"
	
ChlorophyllDesc:
	db   "SPEED is doubled"
	next "under the sun.@"
	
SolarPowerDesc:
	db   "×1.5 SP.ATK in the"
	next "sun, but lose 1/8"
	next "max HP per turn.@"
	
RainDishDesc:
	db   "During rain,"
	next "regain 1/16 max"
	next "HP per turn.@"
	
ShieldDustDesc:
	db   "Block the addi-"
	next "tional effects of"
	next "attacks taken.@"
	
ShedSkinDesc:
	db   "Each turn, 1/3"
	next "chance of curing a"
	next "status condition.@"
	
CompoundEyesDesc:
	db   "Moves get a 30<PERCENT>"
	next "accuracy boost.@"
	
SniperDesc:
	db   "Critical hit"
	next "damage increased"
	next "by 50<PERCENT>.@"
	
KeenEyeDesc:
	db   "Accuracy can't"
	next "be reduced.@"
	
RunAwayDesc:
	db   "You can always run"
	next "away from a"
	next "wild #MON.@"
	
IntimidateDesc:
	db   "Lower the foe's"
	next "ATK upon entering"
	next "battle.@"
	
LightningRodDesc:
	db   "Draw in ELECTRIC"
	next "moves to boost"
	next "SP.ATK.@"
	
SandRushDesc:
	db   "SPEED is doubled"
	next "during sandstorms.@"
	
HustleDesc:
	db   "Physical moves get"
	next "×1.5 ATK"
	next "×0.8 ACCURACY.@"
	
CuteCharmDesc:
	db   "30<PERCENT> odds to infa-"
	next "tuate the foe when"
	next "they make contact.@"
	
FlashFireDesc:
	db   "Negate FIRE moves"
	next "and boost yours by"
	next "×1.5 when hit."
	
DroughtDesc:
	db   "Turn the sunlight"
	next "harsh upon"
	next "entering battle.@"
	
InnerFocusDesc:
	db   "Can't flinch.@"
	
StenchDesc:
	db   "10<PERCENT> of making the"
	next "target flinch"
	next "on hit.@"
	
EffectSporeDesc:
	db   "May PRZ, SLP, PSN"
	next "the foe when they"
	next "make contact.@"
	
SandForceDesc:
	db   "+30<PERCENT> dmg to STEEL,"
	next "ROCK, GROUND moves"
	next "under sandstorms.@"
	
PickupDesc:
	db   "Recover used item"
	next "after a battle.@"
	
LimberDesc:
	db   "Prevent PRZ.@"
	
CloudNineDesc:
	db   "Weather effects"
	next "are eliminated.@"
	
DefiantDesc:
	db   "+2 ATK stages each"
	next "time stats are"
	next "lowered.@"
	
SwiftSwimDesc:
	db   "SPEED is doubled"
	next "under the rain.@"
	
SynchronizeDesc:
	db   "Status conditions"
	next "are copied onto"
	next "the opponent.@"
	
GutsDesc:
	db   "+50<PERCENT> ATK when you"
	next "have a status"
	next "condition.@"
	
LiquidOozeDesc:
	db   "Draining you deals"
	next "damage rather than"
	next "heal.@"
	
SturdyDesc:
	db   "Survive One-Hit KO"
	next "with 1 HP.@"
	
FlameBodyDesc:
	db   "30<PERCENT> chance to BRN"
	next "the opponent when"
	next "they make contact.@"
	
OwnTempoDesc:
	db   "Prevent confusion"
	next "and INTIMIDATE.@"
	
EarlyBirdDesc:
	db   "Wake up twice as"
	next "fast, except when"
	next "using REST.@"
	
ThickFatDesc:
	db   "Halve FIRE & ICE"
	next "damage you take.@"
	
ShellArmorDesc:
	db   "Protect from"
	next "critical hits.@"
	
LevitateDesc:
	db   "Immune to GROUND-"
	next "type damage.@"
	
InsomniaDesc:
	db   "Can't be put to"
	next "sleep."
	next "REST fails.@"
	
StaticDesc:
	db   "30<PERCENT> chance to PRZ"
	next "the opponent when"
	next "they make contact.@"
	
HarvestDesc:
	db   "May create another"
	next "Berry after one"
	next "is used.@"
	
RockHeadDesc:
	db   "Can't take recoil"
	next "damage.@"
	
NaturalCureDesc:
	db   "Status condition"
	next "is healed upon"
	next "switching out.@"
	
RegeneratorDesc:
	db   "Regain 1/3 max HP"
	next "upon switching"
	next "out.@"
	
TechnicianDesc:
	db   "Moves with 60 POW"
	next "or less gain +50<PERCENT>"
	next "damage.@"
	
MoxieDesc:
	db   "+1 ATK boost"
	next "after each KO.@"
	
HydrationDesc:
	db   "Status conditions"
	next "are healed under"
	next "the rain.@"
	
ImposterDesc:
	db   "TRANSFORM upon"
	next "entering battle.@"
	
WaterAbsorbDesc:
	db   "WATER-type moves"
	next "hitting you heal"
	next "25<PERCENT> max HP.@"
	
VoltAbsorbDesc:
	db   "ELECTRIC-type"
	next "moves hitting you"
	next "heal 25<PERCENT> max HP.@"
	
TraceDesc:
	db   "Copy the foe's"
	next "ABILITY upon"
	next "entering battle.@"
	
WeakArmorDesc:
	db   "Physical dmg taken"
	next "highly ups SPEED"
	next "but lowers DEF.@"
	
PressureDesc:
	db   "Foes consume twice"
	next "as many PP.@"
	
MultiscaleDesc:
	db   "When at full HP,"
	next "damage taken from"
	next "moves is halved.@"
	
LeafGuardDesc:
	db   "Status conditions"
	next "are healed under"
	next "harsh sunlight.@"
	
SheerForceDesc:
	db   "Added effects"
	next "removed to up"
	next "move dmg by 30<PERCENT>.@"
	
SuperLuckDesc:
	db   "Critical hit"
	next "chance increased"
	next "by 1 stage.@"
	
HugePowerDesc:
	db   "ATK is doubled.@"
	
DrizzleDesc:
	db   "Summon rain upon"
	next "entering battle.@"
	
SpeedBoostDesc:
	db   "SPEED is increased"
	next "by 1 stage after"
	next "each turn.@"
	
ShadowTagDesc:
	db   "Prevent the foe"
	next "from escaping.@"
	
SapSipperDesc:
	db   "Negate GRASS moves"
	next "that hit you, and"
	next "gain +1 ATK stage.@"

ImmunityDesc:
	db   "Immune to PSN.@"
	
PoisonPointDesc:
	db   "30<PERCENT> chance to PSN"
	next "the opponent when"
	next "they make contact.@"
	
MoodyDesc:
	db   "Each turn, highly"
	next "up a stat & lower"
	next "another at random.@"
	
SandStreamDesc:
	db   "Summon a sandstorm"
	next "upon entering"
	next "battle.@"
	