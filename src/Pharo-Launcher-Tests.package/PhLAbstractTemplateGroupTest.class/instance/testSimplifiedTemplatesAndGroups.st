tests
testSimplifiedTemplatesAndGroups
	"We want
- Main
  - template 1
  - template 2
  - normal group
    - template 3
    - template 4
    - normal sub group
      - template 5
      - template 6"

	| tAndG normalGroup normalSubGroup normalGroupTAndG normalSubGroupTAndG |
	tAndG := self newMockGroup simplifiedTemplatesAndGroups.
	self assert: tAndG size equals: 3.
	self assert: tAndG first name equals: 'template 1'.
	self assert: tAndG second name equals: 'template 2'.
	normalGroup := tAndG third.
	normalGroupTAndG := normalGroup simplifiedTemplatesAndGroups.
	self assert: normalGroup name equals: 'normal group'.
	self assert: normalGroupTAndG size equals: 3.
	self assert: normalGroupTAndG first name equals: 'template 3'.
	self assert: normalGroupTAndG second name equals: 'template 4'.
	normalSubGroup := normalGroupTAndG third.
	normalSubGroupTAndG := normalSubGroup simplifiedTemplatesAndGroups.
	self assert: normalSubGroup name equals: 'normal sub group'.
	self assert: normalSubGroupTAndG size equals: 2.
	self assert: normalSubGroupTAndG first name equals: 'template 5'.
	self assert: normalSubGroupTAndG second name equals: 'template 6'.