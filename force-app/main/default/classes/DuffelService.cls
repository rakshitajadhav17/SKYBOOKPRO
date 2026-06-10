public with sharing class DuffelService {

    public static String testConnection() {

        Http http = new Http();
        HttpRequest req = new HttpRequest();

        req.setEndpoint('callout:Duffel_API');
        req.setMethod('GET');

        req.setHeader('Duffel-Version', 'v2');
        req.setHeader('Authorization','Bearer duffel_test__CAM1cJj9UGc35b3Bm-szB2opq1b_mvdLmlBmtie7L1');

        HttpResponse res = http.send(req);

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
    req.setHeader('Authorization', 'Bearer duffel_test__CAM1cJj9UGc35b3Bm-szB2opq1b_mvdLmlBmtie7L1');

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