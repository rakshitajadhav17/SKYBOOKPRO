public with sharing class AgentDashboardService {

    //=============================
    // Dashboard Statistics
    //=============================

    @AuraEnabled(cacheable=true)
    public static DashboardWrapper getDashboardStats() {

        DashboardWrapper wrapper = new DashboardWrapper();

        wrapper.totalBookings = [
            SELECT COUNT()
            FROM Booking__c
        ];

        wrapper.confirmedBookings = [
            SELECT COUNT()
            FROM Booking__c
            WHERE Booking_Status__c = 'Confirmed'
        ];

        wrapper.cancelledBookings = [
            SELECT COUNT()
            FROM Booking__c
            WHERE Booking_Status__c = 'Cancelled'
        ];

        AggregateResult revenue = [

            SELECT SUM(Total_Amount__c) total

            FROM Booking__c

            WHERE Booking_Status__c='Confirmed'

        ];

        if(revenue.get('total') != null){

            wrapper.totalRevenue =
                (Decimal)revenue.get('total');

        }
        else{

            wrapper.totalRevenue = 0;

        }

        wrapper.pendingRefunds = [

            SELECT COUNT()

            FROM Refund__c

            WHERE Refund_Status__c != 'Completed'

        ];

        return wrapper;

    }

    //=========================================
    // ALL BOOKINGS
    //=========================================

    @AuraEnabled(cacheable=true)
    public static List<Booking__c> getAllBookings(){

        return [

            SELECT Id,
                   Name,
                   Booking_Status__c,
                   Total_Amount__c,
                   Booking_Date__c,
                   Passenger__r.FirstName,
                   Passenger__r.LastName

            FROM Booking__c

            ORDER BY CreatedDate DESC

        ];

    }

    //=========================================
    // CONFIRMED BOOKINGS
    //=========================================

    @AuraEnabled(cacheable=true)
    public static List<Booking__c> getConfirmedBookings(){

        return [

            SELECT Id,
                   Name,
                   Booking_Status__c,
                   Total_Amount__c,
                   Booking_Date__c,
                   Passenger__r.FirstName,
                   Passenger__r.LastName

            FROM Booking__c

            WHERE Booking_Status__c='Confirmed'

            ORDER BY CreatedDate DESC

        ];

    }

    //=========================================
    // CANCELLED BOOKINGS
    //=========================================

    @AuraEnabled(cacheable=true)
    public static List<Booking__c> getCancelledBookings(){

        return [

            SELECT Id,
                   Name,
                   Booking_Status__c,
                   Total_Amount__c,
                   Booking_Date__c,
                   Passenger__r.FirstName,
                   Passenger__r.LastName

            FROM Booking__c

            WHERE Booking_Status__c='Cancelled'

            ORDER BY CreatedDate DESC

        ];

    }

    //=========================================
    // REVENUE BOOKINGS
    //=========================================

    @AuraEnabled(cacheable=true)
    public static List<Booking__c> getRevenueBookings(){

        return [

            SELECT Id,
                   Name,
                   Booking_Status__c,
                   Total_Amount__c,
                   Booking_Date__c,
                   Passenger__r.FirstName,
                   Passenger__r.LastName

            FROM Booking__c

            WHERE Booking_Status__c='Confirmed'

            ORDER BY Total_Amount__c DESC

        ];

    }

    //=========================================
    // PENDING REFUNDS
    //=========================================

    @AuraEnabled(cacheable=true)
    public static List<Refund__c> getPendingRefunds(){

        return [

            SELECT Id,
                   Name,
                   Booking__r.Name,
                   Refund_Amount__c,
                   Refund_Status__c,
                   Requested_Date__c

            FROM Refund__c

            WHERE Refund_Status__c!='Completed'

            ORDER BY CreatedDate DESC

        ];

    }

    //=========================================
    // RECENT BOOKINGS
    //=========================================

    @AuraEnabled(cacheable=true)
    public static List<Booking__c> getRecentBookings(){

        return [

            SELECT Id,
                   Name,
                   Booking_Status__c,
                   Total_Amount__c,
                   Booking_Date__c,
                   Passenger__r.FirstName,
                   Passenger__r.LastName,
                   Flight__r.Airline_Name__c

            FROM Booking__c

            ORDER BY CreatedDate DESC

            LIMIT 5

        ];

    }

    //=========================================
    // RECENT REFUNDS
    //=========================================

    @AuraEnabled(cacheable=true)
    public static List<Refund__c> getRecentRefunds(){

        return [

            SELECT Id,
                   Booking__r.Name,
                   Refund_Amount__c,
                   Refund_Status__c,
                   Requested_Date__c

            FROM Refund__c

            ORDER BY CreatedDate DESC

            LIMIT 5

        ];

    }

    //=========================================
    // SEARCH PASSENGERS
    //=========================================

    @AuraEnabled(cacheable=true)
    public static List<List<SObject>> searchPassengers(String searchTerm){

        if(String.isBlank(searchTerm)){

            return new List<List<SObject>>();

        }

        List<Contact> contacts = [

            SELECT Id,
                   FirstName,
                   LastName,
                   Email

            FROM Contact

            WHERE FirstName LIKE :('%'+searchTerm+'%')
               OR LastName LIKE :('%'+searchTerm+'%')
               OR Email LIKE :('%'+searchTerm+'%')

            LIMIT 10

        ];

        Set<Id> contactIds = new Set<Id>();

        for(Contact c : contacts){

            contactIds.add(c.Id);

        }

        List<Booking__c> bookings = new List<Booking__c>();

        if(!contactIds.isEmpty()){

            bookings = [

                SELECT Id,
                       Name,
                       Booking_Status__c,
                       Total_Amount__c

                FROM Booking__c

                WHERE Passenger__c IN :contactIds

            ];

        }

        return new List<List<SObject>>{

            contacts,
            bookings

        };

    }

    //=========================================
    // WRAPPER CLASS
    //=========================================

    public class DashboardWrapper{

        @AuraEnabled
        public Integer totalBookings;

        @AuraEnabled
        public Integer confirmedBookings;

        @AuraEnabled
        public Integer cancelledBookings;

        @AuraEnabled
        public Decimal totalRevenue;

        @AuraEnabled
        public Integer pendingRefunds;

    }

}