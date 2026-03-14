Scriptname C00JorrvaskrFightNjadaScript extends ReferenceAlias  


Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	if (akAggressor == Game.GetPlayer())
		if (akSource as weapon) || ( (akSource as spell) && (akSource as spell).IsHostile() ) || (akSource as scroll) ;USSEP 4.3.4 Bug #34767
			(GetOwningQuest() as C00JorrvaskrFightSceneScript).PlayerEndedFight = True
			GetOwningQuest().Stop()
		endif
	endif
EndEvent
