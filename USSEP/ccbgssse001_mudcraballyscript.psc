Scriptname ccBGSSSE001_MudcrabAllyScript extends Quest conditional

int mudcrabAllyCount = 0 conditional
ReferenceAlias[] property crabAliases auto
EffectShader property AnimalAllyFXS auto

bool working = false

ReferenceAlias function TryToAddMudcrabAlly(Actor akTarget, Actor akCaster)
	while working
		if mudcrabAllyCount >= crabAliases.length
			; If we're already over the ally limit, exit early.
			return None
		else
			Utility.Wait(1)
		endif
	endWhile

	working = true

	ReferenceAlias myAlias = None
	; Set as player teammate, increment the ally count, and assign to a ref alias
	if mudcrabAllyCount < crabAliases.length
		AnimalAllyFXS.Play(akTarget)
		akTarget.StopCombat()
		akCaster.StopCombat()

		mudcrabAllyCount += 1
		akTarget.SetPlayerTeammate(true, false)

		;USSEP 4.3.7 Bug #35834
		Quest FollowerQuest = Game.GetFormFromFile( 0x000750ba, "Skyrim.esm" ) as Quest
		ReferenceAlias Follower = FollowerQuest.GetAlias(0) as ReferenceAlias
		ReferenceAlias AnimalFollower = FollowerQuest.GetAlias(1) as ReferenceAlias

		if( Follower.GetReference() != None )
			Follower.GetActorReference().StopCombat()
		endif
		if( AnimalFollower.GetReference() != None )
			AnimalFollower.GetActorReference().StopCombat()
		endif
		int i = 0
		bool assigned = false
		while i < crabAliases.length && !assigned
			if !crabAliases[i].GetActorRef()
				myAlias = crabAliases[i]
				myAlias.ForceRefTo(akTarget)
				assigned = true
			endif
			i += 1
		endWhile
	endif

	working = false
	return myAlias
endFunction

function RemoveMudcrabAlly(Actor akTarget, ReferenceAlias akAlias)
	while working
		Utility.Wait(1)
	endWhile

	working = true

	AnimalAllyFXS.Stop(akTarget)
	mudcrabAllyCount -= 1
	akAlias.Clear()
	akTarget.SetPlayerTeammate(false, false)

	working = false
endFunction
