Scriptname USSEPRetroactive435Script extends Quest  

Quest Property MQ101 Auto
USSEP_VersionTrackingScript Property USSEPTracking Auto
USSEPRetroactive436Script Property Retro436 Auto

Actor Property AlesanRef Auto
MiscObject Property BasketCarry Auto
int baskets

Quest Property dunPOITundraMarshDogQST Auto
Actor Property MeekoRef Auto

Function Process()
	;Abort this if chargen is not sufficiently advanced. We do not have any bugfixes for the cart ride scene in Helgen.
	if( MQ101.GetStage() < 70 )
		debug.trace( "USSEP 4.3.5 Retroactive Updates Complete" )
		USSEPTracking.LastVersion = 435
		Retro436.Process()
		Stop()
		Return
	EndIf

	;Bug #35201 - Alesan's inventory is swollen with baskets he never uses for anything.
	baskets = AlesanRef.GetItemCount( BasketCarry )
	AlesanRef.RemoveItem( BasketCarry, baskets )

	;Bug #35189 - Meeko's corpse never cleans up after he dies.
	if( MeekoRef.IsDead() )
		dunPOITundraMarshDogQST.Stop()
	endif

	debug.trace( "USSEP 4.3.5 Retroactive Updates Complete" )
	USSEPTracking.LastVersion = 435
	Retro436.Process()
	Stop()
EndFunction
