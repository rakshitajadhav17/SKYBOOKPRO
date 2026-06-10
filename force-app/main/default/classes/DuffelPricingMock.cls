@isTest
global class DuffelPricingMock
implements HttpCalloutMock {

    global HttpResponse respond(
        HttpRequest req
    ) {

        HttpResponse res =
            new HttpResponse();

        res.setStatusCode(200);

        res.setBody(
            '{"data":{"id":"TEST001"}}'
        );

        return res;
    }
}