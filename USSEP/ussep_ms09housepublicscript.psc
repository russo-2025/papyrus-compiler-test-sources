Scriptname USSEP_MS09HousePublicScript extends ObjectReference  
{This script will set Fralia's house to public during the stages of MS09 where it is necessary to come and go at will.}

Quest Property MS09 Auto
Cell Property HouseGreyMane Auto
ObjectReference Property HouseDoor Auto
ObjectReference Property HouseDoor2 Auto

Event OnTriggerEnter( ObjectReference akActionRef )
	if( MS09.GetStage() >= 10 && MS09.GetStage() < 200 )
		if( akActionRef == Game.GetPlayer() )
			HouseGreyMane.SetPublic(true)
			HouseDoor.Lock(False)
			HouseDoor2.Lock(False)
		endif
	endif
EndEvent
