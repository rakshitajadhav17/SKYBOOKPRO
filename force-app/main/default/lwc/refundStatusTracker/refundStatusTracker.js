import { LightningElement, api, wire } from 'lwc';

import getRefundStatus
from '@salesforce/apex/RefundService.getRefundStatus';

export default class RefundStatusTracker
extends LightningElement {

    @api bookingId;

    refund;

    @wire(getRefundStatus,
    { bookingId:'$bookingId' })

    wiredRefund({data,error}){

        if(data){

            this.refund=data;

        }

        else if(error){

            console.error(error);

        }

    }

    get currentStep(){

        if(!this.refund){

            return 'Initiated';

        }

        return this.refund.Refund_Status__c;

    }

}