public with sharing class GeminiAISearch {
    public GeminiAISearch() {
    }

    @AuraEnabled(cacheable=false)
    public static String getDetails(String userQuery) {
        Http httpCall = new Http();
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Gemini_AI_Search');
        req.setHeader('X-goog-api-key', Label.Gemini_AI_Search_API_Key);
        req.setMethod('POST');
        req.setTimeout(120000);
        String strBody = '{"contents": [{"parts": [{"text": "'+userQuery+'"}]}]}';
        req.setBody(strBody);
        
        HttpResponse resp = httpCall.send(req);
        return resp.getBody();
    }
}