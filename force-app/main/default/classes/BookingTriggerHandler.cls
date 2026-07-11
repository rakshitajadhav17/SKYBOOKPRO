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
        Map<Id,Booking__c> oldMap
    ){

        for(Booking__c b : newBookings){

            Booking__c oldBooking = oldMap.get(b.Id);

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

    public void afterInsert(List<Booking__c> bookings){

        // Booking confirmation email is handeled by Flow.

    }

    public void afterUpdate(
        List<Booking__c> newBookings,
        Map<Id,Booking__c> oldMap
    ){

        if(isRunning){
            return;
        }

        isRunning = true;

        try{

            List<Refund__c> refunds = new List<Refund__c>();
            List<Case> cases = new List<Case>();
            List<Id> bookingIds = new List<Id>();

            for(Booking__c booking : newBookings){

                Booking__c oldBooking = oldMap.get(booking.Id);

                if(oldBooking.Booking_Status__c != 'Cancelled'
                    && booking.Booking_Status__c == 'Cancelled'){
                        bookingIds.add(booking.Id);
                    //==========================
                    // Refund
                    //==========================

                    Refund__c refund = new Refund__c();

                    refund.Booking__c = booking.Id;
                    refund.Refund_Amount__c = booking.Total_Amount__c * 0.80;
                    refund.Refund_Status__c = 'Initiated';
                    refund.Requested_Date__c = Date.today();

                    refunds.add(refund);

                    //==========================
                    // Case
                    //==========================

                    Case c = new Case();

                    c.Subject = 'Refund Request - ' + booking.Name;
                    c.Status = 'New';
                    c.Origin = 'Web';

                    cases.add(c);

                }

            }

           if(!refunds.isEmpty()){

    try{

        insert refunds;

    }

    catch(Exception e){

        System.debug('Refund Error : ' + e.getMessage());

    }

}

            // Insert Cases
if(!cases.isEmpty()){

    try{

        insert cases;

    }

    catch(Exception e){

        System.debug('Case Error : ' + e.getMessage());

    }

}

//==========================
// Send Cancellation Email
//==========================
System.debug('Booking IDs = ' + bookingIds);
List<Booking__c> bookingsForEmail = [

    SELECT Id,
           Name,
           Total_Amount__c,
           Cancellation_Reason__c,
           Passenger__r.FirstName,
           Passenger__r.LastName,
           Passenger__r.Email,
           Flight__r.Airline_Name__c,
           Flight__r.Flight_Number__c,
           Flight__r.Origin_Airport__c,
           Flight__r.Destination_Airport__c

    FROM Booking__c

    WHERE Id IN :bookingIds

];
System.debug('Bookings For Email = ' + bookingsForEmail.size());
List<Messaging.SingleEmailMessage> emails =
    new List<Messaging.SingleEmailMessage>();

for(Booking__c booking : bookingsForEmail){

    if(booking.Passenger__r != null &&
   booking.Flight__r != null &&
   String.isNotBlank(booking.Passenger__r.Email)){
        Messaging.SingleEmailMessage mail =
            new Messaging.SingleEmailMessage();

        mail.setToAddresses(
            new String[]{
                booking.Passenger__r.Email
            }
        );

        mail.setSubject(
            'SkyBook Pro - Booking Cancellation Confirmation'
        );

        String body =
'Dear ' + booking.Passenger__r.FirstName + ' ' +
booking.Passenger__r.LastName +

'\n\nYour booking has been cancelled successfully.\n\n' +

'Booking Number : ' + booking.Name +

'\nAirline : ' + booking.Flight__r.Airline_Name__c +

'\nFlight Number : ' + booking.Flight__r.Flight_Number__c +

'\nRoute : ' + booking.Flight__r.Origin_Airport__c +
' → ' +
booking.Flight__r.Destination_Airport__c +

'\nRefund Amount : ₹' +
String.valueOf(booking.Total_Amount__c * 0.80) +

'\nRefund Status : Initiated' +

'\nCancellation Reason : ' +
booking.Cancellation_Reason__c +

'\n\nYour refund request has been initiated and will be processed within 5-7 business days.' +

'\n\nThank you for choosing SkyBook Pro.' +

'\n\nRegards,' +
'\nSkyBook Pro Team';

        mail.setPlainTextBody(body);

        emails.add(mail);

    }

}

if(!emails.isEmpty()){

    try{

        System.debug('Emails Count = ' + emails.size());

        Messaging.SendEmailResult[] results =
            Messaging.sendEmail(emails);

        for(Messaging.SendEmailResult r : results){

            if(r.isSuccess()){

                System.debug('EMAIL SENT SUCCESSFULLY');

            }
            else{

                for(Messaging.SendEmailError err : r.getErrors()){

                    System.debug('EMAIL ERROR : ' + err.getMessage());

                }

            }

        }

    }
    catch(Exception e){

        System.debug('Exception : ' + e.getMessage());

    }

}
        }
        finally{

            isRunning = false;

        }

    }
    

}