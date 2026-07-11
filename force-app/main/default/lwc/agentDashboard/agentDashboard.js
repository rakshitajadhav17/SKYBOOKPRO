import { LightningElement, wire } from 'lwc';

import getDashboardStats
from '@salesforce/apex/AgentDashboardService.getDashboardStats';

import getRecentBookings
from '@salesforce/apex/AgentDashboardService.getRecentBookings';

import getRecentRefunds
from '@salesforce/apex/AgentDashboardService.getRecentRefunds';

import getAllBookings
from '@salesforce/apex/AgentDashboardService.getAllBookings';

import getConfirmedBookings
from '@salesforce/apex/AgentDashboardService.getConfirmedBookings';

import getCancelledBookings
from '@salesforce/apex/AgentDashboardService.getCancelledBookings';

import getRevenueBookings
from '@salesforce/apex/AgentDashboardService.getRevenueBookings';

import getPendingRefunds
from '@salesforce/apex/AgentDashboardService.getPendingRefunds';

import searchPassengers
from '@salesforce/apex/AgentDashboardService.searchPassengers';

import { refreshApex } from '@salesforce/apex';

import { MessageContext, subscribe }
from 'lightning/messageService';

import SKYBOOK_CHANNEL
from '@salesforce/messageChannel/SkyBook_Channel__c';

export default class AgentDashboard extends LightningElement {

    dashboard = {};

    recentBookings = [];
    recentRefunds = [];

    contacts = [];
    bookings = [];

    subscription;
    wiredDashboardResult;

    searchKey = '';

    // ===========================
    // Dynamic Table Variables
    // ===========================

    displayBookings = [];

    displayRefunds = [];

    tableTitle = '';

    showResultTable = false;

    isBookingTable = false;

    isRefundTable = false;

    @wire(MessageContext)
    messageContext;

    // ===========================
    // Dashboard Statistics
    // ===========================

    @wire(getDashboardStats)
    wiredDashboard(result){

        this.wiredDashboardResult = result;

        if(result.data){

            this.dashboard = result.data;

        }

        else if(result.error){

            console.error(result.error);

        }

    }

    // ==============================
// Recent Bookings
// ==============================

@wire(getRecentBookings)
wiredBookings({ data, error }) {

    if (data) {

        this.recentBookings = data.map(row => {

            return {

                Id: row.Id,

                Name: row.Name,

                PassengerName:
                    row.Passenger__r
                        ? row.Passenger__r.FirstName + ' ' +
                          row.Passenger__r.LastName
                        : '',

                Booking_Status__c:
                    row.Booking_Status__c,

                Total_Amount__c:
                    row.Total_Amount__c,

                Booking_Date__c:
                    row.Booking_Date__c

            };

        });

    }
    else if (error) {

        console.error(error);

    }

}

// ==============================
// Recent Refunds
// ==============================

@wire(getRecentRefunds)
wiredRefunds({ data, error }) {

    if (data) {

        this.recentRefunds = data.map(row => {

            return {

                Id: row.Id,

                BookingName:
                    row.Booking__r
                        ? row.Booking__r.Name
                        : '',

                Refund_Amount__c:
                    row.Refund_Amount__c,

                Refund_Status__c:
                    row.Refund_Status__c,

                Requested_Date__c:
                    row.Requested_Date__c

            };

        });

    }
    else if (error) {

        console.error(error);

    }

}

// ==============================
// Helper Method
// Used by all KPI cards
// ==============================

mapBookingData(data) {

    return data.map(row => {

        return {

            Id: row.Id,

            Name: row.Name,

            PassengerName:
                row.Passenger__r
                    ? row.Passenger__r.FirstName + ' ' +
                      row.Passenger__r.LastName
                    : '',

            Booking_Status__c:
                row.Booking_Status__c,

            Total_Amount__c:
                row.Total_Amount__c

        };

    });

}
       bookingColumns = [

        {
            label: 'Booking',
            fieldName: 'Name'
        },

        {
            label: 'Passenger',
            fieldName: 'PassengerName'
        },

        {
            label: 'Status',
            fieldName: 'Booking_Status__c'
        },

        {
            label: 'Amount',
            fieldName: 'Total_Amount__c',
            type: 'currency'
        }

    ];

    // Reuse the same columns for dynamic booking table
    confirmedColumns = [
    {
        label:'Booking',
        fieldName:'Name'
    },
    {
        label:'Passenger',
        fieldName:'PassengerName'
    },
    {
        label:'Status',
        fieldName:'Booking_Status__c'
    },
    {
        label:'Amount',
        fieldName:'Total_Amount__c',
        type:'currency'
    }
];
    refundColumns = [

        {
            label: 'Booking',
            fieldName: 'BookingName'
        },

        {
            label: 'Amount',
            fieldName: 'Refund_Amount__c',
            type: 'currency'
        },

        {
            label: 'Status',
            fieldName: 'Refund_Status__c'
        }

    ];

    contactColumns = [

        {
            label:'First Name',
            fieldName:'FirstName'
        },

        {
            label:'Last Name',
            fieldName:'LastName'
        },

        {
            label:'Email',
            fieldName:'Email'
        }

    ];

    bookingSearchColumns = [

        {
            label:'Booking',
            fieldName:'Name'
        },

        {
            label:'Status',
            fieldName:'Booking_Status__c'
        },

        {
            label:'Amount',
            fieldName:'Total_Amount__c',
            type:'currency'
        }

    ];

    handleSearch(event){

        this.searchKey = event.target.value;

    }

    searchPassenger(){

        if(!this.searchKey){

            this.contacts = [];
            this.bookings = [];
            return;

        }

        searchPassengers({

            searchTerm:this.searchKey

        })

        .then(result=>{

            this.contacts = result[0];
            this.bookings = result[1];

        })

        .catch(error=>{

            console.error(error);

        });

    }

    connectedCallback(){

        if(!this.subscription){

            this.subscription = subscribe(

                this.messageContext,

                SKYBOOK_CHANNEL,

                (message)=>{

                    this.handleMessage(message);

                }

            );

        }

    }

    handleMessage(message){

        if(message.action === 'BookingCancelled'){

            refreshApex(this.wiredDashboardResult);

        }

    }

    // ==========================
    // Helper
    // ==========================

    scrollToTable(){

        setTimeout(()=>{

            const section = this.template.querySelector('[data-id="resultSection"]');

            if(section){

                section.scrollIntoView({

                    behavior:'smooth',

                    block:'start'

                });

            }

        },200);

    }

    // ==========================
    // Total Bookings
    // ==========================
loadAllBookings(){

    if(this.showResultTable &&
       this.tableTitle === 'All Bookings'){

        this.showResultTable = false;
        return;

    }

    getAllBookings()

    .then(result=>{

        this.displayBookings = this.mapBookingData(result);

        this.tableTitle = 'All Bookings';

        this.showResultTable = true;

        this.isBookingTable = true;

        this.isRefundTable = false;

        this.scrollToTable();

    })

    .catch(error=>{

        console.error(error);

    });

}

    // ==========================
    // Confirmed
    // ==========================

    loadConfirmedBookings(){

    if(this.showResultTable &&
       this.tableTitle === 'Confirmed Bookings'){

        this.showResultTable = false;
        return;

    }

    getConfirmedBookings()

    .then(result=>{

        this.displayBookings = this.mapBookingData(result);

        this.tableTitle = 'Confirmed Bookings';

        this.showResultTable = true;

        this.isBookingTable = true;

        this.isRefundTable = false;

        this.scrollToTable();

    })

    .catch(error=>{

        console.error(error);

    });

}

    // ==========================
    // Cancelled
    // ==========================

    loadCancelledBookings(){

    if(this.showResultTable &&
       this.tableTitle === 'Cancelled Bookings'){

        this.showResultTable = false;
        return;

    }

    getCancelledBookings()

    .then(result=>{

        this.displayBookings = this.mapBookingData(result);

        this.tableTitle = 'Cancelled Bookings';

        this.showResultTable = true;

        this.isBookingTable = true;

        this.isRefundTable = false;

        this.scrollToTable();

    })

    .catch(error=>{

        console.error(error);

    });

}
    // ==========================
    // Revenue
    // ==========================

    loadRevenueBookings(){

    if(this.showResultTable &&
       this.tableTitle === 'Revenue Details'){

        this.showResultTable = false;
        return;

    }

    getRevenueBookings()

    .then(result=>{

        this.displayBookings = this.mapBookingData(result);

        this.tableTitle = 'Revenue Details';

        this.showResultTable = true;

        this.isBookingTable = true;

        this.isRefundTable = false;

        this.scrollToTable();

    })

    .catch(error=>{

        console.error(error);

    });

}
    // ==========================
    // Pending Refunds
    // ==========================

    loadPendingRefunds(){

    if(this.showResultTable &&
       this.tableTitle === 'Pending Refunds'){

        this.showResultTable = false;
        return;

    }

    getPendingRefunds()

    .then(result=>{

        this.displayRefunds = result.map(row => ({

            Id: row.Id,

            BookingName: row.Booking__r
                ? row.Booking__r.Name
                : '',

            Refund_Amount__c: row.Refund_Amount__c,

            Refund_Status__c: row.Refund_Status__c

        }));

        this.tableTitle = 'Pending Refunds';

        this.showResultTable = true;

        this.isBookingTable = false;

        this.isRefundTable = true;

        this.scrollToTable();

    })

    .catch(error=>{

        console.error(error);

    });

}
}