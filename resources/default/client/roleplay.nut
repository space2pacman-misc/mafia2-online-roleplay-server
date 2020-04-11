local blips = {
    "boxLoading": 0,
    "boxUnloading": 0
}
local texts = {
    "boxLoading": 0,
    "boxLoadingDescription": 0,
    "boxUnloading": 0,
    "boxUnloadingDescription": 0
}

function init() {
    createBlip(-348.026, -731.716, 7, 0);
    create3DTextLabel(-348.026, -731.716, -14.3389, "Docks", 0xFFFFFF, 50.0);
    create3DTextLabel(-348.026, -731.716, -14.4389, "Press E to enter", 0xFFFFFF, 1.0);
    create3DTextLabel(-348.129, -730.045, -14.4389, "Press E to leave", 0xFFFFFF, 1.5);

    create3DTextLabel(-350.47, -726.698, -14.3389, "Job loader", 0xFFFFFF, 5.0);
    create3DTextLabel(-350.47, -726.698, -14.4389, "Press E to action", 0xFFFFFF, 1.0);
}

function action() {
    triggerServerEvent("onAction");
}

function jobLoaderStart() {
    texts["boxLoading"] <- create3DTextLabel(-334.026, -700.553, -20.7302, "Box (loading)", 0xFFFF00, 30.0);
    texts["boxLoadingDescription"] <- create3DTextLabel(-334.026, -700.553, -20.8302, "Press E to action", 0xFFFF00, 1.0);
    texts["boxUnloading"] <- create3DTextLabel(-331.622, -713.436, -19.7489, "Box (unloading)", 0xFFFF00, 30.0);
    texts["boxUnloadingDescription"] <- create3DTextLabel(-331.622, -713.436, -19.8489, "Press E to action", 0xFFFF00, 1.0);
}

function boxLoading() {
    destroyBlip(blips["boxUnloading"]);
    blips["boxLoading"] <- createBlip(-334.026, -700.553, 0, 2);
}

function boxUnloading() {
    destroyBlip(blips["boxLoading"]);
    blips["boxUnloading"] <- createBlip(-331.622, -713.436, 0, 2);
}

function clearJobLoadingBlips() {
    destroyBlip(blips["boxLoading"]);
    destroyBlip(blips["boxUnloading"]);
    remove3DTextLabel(texts["boxLoading"]);
    remove3DTextLabel(texts["boxLoadingDescription"]);
    remove3DTextLabel(texts["boxUnloading"]);
    remove3DTextLabel(texts["boxUnloadingDescription"]);
}

addEventHandler("onClientScriptInit", init);
addEventHandler("onJobLoaderStart", jobLoaderStart);
addEventHandler("onBoxLoading", boxLoading);
addEventHandler("onBoxUnloading", boxUnloading);
addEventHandler("onClearJobLoadingBlips", clearJobLoadingBlips);
bindKey("e", "down", action);