import { createElement } from '@lwc/engine-dom';
import BookingConfirmation from 'c/bookingConfirmation';

describe('c-booking-confirmation', () => {

    afterEach(() => {

        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }

    });

    it('renders booking confirmation', () => {

        const element = createElement('c-booking-confirmation', {
            is: BookingConfirmation
        });

        // Mock selectedOffer
        element.selectedOffer = {
            airline: 'IndiGo',
            origin: 'BLR',
            destination: 'DEL',
            flightNumber: '6E101',
            cabinClass: 'Economy',
            price: 5500
        };

        // Mock passengerDetails
        element.passengerDetails = [
            {
                firstName: 'Rakshita',
                lastName: 'Jadhav',
                type: 'Adult'
            }
        ];

        document.body.appendChild(element);

        expect(element).toBeTruthy();

    });

});