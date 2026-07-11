import { LightningElement, api } from 'lwc';

export default class BookingConfirmation extends LightningElement {

    @api selectedOffer;
    @api passengerDetails;

    acceptedTerms = false;

    handleTerms(event) {

        this.acceptedTerms = event.target.checked;

    }

    confirmBooking() {

        if (!this.acceptedTerms) {

            alert('Please accept Terms & Conditions');

            return;

        }

        // Open Payment Screen
        this.dispatchEvent(
            new CustomEvent('bookingconfirmed')
        );

    }

    get passengerName() {

        if(this.passengerDetails && this.passengerDetails.length){

            return this.passengerDetails[0].firstName + ' ' +
                   this.passengerDetails[0].lastName;

        }

        return '';

    }

    get passengerType() {

        if(this.passengerDetails && this.passengerDetails.length){

            return this.passengerDetails[0].type;

        }

        return '';

    }

            get airline() {

            return this.selectedOffer
                ? this.selectedOffer.airline
                : '';

        }

        get origin() {

            return this.selectedOffer
                ? this.selectedOffer.origin
                : '';

        }

        get destination() {

            return this.selectedOffer
                ? this.selectedOffer.destination
                : '';

        }

        get flightNumber() {

            return this.selectedOffer
                ? this.selectedOffer.flightNumber
                : '';

        }

        get cabinClass() {

            return this.selectedOffer
                ? this.selectedOffer.cabinClass
                : '';

        }

        get price() {

            return this.selectedOffer
                ? this.selectedOffer.price
                : '';

        }

}