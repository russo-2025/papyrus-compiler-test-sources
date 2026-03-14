Scriptname UDGP_Retroactive124Script extends Quest  

Quest Property MQ101 Auto
UDGP_VersionTrackingScript Property UDGPTracking Auto
UDGP_Retroactive200Script Property Retro200 Auto

Function Process()
	;Abort this if chargen is not sufficiently advanced. We do not have any bugfixes for the cart ride scene in Helgen.
	if( MQ101.GetStage() < 70 )
		debug.trace( "UDGP 1.2.4 Retroactive Updates Complete" )
		UDGPTracking.LastVersion = 124
		Retro200.Process()
		Stop()
		Return
	EndIf

	debug.trace( "UDGP 1.2.4 Retroactive Updates Complete" )
	UDGPTracking.LastVersion = 124
	Retro200.Process()
	Stop()
EndFunction
