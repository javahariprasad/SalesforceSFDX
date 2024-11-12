public class TravelNotificationDetails {
    	@AuraEnabled
        public String cardNumber { get; set; }
        @AuraEnabled
    	public String startDate { get; set; }
		@AuraEnabled	
    	public String endDate { get; set; }
    	@AuraEnabled	
    	public String location { get; set; }
        public String destinationCountry { get; set; }
        public String destinationState { get; set; }
        public List<String> destinationOther { get; set; }
        @AuraEnabled
    	public String primaryPhone { get; set; }
    	@AuraEnabled
        public String secondaryPhone { get; set; }
        public String activeStatus { get; set; }
        public boolean primaryCardholderOnly { get; set; }
        public boolean includeDebitCard { get; set; }    

}