@isTest
private class BookingServiceTest {

    @isTest
    static void testCreateBooking() {

        Test.startTest();

        Booking__c booking = BookingService.createBooking(

            'TEST001',
            '6E3754',
            'IndiGo',
            'BLR',
            'DEL',
            5000,
            'Economy',
            1,
            'Test',
            'User',
            'test@example.com',
            Date.newInstance(2000, 1, 1),
            'P1234567',
            'Adult',
            'Veg'

        );

        Test.stopTest();

        System.assertNotEquals(null, booking);
        System.assertNotEquals(null, booking.Id);

        Booking__c savedBooking = [

            SELECT Id,
                   Account__c,
                   Contact__c,
                   Flight__c,
                   Seat_Class__c,
                   Number_of_Seats__c,
                   Base_Fare__c,
                   Booking_Status__c

            FROM Booking__c

            WHERE Id = :booking.Id

        ];

        System.assertNotEquals(null, savedBooking.Account__c);
        System.assertNotEquals(null, savedBooking.Contact__c);
        System.assertNotEquals(null, savedBooking.Flight__c);

        System.assertEquals('Economy', savedBooking.Seat_Class__c);
        System.assertEquals(1, savedBooking.Number_of_Seats__c);
        System.assertEquals(5000, savedBooking.Base_Fare__c);
        System.assertEquals('Confirmed', savedBooking.Booking_Status__c);

    }

    @isTest
    static void testCreateBookingWithDifferentValues() {

        Test.startTest();

        Booking__c booking = BookingService.createBooking(

            'TEST002',
            'AI315',
            'Air India',
            'BOM',
            'HYD',
            7500,
            'Business',
            2,
            'Rakshita',
            'Jadhav',
            'rakshita@example.com',
            Date.newInstance(2003, 5, 17),
            'A9876543',
            'Adult',
            'Non Veg'

        );

        Test.stopTest();

        Booking__c savedBooking = [

            SELECT Id,
                   Account__c,
                   Contact__c,
                   Flight__c,
                   Seat_Class__c,
                   Number_of_Seats__c,
                   Base_Fare__c,
                   Booking_Status__c

            FROM Booking__c

            WHERE Id = :booking.Id

        ];

        System.assertNotEquals(null, savedBooking.Account__c);
        System.assertNotEquals(null, savedBooking.Contact__c);
        System.assertNotEquals(null, savedBooking.Flight__c);

        System.assertEquals(2, savedBooking.Number_of_Seats__c);
        System.assertEquals('Business', savedBooking.Seat_Class__c);
        System.assertEquals(7500, savedBooking.Base_Fare__c);
        System.assertEquals('Confirmed', savedBooking.Booking_Status__c);

    }

}