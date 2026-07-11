public with sharing class BookingDetailService {

    @AuraEnabled(cacheable=true)
    public static Booking__c getBookingDetails(Id bookingId){

        return [

            SELECT
                Id,
                Name,
                Booking_Status__c,
                Booking_Date__c,
                Seat_Class__c,
                Number_of_Seats__c,
                Base_Fare__c,
                Taxes_Fees__c,
                Total_Amount__c,

                Passenger__r.FirstName,
                Passenger__r.LastName,
                Passenger__r.Email,

                Flight__r.Airline_Name__c,
                Flight__r.Flight_Number__c,
                Flight__r.Origin_Airport__c,
                Flight__r.Destination_Airport__c,
                Flight__r.Departure_DateTime__c,
                Flight__r.Arrival_DateTime__c

            FROM Booking__c

            WHERE Id = :bookingId

            LIMIT 1

        ];

    }

}