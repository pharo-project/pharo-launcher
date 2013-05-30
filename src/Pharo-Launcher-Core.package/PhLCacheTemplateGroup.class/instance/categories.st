accessing
categories
	^ categories ifNil: [ categories := templateCategoryMap keys ]