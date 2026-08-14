import { LightningElement, api, track } from 'lwc';
import runAction from '@salesforce/apex/VisitCockpitLwcController.loadRows';

export default class TargetScorecard extends LightningElement {
    @api recordId;
    @track rows = [];
    @track error;
    columns = [
        { label: 'Name', fieldName: 'name', type: 'text' },
        { label: 'Status', fieldName: 'status', type: 'text' },
        { label: 'Score', fieldName: 'score', type: 'number' }
    ];

    connectedCallback() {
        this.handleRefresh();
    }

    handleRefresh() {
        return runAction({ recordId: this.recordId })
            .then((data) => {
                this.rows = data || [];
                this.error = undefined;
            })
            .catch((err) => {
                this.error = err.body ? err.body.message : 'Apex call failed';
            });
    }

    handleApply() {
        // Path: LWC → Apex service → DML. Candidate for LWC → Flow → Invocable Apex.
        return this.handleRefresh();
    }

    handleRowAction(event) {
        this.recordId = event.detail.row.id;
        this.handleApply();
    }
}
