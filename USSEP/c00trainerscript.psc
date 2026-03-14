Scriptname C00TrainerScript extends ReferenceAlias  

int numHits = 0

;USSEP 4.3.4 Bug #34767 - The OnMagicEffectApply block is no longer necessary with the aggression checks in OnHit.
;/
Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
; 	Debug.Trace("C00: Vilkas hit by magic.")
	if (Game.GetPlayer() == akCaster)
		GetOwningQuest().SetStage(100)
	endif
EndEvent
/;

Event OnEnterBleedout()
	BleedoutChecks()
EndEvent

Function BleedoutChecks()
	if (!GetOwningQuest().IsRunning())
		return
	endif
; 	Debug.Trace("C00: Vilkas reached bleedout.")
	int currStage = GetOwningQuest().GetStage()
	if (currStage != 100 && currStage != 110) ; don't let it through if he's trying to
											  ;  razz you about using magic, for instance
		GetOwningQuest().SetStage(125)
	endif
EndFunction

;USSEP 4.3.4 Bug #34767 - Rewrote this event.
Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, Bool abPowerAttack, Bool abSneakAttack, Bool abBashAttack, Bool abHitBlocked)

	if akAggressor == game.GetPlayer() as ObjectReference
		if( ( (akSource as spell) && (akSource as spell).IsHostile() ) || (akSource as scroll) )
			self.GetOwningQuest().SetStage(100)
		elseIf( !akSource as explosion && !akSource as enchantment )
			NumHits += 1
			if NumHits >= 3
				self.GetOwningQuest().SetStage(150)
			endIf
		endIf
	elseIf( (akSource as weapon) || ( (akSource as spell) && (akSource as spell).IsHostile() ) )
		self.GetOwningQuest().SetStage(110)
	endIf
EndEvent

Function ResetHits()
	numHits = 0
EndFunction
