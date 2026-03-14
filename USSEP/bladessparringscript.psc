Scriptname BladesSparringScript extends ReferenceAlias  

import game

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	; if I'm hit by anybody but my opponent, stop quest
	if akAggressor != Opponent.GetRef()
		if (akSource as weapon) || ( (akSource as spell) && (akSource as spell).IsHostile() ) || (akSource as scroll) ;USSEP 4.3.4 Bug #34767
			;debug.trace(self + " hit by someone besides my opponent - end sparring")
			GetOwningQuest().SetStage(300)
		endif
	endif
endEvent

;USSEP 4.3.4 Bug #34767 - The OnMagicEffectApply block is no longer necessary with the aggression checks in OnHit.

;/
Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
; 	debug.trace(self + "OnMagicEffectApply akCaster=" + akCaster)
	; if hit by anybody but opponent
	if akCaster != Opponent.GetRef() && akCaster != GetRef()
; 		debug.trace(self + " hit by someone besides my opponent - end sparring")
		GetOwningQuest().SetStage(300)
	endif 	
endEvent
/;

ReferenceAlias Property Opponent  Auto

