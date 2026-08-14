import { LightningElement, api, track } from 'lwc';

/**
 * Designed as a Flow screen component (lightning__FlowScreen) but currently
 * hosted on Lightning pages because this org has no Flow definitions.
 *
 * MIGRATION: F — retain LWC; embed inside Screen Flow later.
 */
export default class CreditCheckPanel extends LightningElement {
    @api recordId;
    @api availableStatuses = 'Open,Working,Closed';
    @track selectedStatus;
    @track error;
    @track rows = [];
    columns = [
        { label: 'Choice', fieldName: 'name', type: 'text' }
    ];

    connectedCallback() {
        this.rows = (this.availableStatuses || '').split(',').map((s, i) => ({
            id: String(i),
            name: s.trim(),
            status: 'option'
        }));
    }

    handleRefresh() {}
    handleApply() {
        this.dispatchEvent(new CustomEvent('statuschange', { detail: this.selectedStatus }));
    }
    handleRowAction(event) {
        this.selectedStatus = event.detail.row.name;
    }
}
