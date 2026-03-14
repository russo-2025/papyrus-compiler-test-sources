Scriptname USSEPRetroactive426Script extends Quest  

Quest Property MQ101 Auto
USSEP_VersionTrackingScript Property USSEPTracking Auto
USSEPRetroactive427Script Property Retro427 Auto

Quest Property MG05 Auto
Quest Property MG07 Auto

Function Process()

	;Abort this if chargen is not sufficiently advanced. We do not have any bugfixes for the cart ride scene in Helgen.
	if( MQ101.GetStage() < 70 )
		debug.trace( "USSEP 4.2.6 Retroactive Updates Complete" )
		USSEPTracking.LastVersion = 426
		Retro427.Process()
		Stop()
		Return
	EndIf

	;MG07 will not start if Faralda or Arniel have been disabled.
	if( MG05.GetStage() == 200 && MG07.GetStage() < 10 )
		MG07.Start()
	endif

	debug.trace( "USSEP 4.2.6 Retroactive Updates Complete" )
	USSEPTracking.LastVersion = 426
	Retro427.Process()
	Stop()
EndFunction
