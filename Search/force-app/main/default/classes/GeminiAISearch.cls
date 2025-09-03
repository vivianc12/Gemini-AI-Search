/* 
This class connects with Gemini 2.0 Flash text generation api
The class is invoked from the "GeminiAISearch" LWC component
*/
public with sharing class GeminiAISearch {
    public GeminiAISearch() {
    }

    /* 
    Description : The "getDetails" methods accepts the users input, and send the same to Gemini api
    to generate the reponse and return it to the "GeminiAISearch" LWC
    Input : The "userQuery" string variable accepts the customers search term and 
    passes it to Gemini 2.0 Flash
    Output : The method returns the HTTP resonse body as a string
    */
    @AuraEnabled(cacheable=false)
    public static String getDetails(String userQuery) {
        Http httpCall = new Http();
        
        // Prepare the request instance
        HttpRequest req = new HttpRequest();
        // Using Named Credentials for authentication
        req.setEndpoint('callout:Gemini_AI_Search');
        // Storing the Google API Key in a custom label for easy configuration
        req.setHeader('X-goog-api-key', Label.Gemini_AI_Search_API_Key);
        req.setMethod('POST');
        req.setTimeout(120000);
        // hardcodng the JSON body for the body. Utilize proper JSON generation logic
        String strBody = '{"contents": [{"parts": [{"text": "'+userQuery+'"}]}]}';
        req.setBody(strBody);
        
        HttpResponse resp = httpCall.send(req);
        return resp.getBody();
    }
}