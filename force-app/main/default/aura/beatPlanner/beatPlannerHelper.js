({
    load: function (component) {
        component.set("v.busy", true);
        var action = component.get("c.loadPanel");
        action.setParams({ recordId: component.get("v.recordId") });
        action.setCallback(this, function (response) {
            component.set("v.busy", false);
            if (response.getState() === "SUCCESS") {
                component.set("v.rows", response.getReturnValue());
            } else {
                component.set("v.error", "Unable to load legacy data");
            }
        });
        $A.enqueueAction(action);
    },
    runAction: function (component) {
        var action = component.get("c.loadPanel");
        action.setParams({ recordId: component.get("v.recordId") });
        $A.enqueueAction(action);
    }
})
