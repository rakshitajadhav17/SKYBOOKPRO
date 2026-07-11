import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import searchFlights from '@salesforce/apex/DuffelFlightSearchService.searchFlights';

export default class flightSearchForm extends LightningElement {

    // Public Properties
    @api initialOrigin = '';
    @api initialDestination = '';

    // Form Fields
    origin = '';
    destination = '';
    departureDate = '';
    returnDate = '';
    tripType = 'One Way';
    cabinClass = 'Economy';
    adults = 1;

    isLoading = false;

    // Trip Type Options
    tripOptions = [
        { label: 'One Way', value: 'One Way' },
        { label: 'Round Trip', value: 'Round Trip' }
    ];

    // Cabin Options
    cabinOptions = [
        { label: 'Economy', value: 'Economy' },
        { label: 'Business', value: 'Business' },
        { label: 'First', value: 'First' }
    ];

    connectedCallback() {
        this.origin = this.initialOrigin;
        this.destination = this.initialDestination;
    }

    get isRoundTrip() {
        return this.tripType === 'Round Trip';
    }

    handleTripTypeChange(event) {
        this.tripType = event.detail.value;
    }

    handleOriginChange(event) {
        this.origin = event.target.value;
    }

    handleDestinationChange(event) {
        this.destination = event.target.value;
    }

    handleDepartureChange(event) {
        this.departureDate = event.target.value;
    }

    handleReturnChange(event) {
        this.returnDate = event.target.value;
    }

    handleCabinChange(event) {
        this.cabinClass = event.detail.value;
    }

    handleAdultsChange(event) {
        this.adults = Number(event.target.value);
    }

    async handleSearch() {

        // Validation
        if (!this.origin) {
            this.showError('Please enter Origin Airport');
            return;
        }

        if (!this.destination) {
            this.showError('Please enter Destination Airport');
            return;
        }

        if (this.origin === this.destination) {
            this.showError('Origin and Destination cannot be the same');
            return;
        }

        if (!this.departureDate) {
            this.showError('Please select Departure Date');
            return;
        }

        if (this.adults < 1) {
            this.showError('Adults must be at least 1');
            return;
        }

        this.isLoading = true;

        try {

            const result = await searchFlights({
                origin: this.origin,
                destination: this.destination,
                departureDate: this.departureDate,
                adults: this.adults,
                cabinClass: this.cabinClass
            });

            console.log('Flight Results:', result);

            this.dispatchEvent(
                new CustomEvent('flightsearch', {
                    detail: result
                })
            );

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Flights Found Successfully',
                    variant: 'success'
                })
            );

        } catch (error) {

            console.error(error);

            this.showError(
                error?.body?.message || 'Unable to search flights.'
            );

        } finally {

            this.isLoading = false;

        }
    }

    showError(message) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Validation Error',
                message: message,
                variant: 'error'
            })
        );
    }
}