scriptname Survival_PlayerHitInfo extends ReferenceAlias

Actor property PlayerRef auto

Spell property Survival_DiseaseGreenspore auto
Spell property Survival_DiseaseBrownRot auto
Spell property Survival_DiseaseGutworm auto

FormList property Survival_BrownRotCarryingRaces auto
FormList property Survival_GreensporeCarryingRaces auto
FormList property Survival_GutwormCarryingRaces auto

bool processing = false
Int baseChance  ; Unofficial Skyrim Survival Patch 2.6: Define baseChance variable as int

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	if akProjectile || !(akAggressor as Actor)
		return
	endif

	while processing
		Utility.Wait(0.1)
	endWhile
	
	processing = true
	OnHitImpl(akAggressor)
	processing = false
EndEvent

function OnHitImpl(ObjectReference akAggressor)
	Race theRace = (akAggressor as Actor).GetLeveledActorBase().GetRace()
	Spell diseaseSpell  ; Unofficial Skyrim Survival Patch 2.6: Define diseaseSpell variable type for later use

	if Survival_BrownRotCarryingRaces.HasForm(theRace)
		diseaseSpell = Survival_DiseaseBrownRot  ; Unofficial Skyrim Survival Patch 2.6: Define diseaseSpell instead of immediately rolling to see if player becomes infected
		baseChance = 3 ; Unofficial Skyrim Survival Patch 2.6: Set Brown Rot disease contraction chance at three percent
	elseif Survival_GreensporeCarryingRaces.HasForm(theRace)
		diseaseSpell = Survival_DiseaseGreenspore  ; Unofficial Skyrim Survival Patch 2.6: Define diseaseSpell instead of immediately rolling to see if player becomes infected
		baseChance = 5  ; Unofficial Skyrim Survival Patch 2.6: Set Greenspore disease contraction chance at five percent
	elseif Survival_GutwormCarryingRaces.HasForm(theRace)
		diseaseSpell = Survival_DiseaseGutworm  ; Unofficial Skyrim Survival Patch 2.6: Define diseaseSpell instead of immediately rolling to see if player becomes infected
		baseChance = 6  ; Unofficial Skyrim Survival Patch 2.6: Set Gutworm disease contraction chance at six percent
	endif

	; Unofficial Skyrim Survival Patch 2.6: Apply survival resistance check before performing rolling to see if player becomes infected
	;------------------------------------------------------------------------------
	Int diseaseResistMult = PlayerRef.GetActorValue("DiseaseResist") as Int  ; Player's DiseaseResist value is a Float but will always be a whole number, so cast as an Int
	if diseaseSpell != none && diseaseResistMult < 100
		Int chance = baseChance * (100 - diseaseResistMult)
		Int result = utility.RandomInt(1, 10000)
	
		if result <= chance
			PlayerRef.AddSpell(diseaseSpell, false)
		endIf
	endIf
	;------------------------------------------------------------------------------
endFunction