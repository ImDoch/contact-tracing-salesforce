public with sharing class CTLocationTracingController {
  public static List<Location_Tracing__c> getVisitors(String locationId) {
    return [
      SELECT Id, Name, Person__c, Location__c, Visit_Date__c
      FROM Location_Tracing__c
      WHERE Id = :locationId
      ORDER BY Visiti_Date__c DESC NULLS LAST
    ];
  }

  public static List<Location_Tracing__c> getLocationsByPersonsId(
    Set<Id> personIds
  ) {
    Date last10Days = Date.today() - 10;
    return [
      SELECT Id, Name, Person__c, Location__c, Visit_Date__c
      FROM Location_Tracing__c
      WHERE Person__c = :personIds AND Visit_Date__c < :last10Days
    ];
  }
}
