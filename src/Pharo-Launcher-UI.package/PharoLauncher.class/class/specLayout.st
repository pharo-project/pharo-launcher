specs
specLayout
	<spec: #default>
	^ SpecLayout composed
			newRow: 
			[ 	:r | r 
				newColumn: 
				[ 	:c2 | c2
					add: #imagesModel ;
					add: #quitOnLaunchCheckBoxModel height: 25 "2013-10-13-BTC How do you left justfiy checkbox?"						
				] right: 0.66; 
				addSplitter;
				newColumn:
				[	:c3 | c3
					add: #templatesModel;
					add: #statusbarModel height: 25
				] left: 0.34
			];
			yourself.