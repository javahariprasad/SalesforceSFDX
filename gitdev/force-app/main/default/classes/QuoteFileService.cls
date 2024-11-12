public class QuoteFileService {
    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> getPdfFilesWithIdsAsBase64(Id opportunityId) {
        // List of statuses in the required order
        List<String> statusOrder = new List<String>{'Closed Won'};
                    
        // Find all quotes related to the given opportunity
        List<Opportunity> quotes = [SELECT Id , StageName FROM Opportunity WHERE Id = :opportunityId];
        
        // Collect all quote IDs
        Set<Id> quoteIds = new Set<Id>();
        Map<Id, String> quoteStatusMap = new Map<Id, String>();
        for (Opportunity quote : quotes) {
            quoteIds.add(quote.Id);
            quoteStatusMap.put(quote.Id, quote.StageName);
        }
        system.debug(' quoteIds   '+quoteIds);
        
        // Find all content document links related to the quotes
        List<ContentDocumentLink> contentDocumentLinks = [
            SELECT ContentDocumentId, LinkedEntityId
            FROM ContentDocumentLink
            WHERE LinkedEntityId IN :quoteIds
        ];
        system.debug(' contentDocumentLinks   '+contentDocumentLinks);
        // Collect all content document IDs from the links
        Set<Id> contentDocumentIds = new Set<Id>();
        for (ContentDocumentLink cdl : contentDocumentLinks) {
            contentDocumentIds.add(cdl.ContentDocumentId);
        }
        system.debug(' contentDocumentIds   '+contentDocumentIds);
        // Find all content versions based on the content document IDs
        List<ContentVersion> contentVersions = [
            SELECT ContentDocumentId, VersionData, CreatedDate
            FROM ContentVersion
            WHERE ContentDocumentId IN :contentDocumentIds
            ORDER BY CreatedDate DESC
        ];
        system.debug(' contentVersions   '+contentVersions);
        // Map content document ID to its content versions
        Map<Id, List<ContentVersion>> documentVersionsMap = new Map<Id, List<ContentVersion>>();
        for (ContentVersion version : contentVersions) {
            if (!documentVersionsMap.containsKey(version.ContentDocumentId)) {
                documentVersionsMap.put(version.ContentDocumentId, new List<ContentVersion>());
            }
            documentVersionsMap.get(version.ContentDocumentId).add(version);
        }
        system.debug(' documentVersionsMap   '+documentVersionsMap);
        // Prepare the list of files with their IDs and base64 data
        List<Map<String, String>> pdfFilesWithIds = new List<Map<String, String>>();
        for (String status : statusOrder) {
            for (Opportunity quote : quotes) {
                if (quote.StageName == status) {
                    List<ContentVersion> allVersionsForQuote = new List<ContentVersion>();
                    for (ContentDocumentLink link : contentDocumentLinks) {
                        if (link.LinkedEntityId == quote.Id && documentVersionsMap.containsKey(link.ContentDocumentId)) {
                            allVersionsForQuote.addAll(documentVersionsMap.get(link.ContentDocumentId));
                        }
                    }
                    allVersionsForQuote.sort();
                    
                    for (ContentVersion version : allVersionsForQuote) {
                        Map<String, String> pdfData = new Map<String, String>();
                        pdfData.put('ContentDocumentId', version.ContentDocumentId);
                        pdfData.put('Base64Data', EncodingUtil.base64Encode(version.VersionData));
                        pdfFilesWithIds.add(pdfData);
                    }
                }
            }
        }
        system.debug(' pdfFilesWithIds   '+pdfFilesWithIds);
        return pdfFilesWithIds;
    }
}