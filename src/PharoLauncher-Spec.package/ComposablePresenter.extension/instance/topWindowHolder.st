*PharoLauncher-Spec
topWindowHolder
     ^ owner
            ifNil: [ window ]
            ifNotNil: [ :o | o topWindowHolder ].