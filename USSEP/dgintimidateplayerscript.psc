Scriptname DGIntimidatePlayerScript extends ReferenceAlias  

import game

;USSEP 4.3.4 Bug #34767 - Rewritten event for aggression checks.
Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, Bool abPowerAttack, Bool abSneakAttack, Bool abBashAttack, Bool abHitBlocked)

	if akAggressor != Opponent.GetRef() && akAggressor != OpponentFriend.GetRef()
		if( (akSource as weapon) || ( (akSource as spell) && (akSource as spell).IsHostile() ) )
			self.GetOwningQuest().SetStage(200)
		endIf
	endIf
endEvent

;USSEP 4.3.4 Bug #34767 - This event was disabled in vanilla.
Event OnSpellCast(Form akSpell)

	if akSpell as spell
		actor PlayerRef = game.GetPlayer()
		if PlayerRef.GetEquippedSpell(0) == akSpell as spell || PlayerRef.GetEquippedSpell(1) == akSpell as spell
			if (akSpell as spell).IsHostile()
				
			else
				self.GetOwningQuest().SetStage(180)
			endIf
		endIf
	elseIf (akSpell as ingredient) || (akSpell as potion)
		self.GetOwningQuest().SetStage(180)
	endIf
endEvent

;USSEP 4.3.4 Bug #34767 - The OnMagicEffectApply block is no longer necessary with the aggression checks in OnHit.
;/
Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
	; if player is hit with any magic effect (not by himself)
	if akCaster != GetPlayer()
; 			debug.trace(self + " hit with magic - end Intimidate")
			GetOwningQuest().SetStage(150)
	endif
endEvent
/;

Event OnEnterBleedout()
; 	Debug.Trace("player enters bleedout")
	GetOwningQuest().SetStage(180)
;	Opponent.GetActorReference().EvaluatePackage() ; 
;	if OpponentFriend
;		OpponentFriend.GetActorReference().EvaluatePackage() ; 
;	endif
EndEvent


Event OnLocationChange(Location akOldLoc, Location akNewLoc)
  if Game.GetPlayer().IsInLocation(Opponent.GetActorRef().GetCurrentLocation()) == False
;     Debug.Trace(self + "Player has left opponent's location, shutting down")
    GetOwningQuest().SetStage(200)
  endIf
endEvent

Weapon Property UnarmedWeapon  Auto  


ReferenceAlias Property Opponent  Auto  
{opponent in the brawl}

ReferenceAlias Property OpponentFriend  Auto  
