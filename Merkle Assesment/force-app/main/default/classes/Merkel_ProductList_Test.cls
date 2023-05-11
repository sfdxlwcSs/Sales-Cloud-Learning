/**
 * @description       : 
 * @author            : Somnath Sharma
 * @group             : 
 * @last modified on  : 10-05-2023
 * @last modified by  : Somnath Sharma
**/
@isTest
public with sharing class Merkel_ProductList_Test {
    @testsetup
    public static void setup(){
        
        Pricebook2 listPriceBook  = new Pricebook2(
            Name  = 'TestPriceBook',
            isActive = true                                     
        );
        insert listPriceBook;
         List<Product2> listProducts = new List<Product2>();
        for(Integer i=0;i<4;i++){
         listProducts.add( new Product2(name='Product-TestSs',
                                    Family = 'Fuel'));
        }
        Insert listProducts;
        createContentDocument('test file',listProducts[0].Id);
         Id pricebookId = Test.getStandardPricebookId();
        Id pid=[Select id from Pricebook2 limit 1].id;
        PricebookEntry obj=  new PricebookEntry(
                Pricebook2Id  = pricebookId,
                Product2Id  = listProducts[0].Id,
                UnitPrice = 10,
                isActive = true                                     
            );
        
        Insert obj;
         PricebookEntry objNotStandard=  new PricebookEntry(
                Pricebook2Id  = listPriceBook.Id,
                Product2Id  = listProducts[0].Id,
                UnitPrice = 10,
                isActive = true                                     
            );
        
        Insert objNotStandard;
        
    }
    
     @isTest 
    private static void test_getProducts() {
        Merkel_ProductList.getProducts();
        Test.startTest();
        Product2 objProduct2=[Select Id From Product2 Limit 1];
        createContentDocument('testFile',objProduct2.Id);
        Test.stopTest();
        ContentDocumentLink obj=[Select Id,Visibility From ContentDocumentLink Where LinkedEntityId=:objProduct2.Id Limit 1];
        Assert.areEqual('AllUsers', obj.Visibility,'Visibility updated as per trigger: Merkel_FileShare');
    }
    
    private static void createContentDocument(string testFile,string linkedEntityId){
        ContentVersion conVer = new ContentVersion();
        conVer.ContentLocation = 'S'; 
        conVer.PathOnClient = 'image.jpg'; 
        conVer.Title = 'Test';
        conVer.VersionData = EncodingUtil.base64Decode(testFile); 
        insert conVer;
        
        Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId; 
        
        ContentDocument cd = new ContentDocument();
        cd.Id = conDoc;
        upsert cd;
        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.ContentDocumentId = conDoc;
        cdl.LinkedEntityId = linkedEntityId; 
        cdl.ShareType = 'V'; 
        Insert cdl;
    }
}