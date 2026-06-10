trigger BookingTrigger on Booking__c (
    before insert,
    before update,
    after insert,
    after update
) {

    BookingTriggerHandler handler = new BookingTriggerHandler();

    if(Trigger.isBefore){

        if(Trigger.isInsert){
            handler.beforeInsert(Trigger.new);
        }

        if(Trigger.isUpdate){
            handler.beforeUpdate(
                Trigger.new,
                Trigger.oldMap
            );
        }
    }

    if(Trigger.isAfter){

        if(Trigger.isInsert){
            handler.afterInsert(Trigger.new);
        }

        if(Trigger.isUpdate){
            handler.afterUpdate(
                Trigger.new,
                Trigger.oldMap
            );
        }
    }
}