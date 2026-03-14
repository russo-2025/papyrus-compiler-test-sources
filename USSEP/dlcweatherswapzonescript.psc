Scriptname DLCWeatherSwapZoneSCRIPT extends ObjectReference  
{Changes the weather when you are in this trigger.}

Import Weather

Weather property WeatherForm auto
{The name of the Weather we will see while in the triggr box, if we have one.}


int Property timeLimit = 10000 Auto
{Time to wait before auto releasing the weather.}
Int InTrigger = 0 ;USSEP 4.3.7 Bug #35773 - Added for proper thread safety.

;===============================================

	EVENT ONTRIGGERENTER(ObjectReference akActionRef)
		if (InTrigger == 0)
			if (akActionRef == game.getPlayer() as ObjectReference)	;Should be expanded to include all actors
				InTrigger += 1
				WeatherForm.SetActive(True,True)
			endif
		endif
	endEvent

	EVENT OnTriggerLeave(ObjectReference akActionRef)
		if (InTrigger > 0)
			if (akActionRef == game.getPlayer() as ObjectReference)
				ReleaseOverride()
				InTrigger -= 1
			endif
		endif
	ENDEVENT
	
	EVENT OnUnLoad()
		InTrigger = 0  ;reset since we're unloading entirely 
		ReleaseOverride()
	ENDEVENT
	
