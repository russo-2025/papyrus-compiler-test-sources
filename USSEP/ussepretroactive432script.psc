Scriptname USSEPRetroactive432Script extends Quest  

Quest Property MQ101 Auto
USSEP_VersionTrackingScript Property USSEPTracking Auto
USSEPRetroactive433Script Property Retro433 Auto

Quest Property dunBleakFallsBarrowQST Auto

Function Process()
	;Abort this if chargen is not sufficiently advanced. We do not have any bugfixes for the cart ride scene in Helgen.
	if( MQ101.GetStage() < 70 )
		debug.trace( "USSEP 4.3.2 Retroactive Updates Complete" )
		USSEPTracking.LastVersion = 432
		Retro433.Process()
		Stop()
		Return
	EndIf

	;Bug #15086 - Extra BFB dragon corpse stuck in quest alias forever.
	if( dunBleakFallsBarrowQST.GetStageDone(92) == 1 )
		dunBleakFallsBarrowQST.Stop()
	endif

	debug.trace( "USSEP 4.3.2 Retroactive Updates Complete" )
	USSEPTracking.LastVersion = 432
	Retro433.Process()
	Stop()
EndFunction
