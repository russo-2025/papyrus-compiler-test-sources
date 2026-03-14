Scriptname USSEPBullseyeEffectScript extends ActiveMagicEffect
{casts the bullseye paralysis effect only when hit by an archery weapon}

perk property Bullseye auto
spell property PerkBullseyeParalyze auto
keyword property WeapTypeBow auto

Event OnHit( ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked )
	actor attacker = akAggressor as actor
	weapon source = akSource as weapon

	if( attacker != None && source != None )
		if( source.HasKeyword( WeapTypeBow ) )
			attacker.DoCombatSpellApply( PerkBullseyeParalyze, (self.GetTargetActor()) )
		endif
	endif
endEvent