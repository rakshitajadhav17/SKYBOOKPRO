import { LightningElement } from 'lwc';

export default class SkyBookApp extends LightningElement {

    flightOffers = [];
    selectedOffer;
    passengerDetails = [];

    showPassengerForm = false;
    showBookingConfirmation = false;
    showPayment = false;
    showBookingSuccess = false;

    get hasFlightOffers() {
        return this.flightOffers.length > 0;
    }

    handleFlightSearch(event) {

        this.flightOffers = [...event.detail];

        console.log('Flight Offers:', this.flightOffers);
        console.log('Count:', this.flightOffers.length);

    }

   handleOfferSelected(event) {

    console.log('SkyBookApp received:', event.detail);

    this.selectedOffer = event.detail;

    this.showPassengerForm = true;

    // Scroll after the component is rendered
    setTimeout(() => {

        const passengerSection =
            this.template.querySelector(
                '[data-id="passengerSection"]'
            );

        if (passengerSection) {

            passengerSection.scrollIntoView({

                behavior: 'smooth',

                block: 'start'

            });

        }

    }, 100);

}

handleContinue() {

    const passengerComponent =
        this.template.querySelector(
            'c-passenger-details-form'
        );

    this.passengerDetails =
        passengerComponent.getPassengerDetails();

    this.showPassengerForm = false;

    this.showBookingConfirmation = true;

    setTimeout(() => {

        const section = this.template.querySelector(
            '[data-id="confirmationSection"]'
        );

        if(section){

            section.scrollIntoView({
                behavior:'smooth',
                block:'start'
            });

        }

    },200);

}
handleBookingConfirmed() {

    this.showBookingConfirmation = false;

    this.showPayment = true;

    setTimeout(() => {

        const section = this.template.querySelector(
            '[data-id="paymentSection"]'
        );

        if(section){

            section.scrollIntoView({
                behavior:'smooth',
                block:'start'
            });

        }

    },200);

}
handlePaymentSuccess() {

    this.showPayment = false;

    this.showBookingSuccess = true;

    this.flightOffers = [];

    setTimeout(() => {

        const section = this.template.querySelector(
            '[data-id="successSection"]'
        );

        if(section){

            section.scrollIntoView({
                behavior:'smooth',
                block:'start'
            });

        }

    },200);

}
}