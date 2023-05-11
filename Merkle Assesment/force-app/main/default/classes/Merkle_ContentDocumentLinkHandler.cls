/**
* @description       : 
* @author            : Somnath Sharma
* @group             : 
* @last modified on  : 11-05-2023
* @last modified by  : Somnath Sharma
**/
public with sharing class Merkle_ContentDocumentLinkHandler {
    
    /**
* @description Method to process records on Before Insert
* @param records List of new records to be processed
*/
    public static void onBeforeInsert(List<ContentDocumentLink> records) {
        Merkle_ContentDocumentLinkService.updateVisibilityOnFileInsertForProduct2(records);
    }
    
}