	object_const_def

GoldenrodHospitalRoom_MapScripts:
	def_scene_scripts

	def_callbacks

GoldenrodHospitalRoomMedicineScript:
	jumptext GoldenrodHospitalRoomMedicineText

GoldenrodHospitalRoomMedicineText:
	text "Lots of different"
	line "medications."
	done

GoldenrodHospitalRoom_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  2,  9, DYNAMIC_WARP_PREVIOUS ; Sends back into the corridor, where we entered.
	warp_event  3,  9, DYNAMIC_WARP_PREVIOUS ; Sends back into the corridor, where we entered.

	def_coord_events

	def_bg_events
	bg_event  2,  3, BGEVENT_READ, GoldenrodHospitalRoomMedicineScript
	bg_event  3,  3, BGEVENT_READ, GoldenrodHospitalRoomMedicineScript

	def_object_events

; 0: talk to guy on route 35 -> 1
; "This #MON is really sick and needs immediate care. Go find the CHIEF NURSE and bring her here now! At this time, she must be at the HOSPITAL."
; 1: accueil -> 2
; "Chief Nurse? I haven't seen her in a while, she must be into her office. That's the door behind me, next to the waiting room."
; 2: check office -> 3
; 3: accueil -> 4
; "If she isn't in her office, she must be doing her round in the patients rooms. Good luck finding her."
; 1 to 4: room 17 -> 5
; 1 to 4: room 1 -> 5
; "I saw her move to the next corridor on the right."
; 5: top rooms -> 6
; "I just crossed her in the corridor when coming from room 11."
; 6: room 10 -> 7
; "She told me she had to go urgently in room 30-something."
; 7: room 31 -> 8
; "She left like 10 seconds ago."
; 8: man in the corridor next to room 31 -> 9
; "I just saw the CHIEF NURSE! She was going straight towards the Reception."
; 9: man in the south of corridor 1 -> 10
; "CHIEF NURSE? She's here, she just stopped into room 18".
; 10: Nurse battle.
; Movement: nurse comes out of Room 18.
; "I'm sooo stressed! I can't take it, there's too much work on my plate. I'm about to burn out! I need to relax. I know, YOU trainer, come here."
; "Woooo. (deep breath). Thanks for the battle, I'm feeling better now."
; "What are you telling me? This person is on ROUTE 35? I need to hurry now! Please come back later, if you want to talk."

; "I'm on break. Let's have a battle! Scientist."		"I better get back to work."
; "I'm not allowed to leave this room, I'm missing #MON battles so much! Pokefan_F" 		"Couldn't you let a sick person win?"
; "You have nothing to do in this room, GET OUT! Rocker" 		"Ok, I'll cool it."
; "I've been waiting here forever... PSYCHIC_T" "Waiting felt better."
; "Welcome to my humble house. Please be my guest. GENTLEMAN" 	"Be nice to your uncle, RILEY!" 		"My husband is delirious because of the fever."
; "Let me check your Pokémon."		"I admit I baited you into a battle."
; "I'm doing a show for the sick kids. JUGGLER"		"You ruined the show!"
; "A good battle should entertain my daugther. MONTAGNARD" 		"Was it entertaining?"
