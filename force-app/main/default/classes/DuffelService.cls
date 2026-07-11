public with sharing class DuffelService {

    public static String testConnection() {

        Http http = new Http();
        HttpRequest req = new HttpRequest();

        req.setEndpoint('callout:Duffel_API');
        req.setMethod('GET');

        req.setHeader('Duffel-Version', 'v2');
       req.setHeader('Authorization','YOUR_DUFFEL_API_KEY');

        HttpResponse res = http.send(req);

        System.debug('STATUS CODE = ' + res.getStatusCode());
        System.debug('STATUS = ' + res.getStatus());
        System.debug('BODY = ' + res.getBody());

        return res.getBody();
    }
    
    public static String createOfferRequest(String origin,
    String destination,
    Date departureDate,
    Integer adults,
    String cabinClass) {

    Http http = new Http();
    HttpRequest req = new HttpRequest();

    req.setEndpoint('callout:Duffel_API/air/offer_requests');
    req.setMethod('POST');

    req.setHeader('Content-Type', 'application/json');
    req.setHeader('Duffel-Version', 'v2');
   req.setHeader( 'Authorization','YOUR_DUFFEL_API_KEY');
    String body =
'{"data":{"slices":[{"origin":"' + origin +
'","destination":"' + destination +
'","departure_date":"' + String.valueOf(departureDate) +
'"}],"passengers":[{"type":"adult"}],"cabin_class":"' +
cabinClass.toLowerCase() + '"}}';

    req.setBody(body);

    HttpResponse res = http.send(req);
    return res.getBody();
}
}