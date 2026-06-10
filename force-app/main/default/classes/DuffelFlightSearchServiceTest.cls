@isTest
private class DuffelFlightSearchServiceTest {

    @isTest
    static void testSearchFlights() {

        Test.setMock(
            HttpCalloutMock.class,
            new DuffelPricingMock()
        );

        Test.startTest();

        List<FlightOfferWrapper> offers =
            DuffelFlightSearchService.searchFlights(
                'BLR',
                'DEL',
                Date.today().addDays(10),
                1,
                'Economy'
            );

        Test.stopTest();

        System.assertNotEquals(
            null,
            offers
        );

        System.assertEquals(
            1,
            offers.size()
        );
    }
}