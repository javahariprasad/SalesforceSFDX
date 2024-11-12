public class CountryCodeHelper {
  public static String getCountryCode(String country) {
    Country_Code__mdt countryCode = Country_Code__mdt.getInstance(country);
        /*[
      SELECT Id, MasterLabel, Country_Code__c
      FROM Country_Code__mdt
      WHERE MasterLabel = :country
      LIMIT 1
    ];*/
  
    return countryCode.Country_Code__c;
  }
}