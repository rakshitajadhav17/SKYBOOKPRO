public class AmadeusTokenRefreshJob
implements Queueable, Database.AllowsCallouts {

    public void execute(QueueableContext context) {

        String response =
            DuffelService.testConnection();

        System.debug(
            'Duffel Response: ' + response
        );
    }
}