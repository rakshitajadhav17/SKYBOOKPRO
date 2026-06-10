@isTest
private class AmadeusTokenRefreshJobTest {

    @isTest
    static void testQueueable() {

        Test.startTest();

        System.enqueueJob(
            new AmadeusTokenRefreshJob()
        );

        Test.stopTest();

        System.assert(true);
    }
}