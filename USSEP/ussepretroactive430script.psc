Scriptname USSEPRetroactive430Script extends Quest  

Quest Property MQ101 Auto
USSEP_VersionTrackingScript Property USSEPTracking Auto
USSEPRetroactive432Script Property Retro432 Auto

ReferenceAlias Property Hadvar Auto
ReferenceAlias Property Ralof Auto
ReferenceAlias Property HadvarQuest Auto
ReferenceAlias Property RalofQuest Auto
Quest Property CW02A Auto
Quest Property CW02B Auto
Quest Property CW03 Auto
Faction Property CWImperialFactionNPC Auto
Outfit Property HadvarOutfit Auto
Faction Property CWSonsFactionNPC Auto
Weapon Property IronWarhammer Auto
Outfit Property RalofOutfit Auto
Faction Property CWBuddies Auto

Formlist Property BYOHRelationshipAdoptionPlayerGiftChildFemale Auto
Formlist Property BYOHRelationshipAdoptionPlayerGiftChildMale Auto
Weapon Property ccBGSSSE001_DraugrDagger Auto
Weapon Property ccBGSSSE001_ArtifactArgonianDagger Auto
Weapon Property ccBGSSSE001_NordHeroDagger Auto
Weapon Property ccBGSSSE025_GoldenSaintDagger Auto
Weapon Property ccBGSSSE025_DarkSeducerDagger Auto
Weapon Property ccBGSSSE025_AmberDagger Auto
Weapon Property ccBGSSSE025_MadnessDagger Auto

Function Process()
	;Bug #33100 - Add DLC daggers to gift formlists. Might look messy but this is the proper and safe way to do this.
	;First - the girls
	if( !BYOHRelationshipAdoptionPlayerGiftChildFemale.HasForm(ccBGSSSE001_DraugrDagger) )
		BYOHRelationshipAdoptionPlayerGiftChildFemale.AddForm(ccBGSSSE001_DraugrDagger)
	endif

	if( !BYOHRelationshipAdoptionPlayerGiftChildFemale.HasForm(ccBGSSSE001_ArtifactArgonianDagger) )
		BYOHRelationshipAdoptionPlayerGiftChildFemale.AddForm(ccBGSSSE001_ArtifactArgonianDagger)
	endif

	if( !BYOHRelationshipAdoptionPlayerGiftChildFemale.HasForm(ccBGSSSE001_NordHeroDagger) )
		BYOHRelationshipAdoptionPlayerGiftChildFemale.AddForm(ccBGSSSE001_NordHeroDagger)
	endif

	if( !BYOHRelationshipAdoptionPlayerGiftChildFemale.HasForm(ccBGSSSE025_GoldenSaintDagger) )
		BYOHRelationshipAdoptionPlayerGiftChildFemale.AddForm(ccBGSSSE025_GoldenSaintDagger)
	endif

	if( !BYOHRelationshipAdoptionPlayerGiftChildFemale.HasForm(ccBGSSSE025_DarkSeducerDagger) )
		BYOHRelationshipAdoptionPlayerGiftChildFemale.AddForm(ccBGSSSE025_DarkSeducerDagger)
	endif

	if( !BYOHRelationshipAdoptionPlayerGiftChildFemale.HasForm(ccBGSSSE025_AmberDagger) )
		BYOHRelationshipAdoptionPlayerGiftChildFemale.AddForm(ccBGSSSE025_AmberDagger)
	endif

	if( !BYOHRelationshipAdoptionPlayerGiftChildFemale.HasForm(ccBGSSSE025_MadnessDagger) )
		BYOHRelationshipAdoptionPlayerGiftChildFemale.AddForm(ccBGSSSE025_MadnessDagger)
	endif

	;And now the boys
	if( !BYOHRelationshipAdoptionPlayerGiftChildMale.HasForm(ccBGSSSE001_DraugrDagger) )
		BYOHRelationshipAdoptionPlayerGiftChildMale.AddForm(ccBGSSSE001_DraugrDagger)
	endif

	if( !BYOHRelationshipAdoptionPlayerGiftChildMale.HasForm(ccBGSSSE001_ArtifactArgonianDagger) )
		BYOHRelationshipAdoptionPlayerGiftChildMale.AddForm(ccBGSSSE001_ArtifactArgonianDagger)
	endif

	if( !BYOHRelationshipAdoptionPlayerGiftChildMale.HasForm(ccBGSSSE001_NordHeroDagger) )
		BYOHRelationshipAdoptionPlayerGiftChildMale.AddForm(ccBGSSSE001_NordHeroDagger)
	endif

	if( !BYOHRelationshipAdoptionPlayerGiftChildMale.HasForm(ccBGSSSE025_GoldenSaintDagger) )
		BYOHRelationshipAdoptionPlayerGiftChildMale.AddForm(ccBGSSSE025_GoldenSaintDagger)
	endif

	if( !BYOHRelationshipAdoptionPlayerGiftChildMale.HasForm(ccBGSSSE025_DarkSeducerDagger) )
		BYOHRelationshipAdoptionPlayerGiftChildMale.AddForm(ccBGSSSE025_DarkSeducerDagger)
	endif

	if( !BYOHRelationshipAdoptionPlayerGiftChildMale.HasForm(ccBGSSSE025_AmberDagger) )
		BYOHRelationshipAdoptionPlayerGiftChildMale.AddForm(ccBGSSSE025_AmberDagger)
	endif

	if( !BYOHRelationshipAdoptionPlayerGiftChildMale.HasForm(ccBGSSSE025_MadnessDagger) )
		BYOHRelationshipAdoptionPlayerGiftChildMale.AddForm(ccBGSSSE025_MadnessDagger)
	endif

	;Abort this if chargen is not sufficiently advanced. We do not have any bugfixes for the cart ride scene in Helgen.
	if( MQ101.GetStage() < 70 )
		debug.trace( "USSEP 4.3.0 Retroactive Updates Complete" )
		USSEPTracking.LastVersion = 430
		Retro432.Process()
		Stop()
		Return
	EndIf

	;Bug #33002 - Hadvar and Ralof do not properly enable if the player switches sides between Helgen and Jagged Crown.
	Actor HadvarRef = Hadvar.GetActorReference()

	if( HadvarRef != None )
		if( CW02A.IsRunning() )
			HadvarQuest.ForceRefTo(HadvarRef)
		endif

		if( CW02A.GetStageDone(30) == 1 )
			if( HadvarRef.IsDisabled() )
				HadvarRef.EnableNoWait()
				HadvarRef.AddToFaction(CWImperialFactionNPC)
				HadvarRef.SetActorValue("Aggression", 1)
				HadvarRef.SetOutfit(HadvarOutfit)

				if( CW02A.GetStageDone(180) == 1 )
					HadvarRef.AddToFaction(CWBuddies)
				endif

				HadvarRef.EvaluatePackage()
			endif
		endif
	endif

	Actor RalofRef = Ralof.GetActorReference()

	if( RalofRef != None )
		if( CW02B.IsRunning() )
			RalofQuest.ForceRefTo(RalofRef)
		endif

		if( CW02B.GetStageDone(30) == 1 )
			if( RalofRef.IsDisabled() )
				RalofRef.EnableNoWait()
				RalofRef.AddToFaction(CWSonsFactionNPC)
				RalofRef.SetActorValue("Aggression", 1)
				RalofRef.AddItem(IronWarhammer, 1)
				RalofRef.SetOutfit(RalofOutfit)

				if( CW02B.GetStageDone(180) == 1 )
					RalofRef.AddToFaction(CWBuddies)
				endif

				RalofRef.EvaluatePackage()
			endif
		endif
	endif

	HadvarRef = None
	RalofRef = None

	debug.trace( "USSEP 4.3.0 Retroactive Updates Complete" )
	USSEPTracking.LastVersion = 430
	Retro432.Process()
	Stop()
EndFunction
