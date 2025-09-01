import { LightningElement, track } from 'lwc';
import invokeApex from '@salesforce/apex/GeminiAISearch.getDetails';
export default class GeminiAISearch extends LightningElement {
    @track userQuery = '';
    @track result = '';
    @track isLoading = false;

    // Handles the change event from the textarea
    handleQueryChange(event) {
        this.userQuery = event.target.value;
    }

    // Handles the button click to call the Apex class
    handleButtonClick() {
        if (!this.userQuery) {
            // Optional: add validation or an error message here
            return;
        }

        this.isLoading = true; // Show the loading message
        this.result = ''; // Clear previous results
        invokeApex({ userQuery: this.userQuery })
            .then(data => {
                this.isLoading = false; // Hide the loading message
                this.parseJSONResponse(this.result);
            })
            .catch(error => {
                this.isLoading = false; // Hide the loading message on error
                this.result = 'An error occurred. Please try again.';
            });
    }

    parseJSONResponse(resp){
        let parsedValue = JSON.parse(resp);
        this.result = parsedValue.candidates[0].content.parts[0].text;
    }

    // A getter to disable the button when the query is empty or a process is running
    get isButtonDisabled() {
        return !this.userQuery || this.isLoading;
    }
}