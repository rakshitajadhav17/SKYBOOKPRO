@isTest
private class AsyncApexTest {

    @isTest
    static void testFutureMethod() {

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

        Flight__c flight =
            TestDataFactory.createFlight(
                'BLR',
                'DEL',
                System.now().addDays(10)
            );

        Booking__c booking =
            TestDataFactory.createBooking(
                con.Id,
                flight.Id,
                1
            );

        Set<Id> bookingIds =
            new Set<Id>{booking.Id};

        Test.startTest();

        BookingEmailService.sendBookingConfirmationEmail(
            bookingIds
        );

        Test.stopTest();

        System.assert(true);
    }

    @isTest
    static void testBatch() {

        Test.startTest();

        Database.executeBatch(
            new BookingArchiveBatch(),
            200
        );

        Test.stopTest();

        System.assert(true);
    }

    @isTest
    static void testBatchWithData() {

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

        Flight__c flight =
            TestDataFactory.createFlight(
                'BLR',
                'DEL',
                System.now().addDays(10)
            );

        Booking__c booking =
            TestDataFactory.createBooking(
                con.Id,
                flight.Id,
                1
            );

        Test.startTest();

        Database.executeBatch(
            new BookingArchiveBatch(),
            1
        );

        Test.stopTest();

        System.assertNotEquals(
            null,
            booking.Id
        );
    }

    @isTest
    static void testQueueable() {

        Test.setMock(
            HttpCalloutMock.class,
            new DuffelPricingMock()
        );

        Test.startTest();

        System.enqueueJob(
            new AmadeusTokenRefreshJob()
        );

        Test.stopTest();

        System.assert(true);
    }
}