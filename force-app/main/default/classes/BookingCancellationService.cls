public with sharing class BookingCancellationService {
@AuraEnabled
public static void cancelBooking(Id bookingId, String reason) {

    if (String.isBlank(reason)) {
        throw new AuraHandledException(
            'Please enter the reason for the cancellation.'
        );
    }

    Booking__c booking = [
        SELECT Id,
               Booking_Status__c,
               Cancellation_Reason__c
        FROM Booking__c
        WHERE Id = :bookingId
        LIMIT 1
    ];

    if (booking.Booking_Status__c == 'Cancelled') {
        throw new AuraHandledException(
            'Booking is already cancelled.'
        );
    }

    booking.Booking_Status__c = 'Cancelled';
    booking.Cancellation_Reason__c = reason;

    update booking;
}
}