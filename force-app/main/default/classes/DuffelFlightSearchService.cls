public with sharing class DuffelFlightSearchService {

    @AuraEnabled
    public static List<FlightOfferWrapper> searchFlights(
        String origin,
        String destination,
        Date departureDate,
        Integer adults,
        String cabinClass
    ) {

        String response = DuffelService.createOfferRequest(
            origin,
            destination,
            departureDate,
            adults,
            cabinClass
        );
        
        Map<String,Object> responseMap =
    (Map<String,Object>)JSON.deserializeUntyped(response);

        List<FlightOfferWrapper> offersList = new List<FlightOfferWrapper>();

        FlightOfferWrapper wrapper = new FlightOfferWrapper();

wrapper.offerId = 'TEST001';
wrapper.airline = 'Duffel';
wrapper.origin = origin;
wrapper.destination = destination;
wrapper.price = 0;
wrapper.currencyCode = 'USD';
wrapper.cabinClass = cabinClass;

offersList.add(wrapper);
        return offersList;
    }
}