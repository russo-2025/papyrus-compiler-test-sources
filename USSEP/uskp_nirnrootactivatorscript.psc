Scriptname USKP_NirnrootACTIVATORScript extends ObjectReference Hidden 
{Special case of Crimson Nirnroot at Sarethi Farm. Only activates after NN01.}

Ingredient Property Nirnroot Auto
Activator Property NirnrootGlowACTIVATOR Auto
Activator Property NirnrootEmptyACTIVATOR Auto

ObjectReference Property NirnrootGlowReference Auto Hidden
ObjectReference Property NirnrootEmptyReference Auto Hidden

Quest Property NN01 Auto

Float NirnScale

;-------------------------------------------
;	Added by USLEEP 3.0.8 for Bug #13603
;-------------------------------------------

bool USLEEP_CellAttached = false

EVENT OnCellAttach()
	if( NN01.GetStage() >= 200 )
		;USLEEP 3.0.8 for Bug #13603: set tracking bool to 'true':
		USLEEP_CellAttached = true

		if (self.IsDisabled() == FALSE)
			NirnrootGlowReference = PlaceAtMe(NirnRootGlowACTIVATOR)
			NirnrootEmptyReference = PlaceAtMe(NirnRootEmptyACTIVATOR)
			NirnrootEmptyReference.DisableNoWait()
		endif
	EndIf
endEVENT



EVENT OnReset()
	if( NN01.GetStage() >= 200 )
		if (self.IsDisabled() == TRUE)
			self.Enable()
			;USLEEP 3.0.8 Bug #13603: Added the following check to make sure that OnCellAttach creates the references if it fires before OnReset (in that
			;case, it wouldn't have created anything because the reference was still disabled):
			if USLEEP_CellAttached && (NirnrootEmptyReference == none)
				OnCellAttach()
			endif
			GoToState("WaitingForHarvest")
		endif
	EndIf
endEVENT



Auto STATE WaitingForHarvest

	EVENT onActivate(ObjectReference TriggerRef)
		GoToState("AlreadyHarvested")
		Nirnscale = Self.GetScale()
		NirnrootEmptyReference.SetScale(Nirnscale)
		NirnrootEmptyReference.EnableNoWait()
		(TriggerRef as Actor).additem(Nirnroot, 1)
		Game.IncrementStat( "Nirnroots Found" )
		NirnRootGlowReference.DisableNoWait()
		NirnRootGlowReference.Delete()

		self.DisableNoWait()
		
	endEVENT

endSTATE



STATE AlreadyHarvested
	

endSTATE

;-------------------------------------------
;	Added by USLEEP 3.0.8 for Bug #13603
;-------------------------------------------

Event OnCellDetach()
	USLEEP_CellAttached = false
endEvent 