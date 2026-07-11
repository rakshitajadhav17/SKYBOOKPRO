public with sharing class BookingService {

    @AuraEnabled(cacheable=false)
    public static Booking__c createBooking(
        String offerId,
        String flightNumber,
        String airline,
        String origin,
        String destination,
        Decimal price,
        String seatClass,
        Integer seats,
        String firstName,
        String lastName,
        String email,
        Date dateOfBirth,
        String passportNumber,
        String passengerType,
        String mealPreference
    ) {

        try {

            // Basic Validation
            if (String.isBlank(firstName) || String.isBlank(lastName)) {
                throw new AuraHandledException('First Name and Last Name are required.');
            }

            if (String.isBlank(offerId)) {
                throw new AuraHandledException('Offer Id is required.');
            }

            if (price == null || price <= 0) {
                throw new AuraHandledException('Invalid ticket price.');
            }

            //==============================
            // Create or Reuse Account
            //==============================

            Account acc;

            List<Account> accountList = [
                SELECT Id, Name
                FROM Account
                WHERE Name = :firstName + ' ' + lastName
                LIMIT 1
            ];

            if(accountList.isEmpty()){

                acc = new Account(
                    Name = firstName + ' ' + lastName
                );

                insert acc;

            }
            else{

                acc = accountList[0];

            }

            //==============================
            // Create Contact
            //==============================

            Contact contact = new Contact(

                FirstName = firstName,
                LastName = lastName,
                Email = email,
                AccountId = acc.Id

            );

            insert contact;

            // Create Flight
            Flight__c flight = new Flight__c(
                Flight_Number__c = flightNumber,
                Airline_Name__c = airline,
                Origin_Airport__c = origin,
                Destination_Airport__c = destination,
                Departure_DateTime__c = System.now().addDays(10),
                Arrival_DateTime__c = System.now().addDays(10).addHours(2),
                Status__c = 'Active'
            );
            insert flight;
            
            // Create Booking
            Booking__c booking = new Booking__c(

                Account__c = acc.Id,

                Contact__c = contact.Id,

                Passenger__c = contact.Id,

                Flight__c = flight.Id,

                Seat_Class__c = seatClass,

                Number_of_Seats__c = seats,

                Base_Fare__c = price,

                Taxes_Fees__c = 500,

                Booking_Status__c = 'Confirmed',

                Booking_Date__c = Date.today()

            );
            insert booking;

            // Create Passenger Detail
            Passenger_Detail__c passenger = new Passenger_Detail__c(
                Booking__c = booking.Id,
                First_Name__c = firstName,
                Last_Name__c = lastName,
                Date_of_Birth__c = dateOfBirth,
                Passport_Number__c = passportNumber,
                Passenger_Type__c = passengerType,
                Meal_Preference__c = mealPreference
            );
            insert passenger;

            // Create Flight Segment
            Flight_Segment__c segment = new Flight_Segment__c(
                Booking__c = booking.Id,
                Segment_Order__c = 1,
                Origin__c = origin,
                Destination__c = destination,
                Carrier_Code__c = airline.length() >= 2
                    ? airline.substring(0, 2).toUpperCase()
                    : airline.toUpperCase(),
                Flight_Number__c = flightNumber,
                Departure_DateTime__c = flight.Departure_DateTime__c,
                Arrival_DateTime__c = flight.Arrival_DateTime__c
            );
            insert segment;
            // Query the booking again so Name (PNR) is populated
booking = [
    SELECT Id,
           Name,
           Booking_Status__c,
           Seat_Class__c,
           Booking_Date__c
    FROM Booking__c
    WHERE Id = :booking.Id
];
            return booking;

        } catch (Exception e) {
            System.debug('Booking Error: ' + e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }
}