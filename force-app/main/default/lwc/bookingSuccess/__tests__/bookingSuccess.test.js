import { createElement } from '@lwc/engine-dom';
import BookingSuccess from 'c/bookingSuccess';

describe('c-booking-success', () => {

    afterEach(() => {

        while (document.body.firstChild) {

            document.body.removeChild(document.body.firstChild);

        }

    });

    it('renders booking success component', () => {

        const element = createElement('c-booking-success', {

            is: BookingSuccess

        });

        element.selectedOffer = {

            airline: 'IndiGo',

            origin: 'BLR',

            destination: 'DEL',

            cabinClass: 'Economy'

        };

        element.passengerDetails = [

            {

                firstName: 'Rakshita',

                lastName: 'Jadhav'

            }

        ];

        document.body.appendChild(element);

        expect(element).toBeTruthy();

    });

});