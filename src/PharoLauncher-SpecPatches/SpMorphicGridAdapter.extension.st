Extension { #name : 'SpMorphicGridAdapter' }

{ #category : '*PharoLauncher-SpecPatches-GridColumnSizing' }
SpMorphicGridAdapter >> basicApplyChildrenAlignmentTo: aWidget constraints: constraints [

	| alignmentWidget |	
	constraints hasAlignment ifFalse: [ ^ aWidget ].
	
	aWidget 
		changeTableLayout;
		hResizing: #shrinkWrap; 
		vResizing: #shrinkWrap.
	
	alignmentWidget := Morph new
		changeTableLayout; 
		color: Color transparent;
		addMorphBack: aWidget;
		setProperty: #gridAlignmentWrapper toValue: true.

	constraints vAlign ifNotNil: [ :align |
		alignmentWidget listCentering: align asMorphicAlign ].
	constraints hAlign ifNotNil: [ :align |
		alignmentWidget wrapCentering: align asMorphicAlign ].
		
	^ alignmentWidget
]
