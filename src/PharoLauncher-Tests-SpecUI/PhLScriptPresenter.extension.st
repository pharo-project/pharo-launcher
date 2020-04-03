Extension { #name : #PhLScriptPresenter }

{ #category : #'*PharoLauncher-Tests-SpecUI' }
PhLScriptPresenter >> clickAddScriptButton [
	scriptTable addButton click
]

{ #category : #'*PharoLauncher-Tests-SpecUI' }
PhLScriptPresenter >> clickRemoveScriptButton [
	scriptTable removeButton click
]

{ #category : #'*PharoLauncher-Tests-SpecUI' }
PhLScriptPresenter >> fileEditor [
	^ fileEditor
]
