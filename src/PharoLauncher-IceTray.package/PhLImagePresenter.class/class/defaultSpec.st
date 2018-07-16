specs
defaultSpec

	<spec: #default>

	| fontWidth labelsWidth rowHeight checkboxWidth |
	fontWidth := (StandardFonts defaultFont widthOfString: 'M').
	labelsWidth := fontWidth * 8.
	rowHeight := self inputTextHeight.
	checkboxWidth := fontWidth * 2.
	
	^ SpecLayout composed 
	newRow: [ :mainRow |
		mainRow newColumn: [ :col | 

			col newRow: [ : row | 
				row add: #nameLabel right: labelsWidth.
				row add: #nameTextInput ]
			height: rowHeight.
		
			col newRow: [ :row | 
				row add: #vmLabel right: labelsWidth.
				row add: #vmInput ]
			height: rowHeight.

			col newRow: [ :row | 
				row add: #templateLabel right: labelsWidth.
				row add: #templateInput ]
			height: rowHeight. 
			
			col newRow: [ :row | 
				row add: #locationLabel right: labelsWidth.
				row add: #locationInput ]
			height: rowHeight.

			col newRow: [ :row |  ]. "fill the rest"

			].

		mainRow newColumn: [ :col | 
			
			col newRow: [ :row | 
				row add: #lastModificationLabel right: labelsWidth.
				row add: #lastModificationInput ]
			height: rowHeight.

			col newRow: [ :row | 
				row add: #tagsLabel right: labelsWidth.
				row add: #tagsInput ]
			height: rowHeight.


			col newRow: [ :row | 
				row add: #commentLabel right: labelsWidth.
				row add: #commentInput ]
			height: rowHeight*2.
			
			col newRow: [ :row |  ]. "fill the rest"

	]].


	