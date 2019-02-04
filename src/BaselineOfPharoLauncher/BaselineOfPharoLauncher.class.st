Class {
	#name : #BaselineOfPharoLauncher,
	#superclass : #BaselineOf,
	#category : 'BaselineOfPharoLauncher'
}

{ #category : #baselines }
BaselineOfPharoLauncher >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
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
					repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/' ];
			baseline: #Icetray
				with: [ spec repository: 'github://pharo-spec/icetray/src' ];
			package: #FastTableExtentions
				with: [ spec repository: 'github://sbragagnolo/FastTableExtention/src' ].
		spec
			package: #'ConfigurationOfPharoLauncher'; 
			package: #'PharoLauncher-Core' with: [
				spec requires: #(#'XMLParser' #'Ston' #'OSProcess' #'ProcessWrapper'). ];
			package: #'PharoLauncher-Spec' with: [ 
				spec requires: #(#'PharoLauncher-Core' ). ];
			package: #'PharoLauncher-IceTray' with: [ spec
				requires: #(#'PharoLauncher-Core' #Icetray #FastTableExtentions) ];
			for: #'pharo6.x' do: [
				spec 
					package: #'PharoLauncher-Pharo6';
	            package: #'PharoLauncher-Core' with: [ 
 	               spec requires: #(#'PharoLauncher-Pharo6') ].
			];

			package: #'PharoLauncher-Tests-Core' with: [
				spec requires: #(#'PharoLauncher-Core' ). ];
			package: #'PharoLauncher-Tests-SpecUI' with: [
				spec requires: #(#'PharoLauncher-Core' #'PharoLauncher-Spec'). ];
			package: #'PharoLauncher-Tests-Download' with: [
				spec requires: #(#'PharoLauncher-Tests-Core' ). ];
			package: #'PharoLauncher-Tests-Functional' with: [
				spec requires: #(#'PharoLauncher-Core' #'PharoLauncher-Tests-Download'). ].
		spec 
			group: 'Default' with: #(#'PharoLauncher-Tests-Core' #'PharoLauncher-Tests-Download' #'PharoLauncher-Core' #'PharoLauncher-Spec' #'PharoLauncher-Tests-SpecUI' #'PharoLauncher-Tests-Functional' #'PharoLauncher-IceTray'). ].

	spec for: #'pharo6.x' do: [	
		self spec70: spec.
		spec
			baseline: 'PharoWin32' with: [
				spec
					repository: 'github://tesonep/pharo-com' ].
		spec 
			package: #'PharoLauncher-Env';
			package: #'PharoLauncher-Core' with: [
				spec requires: #(#'PharoLauncher-Env'). ];
			package: #'PharoLauncher-Spec' with: [ 
				spec requires: #(#'Spec70Compatibility') ] ]
]

{ #category : #baselines }
BaselineOfPharoLauncher >> spec70: spec [
	"for pharo6 compatibility"
	spec
		baseline: 'Spec70Compatibility' 
		with: [ spec repository: 'github://pharo-contributions/Spec70Compatibility:v1.0.0/src' ]
]
