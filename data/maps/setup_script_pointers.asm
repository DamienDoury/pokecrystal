add_mapsetup: MACRO
\1_MapSetupCmd:
	dba \1
ENDM

MapSetupCommands:
	add_mapsetup EnableLCD ; 00
	add_mapsetup DisableLCD ; 01
	add_mapsetup InitSound ; 02
	add_mapsetup PlayMapMusic ; 03
	add_mapsetup RestartMapMusic ; 04
	add_mapsetup FadeToMapMusic ; 05
	add_mapsetup FadeMapMusicAndPalettes ; 06
	add_mapsetup PlayMapMusicBike ; 07
	add_mapsetup ForceMapMusic ; 08
	add_mapsetup FadeInToMusic ; 09
	add_mapsetup LoadBlockData ; 0a (callback 1)
	add_mapsetup LoadConnectionBlockData ; 0b
	add_mapsetup SaveScreen ; 0c
	add_mapsetup BufferScreen ; 0d
	add_mapsetup LoadMapGraphics ; 0e
	add_mapsetup LoadMapTileset ; 0f
	add_mapsetup LoadMapTimeOfDay ; 10
	add_mapsetup LoadMapPalettes ; 11
	add_mapsetup LoadWildMonData ; 12
	add_mapsetup RefreshMapSprites ; 13
	add_mapsetup RefreshPolice ; 14 added by Damien
	add_mapsetup HandleNewMap ; 15
	add_mapsetup HandleContinueMap ; 16
	add_mapsetup LoadMapObjects ; 17
	add_mapsetup EnterMapSpawnPoint ; 18
	add_mapsetup EnterMapConnection ; 19
	add_mapsetup EnterMapWarp ; 1a
	add_mapsetup LoadMapAttributes ; 1b
	add_mapsetup LoadMapAttributes_SkipObjects ; 1c
	add_mapsetup ClearBGPalettes ; 1d
	add_mapsetup FadeOutPalettes ; 1e
	add_mapsetup FadeInPalettes ; 1f
	add_mapsetup GetMapScreenCoords ; 20
	add_mapsetup GetWarpDestCoords ; 21
	add_mapsetup SpawnInFacingDown ; 22
	add_mapsetup SpawnPlayer ; 23
	add_mapsetup RefreshPlayerCoords ; 24
	add_mapsetup ResetPlayerObjectAction ; 25
	add_mapsetup SkipUpdateMapSprites ; 26
	add_mapsetup UpdateRoamMons ; 27
	add_mapsetup JumpRoamMons ; 28
	add_mapsetup FadeOutMapMusic ; 29
	add_mapsetup ActivateMapAnims ; 2a
	add_mapsetup SuspendMapAnims ; 2b
	add_mapsetup ApplyMapPalettes ; 2c
	add_mapsetup EnableTextAcceleration ; 2d
	add_mapsetup InitMapNameSign ; 2e
