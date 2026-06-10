public class FlightOfferWrapper {

    @AuraEnabled
    public String offerId;

    @AuraEnabled
    public String airline;

    @AuraEnabled
    public String origin;

    @AuraEnabled
    public String destination;

    @AuraEnabled
    public Decimal price;

    @AuraEnabled
    public String currencyCode;

    @AuraEnabled
    public String cabinClass;
    
    @AuraEnabled 
    public String flightNumber;
    
    @AuraEnabled 
    public String departureTime;
    
    @AuraEnabled 
    public String arrivalTime;
    
    @AuraEnabled 
    public String duration;
    
    @AuraEnabled 
    public Integer seatsAvailable;
    
    @AuraEnabled 
    public List<String> segments;

}