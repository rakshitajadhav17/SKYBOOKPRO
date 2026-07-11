import { LightningElement, wire } from 'lwc';

import getMyBookings
from '@salesforce/apex/BookingDashboardService.getMyBookings';

export default class MyBookingsDashboard extends LightningElement {

    bookings;

    selectedBookingId;

    showDetails = false;

    @wire(getMyBookings)

    wiredBookings({ data, error }) {

        if (data) {

            this.bookings = data;

        }
        else if (error) {

            console.error(error);

        }

    }

    viewBooking(event) {

        this.selectedBookingId =
            event.target.dataset.id;

        this.showDetails = true;

    }

    goBack() {

        this.showDetails = false;

    }

}