Scriptname USSEPCR05FixTriggerScript extends ObjectReference  
{USSEP 4.3.6 Bug #19604: Fix Haldir's Cairn so that the proper draugr boss is targeted by the quest during CR05.}

Quest Property dunHalldirsCairnQST Auto
Quest Property CR05 Auto
ObjectReference Property BossRef Auto
ReferenceAlias Property CR05Boss Auto
ObjectReference Property DraugrBossRef Auto

Event onTriggerEnter( objectReference triggerRef )
	if( triggerRef == Game.GetPlayer() )
		if( dunHalldirsCairnQST.GetStageDone( 100 ) )
			if( CR05.IsRunning() )
				if( BossRef == CR05Boss.GetReference() )
					DraugrBossRef.Enable()
					BossRef.Disable()
					CR05Boss.ForceRefTo( DraugrBossRef )
				endif
			endif
		endif
	endif
EndEvent
