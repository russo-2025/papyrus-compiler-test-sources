Scriptname USSEPRetroactive436Script extends Quest  

Quest Property MQ101 Auto
USSEP_VersionTrackingScript Property USSEPTracking Auto
USSEPRetroactive437Script Property Retro437 Auto

RelationshipMarriageSpouseHouseScript Property RelationshipMarriageFIN Auto
Quest Property BYOHRelationshipAdoption Auto
LocationAlias Property CurrentMarriageHouse Auto
ReferenceAlias Property LoveInterest Auto

Function Process()
	;Abort this if chargen is not sufficiently advanced. We do not have any bugfixes for the cart ride scene in Helgen.
	if( MQ101.GetStage() < 70 )
		debug.trace( "USSEP 4.3.6 Retroactive Updates Complete" )
		USSEPTracking.LastVersion = 436
		Retro437.Process()
		Stop()
		Return
	EndIf

	;Bug #35664 - This alias on the marriage quest is never filled but is used in the Lover's Comfort benefit.
	if( RelationshipMarriageFIN.IsRunning() )
		if( LoveInterest.GetReference() != None )
			Location HomeLoc = (BYOHRelationshipAdoption as BYOHRelationshipAdoptionScript).TranslateHouseIntToLoc(RelationshipMarriageFIN.SpouseCurrentHome)

			if( HomeLoc != None )
				CurrentMarriageHouse.ForceLocationTo( HomeLoc )
			endif
		endif
	endif

	debug.trace( "USSEP 4.3.6 Retroactive Updates Complete" )
	USSEPTracking.LastVersion = 436
	Retro437.Process()
	Stop()
EndFunction
