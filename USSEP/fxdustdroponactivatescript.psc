scriptName FXdustDropOnActivateSCRIPT extends objectReference 
{this Script plays three dust falling animations when triggered} 
;===============================================

import debug				; import debug.psc for acces to trace()
import utility				; utility.psc for access to wait()
import sound				; sound.psc for access to play()

;===============================================
Explosion property FallingDustExplosion01 auto
sound property mySFX auto			; specify SFX to play

;*********************************

auto State waiting
	Event onActivate(objectReference triggerRef)
; 		debug.trace(self + " activated")
		;;Actor actorRef = triggerRef as Actor
		;if(actorRef == game.getPlayer())
			;player has entered trigger
			gotoState("done")
			self.PlayAnimation("PlayAnim01")
			mySFX.play(self)
			wait(0.3)
			objectReference myExplosion = placeAtMe(FallingDustExplosion01) ;USSEP 4.3.7 Bug #36202
			wait(3.0)
			self.PlayAnimation("PlayAnim02")
			mySFX.play(self)
			wait(3.3)
			self.PlayAnimation("PlayAnim03")
			mySFX.play(self)
			myExplosion.delete() ;USSEP 4.3.7 Bug #36202 - The explosion animation only takes 4 seconds, so waiting 6.6 is more than enough here.
		;endif
	endEvent
endSTATE

;*********************************

State done
	;do nothing
endState

;*********************************
