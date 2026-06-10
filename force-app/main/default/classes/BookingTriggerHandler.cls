public class BookingTriggerHandler {
public static Boolean isRunning = false;
    public void beforeInsert(List<Booking__c> bookings){

        for(Booking__c b : bookings){

            b.Booking_Date__c = Date.today();

            b.Agent__c = UserInfo.getUserId();

            if(String.isBlank(b.Booking_Status__c)){
                b.Booking_Status__c = 'Draft';
            }
        }
    }

    public void beforeUpdate(
        List<Booking__c> newBookings,
        Map<Id,Booking__c> oldMap){

        for(Booking__c b : newBookings){

            Booking__c oldBooking =
                oldMap.get(b.Id);

            if(oldBooking.Booking_Status__c == 'Cancelled'
               && b.Booking_Status__c == 'Confirmed'){

                b.addError(
                    'Cancelled booking cannot be confirmed again.'
                );
            }
            if(b.Number_of_Seats__c < oldBooking.Number_of_Seats__c){

    b.addError(
        'Cannot reduce seats below passengers already added.'
    );
}
        }
    }

    public void afterInsert(
        List<Booking__c> bookings){

        List<Messaging.SingleEmailMessage> emails =
            new List<Messaging.SingleEmailMessage>();

        for(Booking__c b : bookings){

            if(b.Booking_Status__c == 'Confirmed'){

                Messaging.SingleEmailMessage mail =
                    new Messaging.SingleEmailMessage();

                mail.setToAddresses(
                    new String[]{
                        'yourmail@gmail.com'
                    }
                );

                mail.setSubject(
                    'Booking Confirmed'
                );

                mail.setPlainTextBody(
                    'Booking confirmed.'
                );

                emails.add(mail);
            }
        }

        if(!emails.isEmpty()){
            Messaging.sendEmail(emails);
        }
    }

    public void afterUpdate(
        List<Booking__c> newBookings,
        Map<Id,Booking__c> oldMap){

        List<Refund__c> refunds =
            new List<Refund__c>();

        for(Booking__c b : newBookings){

            Booking__c oldBooking =
                oldMap.get(b.Id);

            if(oldBooking.Booking_Status__c != 'Cancelled'
               && b.Booking_Status__c == 'Cancelled'){

                Refund__c refund =
                    new Refund__c();

                refund.Booking__c = b.Id;

                refund.Refund_Amount__c =
                    b.Total_Amount__c * 0.80;
                    
                    refund.Refund_Status__c = 'Initiated';
refund.Requested_Date__c = Date.today();

                refunds.add(refund);
            }
        }

        if(!refunds.isEmpty()){
            insert refunds;
        }
    }
}