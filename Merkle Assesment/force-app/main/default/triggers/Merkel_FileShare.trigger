/**
* @description       : 
* @author            : Somnath Sharma
* @group             : 
* @last modified on  : 11-05-2023
* @last modified by  : Somnath Sharma
**/
trigger Merkel_FileShare on ContentDocumentLink (before insert) {
    
    
    if( Trigger.isInsert )
    {
        if(Trigger.isBefore){
            Merkle_ContentDocumentLinkHandler.onBeforeInsert(Trigger.new);
            
        }
    }
}