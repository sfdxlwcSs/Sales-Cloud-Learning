/**
* @description       : 
* @author            : Somnath Sharma
* @group             : 
* @last modified on  : 10-05-2023
* @last modified by  : Somnath Sharma
**/
public inherited sharing class Merkel_ProductList {
    
    public class Product2Details{
        @AuraEnabled
        public String Brand { get; set; }
        @AuraEnabled
        public String Description { get; set; }
        @AuraEnabled
        public String Family { get; set; }
        @AuraEnabled
        public String Id { get; set; }
        @AuraEnabled
        public Decimal Inventory { get; set; }
        @AuraEnabled
        public Boolean IsActive { get; set; }
        @AuraEnabled
        public Boolean PreOrder { get; set; }
        @AuraEnabled
        public String Name { get; set; }
        @AuraEnabled
        public String QuantityUnitOfMeasure { get; set; }
        @AuraEnabled
        public String ProductCode { get; set; }
        @AuraEnabled
        public String ProductImageUrl { get; set; }
        @AuraEnabled
        public Decimal ProductPrice { get; set; }
    }
    
    @AuraEnabled(Cacheable=true scope='global')
    public static List<Product2Details> getProducts( ) {
        
        List<Product2Details> results = new List<Product2Details>();
        Set<Id> productIds = new Set<Id>();
        
        
        for(PricebookEntry obj: [ SELECT Id,UnitPrice,Product2Id,Product2.Name,Product2.Brand__c,Product2.CreatedById,Pricebook2.IsStandard,IsActive,
                                 Product2.Description,Product2.Family,Product2.Inventory__c,Product2.IsActive,Product2.Pre_Order_Available__c,
                                 Product2.LastModifiedDate,Product2.ProductCode,Product2.QuantityUnitOfMeasure FROM PricebookEntry
                                 Where PriceBook2.IsStandard =false And IsActive=true and Pricebook2.CreatedById=:UserInfo.getUserId() AND Pricebook2.IsActive=true
                                 AND Product2.CreatedById=:UserInfo.getUserId()  WITH SECURITY_ENFORCED ORDER BY Product2.LastModifiedDate DESC ]){
                                     
                                     productIds.add(obj.Product2Id);                        
                                     Product2Details res=new Product2Details();
                                     res.Brand=obj.Product2.Brand__c!=null?obj.Product2.Brand__c:'In House';
                                     res.Description=obj.Product2.Description;
                                     res.Family=obj.Product2.Family;
                                     res.Id=obj.Product2Id;
                                     res.Inventory=obj.Product2.Inventory__c!=null?obj.Product2.Inventory__c:0;
                                     res.IsActive=obj.Product2.IsActive;
                                     res.QuantityUnitOfMeasure=obj.Product2.QuantityUnitOfMeasure!=null?obj.Product2.QuantityUnitOfMeasure:'1 Unit';
                                     res.ProductCode=obj.Product2.ProductCode;
                                     res.PreOrder=obj.Product2.Pre_Order_Available__c;
                                     res.ProductPrice=obj.UnitPrice;
                                     res.Name=obj.Product2.Name;
                                     results.add(res);
                                 }
        if(!Test.IsRunningTest()){
            Map<Id,Id> productFileIdMap=getProductImageIds(productIds);
            System.debug('data'+productFileIdMap);
            for(Product2Details resObj:results){
                resObj.ProductImageUrl=productFileIdMap.get(resObj.Id)!= null?String.valueOf(productFileIdMap.get(resObj.Id)): resObj.ProductImageUrl;
            }
        }
        return results;
    }
    
    
    
    public static Map<Id,Id> getProductImageIds(set<Id> recordIds) {
        
        Map<Id,Id> contentIdMap2ProductIdMap = new Map<Id,Id>();
        Map<Id,Id> sObjectIdMap2VersionId = new Map<Id,Id>();
        
        Set<Id> contentIds = new Set<Id>();
        for (ContentDocumentLink contentDocLink :[SELECT ContentDocumentId, LinkedEntityId FROM ContentDocumentLink 
                                                  Where LinkedEntityId IN :recordIds]) {
                                                      
                                                      contentIdMap2ProductIdMap.put(contentDocLink.ContentDocumentId,contentDocLink.LinkedEntityId);
                                                  }
        for(ContentVersion ver :[SELECT Id,ContentDocumentId FROM ContentVersion 
                                 WHERE ContentDocumentId IN :contentIdMap2ProductIdMap.keySet()
                                 AND IsLatest = True]){
                                     sObjectIdMap2VersionId.put(contentIdMap2ProductIdMap.get(ver.ContentDocumentId),ver.Id);               
                                 }
        return sObjectIdMap2VersionId;
    }
    
}