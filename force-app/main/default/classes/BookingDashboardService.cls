public with sharing class BookingDashboardService {

    @AuraEnabled(cacheable=true)
    public static List<Booking__c> getMyBookings() {

        return [

            SELECT
                Id,
                Name,
                Booking_Status__c,
                Booking_Date__c,
                Seat_Class__c,
                Number_of_Seats__c,
                Total_Amount__c,

                Flight__r.Airline_Name__c,
                Flight__r.Flight_Number__c,
                Flight__r.Origin_Airport__c,
                Flight__r.Destination_Airport__c,
                Flight__r.Departure_DateTime__c,
                Flight__r.Arrival_DateTime__c

            FROM Booking__c

            WHERE Agent__c = :UserInfo.getUserId()

            ORDER BY CreatedDate DESC

        ];

    }

}