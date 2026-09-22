sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"salesorders/test/integration/pages/HeaderList.gen",
	"salesorders/test/integration/pages/HeaderObjectPage.gen",
	"salesorders/test/integration/pages/ItemObjectPage.gen"
], function (JourneyRunner, HeaderListGenerated, HeaderObjectPageGenerated, ItemObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('salesorders') + '/test/flp.html#app-preview',
        pages: {
			onTheHeaderListGenerated: HeaderListGenerated,
			onTheHeaderObjectPageGenerated: HeaderObjectPageGenerated,
			onTheItemObjectPageGenerated: ItemObjectPageGenerated
        },
        async: true
    });

    return runner;
});

