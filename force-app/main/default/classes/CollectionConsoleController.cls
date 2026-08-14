/**
 * Visualforce custom controller.
 * MIGRATION: F — SCREEN_FLOW_CANDIDATE for the wizard/search UX.
 * Apex service calls should remain if they perform integration or bulk DML.
 */
public with sharing class CollectionConsoleController {
    public String searchKey { get; set; }
    public String selectedIds { get; set; }
    public Integer stepNumber { get; set; }
    public String contextName { get; set; }
    public Boolean confirmFlag { get; set; }
    public String resultMessage { get; set; }
    public String derivedSummary { get; set; }
    public List<RowWrapper> rows { get; set; }

    public CollectionConsoleController() {
        stepNumber = 1;
        confirmFlag = false;
        rows = new List<RowWrapper>();
        refresh();
    }

    public void refresh() {
        search();
    }

    public void search() {
        rows = new List<RowWrapper>();
        String term = String.isBlank(searchKey) ? '%' : '%' + searchKey + '%';
        for (SObject rec : Database.query('SELECT Id, Name FROM Collection__c LIMIT 40')) {
            RowWrapper w = new RowWrapper();
            w.id = (Id) rec.get('Id');
            w.label = (String) rec.get('Name');
            w.status = rec.getSobjectType().getDescribe().getName();
            w.selected = false;
            rows.add(w);
        }
        derivedSummary = 'Loaded ' + rows.size() + ' CollectionConsole records';
    }

    public void next() {
        if (stepNumber < 4) {
            stepNumber++;
        }
    }

    public void previous() {
        if (stepNumber > 1) {
            stepNumber--;
        }
    }

    public PageReference finish() {
        if (!confirmFlag) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Confirm the action first'));
            return null;
        }
        resultMessage = 'Completed legacy bulk action for ' + rows.size() + ' rows';
        return null;
    }

    public PageReference saveRelated() {
        resultMessage = 'Saved';
        return null;
    }



    public class RowWrapper {
        public Id id { get; set; }
        public String label { get; set; }
        public String status { get; set; }
        public Boolean selected { get; set; }
        public String Name { get; set; }
    }
}
