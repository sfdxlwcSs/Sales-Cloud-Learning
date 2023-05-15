/**
 * @description       : 
 * @author            : Somnath Sharma
 * @group             : 
 * @last modified on  : 15-05-2023
 * @last modified by  : Somnath Sharma
**/
public with sharing class Merkle_Utility {
      public static string fetchImageUrl(String imageRichText){
        
        if(String.isBlank(imageRichText))  {
            return null;
        }
        Matcher imgMatcher = Pattern.compile( '<img(.+?)>' ).matcher(imageRichText);
        String img = '';
        while (imgMatcher.find()){                
            String imageTag = imgMatcher.group();
            img = imageTag.substringBetween(' src="', '"' );
            System.debug('img ===>' + img);
        }
        return img.unescapeHtml4();
    }
}