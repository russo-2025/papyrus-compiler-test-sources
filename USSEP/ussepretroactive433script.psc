Scriptname USSEPRetroactive433Script extends Quest  

Quest Property MQ101 Auto
USSEP_VersionTrackingScript Property USSEPTracking Auto
USSEPRetroactive435Script Property Retro435 Auto

ccBGSSSE001_FishTankContainerScript Property FisheryTank1 Auto
QF_ccBGSSSE001_Fish_MQ2_050009EB Property FishQuest Auto
Ingredient Property Pearlfish Auto
Ingredient Property Spadefish Auto

Function Process()
	;Abort this if chargen is not sufficiently advanced. We do not have any bugfixes for the cart ride scene in Helgen.
	if( MQ101.GetStage() < 70 )
		debug.trace( "USSEP 4.3.3 Retroactive Updates Complete" )
		USSEPTracking.LastVersion = 434
		Retro435.Process()
		Stop()
		Return
	EndIf

	;Bug #34297 - Fishing MQ2 missing property for fish tank.
	FishQuest.fishTank = FisheryTank1
	;Now check to see if the quest is done, if so, add the missing fish.
	if( FishQuest.GetStage() >= 200 )
		FisheryTank1.AddFish( Spadefish, 1 )
		FisheryTank1.AddFish( Pearlfish, 1 )
		FisheryTank1.UpdateFish()
	endif

	debug.trace( "USSEP 4.3.3 Retroactive Updates Complete" )
	USSEPTracking.LastVersion = 434
	Retro435.Process()
	Stop()
EndFunction
