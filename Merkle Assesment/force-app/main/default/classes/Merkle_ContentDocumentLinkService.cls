/**
* @description       : 
* @author            : Somnath Sharma
* @group             : 
* @last modified on  : 11-05-2023
* @last modified by  : Somnath Sharma
**/
public with sharing class Merkle_ContentDocumentLinkService {
    public static void updateVisibilityOnFileInsertForProduct2(List<ContentDocumentLink> records) {
        for(ContentDocumentLink obj:records){
            String Id = obj.LinkedEntityId;
            if (Id.substring(0,3) == Product2.SObjectType.getDescribe().getKeyPrefix()){
                obj.Visibility='AllUsers';
            }
        }
        
    }
}