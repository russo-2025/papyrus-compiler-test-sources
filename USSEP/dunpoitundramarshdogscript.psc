Scriptname dunPOITundraMarshDogSCRIPT extends Actor  

Quest Property myQuest  Auto  

int Property myStage  Auto  

int distanceCheck = 2500
bool breakLoop

EVENT onLoad()      
	UpdateLoop()																; This script will update every (2) seconds
endEVENT
 
EVENT onUnload()
	breakLoop = True
endEVENT
 
Function UpdateLoop()		
	While (myQuest.GetStage() < myStage && !breakLoop)
		if (getDistance(game.getplayer()) <= distanceCheck)
			myQuest.setStage(myStage)	
		EndIf
		Utility.Wait(2)
	EndWhile
	breakLoop = False
EndFunction

;USSEP 4.3.5 Bug #35189
Event OnDeath( Actor akKiller )
	myQuest.Stop()
EndEvent
