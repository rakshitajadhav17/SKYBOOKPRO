import { LightningElement, api } from 'lwc';

import createBooking from '@salesforce/apex/BookingService.createBooking';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class PaymentGateway extends LightningElement {

    @api amount;

    @api selectedOffer;

    @api passengerDetails;

    selectedPayment = 'Card';

    cardName = '';
    cardNumber = '';
    expiry = '';
    cvv = '';

    upiId = '';

    selectedBank = '';

    paymentOptions = [

        { label: '💳 Credit / Debit Card', value: 'Card' },

        { label: '📱 UPI', value: 'UPI' },

        { label: '🏦 Net Banking', value: 'Bank' }

    ];

    bankOptions = [

        { label: 'State Bank of India', value: 'SBI' },

        { label: 'HDFC Bank', value: 'HDFC' },

        { label: 'ICICI Bank', value: 'ICICI' },

        { label: 'Axis Bank', value: 'AXIS' }

    ];

    get showCard() {

        return this.selectedPayment === 'Card';

    }

    get showUPI() {

        return this.selectedPayment === 'UPI';

    }

    get showNetBanking() {

        return this.selectedPayment === 'Bank';

    }

    handlePayment(event) {

        this.selectedPayment = event.detail.value;

    }

    handleName(event) {

        this.cardName = event.target.value;

    }

    handleCard(event) {

        this.cardNumber = event.target.value;

    }

    handleExpiry(event) {

        this.expiry = event.target.value;

    }

    handleCVV(event) {

        this.cvv = event.target.value;

    }

    handleUPI(event) {

        this.upiId = event.target.value;

    }

    handleBank(event) {

        this.selectedBank = event.detail.value;

    }

    async pay() {

        try {

            const passenger = this.passengerDetails[0];

            await createBooking({

                offerId: this.selectedOffer.offerId,

                flightNumber: this.selectedOffer.flightNumber,

                airline: this.selectedOffer.airline,

                origin: this.selectedOffer.origin,

                destination: this.selectedOffer.destination,

                price: this.selectedOffer.price,

                seatClass: this.selectedOffer.cabinClass,

                seats: 1,

                firstName: passenger.firstName,

                lastName: passenger.lastName,

                email: passenger.email,

                dateOfBirth: passenger.dob,

                passportNumber: passenger.passport,

                passengerType: passenger.type,

                mealPreference: null

            });

            this.dispatchEvent(

                new ShowToastEvent({

                    title: 'Payment Successful',

                    message: 'Booking Confirmed Successfully',

                    variant: 'success'

                })

            );

            this.dispatchEvent(

                new CustomEvent('paymentsuccess')

            );

        }

        catch(error){

            this.dispatchEvent(

                new ShowToastEvent({

                    title:'Error',

                    message:error.body.message,

                    variant:'error'

                })

            );

        }

    }

}