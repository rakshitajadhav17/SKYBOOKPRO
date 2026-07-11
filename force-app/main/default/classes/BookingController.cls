public with sharing class BookingController {

    @AuraEnabled(cacheable=true)
    public static List<Booking__c> getMyBookings() {

        return [

            SELECT
                Id,
                Name,
                Booking_Date__c,
                Booking_Status__c,
                Seat_Class__c,
                Passenger__r.Name,
                Flight__r.Airline_Name__c,
                Flight__r.Origin_Airport__c,
                Flight__r.Destination_Airport__c

            FROM Booking__c

            ORDER BY CreatedDate DESC

        ];

    }

    @AuraEnabled(cacheable=true)
    public static Booking__c getBookingDetails(Id bookingId) {

        return [

            SELECT
                Id,
                Name,
                Booking_Date__c,
                Booking_Status__c,
                Seat_Class__c,
                Number_of_Seats__c,
                Base_Fare__c,
                Taxes_Fees__c,
                Total_Amount__c,
                Passenger__r.Name,
                Flight__r.Airline_Name__c,
                Flight__r.Origin_Airport__c,
                Flight__r.Destination_Airport__c,
                Flight__r.Departure_DateTime__c,
                Flight__r.Arrival_DateTime__c

            FROM Booking__c

            WHERE Id = :bookingId

            LIMIT 1

        ];

    }

    @AuraEnabled
    public static void cancelBooking(Id bookingId, String reason) {

        Booking__c booking = [

            SELECT Id,
                   Booking_Status__c

            FROM Booking__c

            WHERE Id = :bookingId

            LIMIT 1

        ];

        booking.Booking_Status__c = 'Cancelled';
        booking.Cancellation_Reason__c = reason;

        update booking;

        Refund__c refund = new Refund__c();

        refund.Booking__c = booking.Id;
        refund.Refund_Status__c = 'Requested';
        refund.Refund_Amount__c = 1000;

        insert refund;

    }

    @AuraEnabled(cacheable=true)
    public static Refund__c getRefundStatus(Id bookingId) {

        return [

            SELECT
                Id,
                Refund_Status__c,
                Refund_Amount__c,
                Booking__c

            FROM Refund__c

            WHERE Booking__c = :bookingId

            LIMIT 1

        ];

    }

}