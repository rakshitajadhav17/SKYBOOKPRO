@isTest
private class BookingServiceTest {

    @isTest
    static void testCreateBooking() {

        Test.setMock(
            HttpCalloutMock.class,
            new DuffelPricingMock()
        );

        Account acc =
            TestDataFactory.createAccount(
                'Test Account'
            );

        Contact con =
            TestDataFactory.createContact(
                acc.Id,
                'Test',
                'User'
            );

        FlightOfferWrapper offer =
            new FlightOfferWrapper();

        offer.offerId = 'TEST001';

        Test.startTest();

        Booking__c booking =
            BookingService.createBooking(
                con.Id,
                offer,
                1,
                'Economy'
            );

        Test.stopTest();

        System.assertNotEquals(
            null,
            booking
        );
    }

    @isTest
    static void testCreateBookingFailure() {

        Test.setMock(
            HttpCalloutMock.class,
            new DuffelPricingMock()
        );

        FlightOfferWrapper offer =
            new FlightOfferWrapper();

        offer.offerId = 'TEST001';

        Test.startTest();

        Booking__c booking =
            BookingService.createBooking(
                null,
                offer,
                1,
                'Economy'
            );

        Test.stopTest();

        System.assertEquals(
            null,
            booking
        );
    }
}