Scriptname DGIntimidateAliasScript extends ReferenceAlias  

Faction Property DGIntimidateFaction Auto

import game

Event OnUpdate()
; 	debug.trace("DGIntimidateAliasScript: OnUpdate")
	actor pActor = GetActorRef()
	if pActor.IsInCombat() == 0 && pActor.IsBleedingOut() == 0 && GetOwningQuest().GetStage() < 15 && GetOwningQuest().GetStage() > 20
; 		debug.trace(self + " is no longer in combat, ending quest")
		; end quest
		GetOwningQuest().SetStage(200)
	endif
endEvent

;USSEP 4.3.4 Bug #34767 - Rewritten event for aggression checks.
Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, Bool abPowerAttack, Bool abSneakAttack, Bool abBashAttack, Bool abHitBlocked)

	actor TheActor = self.GetActorRef()
	actor ThePlayer = game.GetPlayer()
	if akAggressor == ThePlayer as ObjectReference && (self.GetOwningQuest() as dgintimidatequestscript).CR04Running == 0
		if( ( (akSource as weapon) && akSource != UnarmedWeapon ) || ( (akSource as spell) && (akSource as spell).IsHostile() ) || (akSource as scroll) )
			ThePlayer.RemoveFromFaction(DGIntimidateFaction)
			TheActor.RemoveFromFaction(DGIntimidateFaction)
			TheActor.StopCombat()
			TheActor.SendAssaultAlarm()
			TheActor.StartCombat(ThePlayer)
			self.GetOwningQuest().SetStage(150)
		endIf
	endIf
endEvent

;USSEP 4.3.4 Bug #34767 - The OnMagicEffectApply block is no longer necessary with the aggression checks in OnHit.
;/
Event OnMagicEffectApply(ObjectReference akCaster, MagicEffect akEffect)
	; if player hits with any magic effect
	; don't do this if it's a Companion's radiant quest
		if (akCaster == GetPlayer()) &&  ((GetOwningQuest() as DGIntimidateQuestScript).CR04Running == 0)
; 				debug.trace(self + " hit with magic - end Intimidate")
				GetOwningQuest().SetStage(150)
		endif 	
endEvent
/;

Event OnEnterBleedout()
	GetOwningQuest().SetStage(15)
; 	Debug.Trace("Opponent entering bleedout.")
	GetActorReference().EvaluatePackage() ; to make sure the forcegreet happens
EndEvent

Weapon Property UnarmedWeapon  Auto  
