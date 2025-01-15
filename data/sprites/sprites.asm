overworld_sprite: MACRO
; pointer, length, type, palette
	dw \1
	db BANK(\1), \2 tiles, \3, \4
ENDM

OverworldSprites:
; entries correspond to SPRITE_* constants
	table_width NUM_SPRITEDATA_FIELDS, OverworldSprites
	overworld_sprite ChrisSpriteGFX, 12, WALKING_SPRITE, PAL_OW_RED
	overworld_sprite ChrisBikeSpriteGFX, 12, WALKING_SPRITE, PAL_OW_RED
	overworld_sprite GameboyKidSpriteGFX, 12, STANDING_SPRITE, PAL_OW_GREEN
	overworld_sprite SilverSpriteGFX, 12, WALKING_SPRITE, PAL_OW_RED
	overworld_sprite OakSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BROWN
	overworld_sprite RedSpriteGFX, 12, WALKING_SPRITE, PAL_OW_RED
	overworld_sprite BlueSpriteGFX, 12, WALKING_SPRITE, PAL_OW_RED
	overworld_sprite BillSpriteGFX, 12, WALKING_SPRITE, PAL_OW_RED
	overworld_sprite ElderSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BROWN
	overworld_sprite JanineSpriteGFX, 12, WALKING_SPRITE, PAL_OW_RED
	overworld_sprite KurtSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BROWN
	overworld_sprite MomSpriteGFX, 12, WALKING_SPRITE, PAL_OW_RED
	overworld_sprite BlaineSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BROWN
	overworld_sprite RedsMomSpriteGFX, 12, WALKING_SPRITE, PAL_OW_RED
	overworld_sprite DaisySpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite ElmSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BROWN
	overworld_sprite WillSpriteGFX, 12, STANDING_SPRITE, PAL_OW_RED
	overworld_sprite FalknerSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite WhitneySpriteGFX, 12, WALKING_SPRITE, PAL_OW_PINK
	overworld_sprite BugsySpriteGFX, 12, WALKING_SPRITE, PAL_OW_GREEN
	overworld_sprite MortySpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite ChuckSpriteGFX, 12, WALKING_SPRITE, PAL_OW_RED
	overworld_sprite JasmineSpriteGFX, 12, WALKING_SPRITE, PAL_OW_RED
	overworld_sprite PryceSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BROWN
	overworld_sprite ClairSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite BrockSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BROWN
	overworld_sprite KarenSpriteGFX, 12, STANDING_SPRITE, PAL_OW_BLUE
	overworld_sprite BrunoSpriteGFX, 12, WALKING_SPRITE, PAL_OW_RED
	overworld_sprite MistySpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite LanceSpriteGFX, 12, WALKING_SPRITE, PAL_OW_RED
	overworld_sprite SurgeSpriteGFX, 12, WALKING_SPRITE, PAL_OW_GREEN
	overworld_sprite ErikaSpriteGFX, 12, WALKING_SPRITE, PAL_OW_GREEN
	overworld_sprite KogaSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BROWN
	overworld_sprite SabrinaSpriteGFX, 12, WALKING_SPRITE, PAL_OW_RED
	overworld_sprite CooltrainerMSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite CooltrainerFSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite BugCatcherSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite TwinSpriteGFX, 12, WALKING_SPRITE, PAL_OW_RED
	overworld_sprite YoungsterSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite LassSpriteGFX, 12, WALKING_SPRITE, PAL_OW_RED
	overworld_sprite TeacherSpriteGFX, 12, WALKING_SPRITE, PAL_OW_RED
	overworld_sprite BeautySpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite SuperNerdSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite RockerSpriteGFX, 12, WALKING_SPRITE, PAL_OW_GREEN
	overworld_sprite PokefanMSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BROWN
	overworld_sprite PokefanFSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BROWN
	overworld_sprite GrampsSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BROWN
	overworld_sprite GrannySpriteGFX, 12, WALKING_SPRITE, PAL_OW_BROWN
	overworld_sprite SwimmerGuySpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite SwimmerGirlSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite BigSnorlaxSpriteGFX, 12, STANDING_SPRITE, PAL_OW_ROCK ; Purple.
	overworld_sprite SurfingPikachuSpriteGFX, 12, WALKING_SPRITE, PAL_OW_RED
	overworld_sprite RocketSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BROWN
	overworld_sprite RocketGirlSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BROWN
	overworld_sprite NurseSpriteGFX, 12, STANDING_SPRITE, PAL_OW_PINK
	overworld_sprite LinkReceptionistSpriteGFX, 12, WALKING_SPRITE, PAL_OW_RED
	overworld_sprite ClerkSpriteGFX, 12, WALKING_SPRITE, PAL_OW_GREEN
	overworld_sprite FisherSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite FishingGuruSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite ScientistSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite KimonoGirlSpriteGFX, 12, WALKING_SPRITE, PAL_OW_RED
	overworld_sprite SageSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BROWN
	overworld_sprite UnusedGuySpriteGFX, 12, STANDING_SPRITE, PAL_OW_BROWN
	overworld_sprite GentlemanSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite BlackBeltSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BROWN
	overworld_sprite ReceptionistSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite OfficerSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite JennySpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite AgathaSpriteGFX, 4, STILL_SPRITE, PAL_OW_SILVER
	overworld_sprite LoreleiSpriteGFX, 12, WALKING_SPRITE, PAL_OW_RED
	overworld_sprite CalSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BROWN
	overworld_sprite SlowpokeSpriteGFX, 4, STILL_SPRITE, PAL_OW_PINK
	overworld_sprite CaptainSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BROWN
	overworld_sprite BigLaprasSpriteGFX, 12, STANDING_SPRITE, PAL_OW_BLUE
	overworld_sprite GymGuideSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite SailorSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite BikerSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BROWN
	overworld_sprite PharmacistSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite MonsterSpriteGFX, 12, WALKING_SPRITE, PAL_OW_PINK
	overworld_sprite FairySpriteGFX, 12, WALKING_SPRITE, PAL_OW_PINK
	overworld_sprite BirdSpriteGFX, 12, WALKING_SPRITE, PAL_OW_RED
	overworld_sprite DragonSpriteGFX, 12, WALKING_SPRITE, PAL_OW_RED
	overworld_sprite BigOnixSpriteGFX, 12, STANDING_SPRITE, PAL_OW_PINK ; Silver
	overworld_sprite N64SpriteGFX, 4, STILL_SPRITE, PAL_OW_BLUE
	overworld_sprite SudowoodoSpriteGFX, 12, STANDING_SPRITE, PAL_OW_GREEN
	overworld_sprite SurfSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite PokeBallSpriteGFX, 4, STILL_SPRITE, PAL_OW_RED
	overworld_sprite PokedexSpriteGFX, 4, STILL_SPRITE, PAL_OW_BROWN
	overworld_sprite PaperSpriteGFX, 4, STILL_SPRITE, PAL_OW_BLUE
	overworld_sprite VirtualBoySpriteGFX, 4, STILL_SPRITE, PAL_OW_RED
	overworld_sprite ShineSpriteGFX, 12, STANDING_SPRITE, PAL_OW_SILVER
	overworld_sprite InvisibleWallSpriteGFX, 4, STILL_SPRITE, PAL_OW_RED
	overworld_sprite RockSpriteGFX, 4, STILL_SPRITE, PAL_OW_ROCK
	overworld_sprite BoulderSpriteGFX, 4, STILL_SPRITE, PAL_OW_ROCK
	overworld_sprite SnesSpriteGFX, 4, STILL_SPRITE, PAL_OW_BLUE
	overworld_sprite FamicomSpriteGFX, 4, STILL_SPRITE, PAL_OW_RED
	overworld_sprite ConeSpriteGFX, 4, STILL_SPRITE, PAL_OW_RED
	overworld_sprite FruitTreeSpriteGFX, 4, STILL_SPRITE, PAL_OW_TREE
	overworld_sprite GoldTrophySpriteGFX, 4, STILL_SPRITE, PAL_OW_BROWN
	overworld_sprite SilverTrophySpriteGFX, 4, STILL_SPRITE, PAL_OW_SILVER
	overworld_sprite KrisSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite KrisBikeSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	overworld_sprite SuicuneSpriteGFX, 4, STILL_SPRITE, PAL_OW_BLUE
	overworld_sprite EnteiSpriteGFX, 4, STILL_SPRITE, PAL_OW_RED
	overworld_sprite RaikouSpriteGFX, 4, STILL_SPRITE, PAL_OW_PINK
	overworld_sprite SquirtleSquadSpriteGFX, 8, POKEMON_SPRITE, PAL_OW_BLUE
	overworld_sprite OldAmberSpriteGFX, 4, STILL_SPRITE, PAL_OW_RED
	overworld_sprite MewtwoOwTopSpriteGFX, 4, STILL_SPRITE, PAL_OW_PINK
	overworld_sprite MewtwoOwBottomSpriteGFX, 4, STILL_SPRITE, PAL_OW_PINK
	overworld_sprite WalkingPikachuSpriteGFX, 12, WALKING_SPRITE, PAL_OW_PINK
	overworld_sprite ChrisClapSpriteGFX, 12, WALKING_SPRITE, PAL_OW_RED
	overworld_sprite KrisClapSpriteGFX, 12, WALKING_SPRITE, PAL_OW_BLUE
	assert_table_length NUM_OVERWORLD_SPRITES

ClappingOverworldSprites:
	table_width 3, ClappingOverworldSprites
	dab ChrisSpriteGFX
	dab ChrisBikeSpriteGFX
	dab GameboyKidSpriteGFX
	dab SilverSpriteGFX
	dab OakSpriteGFX
	dab RedSpriteGFX
	dab BlueSpriteGFX
	dab BillSpriteGFX
	dab ElderSpriteGFX
	dab JanineSpriteGFX
	dab KurtSpriteGFX
	dab MomSpriteGFX
	dab BlaineSpriteGFX
	dab RedsMomSpriteGFX
	dab DaisySpriteGFX
	dab ElmSpriteGFX
	dab WillSpriteGFX
	dab FalknerSpriteGFX
	dab WhitneySpriteGFX
	dab BugsySpriteGFX
	dab MortySpriteGFX
	dab ChuckSpriteGFX
	dab JasmineSpriteGFX
	dab PryceSpriteGFX
	dab ClairSpriteGFX
	dab BrockSpriteGFX
	dab KarenSpriteGFX
	dab BrunoSpriteGFX
	dab MistySpriteGFX
	dab LanceSpriteGFX
	dab SurgeSpriteGFX
	dab ErikaSpriteGFX
	dab KogaSpriteGFX
	dab SabrinaSpriteGFX
	dab CooltrainerMSpriteGFX_Clap
	dab CooltrainerFSpriteGFX_Clap
	dab BugCatcherSpriteGFX_Clap
	dab TwinSpriteGFX_Clap
	dab YoungsterSpriteGFX_Clap
	dab LassSpriteGFX_Clap
	dab TeacherSpriteGFX_Clap
	dab BeautySpriteGFX
	dab SuperNerdSpriteGFX_Clap
	dab RockerSpriteGFX
	dab PokefanMSpriteGFX_Clap
	dab PokefanFSpriteGFX_Clap
	dab GrampsSpriteGFX_Clap
	dab GrannySpriteGFX_Clap
	dab SwimmerGuySpriteGFX
	dab SwimmerGirlSpriteGFX
	dab BigSnorlaxSpriteGFX
	dab SurfingPikachuSpriteGFX
	dab RocketSpriteGFX
	dab RocketGirlSpriteGFX
	dab NurseSpriteGFX
	dab LinkReceptionistSpriteGFX
	dab ClerkSpriteGFX_Clap
	dab FisherSpriteGFX_Clap
	dab FishingGuruSpriteGFX_Clap
	dab ScientistSpriteGFX
	dab KimonoGirlSpriteGFX
	dab SageSpriteGFX
	dab UnusedGuySpriteGFX
	dab GentlemanSpriteGFX_Clap
	dab BlackBeltSpriteGFX_Clap
	dab ReceptionistSpriteGFX_Clap
	dab OfficerSpriteGFX
	dab JennySpriteGFX
	dab AgathaSpriteGFX
	dab LoreleiSpriteGFX
	dab CalSpriteGFX
	dab SlowpokeSpriteGFX
	dab CaptainSpriteGFX
	dab BigLaprasSpriteGFX
	dab GymGuideSpriteGFX
	dab SailorSpriteGFX
	dab BikerSpriteGFX
	dab PharmacistSpriteGFX
	dab MonsterSpriteGFX
	dab FairySpriteGFX
	dab BirdSpriteGFX
	dab DragonSpriteGFX
	dab BigOnixSpriteGFX
	dab N64SpriteGFX
	dab SudowoodoSpriteGFX
	dab SurfSpriteGFX
	dab PokeBallSpriteGFX
	dab PokedexSpriteGFX
	dab PaperSpriteGFX
	dab VirtualBoySpriteGFX
	dab ShineSpriteGFX
	dab InvisibleWallSpriteGFX
	dab RockSpriteGFX
	dab BoulderSpriteGFX
	dab SnesSpriteGFX
	dab FamicomSpriteGFX
	dab ConeSpriteGFX
	dab FruitTreeSpriteGFX
	dab GoldTrophySpriteGFX
	dab SilverTrophySpriteGFX
	dab KrisSpriteGFX
	dab KrisBikeSpriteGFX
	dab SuicuneSpriteGFX
	dab EnteiSpriteGFX
	dab RaikouSpriteGFX
	dab SquirtleSquadSpriteGFX
	dab OldAmberSpriteGFX
	dab MewtwoOwTopSpriteGFX
	dab MewtwoOwBottomSpriteGFX
	dab WalkingPikachuSpriteGFX
	dab ChrisClapSpriteGFX
	dab KrisClapSpriteGFX
	assert_table_length NUM_OVERWORLD_SPRITES
