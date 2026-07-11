import { LightningElement, api, wire } from 'lwc';

import getBookingDetails
from '@salesforce/apex/BookingDetailService.getBookingDetails';

export default class BookingDetailView
extends LightningElement {

    @api bookingId;

    booking;

    @wire(getBookingDetails,
    { bookingId: '$bookingId' })

    wiredBooking({ data, error }) {

        if (data) {

            this.booking = data;

        }

        else if (error) {

            console.error(error);

        }

    }

showModal = false;

cancelBooking(){

    this.showModal = true;

}

closeModal(){

    this.showModal = false;

}

}