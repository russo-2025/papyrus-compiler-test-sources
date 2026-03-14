Scriptname USSEPRetroactive427Script extends Quest  

Quest Property MQ101 Auto
USSEP_VersionTrackingScript Property USSEPTracking Auto
USSEPRetroactive428Script Property Retro428 Auto

;USSEP Bug #32450 - Fix the mess with fix plaques caused by bad copypasta in the references in the HF houses.
;And now we'll just remove all of this since BGS fixed it themselves with 1.6.629. (we hope)

Function Process()

	;Abort this if chargen is not sufficiently advanced. We do not have any bugfixes for the cart ride scene in Helgen.
	if( MQ101.GetStage() < 70 )
		debug.trace( "USSEP 4.2.7 Retroactive Updates Complete" )
		USSEPTracking.LastVersion = 427
		Retro428.Process()
		Stop()
		Return
	EndIf

	debug.trace( "USSEP 4.2.7 Retroactive Updates Complete" )
	USSEPTracking.LastVersion = 427
	Retro428.Process()
	Stop()
EndFunction
