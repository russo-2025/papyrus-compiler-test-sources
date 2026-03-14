Scriptname WEDL06LetrushCleanupTriggerScript extends ObjectReference  

quest property MS03 auto
actorBase property LouisLetrush auto

event onTrigger(objectReference triggerRef)
	if MS03.getStageDone(200)
		actor triggerActor = triggerRef as actor
		 if triggerActor && triggerActor.getActorBase() == LouisLetrush ;USSEP 4.3.7 Bug #35850
			triggerRef.disable()	
			triggerRef.deleteWhenAble()
		endif
	endif
endEvent
