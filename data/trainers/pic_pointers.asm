; Pics are defined in gfx/pics.asm

TrainerPicPointers::
; entries correspond to trainer classes (see constants/trainer_constants.asm)
	table_width 3, TrainerPicPointers
	dba FalknerPic
	dba WhitneyPic
	dba BugsyPic
	dba MortyPic
	dba PrycePic
	dba JasminePic
	dba ChuckPic
	dba ClairPic
	dba Rival1Pic
	dba PokemonProfPic
	dba WillPic
	dba CalPic
	dba BrunoPic
	dba KarenPic
	dba KogaPic
	dba ChampionPic
	dba BrockPic
	dba MistyPic
	dba LtSurgePic
	dba ScientistPic
	dba ErikaPic
	dba YoungsterPic
	dba SchoolboyPic
	dba BirdKeeperPic
	dba LassPic
	dba JaninePic
	dba CooltrainermPic
	dba CooltrainerfPic
	dba BeautyPic
	dba PokemaniacPic
	dba GruntmPic
	dba GentlemanPic
	dba SkierPic
	dba TeacherPic
	dba SabrinaPic
	dba BugCatcherPic
	dba FisherPic
	dba SwimmermPic
	dba SwimmerfPic
	dba SailorPic
	dba SuperNerdPic
	dba Rival2Pic
	dba GuitaristPic
	dba HikerPic
	dba BikerPic
	dba BlainePic
	dba BurglarPic
	dba FirebreatherPic
	dba JugglerPic
	dba BlackbeltTPic
	dba ExecutivemPic
	dba PsychicTPic
	dba PicnickerPic
	dba CamperPic
	dba ExecutivefPic
	dba SagePic
	dba MediumPic
	dba BoarderPic
	dba PokefanmPic
	dba KimonoGirlPic
	dba TwinsPic
	dba PokefanfPic
	dba NursePic
	dba RedPic
	dba BluePic
	dba OfficerPic
	dba SergeantPic
	dba JennyPic
	dba SwatPic
	dba GruntfPic
	dba LoreleiPic
	dba MysticalmanPic
	assert_table_length NUM_TRAINER_CLASSES

; Those are the only trainers that can be found before all trainer wear a face mask.
; It happens when the first lockdown declaration occurs (EVENT_GOT_HM01_CUT).
TrainerPicPointersNoMask::
; entries correspond to trainer classes minus 21 (see constants/trainer_constants.asm)
	table_width 3, TrainerPicPointersNoMask
	dba YoungsterPicNoMask ;;;;
	dba SchoolboyPic
	dba BirdKeeperPicNoMask ;;;;
	dba LassPic
	dba JaninePic
	dba CooltrainermPic
	dba CooltrainerfPic
	dba BeautyPic
	dba PokemaniacPic
	dba GruntmPic
	dba GentlemanPic
	dba SkierPic
	dba TeacherPic
	dba SabrinaPic
	dba BugCatcherPicNoMask ;;;;
	dba FisherPicNoMask ;;;;
	dba SwimmermPic
	dba SwimmerfPic
	dba SailorPic
	dba SuperNerdPic
	dba Rival2Pic
	dba GuitaristPic
	dba HikerPicNoMask ;;;;
	dba BikerPic
	dba BlainePic
	dba BurglarPic
	dba FirebreatherPicNoMask ;;;;
	dba JugglerPic
	dba BlackbeltTPic
	dba ExecutivemPic
	dba PsychicTPic
	dba PicnickerPicNoMask ;;;;
	dba CamperPicNoMask ;;;;
	dba ExecutivefPic
	dba SagePicNoMask ;;;;
	dba MediumPic
	dba BoarderPic
	dba PokefanmPic
	dba KimonoGirlPic
	dba TwinsPicNoMask ;;;;

BeautyFailedCutPicPointer::
	dba BeautyFailedCutPic