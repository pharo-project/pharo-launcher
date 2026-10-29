Extension { #name : 'SpFontStyle' }

{ #category : '*PharoLauncher-SpecPatches-FontStyleSharedFont' }
SpFontStyle >> calculateDefinedFont [
	"LogicalFont instances are shared (see LogicalFont class>>#familyName:fallbackFamilyNames:pointSize:stretchValue:weightValue:slantValue:).
	 Ask for the right weight and slant instead of forcing them on the answered font: that would change the font
	 of every morph using it (e.g. the default font)."

	^ LogicalFont
		familyName: self calculateFontName
		fallbackFamilyNames: nil
		pointSize: self calculateFontSize
		stretchValue: LogicalFont stretchRegular
		weightValue: (self isBold
			ifTrue: [ LogicalFont weightBold ]
			ifFalse: [ LogicalFont weightRegular ])
		slantValue: (self isItalic
			ifTrue: [ LogicalFont slantItalic ]
			ifFalse: [ LogicalFont slantRegular ])
]
