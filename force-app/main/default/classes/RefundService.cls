public with sharing class RefundService {

    @AuraEnabled(cacheable=true)
    public static Refund__c getRefundStatus(Id bookingId) {

        List<Refund__c> refunds = [

            SELECT
                Id,
                Refund_Status__c,
                Refund_Amount__c,
                Requested_Date__c

            FROM Refund__c

            WHERE Booking__c = :bookingId

            ORDER BY CreatedDate DESC

            LIMIT 1

        ];

        if(refunds.isEmpty()){

            return null;

        }

        return refunds[0];

    }

}