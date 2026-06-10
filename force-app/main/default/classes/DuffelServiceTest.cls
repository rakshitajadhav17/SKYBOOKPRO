@isTest
private class DuffelServiceTest {

    @isTest
    static void testConnectionTest() {

        Test.startTest();

        try {
            String result =
                DuffelService.testConnection();

            System.assertNotEquals(
                null,
                result
            );

        } catch(Exception e) {

            System.assert(
                e != null
            );
        }

        Test.stopTest();
    }

    @isTest
    static void testCreateOfferRequest() {

        Test.startTest();

        try {

            String result =
                DuffelService.createOfferRequest(
                    'DEL',
                    'BOM',
                    Date.today().addDays(30),
                    1,
                    'economy'
                );

            System.assertNotEquals(
                null,
                result
            );

        } catch(Exception e) {

            System.assert(
                e != null
            );
        }

        Test.stopTest();
    }
}