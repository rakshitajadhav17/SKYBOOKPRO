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

        Map<String,Object> data =
            (Map<String,Object>)responseMap.get('data');

        List<Object> offers =
            (List<Object>)data.get('offers');

        List<FlightOfferWrapper> wrapperList =
            new List<FlightOfferWrapper>();

        Integer count = 0;

        for (Object obj : offers) {

            // Show only first 10 flights
            if (count == 10) {
                break;
            }
            count++;

            Map<String,Object> offer =
                (Map<String,Object>)obj;

            FlightOfferWrapper wrapper =
                new FlightOfferWrapper();

            wrapper.offerId =
                String.valueOf(offer.get('id'));

if (offer.containsKey('intended_total_amount')) {

    Decimal usdPrice = Decimal.valueOf(
        String.valueOf(
            offer.get('intended_total_amount')
        )
    );

    Decimal exchangeRate = 86;

    wrapper.price = (usdPrice * exchangeRate).setScale(2);

    wrapper.currencyCode = 'INR';



}

            

            wrapper.origin = origin;
            wrapper.destination = destination;
            wrapper.cabinClass = cabinClass;

            List<Object> slices =
                (List<Object>)offer.get('slices');

            if (slices != null && !slices.isEmpty()) {

                Map<String,Object> slice =
                    (Map<String,Object>)slices[0];

                wrapper.duration =
                    String.valueOf(
                        slice.get('duration')
                    );

                List<Object> segments =
                    (List<Object>)slice.get('segments');

                if (segments != null && !segments.isEmpty()) {

                    Map<String,Object> segment =
                        (Map<String,Object>)segments[0];

                    wrapper.flightNumber =
                        String.valueOf(
                            segment.get('marketing_carrier_flight_number')
                        );

                    wrapper.departureTime =
                        String.valueOf(
                            segment.get('departing_at')
                        );

                    wrapper.arrivalTime =
                        String.valueOf(
                            segment.get('arriving_at')
                        );

                    Map<String,Object> carrier =
                        (Map<String,Object>)segment.get('marketing_carrier');

                    if (carrier != null) {

                        wrapper.airline =
                            String.valueOf(
                                carrier.get('name')
                            );

                    } else {

                        wrapper.airline = 'Duffel Airways';

                    }

                }

            }

            wrapperList.add(wrapper);

        }

        return wrapperList;

    }

}