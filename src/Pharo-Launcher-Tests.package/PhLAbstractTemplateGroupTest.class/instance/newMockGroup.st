instance-creation
newMockGroup
	"
- Main
  - empty group
  - singleton template group 1
    - template 1
  - singleton group group
    - singleton template group 2
      - template 2
  - normal group
    - singleton template group 3
      - template 3
    - template 4
    - normal sub group
      - template 5
      - template 6"
	| mainGroup subGroup subSubGroup |
	mainGroup := PhLPluggableTemplateGroup name: 'main'.
	mainGroup add: (PhLPluggableTemplateGroup name: 'empty group').
	subGroup := PhLPluggableTemplateGroup name: 'singleton template group 1'.
	mainGroup add: subGroup.
	subGroup add: (PhLLocalTemplate name: 'template 1' zipFile: nil).
	subGroup := PhLPluggableTemplateGroup name: 'singleton group group'.
	mainGroup add: subGroup.
	subSubGroup := PhLPluggableTemplateGroup name: 'singleton template group 2'.
	subGroup add: subSubGroup.
	subSubGroup add: (PhLLocalTemplate name: 'template 2' zipFile: nil).
	subGroup := (PhLPluggableTemplateGroup name: 'normal group').
	mainGroup add: subGroup.
	subSubGroup := PhLPluggableTemplateGroup name: 'singleton template group 3'.
	subGroup add: subSubGroup.
	subSubGroup add:(PhLLocalTemplate name: 'template 3' zipFile: nil).
	subGroup add: (PhLLocalTemplate name: 'template 4' zipFile: nil).
	subSubGroup := PhLPluggableTemplateGroup name: 'normal sub group'.
	subGroup add: subSubGroup.
	subSubGroup add:(PhLLocalTemplate name: 'template 5' zipFile: nil).
	subSubGroup add:(PhLLocalTemplate name: 'template 6' zipFile: nil).
	^ mainGroup