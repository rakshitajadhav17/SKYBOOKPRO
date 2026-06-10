public with sharing class BookingQueryService {

    // Get confirmed bookings by agent
    public static List<Booking__c> getConfirmedBookingsByAgent(Id userId) {

        return [
            SELECT Id, Name, Total_Amount__c
            FROM Booking__c
            WHERE Agent__c = :userId
            AND Booking_Status__c = 'Confirmed'
        ];
    }

    // Upcoming departures for reminder flow
    public static List<Booking__c> getTomorrowDepartures() {

        return [
            SELECT Id
            FROM Booking__c
            WHERE Flight__r.Departure_DateTime__c = TOMORROW
            AND Booking_Status__c = 'Confirmed'
        ];
    }

    // Revenue aggregation by month
    public static AggregateResult[] getRevenueByMonth() {

    return [
        SELECT CALENDAR_MONTH(CreatedDate),
               SUM(Total_Amount__c) revenue
        FROM Booking__c
        GROUP BY CALENDAR_MONTH(CreatedDate)
    ];
}

    // Passenger Search (SOSL)
    public static List<List<SObject>> searchPassengers(String searchTerm) {

        return [
            FIND :searchTerm
            IN ALL FIELDS
            RETURNING
            Contact(Id, Name, Email),
            Booking__c(Name, Booking_Status__c)
        ];
    }
}