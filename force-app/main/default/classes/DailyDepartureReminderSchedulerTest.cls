@isTest
private class DailyDepartureReminderSchedulerTest {

    @isTest
    static void testScheduler() {

        Test.startTest();

        String jobId =
            System.schedule(
                'Daily Reminder Test',
                '0 0 7 * * ?',
                new DailyDepartureReminderScheduler()
            );

        Test.stopTest();

        System.assertNotEquals(
            null,
            jobId
        );
    }
}