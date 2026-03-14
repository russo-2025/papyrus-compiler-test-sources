Scriptname MS11CalixtoScript extends ReferenceAlias  

Scene Property KillScene auto

Event OnDeath(Actor akKiller)
	if (GetOwningQuest().GetStage() == 130)
		(GetOwningQuest() as MS11QuestScript).CalixtoDead = true
		GetActorReference().BlockActivation(false)
		GetOwningQuest().SetStage(150)
	endif
EndEvent

;USSEP 4.3.4 Bug #34767 - Rewritten event for aggression checks.
Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	if (akAggressor == Game.GetPlayer())
		if( (akSource as weapon) || ( (akSource as spell) && (akSource as spell).IsHostile() ) || (akSource as scroll) )
			ResolvePlayerAttack()
		endif
	endif
EndEvent

;USSEP 4.3.4 Bug #34767 - The OnMagicEffectApply block is no longer necessary with the aggression checks in OnHit.
;/
Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
	if (akCaster == Game.GetPlayer())
		ResolvePlayerAttack()
	endif
EndEvent
/;

Function ResolvePlayerAttack()
	if (KillScene.IsPlaying())
		if (KillScene.IsActionComplete(7) && KillScene.IsActionComplete(8) && (GetOwningQuest() as MS11QuestScript).PlayerInMurderZone)
			KillScene.Stop()
		endif
	endif
EndFunction
