public with sharing class BookingService {

    @AuraEnabled(cacheable=false)
    public static Booking__c createBooking(
        Id contactId,
        FlightOfferWrapper offer,
        Integer seats,
        String seatClass
    ) {
    FlightOfferWrapper confirmedOffer =
    DuffelFlightPricingService.confirmPrice(
        offer.offerId,
        '{}'
    );
        Booking__c booking = new Booking__c();
        
        booking.Contact__c = contactId;
booking.Seat_Class__c = seatClass;
booking.Number_of_Seats__c = seats;
booking.Booking_Status__c = 'Pending';

       try {

    insert booking;
    
    Passenger_Detail__c passenger = new Passenger_Detail__c();

passenger.Booking__c = booking.Id;

insert passenger;

Flight_Segment__c segment = new Flight_Segment__c();

segment.Booking__c = booking.Id;

insert segment;

    return booking;

} catch (DmlException e) {

    System.debug('Booking Error: ' + e.getMessage());

    return null;

}
    }
}