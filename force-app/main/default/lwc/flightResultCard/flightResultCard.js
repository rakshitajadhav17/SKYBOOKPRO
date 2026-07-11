import { LightningElement, api } from 'lwc';

export default class FlightResultCard extends LightningElement {

    @api offer;

    get airline() {
    return this.offer ? this.offer.airline : '';
}

get flightNumber() {
    return this.offer ? this.offer.flightNumber : '';
}

get origin() {
    return this.offer ? this.offer.origin : '';
}

get destination() {
    return this.offer ? this.offer.destination : '';
}

get cabinClass() {
    return this.offer ? this.offer.cabinClass : '';
}

get price() {
    return this.offer ? this.offer.price : '';
}
    handleSelect() {

        this.dispatchEvent(
            new CustomEvent('offerselected', {
                detail: this.offer,
                bubbles: true,
                composed: true
            })
        );

    }

    get formattedDuration() {

        if (!this.offer || !this.offer.duration) {
            return '';
        }

        return this.offer.duration
            .replace('PT', '')
            .replace('H', 'h ')
            .replace('M', 'm');
    }

    get formattedDeparture() {

        if (!this.offer || !this.offer.departureTime) {
            return '';
        }

        return new Date(this.offer.departureTime).toLocaleString(
            'en-IN',
            {
                day: '2-digit',
                month: 'short',
                year: 'numeric',
                hour: '2-digit',
                minute: '2-digit',
                hour12: true
            }
        );

    }

    get formattedArrival() {

        if (!this.offer || !this.offer.arrivalTime) {
            return '';
        }

        return new Date(this.offer.arrivalTime).toLocaleString(
            'en-IN',
            {
                day: '2-digit',
                month: 'short',
                year: 'numeric',
                hour: '2-digit',
                minute: '2-digit',
                hour12: true
            }
        );

    }

}