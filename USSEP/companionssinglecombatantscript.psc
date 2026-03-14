Scriptname CompanionsSingleCombatantScript extends ReferenceAlias  

Event OnEnterBleedOut()
	GetOwningQuest().SetStage(200)
EndEvent

;USSEP 4.3.4 Bug #34767 - Added this for aggression checks.
Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, Bool abPowerAttack, Bool abSneakAttack, Bool abBashAttack, Bool abHitBlocked)

	if akAggressor == game.GetPlayer() as ObjectReference
		if( ( (akSource as spell) && (akSource as spell).IsHostile() ) || (akSource as scroll) )
			self.GetOwningQuest().SetStage(150)
		endIf
	endIf
EndEvent

;USSEP 4.3.4 Bug #34767 - The OnMagicEffectApply block is no longer necessary with the aggression checks in OnHit.
;/
Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
	; if player hits with any magic effect
	if (akCaster == Game.GetPlayer())
			GetOwningQuest().SetStage(150)
	endif
EndEvent
/;
