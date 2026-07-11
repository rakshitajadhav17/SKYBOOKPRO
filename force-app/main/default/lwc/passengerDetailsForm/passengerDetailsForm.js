import { LightningElement, api } from 'lwc';

export default class passengerDetailsForm extends LightningElement {

    @api passengerCount = 1;

    passengers = [];

    passengerTypes = [
        { label: 'Adult', value: 'Adult' },
        { label: 'Child', value: 'Child' },
        { label: 'Infant', value: 'Infant' }
    ];

    connectedCallback() {

        let tempPassengers = [];

        for (let i = 1; i <= this.passengerCount; i++) {

            tempPassengers.push({
            id: i,
            firstName: '',
            lastName: '',
            email: '',
            dob: '',
            passport: '',
            type: 'Adult'
        });

        }

        this.passengers = tempPassengers;

        console.log('Passengers Initialized:', this.passengers);

    }

 handleChange(event) {

    console.log('handleChange fired');

    const id = Number(event.target.dataset.id);
    const field = event.target.dataset.field;
    const value = event.target.value;

    console.log('ID:', id);
    console.log('Field:', field);
    console.log('Value:', value);

    this.passengers = this.passengers.map(passenger => {

        if (passenger.id === id) {

            return {
                ...passenger,
                [field]: value
            };

        }

        return passenger;

    });

 console.log(
    'Updated Passengers:',
    JSON.stringify(this.passengers)
);

}

     @api
    validateAllPassengers() {

        for (const passenger of this.passengers) {

            if (!passenger.firstName ||
    !passenger.lastName ||
    !passenger.email) {

                return false;

            }

        }

        return true;

    }

    handleContinue() {

        if (!this.validateAllPassengers()) {

            alert('Please fill all passenger details');
            return;

        }

        this.dispatchEvent(
            new CustomEvent('continue')
        );

    }

    @api
    getPassengerDetails() {

        return JSON.parse(JSON.stringify(this.passengers));

    }
}