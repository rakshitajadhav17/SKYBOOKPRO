public with sharing class FlightService {

    @AuraEnabled
    public static Id createFlight(FlightOfferWrapper offer) {

        Flight__c flight = new Flight__c();

        // Flight Number
        if(String.isBlank(offer.flightNumber)){
            flight.Flight_Number__c = offer.offerId;
        }
        else{
            flight.Flight_Number__c = offer.flightNumber;
        }

        // Airline
        flight.Airline_Name__c = offer.airline;

        // Origin
        flight.Origin_Airport__c = offer.origin;

        // Destination
        flight.Destination_Airport__c = offer.destination;

        // Departure
        if(!String.isBlank(offer.departureTime)){
            flight.Departure_DateTime__c =
                DateTime.valueOf(offer.departureTime);
        }

        // Arrival
        if(!String.isBlank(offer.arrivalTime)){
            flight.Arrival_DateTime__c =
                DateTime.valueOf(offer.arrivalTime);
        }

        // Status
        flight.Status__c = 'Active';

        insert flight;

        return flight.Id;

    }

}