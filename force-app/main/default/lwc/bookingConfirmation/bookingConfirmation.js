// import { LightningElement, api } from 'lwc';
// import createBooking from '@salesforce/apex/BookingService.createBooking';
// import { ShowToastEvent } from 'lightning/platformShowToastEvent';

// export default class bookingConfirmation extends LightningElement {

//     @api selectedOffer;
//     @api passengerDetails;

//     acceptedTerms = false;
//     bookingCompleted = false;
//     booking;

//     handleTerms(event) {
//         this.acceptedTerms = event.target.checked;
//     }

//     async confirmBooking() {

//         if (!this.acceptedTerms) {
//             alert('Please accept Terms & Conditions');
//             return;
//         }

//         try {

//             const passenger = this.passengerDetails[0];

//             const result = await createBooking({

//                 offerId: this.selectedOffer.offerId,
//                  flightNumber: this.selectedOffer.flightNumber,
//                 airline: this.selectedOffer.airline,
//                 origin: this.selectedOffer.origin,
//                 destination: this.selectedOffer.destination,
//                 price: this.selectedOffer.price,

//                 seatClass: this.selectedOffer.cabinClass,
//                 seats: 1,

//                 firstName: passenger.firstName,
//                 lastName: passenger.lastName,
//                 email: passenger.email, 
//                 dateOfBirth: passenger.dob,
//                 passportNumber: passenger.passport,
//                 passengerType: passenger.type,
//                 mealPreference: null

//             });

//             this.booking = result;
//             this.bookingCompleted = true;

//             this.dispatchEvent(
//                 new ShowToastEvent({
//                     title: 'Success',
//                     message: 'Booking Created Successfully',
//                     variant: 'success'
//                 })
//             );
//             this.dispatchEvent(
//     new CustomEvent('bookingconfirmed')
// );
          

//         } catch (error) {

//             console.error(error);

//             this.dispatchEvent(
//                 new ShowToastEvent({
//                     title: 'Error',
//                     message: error.body ? error.body.message : 'Booking Failed',
//                     variant: 'error'
//                 })
//             );
//         }
//     }

//     get passengerName() {

//     if (this.passengerDetails && this.passengerDetails.length > 0) {

//         return this.passengerDetails[0].firstName + ' ' +
//                this.passengerDetails[0].lastName;

//     }

//     return '';

// }

// get passengerType() {

//     if (this.passengerDetails && this.passengerDetails.length > 0) {

//         return this.passengerDetails[0].type;

//     }

//     return '';

// }

// get bookingReference() {

//     return this.booking ? this.booking.Name : '';

// }

// get bookingStatus() {

//     return this.booking ? this.booking.Booking_Status__c : '';

// }
//     refreshPage() {

//         window.location.reload();

//     }

// }

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