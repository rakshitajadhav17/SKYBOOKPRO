public with sharing class DuffelService {
  public static String testConnection() {
    Http http = new Http();
    HttpRequest req = new HttpRequest();

    req.setEndpoint('callout:Duffel_API');
    req.setMethod('GET');

    req.setHeader('Duffel-Version', 'v2');
    req.setHeader('Authorization', 'YOUR_DUFFEL_API');

    HttpResponse res = http.send(req);

    System.debug('STATUS CODE = ' + res.getStatusCode());
    System.debug('STATUS = ' + res.getStatus());
    System.debug('BODY = ' + res.getBody());

    return res.getBody();
  }

  public static String createOfferRequest(
    String origin,
    String destination,
    Date departureDate,
    Integer adults,
    String cabinClass
  ) {
    Http http = new Http();
    HttpRequest req = new HttpRequest();

    req.setEndpoint('callout:Duffel_API/air/offer_requests');
    req.setMethod('POST');

    req.setHeader('Content-Type', 'application/json');
    req.setHeader('Duffel-Version', 'v2');
    req.setHeader('Authorization', 'YOUR_DUFFEL_API');

    //=========================================
    // Convert Salesforce value to Duffel value
    //=========================================

    String duffelCabin = 'economy';

    if (cabinClass == 'Business') {
      duffelCabin = 'business';
    } else if (cabinClass == 'First Class') {
      duffelCabin = 'first';
    } else {
      duffelCabin = 'economy';
    }

    String body =
      '{' +
      '"data":{' +
      '"slices":[{' +
      '"origin":"' +
      origin +
      '",' +
      '"destination":"' +
      destination +
      '",' +
      '"departure_date":"' +
      String.valueOf(departureDate) +
      '"' +
      '}],' +
      '"passengers":[{' +
      '"type":"adult"' +
      '}],' +
      '"cabin_class":"' +
      duffelCabin +
      '"' +
      '}' +
      '}';

    System.debug('Request Body: ' + body);

    req.setBody(body);

    HttpResponse res = http.send(req);

    System.debug('Status Code: ' + res.getStatusCode());
    System.debug('Response Body: ' + res.getBody());

    return res.getBody();
  }
}
