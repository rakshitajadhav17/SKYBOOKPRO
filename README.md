# ✈️ SkyBook Pro

## Salesforce Airline Booking Management System

SkyBook Pro is a Salesforce-based Airline Booking Management System developed as part of the **Wipro Salesforce Capstone Project**.

The application enables users to search flights using the **Duffel API**, select flights, enter passenger details, complete a simulated payment process, manage bookings, cancel bookings, process refunds, and monitor bookings through interactive dashboards built using Salesforce Lightning Web Components (LWC) and Apex.

---

# 🚀 Features

### ✈ Flight Search
- Search one-way flights
- Search using Origin, Destination and Departure Date
- Real-time flight search using Duffel API

### 🛫 Flight Selection
- View available flights
- Airline information
- Flight Number
- Departure & Arrival Time
- Duration
- Cabin Class
- Fare Details

### 👤 Passenger Details
- Passenger Information Form
- Passport Number
- Passenger Type
- Email Validation

### 📋 Booking Confirmation
- Flight Summary
- Passenger Summary
- Fare Summary
- Terms & Conditions

### 💳 Payment Gateway
- Credit / Debit Card (Demo)
- UPI (Demo)
- Net Banking (Demo)
- Payment Success Screen

### ✅ Booking Success
- Booking Confirmation
- Booking Summary
- Book Another Flight

### 📖 My Bookings Dashboard
- View all bookings
- Booking Details
- Booking Status
- Booking Cancellation
- Booking History

### 📊 Agent Dashboard
- Total Bookings
- Confirmed Bookings
- Cancelled Bookings
- Revenue
- Pending Refunds
- Passenger Search
- Recent Bookings
- Recent Refunds

### ⚙ Salesforce Automation
- Booking Confirmation Flow
- Booking Cancellation Trigger
- Refund Record Creation
- Lightning Message Service Refresh

---

# ⚠️ Important Note

The **Payment Gateway** implemented in this project is a **simulated payment module** created solely for demonstration as part of the Salesforce Capstone Project.

- No real payment transactions are processed.
- No credit/debit card or UPI information is stored.
- No banking systems are connected.
- No payment gateway APIs (Stripe, Razorpay, PayPal, etc.) are integrated.
- The payment screen demonstrates the booking workflow only.

This project is intended for **educational, learning, and portfolio purposes only**.

---

# 🛠 Technology Stack

| Technology | Used |
|------------|------|
| Salesforce Platform | ✅ |
| Lightning Web Components (LWC) | ✅ |
| Apex | ✅ |
| SOQL | ✅ |
| Salesforce Flow | ✅ |
| Lightning Message Service | ✅ |
| Platform Events | ✅ |
| Duffel Flight API | ✅ |
| VS Code | ✅ |
| Git & GitHub | ✅ |
| Jest Testing | ✅ |

---

# 📂 Project Structure

```
SkyBookPro
│
├── Apex Classes
│
├── Lightning Web Components
│     ├── SkyBookApp
│     ├── FlightSearchForm
│     ├── FlightResultsList
│     ├── FlightResultCard
│     ├── PassengerDetailsForm
│     ├── BookingConfirmation
│     ├── PaymentGateway
│     ├── BookingSuccess
│     ├── MyBookingsDashboard
│     └── AgentDashboard
│
├── Triggers
├── Flows
├── Message Channels
├── Reports
├── Dashboards
└── Static Resources
```

---

# 🏗 Salesforce Components

## Apex Classes

- BookingService
- DuffelService
- DuffelFlightSearchService
- DuffelFlightPricingService
- AgentDashboardService
- BookingController
- BookingDashboardService
- BookingDetailService
- BookingCancellationService
- DashboardController
- FlightService
- RefundService

---

## Lightning Web Components

- SkyBookApp
- FlightSearchForm
- FlightResultsList
- FlightResultCard
- PassengerDetailsForm
- BookingConfirmation
- PaymentGateway
- BookingSuccess
- MyBookingsDashboard
- AgentDashboard

---

## Salesforce Automation

### Flow

- Booking Confirmation Flow

### Trigger

- Booking Trigger
- BookingTriggerHandler
- Booking Cancellation Logic
- Refund Creation

---

# 🧪 Testing

### Apex Tests

- BookingServiceTest
- Trigger Test Classes

### Jest Testing

Successfully created and executed Jest test cases for Lightning Web Components.

Tested Components:

- BookingConfirmation
- FlightResultCard

All Jest tests passed successfully.

---

# 🔐 API Security

For security reasons, this repository **does not include live Duffel API credentials**.

* Live Duffel API token has been removed.
* Authorization keys and secrets are not included in this repository.
* Before running the application, replace the placeholder API key (for example, `YOUR_DUFFEL_API_KEY`) with **your own valid Duffel API token** or configure it using a secure method such as Salesforce Named Credentials.

Without a valid Duffel API token, the flight search functionality will not return live flight data.

---

# ⚙️ Installation

Clone the repository

```bash
git clone https://github.com/rakshitajadhav17/SKYBOOKPRO.git
```

Move into project

```bash
cd SKYBOOKPRO
```

Install Dependencies

```bash
npm install
```

Authorize Salesforce Org

```bash
sf org login web
```

Deploy Source

```bash
sf project deploy start
```

Run Jest Tests

```bash
npm test
```

---

# ⭐ Project Highlights

- Salesforce Capstone Project
- Complete Airline Booking Workflow
- Lightning Web Components (LWC)
- Apex Programming
- Duffel Flight API Integration
- Simulated Payment Gateway
- Passenger Management
- Booking Confirmation
- Booking Cancellation
- Refund Processing
- Agent Dashboard
- My Bookings Dashboard
- Salesforce Flow Automation
- Trigger Automation
- Lightning Message Service
- Reports & Dashboards
- Jest Testing
- Git Version Control
- GitHub Repository

---

# 👩‍💻 Developer

**Rakshita Jadhav**

Salesforce Developer | Java Full Stack Developer

GitHub:
https://github.com/rakshitajadhav17

---

## ⭐ If you found this project useful, please consider giving it a star on GitHub!
