Scriptname USSEPRetroactive437Script extends Quest

Quest Property MQ101 Auto
USSEP_VersionTrackingScript Property USSEPTracking Auto

Quest Property DBOlavaReadingTreasureObjective Auto

ActorBase Property Lami Auto
ActorBase Property Ahlam Auto
ActorBase Property HerluinLothaire Auto
FormList Property ccBGSSSE001_RadiantAlchemists Auto

Quest Property TG07 Auto
ReferenceAlias Property MercerPlans Auto

Function Process()
	;Bug #34116 - Add the two missing vanilla Alchemists to the radiant list for "Further Study"
	if( !ccBGSSSE001_RadiantAlchemists.HasForm(Lami) )
		ccBGSSSE001_RadiantAlchemists.AddForm(Lami)
	endif
	if( !ccBGSSSE001_RadiantAlchemists.HasForm(Ahlam) )
		ccBGSSSE001_RadiantAlchemists.AddForm(Ahlam)
	endif
	;Also add the Alchemist that comes with Thieves Guild stage 2
	if( !ccBGSSSE001_RadiantAlchemists.HasForm(HerluinLothaire) )
		ccBGSSSE001_RadiantAlchemists.AddForm(HerluinLothaire)
	endif

	;Abort this if chargen is not sufficiently advanced. We do not have any bugfixes for the cart ride scene in Helgen.
	if( MQ101.GetStage() < 70 )
		debug.trace( "USSEP 4.3.7 Retroactive Updates Complete" )
		USSEPTracking.LastVersion = 437
		Stop()
		Return
	EndIf

	;Bug #35796 - Ancient Assassin quest needs to be running if it hasn't been started. Otherwise the corpse gets culled.
	if( !DBOlavaReadingTreasureObjective.IsRunning() && DBOlavaReadingTreasureObjective.GetStage() == 0 )
		DBOlavaReadingTreasureObjective.Start()
	endif

	;Bug #36238 - Enable Mercer's Plans if TG07 is running and already at Stage 50.
	if( TG07.IsRunning() && TG07.GetStage() >= 50 )
		MercerPlans.GetReference().EnableNoWait()
	endif

	debug.trace( "USSEP 4.3.7 Retroactive Updates Complete" )
	USSEPTracking.LastVersion = 437
	Stop()
EndFunction
