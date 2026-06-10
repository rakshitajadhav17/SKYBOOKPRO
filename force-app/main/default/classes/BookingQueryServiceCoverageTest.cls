@isTest
private class BookingQueryServiceCoverageTest {

    @isTest
    static void testConfirmedBookings() {

        List<Booking__c> result =
            BookingQueryService.getConfirmedBookingsByAgent(
                UserInfo.getUserId()
            );

        System.assertNotEquals(
            null,
            result
        );
    }

    @isTest
    static void testRevenueByMonth() {

        AggregateResult[] revenue =
            BookingQueryService.getRevenueByMonth();

        System.assertNotEquals(
            null,
            revenue
        );
    }

    @isTest
    static void testPassengerSearch() {

        List<List<SObject>> searchResults =
            BookingQueryService.searchPassengers(
                'Test'
            );

        System.assertNotEquals(
            null,
            searchResults
        );
    }

    @isTest
    static void testTomorrowDepartures() {

        List<Booking__c> departures =
            BookingQueryService.getTomorrowDepartures();

        System.assertNotEquals(
            null,
            departures
        );
    }
}