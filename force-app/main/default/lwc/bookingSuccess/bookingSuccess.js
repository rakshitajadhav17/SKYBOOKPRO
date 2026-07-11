import { LightningElement, api } from 'lwc';

export default class bookingSuccess extends LightningElement {

    @api selectedOffer;
    @api passengerDetails;

    get passengerName() {

    if (this.passengerDetails && this.passengerDetails.length > 0) {

        return this.passengerDetails[0].firstName + ' ' +
               this.passengerDetails[0].lastName;

    }

    return '';

}

get airline() {

    return this.selectedOffer ? this.selectedOffer.airline : '';

}

get origin() {

    return this.selectedOffer ? this.selectedOffer.origin : '';

}

get destination() {

    return this.selectedOffer ? this.selectedOffer.destination : '';

}

get seatClass() {

    return this.selectedOffer ? this.selectedOffer.cabinClass : '';

}
    bookAnotherFlight() {

        location.reload();

    }

}