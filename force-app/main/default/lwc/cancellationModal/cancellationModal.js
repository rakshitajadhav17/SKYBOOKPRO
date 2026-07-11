import { LightningElement, api, wire } from 'lwc';

import cancelBooking from '@salesforce/apex/BookingCancellationService.cancelBooking';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import { MessageContext, publish } from 'lightning/messageService';

import SKYBOOK_CHANNEL from '@salesforce/messageChannel/SkyBook_Channel__c';

export default class CancellationModal
extends LightningElement {

    @api bookingId;

    @api showModal = false;

    @wire(MessageContext)
    messageContext;
    reason = '';

    handleReason(event){

        this.reason =
            event.target.value;

    }

    close(){

        this.dispatchEvent(

            new CustomEvent('close')

        );

    }

    async cancelBooking(){

    console.log('Cancel button clicked');

    console.log('Booking Id = ', this.bookingId);
    console.log('Reason = ', this.reason);

    try{

        await cancelBooking({

            bookingId: this.bookingId,
            reason: this.reason

        });

        console.log('Apex cancellation completed');

        this.dispatchEvent(
            new ShowToastEvent({
                title:'Success',
                message:'Booking Cancelled',
                variant:'success'
            })
        );

        console.log('Publishing LMS message');

        publish(this.messageContext, SKYBOOK_CHANNEL, {
            action: 'BookingCancelled',
            bookingId: this.bookingId
        });

        console.log('LMS message published');

        this.close();

    }
    catch(error){

        console.error(error);

    }

}
}