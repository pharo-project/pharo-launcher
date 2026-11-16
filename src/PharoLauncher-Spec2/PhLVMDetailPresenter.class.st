"
Presenter of the details of a virtual machine: a header with its id and version, its download URL and location on disk as links, its installation date and its status.
The version and the status are the ones already fetched by my owner.
My model is nil when there is no virtual machine to show.

I'm part of the VM manager window, see `PhLVMPresenter`.
"
Class {
	#name : 'PhLVMDetailPresenter',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'header',
		'downloadUrl',
		'location',
		'installedOn',
		'status'
	],
	#category : 'PharoLauncher-Spec2-View',
	#package : 'PharoLauncher-Spec2',
	#tag : 'View'
}

{ #category : 'layout' }
PhLVMDetailPresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  borderWidth: 5;
		  spacing: 5;
		  add: (SpBoxLayout newLeftToRight
				   hAlignCenter;
				   add: header;
				   yourself)
		  expand: false;
		  add: self detailsLayout;
		  yourself
]

{ #category : 'accessing' }
PhLVMDetailPresenter >> downloadUrl [

	^ downloadUrl
]

{ #category : 'accessing' }
PhLVMDetailPresenter >> header [

	^ header
]

{ #category : 'private - updating' }
PhLVMDetailPresenter >> headerFor: aVm [

	^ (self owner versionDescriptionFor: aVm)
		  ifEmpty: [ 'VM ' , aVm id ]
		  ifNotEmpty: [ :version | 'VM {1} ({2})' format: { aVm id. version } ]
]

{ #category : 'initialization' }
PhLVMDetailPresenter >> initializePresenters [

	header := self newLabel.
	header addStyle: 'form_header'.
	downloadUrl := self newLink.
	location := self newLink.
	installedOn := self newLabel.
	status := self newLabel
]

{ #category : 'accessing' }
PhLVMDetailPresenter >> installedOn [

	^ installedOn
]

{ #category : 'layout' }
PhLVMDetailPresenter >> detailsLayout [

	^ SpGridLayout build: [ :builder |
		  builder
			  beRowNotHomogeneous;
			  beColumnNotHomogeneous;
			  borderWidth: 0;
			  column: 1 withConstraints: [ :c | c hAlignEnd ];
			  column: 2 withConstraints: [ :c | c beExpand ];
			  add: 'Download URL';
			  add: downloadUrl;
			  nextRow;
			  add: 'Location';
			  add: location;
			  nextRow;
			  add: 'Installed on';
			  add: installedOn;
			  nextRow;
			  add: 'Status';
			  add: status ]
]

{ #category : 'accessing' }
PhLVMDetailPresenter >> location [

	^ location
]

{ #category : 'updating' }
PhLVMDetailPresenter >> modelChanged [

	self vm
		ifNil: [ self showNoVm ]
		ifNotNil: [ :vm | self showVm: vm ]
]

{ #category : 'private - updating' }
PhLVMDetailPresenter >> showNoVm [

	header label: ''.
	downloadUrl
		label: '';
		action: [  ].
	location
		label: '';
		action: [  ].
	installedOn label: ''.
	status label: ''
]

{ #category : 'private - updating' }
PhLVMDetailPresenter >> showVm: aVm [

	header label: (self headerFor: aVm).
	downloadUrl
		label: aVm downloadUrl;
		url: aVm downloadUrl;
		help: 'Download the archive of this virtual machine'.
	location
		label: aVm location;
		action: [ aVm showInFolder ];
		help: 'Show this virtual machine in its folder'.
	installedOn label: (aVm installationDate
			 ifNil: [ '' ]
			 ifNotNil: [ :date | date yyyymmdd ]).
	status label: (self owner statusDescriptionFor: aVm)
]

{ #category : 'accessing' }
PhLVMDetailPresenter >> status [

	^ status
]

{ #category : 'accessing' }
PhLVMDetailPresenter >> vm [

	^ self model
]
