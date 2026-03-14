Scriptname USSEP_ImpButton01Script extends ObjectReference  

sound property QSTAstrolabeButtonPressX auto

Event OnActivate( ObjectReference akActionRef )
	PlayGamebryoAnimation("Activate", true)
	QSTAstrolabeButtonPressX.play(akActionRef)
EndEvent
