@isTest
private class BookingTriggerTest {

    @isTest
    static void testBeforeInsert() {

        Account acc =
            TestDataFactory.createAccount(
                'Test Account'
            );

        Contact con =
            TestDataFactory.createContact(
                acc.Id,
                'Rakshita',
                'Jadhav'
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

        booking = [
            SELECT Booking_Status__c,
                   Booking_Date__c,
                   Agent__c
            FROM Booking__c
            WHERE Id = :booking.Id
        ];

        System.assertEquals(
            'Draft',
            booking.Booking_Status__c
        );
    }

    @isTest
    static void testCancelledToConfirmedValidation() {

        Account acc =
            TestDataFactory.createAccount('Test');

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
                System.now().addDays(5)
            );

        Booking__c booking =
            TestDataFactory.createBooking(
                con.Id,
                flight.Id,
                2
            );

        booking.Booking_Status__c = 'Cancelled';
        update booking;

        try {

            booking.Booking_Status__c =
                'Confirmed';

            update booking;

            System.assert(false);

        } catch(Exception e) {

            System.assert(true);
        }
    }

    @isTest
    static void testSeatReductionValidation() {

        Account acc =
            TestDataFactory.createAccount('Test');

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
                System.now().addDays(5)
            );

        Booking__c booking =
            TestDataFactory.createBooking(
                con.Id,
                flight.Id,
                5
            );

        try {

            booking.Number_of_Seats__c = 1;

            update booking;

            System.assert(false);

        } catch(Exception e) {

            System.assert(true);
        }
    }

    @isTest
    static void testConfirmedBookingEmail() {

        Account acc =
            TestDataFactory.createAccount('Test');

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
                System.now().addDays(5)
            );

        Booking__c booking = new Booking__c(
            Contact__c = con.Id,
            Passenger__c = con.Id,
            Flight__c = flight.Id,
            Seat_Class__c = 'Economy',
            Number_of_Seats__c = 1,
            Base_Fare__c = 1000,
            Taxes_Fees__c = 100,
            Booking_Status__c = 'Confirmed'
        );

        insert booking;

        System.assertNotEquals(
            null,
            booking.Id
        );
    }

   @isTest
static void testRefundCreation() {

    Account acc =
        TestDataFactory.createAccount(
            'Test'
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
            System.now().addDays(5)
        );

    Booking__c booking = new Booking__c();

    booking.Contact__c = con.Id;
    booking.Passenger__c = con.Id;
    booking.Flight__c = flight.Id;
    booking.Seat_Class__c = 'Economy';
    booking.Number_of_Seats__c = 1;
    booking.Base_Fare__c = 1000;
    booking.Taxes_Fees__c = 100;
    booking.Booking_Status__c = 'Draft';

    insert booking;

    Test.startTest();

    booking.Booking_Status__c = 'Cancelled';

    update booking;

    Test.stopTest();

    List<Refund__c> refunds = [
        SELECT Id,
               Refund_Status__c
        FROM Refund__c
        WHERE Booking__c = :booking.Id
    ];

    System.assertEquals(
        1,
        refunds.size()
    );
}
}