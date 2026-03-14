Scriptname C00JorrvaskrFightAthisScript extends ReferenceAlias  


Event OnEnterBleedout()
; 	Debug.Trace("C00: Athis entered bleedout; shutting down fight.")
	GetActorReference().GetActorBase().SetInvulnerable(true)
	Utility.Wait(4.0)
	GetOwningQuest().Stop()
EndEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	if (akAggressor == Game.GetPlayer())
		if (akSource as weapon) || ( (akSource as spell) && (akSource as spell).IsHostile() ) || (akSource as scroll) ;USSEP 4.3.4 Bug #34767
			(GetOwningQuest() as C00JorrvaskrFightSceneScript).PlayerEndedFight = True
			GetOwningQuest().Stop()
		endif
	endif
EndEvent
