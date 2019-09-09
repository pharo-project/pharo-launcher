"
Null pattern for a PhLImage.
Used to display information when no image is selected.
"
Class {
	#name : #PhLNullImage,
	#superclass : #Object,
	#category : #'PharoLauncher-Spec2'
}

{ #category : #accessing }
PhLNullImage >> architecture [
	
	^ ''
]

{ #category : #accessing }
PhLNullImage >> description [
	
	^ '<no description given>'
]

{ #category : #accessing }
PhLNullImage >> lastModification [
	
	^ nil
]

{ #category : #accessing }
PhLNullImage >> location [

	^ ''
]

{ #category : #accessing }
PhLNullImage >> name [
	^ 'No image selected'
]

{ #category : #accessing }
PhLNullImage >> originTemplateName [
	
	^ ''
]

{ #category : #accessing }
PhLNullImage >> originTemplateUrl [
	
	^ ''
]
