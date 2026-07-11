public with sharing class DuffelFlightPricingService {

    public static FlightOfferWrapper confirmPrice(
        String offerId,
        String offerJson
    ) {

        FlightOfferWrapper wrapper = new FlightOfferWrapper();
        
        Http http = new Http();
HttpRequest req = new HttpRequest();

req.setEndpoint('callout:Duffel_API');
req.setMethod('POST');

req.setHeader('Content-Type', 'application/json');
req.setHeader('Duffel-Version', 'v2');
req.setHeader('Authorization', 'YOUR_DUFFEL_API_KEY');
req.setBody(offerJson);
HttpResponse res = http.send(req);

String responseBody = res.getBody();

Map<String,Object> responseMap =
    (Map<String,Object>)JSON.deserializeUntyped(responseBody);

wrapper.offerId = offerId;
wrapper.airline = 'Duffel';
wrapper.price = 0;
wrapper.currencyCode = 'USD';
        return wrapper;
    }
}