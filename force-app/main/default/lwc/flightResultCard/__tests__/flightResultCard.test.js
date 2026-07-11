import { createElement } from '@lwc/engine-dom';
import FlightResultCard from 'c/flightResultCard';

describe('c-flight-result-card', () => {

    afterEach(() => {

        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }

    });

    it('renders flight card', () => {

        const element = createElement('c-flight-result-card', {
            is: FlightResultCard
        });

        element.offer = {

            airline: 'IndiGo',

            flightNumber: '6E101',

            origin: 'BLR',

            destination: 'DEL',

            departureTime: '2026-07-15T10:00:00',

            arrivalTime: '2026-07-15T12:30:00',

            duration: 'PT2H30M',

            cabinClass: 'Economy',

            price: 5500

        };

        document.body.appendChild(element);

        expect(element).toBeTruthy();

    });

});