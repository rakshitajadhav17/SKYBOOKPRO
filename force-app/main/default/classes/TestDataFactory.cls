@isTest
public class TestDataFactory {

    public static Account createAccount(String name) {

        Account acc = new Account(
            Name = name
        );

        insert acc;

        return acc;
    }

    public static Contact createContact(
        Id accountId,
        String firstName,
        String lastName
    ) {

        Contact con = new Contact(
            AccountId = accountId,
            FirstName = firstName,
            LastName = lastName,
            Email = 'test@test.com'
        );

        insert con;

        return con;
    }

    public static Flight__c createFlight(
        String origin,
        String destination,
        Datetime departure
    ) {

       Flight__c flight = new Flight__c(
    Flight_Number__c = 'AI101',
    Origin_Airport__c = origin,
    Destination_Airport__c = destination,
    Departure_DateTime__c = departure,
    Arrival_DateTime__c = departure.addHours(2),
    Airline_Name__c = 'Air India',
    Status__c = 'Active'
);

        insert flight;

        return flight;
    }

    public static Booking__c createBooking(
        Id contactId,
        Id flightId,
        Integer seats
    ) {

        Booking__c booking = new Booking__c(
            Passenger__c = contactId,
            Contact__c = contactId,
            Flight__c = flightId,
            Seat_Class__c = 'Economy',
            Number_of_Seats__c = seats,
            Base_Fare__c = 5000,
            Taxes_Fees__c = 500,
            Booking_Status__c = 'Draft',
            Booking_Date__c = Date.today()
        );

        insert booking;

        return booking;
    }
}