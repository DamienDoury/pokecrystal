	object_const_def
	const BATTLETOWERELEVATOR_RECEPTIONIST

BattleTowerElevator_MapScripts:
	def_scene_scripts
	scene_script .Scene0 ; SCENE_DEFAULT
	scene_script .Scene1 ; SCENE_FINISHED

	def_callbacks

.Scene0:
	prioritysjump .RideElevator
	setscene SCENE_FINISHED
.Scene1:
	end

.RideElevator:
	applymovement PLAYER, MovementData_BattleTowerElevatorPlayerWalksIn
	setval BATTLETOWERACTION_0A
	special BattleTowerAction
	playsound SFX_ELEVATOR
	earthquake 60
	waitsfx
	applymovement BATTLETOWERELEVATOR_RECEPTIONIST, MovementData_BattleTowerElevatorReceptionistExitsElevator
	warpsound
	disappear BATTLETOWERELEVATOR_RECEPTIONIST
	applymovement PLAYER, MovementData_BattleTowerElevatorPlayerExitsElevator
	warpcheck
	end

MovementData_BattleTowerElevatorPlayerWalksIn:
	step UP
	turn_head DOWN
	step_end

BattleTowerElevator_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  1,  3, BATTLE_TOWER_HALLWAY, 1
	warp_event  2,  3, BATTLE_TOWER_HALLWAY, 1

	def_coord_events

	def_bg_events

	def_object_events
	object_event  3,  2, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, ObjectEvent, -1
