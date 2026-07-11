public with sharing class DashboardController {

    @AuraEnabled(cacheable=true)
    public static Map<String,Object> getDashboardData() {

        Map<String,Object> result = new Map<String,Object>();

        result.put(
            'totalBookings',
            [
                SELECT Count()
                FROM Booking__c
            ]
        );

        result.put(
            'confirmedBookings',
            [
                SELECT Count()
                FROM Booking__c
                WHERE Booking_Status__c='Confirmed'
            ]
        );

        result.put(
            'cancelledBookings',
            [
                SELECT Count()
                FROM Booking__c
                WHERE Booking_Status__c='Cancelled'
            ]
        );

        AggregateResult revenue = [

            SELECT SUM(Total_Amount__c) total

            FROM Booking__c

        ];

        result.put(
            'totalRevenue',
            revenue.get('total')
        );

        result.put(
            'pendingRefunds',
            [
                SELECT Count()
                FROM Refund__c
                WHERE Refund_Status__c='Requested'
            ]
        );

        return result;

    }

}