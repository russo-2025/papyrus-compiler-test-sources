ScriptName dunGeirmundsBossTrigger extends objectReference
{Trigger that starts the boss battle in Geirmunds Hall.}

ObjectReference property Sigdis Auto
Sound property RumbleSFX Auto
int waitcounter = 0 ;USSEP 4.3.5 Bug #35457
auto State waiting
	Event onTriggerEnter(objectReference triggerRef)
		if (triggerRef == Game.GetPlayer())
			Sigdis.Activate(Self)
			Game.GetPlayer().RampRumble(1, 2, 1600)
			;USSEP 4.3.5 Bug #35457 - Introduce a 3D wait before attempting to play the sound.
			while !Sigdis.is3dLoaded() && waitcounter < 5 ;wait for him to load before playing the sound, otherwise it'll just error
				waitcounter +=1
				utility.wait(0.1)
			endwhile
			;USSEP 4.3.5 Bug #35457 - If the wait didn't work, skip the sound because it can't play without 3D.
			if Sigdis.is3dloaded()
				RumbleSFX.Play(Sigdis)
			endif
			Utility.Wait(0.25)
			Game.GetPlayer().SetAnimationVariableBool("bStaggerPlayerOverride", True)
			Sigdis.KnockAreaEffect(0.5, 1200)
			Utility.Wait(0.25)
			Game.GetPlayer().SetAnimationVariableBool("bStaggerPlayerOverride", False)
			gotoState("allDone")
		EndIf
	EndEvent
endState

State allDone
	;do nothing
endState
