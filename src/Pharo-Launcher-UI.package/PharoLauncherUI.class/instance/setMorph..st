private
setMorph: aMorph

	container removeAllMorphs.
	container addMorph: aMorph.
	aMorph color: Color white.
	aMorph takeKeyboardFocus.