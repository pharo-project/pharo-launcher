actions
removeAllMorphs 
	" Don't keep unnecessary stuff.
	  Also there is a bug popping with FT2 when trying to send #changed to the MenuBar. Removing morphs will workaround this problem"
	World removeAllMorphs