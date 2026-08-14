({
    doInit: function (component, event, helper) {
        helper.load(component);
    },
    handleAction: function (component, event, helper) {
        helper.runAction(component);
    },
    handleSelect: function (component, event, helper) {
        var selected = event.getSource().get("v.value");
        component.set("v.selectedId", selected);
    }
})
