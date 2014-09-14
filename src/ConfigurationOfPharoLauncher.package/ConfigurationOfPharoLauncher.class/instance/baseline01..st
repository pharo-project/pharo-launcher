baselines
baseline01: spec
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
					repository: '/home/cassou/Documents/smalltalk/cache';
					repository: 'http://smalltalkhub.com/mc/PharoExtras/XMLParser/main/' ];
			project: 'OSProcess' with: [
				spec
					className: #ConfigurationOfOSProcess;
					versionString: #'stable';
					loads: #('Core' );
					repository: '/home/cassou/Documents/smalltalk/cache';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ];
			project: 'JSON' with: [
				spec
					className: #ConfigurationOfJSON;
					versionString: #'stable';
					repository: '/home/cassou/Documents/smalltalk/cache';
					repository: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main/' ];
			project: 'Ston' with: [
				spec
					className: #ConfigurationOfSton;
					versionString: #'stable';
					repository: '/home/cassou/Documents/smalltalk/cache';
					repository: 'http://ss3.gemstone.com/ss/STON' ].
		spec 
			package: #'PharoLauncher-Core' with: [
				spec requires: #('XMLParser' 'OSProcess' 'Ston' 'JSON' ). ];
			package: #'PharoLauncher-Spec' with: [
				spec requires: #(#'PharoLauncher-Core' ). ];
			package: #'PharoLauncher-Tests-Core' with: [
				spec requires: #(#'PharoLauncher-Core' ). ]. ].
