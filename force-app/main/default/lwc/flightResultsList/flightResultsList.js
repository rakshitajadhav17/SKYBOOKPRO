import { LightningElement, api } from 'lwc';

export default class flightResultsList extends LightningElement {

    @api flightOffers = [];

    handleOfferSelected(event) {

        console.log('FlightResultsList received:', event.detail);

        this.dispatchEvent(
            new CustomEvent('offerselected', {
                detail: event.detail,
                bubbles: true,
                composed: true
            })
        );

    }

}