public class BookingArchiveBatch
implements Database.Batchable<SObject> {

    public Database.QueryLocator start(
        Database.BatchableContext bc
    ) {

        return Database.getQueryLocator(
            'SELECT Id, Name, Booking_Status__c ' +
            'FROM Booking__c ' +
            'WHERE Booking_Date__c < LAST_N_YEARS:2'
        );
    }

    public void execute(
        Database.BatchableContext bc,
        List<Booking__c> scope
    ) {

        for(Booking__c b : scope){

            System.debug(
                'Archived Booking: ' + b.Name
            );
        }
    }

    public void finish(
        Database.BatchableContext bc
    ) {

        System.debug(
            'Booking Archive Batch Completed'
        );
    }
}