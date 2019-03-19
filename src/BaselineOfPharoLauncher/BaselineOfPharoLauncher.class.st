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
			baseline: #TaskIt
				with: [ 
					spec 
						repository: 'github://sbragagnolo/taskit:v1.0.1';
						loads: 'minimal' ];
			baseline: #Icetray
				with: [ spec repository: 'github://pharo-spec/icetray/src' ];
			package: #FastTableExtentions
				with: [ spec repository: 'github://sbragagnolo/FastTableExtention/src' ].
		spec
			package: #'PharoLauncher-ZipArchive'; 
			package: #'PharoLauncher-Core' with: [
				spec requires: #(#'XMLParser' #'Ston' #'OSProcess' #'ProcessWrapper' #'PharoLauncher-ZipArchive'). ];
			package: #'PharoLauncher-Spec' with: [ 
				spec requires: #(#'PharoLauncher-Core' ). ];
			package: #'PharoLauncher-IceTray' with: [ spec
				requires: #(#'PharoLauncher-Core' #Icetray #FastTableExtentions) ];

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
]
