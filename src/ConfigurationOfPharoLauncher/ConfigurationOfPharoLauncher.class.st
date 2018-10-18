"
A ConfigurationOfPharoLauncher is usefull to configure the launcher

-> Type ""ConfigurationOfPharoLauncher loadBleedingEdge"" to load the latest versions of the mcz files defined for this project.

-> Type ""ConfigurationOfPharoLauncher loadDevelopment"" to load the development version defined for this platform.

-> Type ""ConfigurationOfPharoLauncher load"" to load the stable version defined for this platform (Recommanded to be used on this platform)

"
Class {
	#name : #ConfigurationOfPharoLauncher,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : 'ConfigurationOfPharoLauncher'
}

{ #category : #'development support' }
ConfigurationOfPharoLauncher class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfPharoLauncher class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #private }
ConfigurationOfPharoLauncher class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfPharoLauncher class >> ensureMetacelloBaseConfiguration [

	Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			| repository version |
			repository := MCHttpRepository location: 'http://seaside.gemstone.com/ss/metacello' user: '' password: ''.
			repository
				versionReaderForFileNamed: 'Metacello-Base-DaleHenrichs.2.mcz'
				do: [ :reader | 
					version := reader version.
					version load.
					version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfPharoLauncher class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfPharoLauncher class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfPharoLauncher class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfPharoLauncher class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfPharoLauncher class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfPharoLauncher class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfPharoLauncher >> baseline01: spec [
	<version: '0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/Pharo/PharoLauncher/main/'.
		spec 
			project: 'XMLParser' with: [
				spec
					className: #ConfigurationOfXMLParser;
					versionString: #'stable';
					loads: #('Core' );
					repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/' ];
			project: 'OSProcess' with: [
				spec
					className: #ConfigurationOfOSProcess;
					versionString: #'stable';
					loads: #('Core' );
					repository: 'http://www.squeaksource.com/MetacelloRepository' ];
			project: 'JSON' with: [
				spec
					className: #ConfigurationOfJSON;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main/' ];
			project: 'Ston' with: [
				spec
					className: #ConfigurationOfSton;
					versionString: #'stable';
					repository: 'http://ss3.gemstone.com/ss/STON' ].
		spec 
			package: #'PharoLauncher-Core' with: [
				spec requires: #('XMLParser' 'OSProcess' 'Ston' 'JSON' ). ];
			package: #'PharoLauncher-Spec' with: [
				spec requires: #(#'PharoLauncher-Core' ). ];
			package: #'PharoLauncher-Tests-Core' with: [
				spec requires: #(#'PharoLauncher-Core' ). ]. ].

]

{ #category : #baselines }
ConfigurationOfPharoLauncher >> baseline02: spec [
	<version: '0.2-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/Pharo/PharoLauncher/main/'.
		spec 
			project: 'XMLParser' with: [
				spec
					className: #ConfigurationOfXMLParser;
					versionString: #'stable';
					loads: #('Core' );
					repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/' ];
			project: 'OSProcess' with: [
				spec
					className: #ConfigurationOfOSProcess;
					versionString: #'stable';
					loads: #('Core with Output' );
					repository: 'http://www.squeaksource.com/MetacelloRepository' ];
			project: 'JSON' with: [
				spec
					className: #ConfigurationOfJSON;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main/' ];
			project: 'Ston' with: [
				spec
					className: #ConfigurationOfSton;
					versionString: #'stable';
					repository: 'http://ss3.gemstone.com/ss/STON' ].
		spec 
			package: #'PharoLauncher-Core' with: [
				spec requires: #('XMLParser' 'OSProcess' 'Ston' 'JSON' ). ];
			package: #'PharoLauncher-Spec' with: [
				spec requires: #(#'PharoLauncher-Core' ). ];
			package: #'PharoLauncher-Tests-Core' with: [
				spec requires: #(#'PharoLauncher-Core' ). ]. ].

]

{ #category : #baselines }
ConfigurationOfPharoLauncher >> baseline10: spec [
	<version: '1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/Pharo/PharoLauncher/main/'.
		spec 
			project: 'XMLParser' with: [
				spec
					className: #ConfigurationOfXMLParser;
					versionString: #'stable';
					loads: #('Core' );
					repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/' ];
			project: 'OSProcess' with: [
				spec
					className: #ConfigurationOfOSProcess;
					versionString: #'stable';
					loads: #('Core with Output' );
					repository: 'http://www.squeaksource.com/MetacelloRepository' ];
			project: 'ProcessWrapper' with: [
				spec
					className: #ConfigurationOfProcessWrapper;
					versionString: #'bleedingEdge';
					loads: #('Core' );
					repository: 'http://smalltalkhub.com/mc/hernan/ProcessWrapper/main/' ];
			project: 'JSON' with: [
				spec
					className: #ConfigurationOfJSON;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main/' ];
			project: 'Ston' with: [
				spec
					className: #ConfigurationOfSton;
					versionString: #'stable';
					repository: 'http://ss3.gemstone.com/ss/STON' ].
		spec 
			package: #'PharoLauncher-Core' with: [
				spec requires: #('XMLParser' 'OSProcess' 'Ston' 'JSON' ). ];
			package: #'PharoLauncher-Spec' with: [
				spec requires: #(#'PharoLauncher-Core' ). ];
			package: #'PharoLauncher-Tests-Core' with: [
				spec requires: #(#'PharoLauncher-Core' ). ]. ].

]

{ #category : #baselines }
ConfigurationOfPharoLauncher >> baseline12: spec [
	<version: '1.2-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/Pharo/PharoLauncher/main/'.
		spec 
			project: 'JSON' with: [
				spec
					className: #ConfigurationOfJSON;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main/' ];
			project: 'OSProcess' with: [
				spec
					className: #ConfigurationOfOSProcess;
					versionString: #'stable';
					loads: #('Core with Output' );
					repository: 'http://www.squeaksource.com/MetacelloRepository' ];
			project: 'ProcessWrapper' with: [
				spec
					className: #ConfigurationOfProcessWrapper;
					versionString: #'bleedingEdge';
					loads: #('Core' );
					repository: 'http://smalltalkhub.com/mc/hernan/ProcessWrapper/main/' ];
			project: 'Ston' with: [
				spec
					className: #ConfigurationOfSton;
					versionString: #'stable';
					repository: 'http://ss3.gemstone.com/ss/STON' ];
			project: 'XMLParser' with: [
				spec
					className: #ConfigurationOfXMLParser;
					versionString: #'stable';
					loads: #('Core' );
					repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/' ].
		spec 
			package: #'PharoLauncher-Core' with: [
				spec requires: #(#'PharoLauncher-Download' 'XMLParser' 'Ston' 'JSON' ). ];
			package: #'PharoLauncher-Download' with: [
				spec requires: #('OSProcess' 'ProcessWrapper'). ];
			package: #'PharoLauncher-Spec' with: [
				spec requires: #(#'PharoLauncher-Core' ). ];
			package: #'PharoLauncher-Tests-Core' with: [
				spec requires: #(#'PharoLauncher-Core' ). ];
			package: #'PharoLauncher-Tests-Download' with: [
				spec requires: #(#'PharoLauncher-Download' ). ].
		spec 
			group: 'Default' with: #(#'PharoLauncher-Tests-Core' #'PharoLauncher-Tests-Download' #'PharoLauncher-Core' #'PharoLauncher-Download' #'PharoLauncher-Spec' );
			group: 'Download' with: #(#'PharoLauncher-Download' #'PharoLauncher-Tests-Download' ). ].

]

{ #category : #accessing }
ConfigurationOfPharoLauncher >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfPharoLauncher >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '1.2-baseline'.

]

{ #category : #accessing }
ConfigurationOfPharoLauncher >> project [

	^ project ifNil: [ 
		"Bootstrap Metacello if it is not already loaded"
		(self class baseConfigurationClassIfAbsent: []) ensureMetacello.
		"Construct Metacello project"
		project := MetacelloMCProject new projectAttributes: self customProjectAttributes. 
		(Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfPharoLauncher >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '1.3'.

	spec for: #'pharo3.x' version: '0.2.6'.

	spec for: #'pharo4.x' version: '0.2.9'.

	spec for: #'pharo5.x' version: '0.2.11'.
]

{ #category : #versions }
ConfigurationOfPharoLauncher >> version020: spec [
	<version: '0.2.0' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.0'.
		spec author: 'DamienCassou'.
		spec timestamp: '9/14/2014 21:23'.
		spec 
			project: 'XMLParser' with: '1.6.5';
			project: 'OSProcess' with: '4.5.8';
			project: 'JSON' with: '1.0';
			project: 'Ston' with: '0.9'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-DamienCassou.63';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-TimMackinnon.34';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-TimMackinnon.9'. ].

]

{ #category : #versions }
ConfigurationOfPharoLauncher >> version0210: spec [
	<version: '0.2.10' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.10'.
		spec author: 'VincentBlondeau'.
		spec timestamp: '1/14/2016 10:45'.
		spec 
			project: 'XMLParser' with: '2.5.7';
			project: 'OSProcess' with: '4.6.4';
			project: 'JSON' with: '1.2';
			project: 'Ston' with: '0.15'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-CyrilFerlicot.88';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-VincentBlondeau.44';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-TimMackinnon.9'. ].

]

{ #category : #versions }
ConfigurationOfPharoLauncher >> version0211: spec [
	<version: '0.2.11' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.11
PharoLauncher now runs on top of Pharo 5.0 and is now shipped with both V3 anf Spur VM.
Add support to easily run Pharo 6.0 images.
PharoLauncher now embed th latest pharo stable image for off-line use.
Better display of Jenkins jobs.'.
		spec author: 'ChristopheDemarey'.
		spec timestamp: '5/18/2016 09:25'.
		spec 
			project: 'XMLParser' with: '2.7.6';
			project: 'OSProcess' with: '4.6.4';
			project: 'JSON' with: '1.2';
			project: 'Ston' with: '0.19'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-ChristopheDemarey.102';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-ChristopheDemarey.47';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-ChristopheDemarey.11'. ].

]

{ #category : #versions }
ConfigurationOfPharoLauncher >> version0212: spec [
	<version: '0.2.12' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.12
Run on Pharo 5.0. Fixes the browse folder problem on Windows and added a filter for the images'.
		spec author: 'TorstenBergmann'.
		spec timestamp: '5/18/2016 09:25'.
		spec 
			project: 'XMLParser' with: '2.7.6';
			project: 'OSProcess' with: '4.6.4';
			project: 'JSON' with: '1.2';
			project: 'Ston' with: '0.19'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-TorstenBergmann.103';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-TorstenBergmann.48';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-ChristopheDemarey.11'. ].

]

{ #category : #versions }
ConfigurationOfPharoLauncher >> version0213: spec [
	<version: '0.2.13' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.13
Add a VM management utility able to find (and download) the appropriate VM for a given image. So, the launcher is not shipped anymore with an extra VM.
Pharo Launcher files (images, VMs) are now considered as user Documents. Consequently, they are now stored in the standard documents folder of the OS except for Linux, lancher files are stored in the $HOME directory'.
		spec author: 'Christophe Demarey'.
		spec timestamp: '7/21/2017 13:52'.
		spec 
			project: 'XMLParser' with: '3.1.8';
			project: 'OSProcess' with: '4.6.4';
			project: 'JSON' with: '1.2';
			project: 'Ston' with: '0.24'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-PeterUhnak.120';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-BenComan.50';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-ChristopheDemarey.14'. ].

]

{ #category : #versions }
ConfigurationOfPharoLauncher >> version021: spec [
	<version: '0.2.1' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.1'.
		spec author: 'BenComan'.
		spec timestamp: '9/22/2014 23:50'.
		spec 
			project: 'XMLParser' with: '1.6.5';
			project: 'OSProcess' with: '4.5.8';
			project: 'JSON' with: '1.0';
			project: 'Ston' with: '0.9'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-NicolaiHess.64';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-NicolaiHess.35';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-TimMackinnon.9'. ].

]

{ #category : #versions }
ConfigurationOfPharoLauncher >> version022: spec [
	<version: '0.2.2' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.2'.
		spec author: 'DamienCassou'.
		spec timestamp: '2/11/2015 16:03'.
		spec 
			project: 'XMLParser' with: '1.9.0';
			project: 'OSProcess' with: '4.5.12';
			project: 'JSON' with: '1.0';
			project: 'Ston' with: '0.10'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-DamienCassou.68';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-DamienCassou.37';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-TimMackinnon.9'. ].

]

{ #category : #versions }
ConfigurationOfPharoLauncher >> version023: spec [
	<version: '0.2.3' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.3'.
		spec author: 'DamienCassou'.
		spec timestamp: '2/13/2015 11:01'.
		spec 
			project: 'XMLParser' with: '1.9.0';
			project: 'OSProcess' with: '4.5.12';
			project: 'JSON' with: '1.0';
			project: 'Ston' with: '0.10'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-DamienCassou.68';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-DamienCassou.37';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-TimMackinnon.9'. ].

]

{ #category : #versions }
ConfigurationOfPharoLauncher >> version024: spec [
	<version: '0.2.4' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.4'.
		spec author: 'DamienCassou'.
		spec timestamp: '2/13/2015 11:15'.
		spec 
			project: 'XMLParser' with: '1.9.0';
			project: 'OSProcess' with: '4.5.12';
			project: 'JSON' with: '1.0';
			project: 'Ston' with: '0.10'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-DamienCassou.69';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-DamienCassou.37';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-TimMackinnon.9'. ].

]

{ #category : #versions }
ConfigurationOfPharoLauncher >> version025: spec [
	<version: '0.2.5' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.5, Pharo5'.
		spec author: 'TorstenBergmann'.
		spec timestamp: '2/13/2015 11:15'.
		spec 
			project: 'XMLParser' with: '1.9.0';
			project: 'OSProcess' with: '4.5.12';
			project: 'JSON' with: '1.0';
			project: 'Ston' with: '0.10'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-TorstenBergmann.72';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-TorstenBergmann.38';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-TimMackinnon.9'. ].

]

{ #category : #versions }
ConfigurationOfPharoLauncher >> version026: spec [
	<version: '0.2.6' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.6'.
		spec author: 'DamienCassou'.
		spec timestamp: '4/17/2015 17:17'.
		spec 
			project: 'XMLParser' with: '2.3.0';
			project: 'OSProcess' with: '4.5.13';
			project: 'JSON' with: '1.1';
			project: 'Ston' with: '0.12'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-DamienCassou.74';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-DamienCassou.40';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-TimMackinnon.9'. ].

]

{ #category : #versions }
ConfigurationOfPharoLauncher >> version027: spec [
	<version: '0.2.7' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.7'.
		spec author: 'DamienCassou'.
		spec timestamp: '4/20/2015 10:02'.
		spec 
			project: 'XMLParser' with: '2.3.0';
			project: 'OSProcess' with: '4.5.13';
			project: 'JSON' with: '1.1';
			project: 'Ston' with: '0.12'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-DamienCassou.75';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-DamienCassou.40';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-TimMackinnon.9'. ].

]

{ #category : #versions }
ConfigurationOfPharoLauncher >> version028: spec [
	<version: '0.2.8' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.8'.
		spec author: 'DamienCassou'.
		spec timestamp: '8/8/2015 07:55'.
		spec 
			project: 'XMLParser' with: '2.4.9';
			project: 'OSProcess' with: '4.6.4';
			project: 'JSON' with: '1.1';
			project: 'Ston' with: '0.14'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-SeanDeNigris.78';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-DamienCassou.40';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-TimMackinnon.9'. ].

]

{ #category : #versions }
ConfigurationOfPharoLauncher >> version029: spec [
	<version: '0.2.9' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2.9'.
		spec author: 'StephanEggermont'.
		spec timestamp: '13/1/2016 16:40'.
		spec 
			project: 'XMLParser' with: '2.5.6';
			project: 'OSProcess' with: '4.6.4';
			project: 'JSON' with: '1.2';
			project: 'Ston' with: '0.15'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-StephanEggermont.87';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-CyrilFerlicot.42';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-TimMackinnon.9'. ].

]

{ #category : #versions }
ConfigurationOfPharoLauncher >> version101: spec [
	<version: '1.0.1' imports: #('1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.1
Avoid to scan unattended folders when using VM shipped with the launcher.
Overwrite files when downloading or unzipping.
Catch NotFound error and give better error message.
Fix issue 21: cannot detect unzip availability on windows'.
		spec author: 'Christophe Demarey'.
		spec timestamp: '10/05/2017 12:19'.
		spec 
			project: 'XMLParser' with: '3.1.8';
			project: 'OSProcess' with: '4.6.4';
			project: 'JSON' with: '1.2';
			project: 'Ston' with: '0.24'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-ChristopheDemarey.139';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-ChristopheDemarey.53';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-ChristopheDemarey.19'. ].

]

{ #category : #versions }
ConfigurationOfPharoLauncher >> version10: spec [
	<version: '1.0' imports: #('1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0
Add a VM management utility able to find (and download) the appropriate VM for a given image. So, the launcher is not shipped anymore with an extra VM.
Pharo Launcher files (images, VMs) are now considered as user Documents. Consequently, they are now stored in the standard documents folder of the OS except for Linux, lancher files are stored in the $HOME directory'.
		spec author: 'Christophe Demarey'.
		spec timestamp: '9/29/2017 14:20'.
		spec 
			project: 'XMLParser' with: '3.1.8';
			project: 'OSProcess' with: '4.6.4';
			project: 'JSON' with: '1.2';
			project: 'Ston' with: '0.24'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-ChristopheDemarey.134';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-ChristopheDemarey.52';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-ChristopheDemarey.19'. ].

]

{ #category : #versions }
ConfigurationOfPharoLauncher >> version11: spec [
	<version: '1.1.1' imports: #('1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.1.1
Bux fixes:
  #67 bash is not a command usable under windows
'.
		spec author: 'Christophe Demarey'.
		spec timestamp: '01/20/2018 14:49'.
		spec 
			project: 'XMLParser' with: '3.1.8';
			project: 'OSProcess' with: '4.6.9';
			project: 'JSON' with: '1.2';
			project: 'Ston' with: '0.24'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-VincentBlondeau.170';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-ChristopheDemarey.64';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-ChristopheDemarey.23'. ].

]

{ #category : #versions }
ConfigurationOfPharoLauncher >> version12: spec [
	<version: '1.2' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.2
New features:
	#21 Bless the DMG
	#46 sign pharo launcher app for windows
	#103 No way to rename a local template
	#107 Unable to add a description for the image using the Launcher UI
	#121 You can''t see/sort images by last modified date
Improvements:
	#69 Import command should also import pharo-local directory
	#70 Import command should delete origin folder if empty
	#73 Managers of Download of VMs and images should be in their own packages
	#76 Use https instead of http to requests the pharo file server
	#82 Official Distributions loads 32bit versions on 64bit System (i.e. provide better information on templates architecture)
	#86 Sort Existing Images Case-Insensitive
	#98 Copy and subfolders problem (contents no copied)
	#101 Templates from a local image are listed in "downloaded". "local" would be a better name
	#102 Template Cleared at Startup setting is enabled, making it weird when trying to use the template feature
	#106 Import could work if we select the parent folder of an image
	#109 Use latest pre-Spur VM to determine the image version
	#122 The Run without settings icon looks like a funny grey/which blob (missing alpha correction)
Bux fixes:
	#41 #selectedMorphList was sent to nil
	#67 bash is not a command usable under windows
	#68 Does not launch images on Windows
	#85 Double click on an existing image open a file selector
	#88 Pharo Launcher on Windows > Failing
	#104 GUI bug makes Launcher unusable
	#110 Image launch not reliable on Windows
	#119 MessageNotUnderstood exception on launch
	#123 The status bar of the Launcher is broken, so can''t easily show image descriptions '.
		spec author: 'Christophe Demarey'.
		spec timestamp: '06/19/2018 13:49'.
		spec 
			project: 'XMLParser' with: '3.5.0';
			project: 'OSProcess' with: '4.6.13';
			project: 'ProcessWrapper' with: '1.2';
			project: 'JSON' with: '1.2';
			project: 'Ston' with: '0.24'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-ChristopheDemarey.197';
			package: #'PharoLauncher-Download' with: 'PharoLauncher-Download-ChristopheDemarey.13';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-CyrilFerlicot.71';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-ChristopheDemarey.25';
			package: #'PharoLauncher-Tests-Download' with: 'PharoLauncher-Tests-Download-ChristopheDemarey.4'. ].
]

{ #category : #versions }
ConfigurationOfPharoLauncher >> version13: spec [
	<version: '1.3' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.3
Improvements:
	#129 Warning that appear everytime when you run a 32 bits image in a 64 bits VM PharoLauncher'.
		spec author: 'Christophe Demarey'.
		spec timestamp: '06/21/2018 15:05'.
		spec 
			project: 'XMLParser' with: '3.5.0';
			project: 'OSProcess' with: '4.6.13';
			project: 'ProcessWrapper' with: '1.2';
			project: 'JSON' with: '1.2';
			project: 'Ston' with: '0.24'.
		spec 
			package: #'PharoLauncher-Core' with: 'PharoLauncher-Core-ChristopheDemarey.198';
			package: #'PharoLauncher-Download' with: 'PharoLauncher-Download-ChristopheDemarey.13';
			package: #'PharoLauncher-Spec' with: 'PharoLauncher-Spec-CyrilFerlicot.71';
			package: #'PharoLauncher-Tests-Core' with: 'PharoLauncher-Tests-Core-ChristopheDemarey.25';
			package: #'PharoLauncher-Tests-Download' with: 'PharoLauncher-Tests-Download-ChristopheDemarey.4'. ].
]
