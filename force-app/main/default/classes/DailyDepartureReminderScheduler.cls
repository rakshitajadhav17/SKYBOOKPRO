public class DailyDepartureReminderScheduler
implements Schedulable {

    public void execute(
        SchedulableContext sc
    ) {

        System.enqueueJob(
            new AmadeusTokenRefreshJob()
        );

        System.debug(
            'Daily Departure Reminder Scheduler Executed'
        );
    }
}