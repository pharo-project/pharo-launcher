Class {
	#name : #BaselineOfPharoLauncher,
	#superclass : #BaselineOf,
	#category : 'BaselineOfPharoLauncher'
}

{ #category : #baselines }
BaselineOfPharoLauncher >> baseline: spec [
	<baseline>
	spec for: #common do: [
		self externalProjects: spec.
		spec
			package: #ConfigurationOfPharoLauncher;
			package: #'PharoLauncher-Env';
			package: #'PharoLauncher-Core' with: [ spec requires: #(#'PharoLauncher-Env' #XMLParser #Ston #OSProcess #ProcessWrapper) ];
			package: #'PharoLauncher-Spec' with: [ spec requires: #(#'PharoLauncher-Core') ];
			package: #'PharoLauncher-IceTray' with: [ spec requires: #(#'PharoLauncher-Core' #Icetray #FastTableExtentions) ];
			package: #'PharoLauncher-Tests-Core' with: [ spec requires: #(#'PharoLauncher-Core') ];
			package: #'PharoLauncher-Tests-SpecUI' with: [ spec requires: #(#'PharoLauncher-Core' #'PharoLauncher-Spec') ];
			package: #'PharoLauncher-Tests-Download' with: [ spec requires: #(#'PharoLauncher-Tests-Core') ];
			package: #'PharoLauncher-Tests-Functional' with: [ spec requires: #(#'PharoLauncher-Core' #'PharoLauncher-Tests-Download') ];
			package: #'PharoLauncher-CommandLine' with: [ spec requires: #(#'PharoLauncher-Core' Clap) ].

		spec group: 'Default' with: #(
			#'PharoLauncher-Core'
			#'PharoLauncher-Spec'
			#'PharoLauncher-IceTray'
			#'PharoLauncher-Tests-Core'
			#'PharoLauncher-Tests-Download'
			#'PharoLauncher-Tests-SpecUI'
			#'PharoLauncher-Tests-Functional'
		) ].

	spec for: #'pharo6.x' do: [
		self spec70: spec.
		spec
			package: #'PharoLauncher-Pharo6';
			package: #'PharoLauncher-Core' with: [ spec requires: #(#'PharoLauncher-Pharo6') ];
			package: #'PharoLauncher-Spec' with: [ spec requires: #(#Spec70Compatibility) ] ]
]

{ #category : #baselines }
BaselineOfPharoLauncher >> externalProjects: spec [
	spec
		baseline: 'Clap' with: [ spec repository: 'github://cdlm/clap-st/src'; loads: #(core) ];
		project: 'Ston'
			with: [ spec
				repository: 'http://ss3.gemstone.com/ss/STON';
				className: #ConfigurationOfSton;
				versionString: #stable ];
		project: 'XMLParser'
			with: [ spec
				repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/';
				className: #ConfigurationOfXMLParser;
				versionString: #stable;
				loads: #('Core') ];
		project: 'OSProcess'
			with: [ spec
				repository: 'http://www.squeaksource.com/MetacelloRepository';
				className: #ConfigurationOfOSProcess;
				versionString: #stable;
				loads: #('Core with Output') ];
		project: 'ProcessWrapper'
			with: [ spec
				repository: 'http://smalltalkhub.com/mc/hernan/ProcessWrapper/main/';
				className: #ConfigurationOfProcessWrapper;
				versionString: #bleedingEdge;
				loads: #('Core') ];
		baseline: 'PharoWin32' with: [ spec repository: 'github://tesonep/pharo-com' ];
		baseline: #Icetray with: [ spec repository: 'github://guillep/icetray/src' ];
		package: #FastTableExtentions with: [ spec repository: 'github://sbragagnolo/FastTableExtention/src' ]
]

{ #category : #baselines }
BaselineOfPharoLauncher >> spec70: spec [
	"for pharo6 compatibility"
	spec
		baseline: 'Spec70Compatibility' 
		with: [ spec repository: 'github://pharo-contributions/Spec70Compatibility:v1.0.0/src' ]
]
