Scriptname USSEPRetroactive429Script extends Quest  

Quest Property MQ101 Auto
USSEP_VersionTrackingScript Property USSEPTracking Auto
USSEPRetroactive430Script Property Retro430 Auto

Quest Property MS11 Auto
ReferenceAlias Property Tova Auto
ReferenceAlias Property USKPHjerimReplacementKey Auto

Quest Property DLC2SV02 Auto
Quest Property DLC2SV02AncarionMerchant Auto
Faction Property DLC2AncarionServicesFaction Auto
Actor Property Ancarion Auto

Quest Property dunFrostmereCryptQST Auto
ReferenceAlias Property Eisa Auto

Quest Property ccBGSSSE001_MiscQuests Auto
Quest Property ccBGSSSE001_Misc_Dwarven Auto
ObjectReference Property SpiderAmbushRef Auto

Quest Property BQ01 Auto
Quest Property dunNilheimQST Auto
LocationAlias Property NilheimReservation Auto
Location Property NilheimLocation Auto
Keyword Property BQActiveQuest Auto
LocationAlias Property BQ01Location Auto

CaravanScript Property Caravans Auto

Function Process()
	;Abort this if chargen is not sufficiently advanced. We do not have any bugfixes for the cart ride scene in Helgen.
	if( MQ101.GetStage() < 70 )
		debug.trace( "USSEP 4.2.9 Retroactive Updates Complete" )
		USSEPTracking.LastVersion = 429
		Retro430.Process()
		Stop()
		Return
	EndIf

	if( MS11.IsRunning() )
		if( MS11.GetStage() >= 10 && MS11.GetStage() < 60 )
			if( Tova.GetActorReference().IsDisabled() == 1 )
				USKPHjerimReplacementKey.GetReference().EnableNoWait()
			endif
		endif
	endif

	;Bug #32580 - Fix Ancarion's merchant setup
	if( !DLC2SV02AncarionMerchant.IsRunning() )
		if( Ancarion.IsInFaction( DLC2AncarionServicesFaction ) )
			Ancarion.RemoveFromFaction( DLC2AncarionServicesFaction )
		endif
	else
		if( !Ancarion.IsInFaction( DLC2AncarionServicesFaction ) )
			Ancarion.AddToFaction( DLC2AncarionServicesFaction )
		endif
	endif

	;Bug #32850 - Eisa aggressive at Moorside Inn
	if( dunFrostmereCryptQST.GetStageDone(16) == 1 )
		if( Eisa.GetActorReference() != None )
			Eisa.GetActorReference().SetAV( "Aggression", 1 )
		endif
	endif

	;Bug #32944 - Beneath Bronze Waters start failure due to broken aliases.
	if( ccBGSSSE001_MiscQuests.GetStageDone(85) == 1 )
		if( ccBGSSSE001_Misc_Dwarven.GetStage() < 5 )
			if( !ccBGSSSE001_Misc_Dwarven.IsRunning() )
				ccBGSSSE001_Misc_Dwarven.Start()
			endif
		endif
	endif

	if( ccBGSSSE001_Misc_Dwarven.GetStageDone(300) == 1 )
		SpiderAmbushRef.EnableNoWait()
	endif

	;Bug #32948 - Lock Nilheim out after completing Telrav's Request.
	if( dunNilheimQST.GetStage() > 30 )
		NilheimReservation.ForceLocationTo(NilheimLocation)

		if( BQ01.IsRunning() )
			Location CheckLocation = BQ01Location.GetLocation()

			if( CheckLocation == NilheimLocation )
				if( BQ01.GetStage() < 100 )
					NilheimLocation.setKeywordData( BQActiveQuest, 0 )
					BQ01.Stop()
				endif
			endif
		endif
	endif

	;Bug #32950 - Check all Caravan values and correct them if needed.
	Caravans.CheckArrayInits()

	;Bug #32950 - Fixing an old issue introduced in USKP 1.2.7 where the expected API for Caravan updates was changed without notice.
	if( !Caravans.NumbersFixed )
		Caravans.FixCaravanNumbers()
	endif

	debug.trace( "USSEP 4.2.9 Retroactive Updates Complete" )
	USSEPTracking.LastVersion = 429
	Retro430.Process()
	Stop()
EndFunction
