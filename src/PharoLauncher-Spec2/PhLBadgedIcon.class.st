"
I am an icon with a red badge in its top right corner telling a number, like the notifications of macOS.
The icon is drawn below the badge: the form I answer is larger than the icon by half the height of the badge.

```
(PhLBadgedIcon icon: (self iconNamed: #configuration) count: 2) asForm
```
"
Class {
	#name : 'PhLBadgedIcon',
	#superclass : 'Object',
	#instVars : [
		'icon',
		'count'
	],
	#category : 'PharoLauncher-Spec2-View',
	#package : 'PharoLauncher-Spec2',
	#tag : 'View'
}

{ #category : 'instance creation' }
PhLBadgedIcon class >> icon: aForm count: anInteger [

	^ self new
		  setIcon: aForm count: anInteger;
		  yourself
]

{ #category : 'converting' }
PhLBadgedIcon >> asForm [
	"Answer the icon itself when there is nothing to tell"

	| form canvas badge |
	count = 0 ifTrue: [ ^ icon ].
	form := Form extent: icon extent + (self badgeHeight // 2) depth: 32.
	form fillColor: Color transparent.
	canvas := form getCanvas.
	canvas translucentImage: icon at: 0 @ (self badgeHeight // 2).
	badge := (form width - self badgeWidth) @ 0 extent: self badgeWidth @ self badgeHeight.
	self drawBadge: badge on: canvas.
	^ form
]

{ #category : 'private' }
PhLBadgedIcon >> badgeColor [

	^ Color r: 0.9 g: 0.15 b: 0.15
]

{ #category : 'private' }
PhLBadgedIcon >> badgeHeight [

	^ 12
]

{ #category : 'private' }
PhLBadgedIcon >> badgeWidth [
	"A circle for one digit, a pill for longer texts"

	^ self badgeHeight max: (self font widthOfString: self text) + 5
]

{ #category : 'private' }
PhLBadgedIcon >> drawBadge: aRectangle on: aCanvas [
	"A pill: two circles joined by a rectangle"

	| height textExtent |
	height := aRectangle height.
	aCanvas
		fillOval: (aRectangle topLeft extent: height @ height) color: self badgeColor;
		fillOval: ((aRectangle right - height) @ aRectangle top extent: height @ height) color: self badgeColor;
		fillRectangle: ((aRectangle left + (height // 2)) @ aRectangle top
			corner: (aRectangle right - (height // 2)) @ aRectangle bottom)
		color: self badgeColor.
	textExtent := (self font widthOfString: self text) @ self font height.
	aCanvas
		drawString: self text
		at: aRectangle center - (textExtent // 2)
		font: self font
		color: Color white
]

{ #category : 'private' }
PhLBadgedIcon >> font [

	^ LogicalFont familyName: StandardFonts defaultFont familyName pointSize: 7
]

{ #category : 'initialization' }
PhLBadgedIcon >> setIcon: aForm count: anInteger [

	icon := aForm.
	count := anInteger
]

{ #category : 'accessing' }
PhLBadgedIcon >> text [
	"The badge is too small for more than two characters"

	^ count > 9
		  ifTrue: [ '9+' ]
		  ifFalse: [ count printString ]
]
