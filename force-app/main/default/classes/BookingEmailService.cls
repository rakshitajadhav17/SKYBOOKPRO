public class BookingEmailService {

    @future(callout=false)
    public static void sendBookingConfirmationEmail(
        Set<Id> bookingIds
    ) {

        List<Booking__c> bookings = [
            SELECT Id,
                   Name,
                   Contact__r.Email,
                   Contact__r.Name
            FROM Booking__c
            WHERE Id IN :bookingIds
        ];

        List<Messaging.SingleEmailMessage> emails =
            new List<Messaging.SingleEmailMessage>();

        for(Booking__c b : bookings){

            if(b.Contact__r.Email != null){

                Messaging.SingleEmailMessage mail =
                    new Messaging.SingleEmailMessage();

                mail.setToAddresses(
                    new String[]{
                        b.Contact__r.Email
                    }
                );

                mail.setSubject(
                    'Booking Confirmation'
                );

                mail.setPlainTextBody(
                    'Dear ' + b.Contact__r.Name +
                    ', your booking ' + b.Name +
                    ' has been confirmed.'
                );

                emails.add(mail);
            }
        }

        if(!emails.isEmpty()){
            Messaging.sendEmail(emails);
        }
    }
}