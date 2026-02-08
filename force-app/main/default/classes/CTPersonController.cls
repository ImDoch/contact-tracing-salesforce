public with sharing class CTPersonController {
  //Generate Token with person mobile number
  public static String getToken(String mobileNumber) {
    Blob value = Blob.valueOf(mobileNumber);
    Blob hash = Crypto.generateDigest('MD5', value);
    return EncodingUtil.base64Encode(hash);
  }

  //Get 100 people with recent health status change
  public static List<Person__c> getRecentHealthChanges() {
    return [
      SELECT
        Id,
        Name,
        Health_Status__c,
        Mobile__c,
        Status_Update_Date__c,
        Token__c
      FROM Person__c
      ORDER BY Status_Update_Date__c DESC NULLS LAST
      LIMIT 100
    ];
  }

  //Get people based on a query
  public static List<Person_c> searchPeople(String query) {
    query += '%';
    return [
      SELECT
        Id,
        Name,
        Health_Status__c,
        Mobile__c,
        Status_Update_Date__c,
        Token__c
      FROM Person__c
      WHERE Name LIKE :query OR Mobile__c LIKE :query OR Token__c LIKE :query
      ORDER BY Status_Update_Date__c
    ];
  }

  //Get one person by its id
  public static Person__c getPersonById(String personId) {
    List<Person__c> people = [
      SELECT
        Id,
        Name,
        Health_Status__c,
        Mobile__c,
        Status_Update_Date__c,
        Token__c
      FROM Person__c
      WHERE Id = :personId
    ];

    if (people != null && people.size() > 0) {
      return people[0];
    }

    return null;
  }
}
