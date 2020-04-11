local players = {};
local models = {
    "homeless": 153,
    "loader": 63
}
local objects = {
    "box": 98
}
local hands = {
    "left": 1,
    "right": 2
}

function init() {
    setGameModeText("EB-RP");
    setMapName("Empire Bay");
    setSummer(false);
    setWeather("DT03part03MariaAgnelo");

    // truck for job loader
    createVehicle(36, -331.526, -717.564, -21.4094, 178.694, -0.019687, -0.376999);
}

function playerSpawn(playerid){
    setPlayerPosition(playerid, -342.411, -862.561, -21.7457);
    setPlayerHealth(playerid, 720.0);
    setPlayerModel(playerid, models["homeless"]);

    sendPlayerMessage(playerid, "Welcome to Mafia2-Online RolePlay!", 150, 150, 230);

    players[playerid] <- {};
    players[playerid]["money"] <- 10;
    players[playerid]["salary"] <- 0;
    players[playerid]["hand"] <- 0;
    players[playerid]["work"] <- 0;
}

function onAction(playerid) {
    local position = getPlayerPosition(playerid);
    local docksPointEnter = isPointInCircle2D(position[0], position[1], -348.026, -731.716, 1.0);
    local docksPointLeave = isPointInCircle2D(position[0], position[1], -348.129, -730.045, 1.0);
    local actionJobLoader = isPointInCircle2D(position[0], position[1], -350.47, -726.698, 1.0);
    local actionJobLoader = isPointInCircle2D(position[0], position[1], -350.47, -726.698, 1.0);
    local boxLoadingPoint = isPointInCircle2D(position[0], position[1], -334.026, -700.553, 1.0);
    local boxUnloadingPoint = isPointInCircle2D(position[0], position[1], -331.622, -713.436, 1.0);

    if(docksPointEnter) {
        setPlayerPosition(playerid, -348.791, -729.347, -15.4212);
    }

    if(docksPointLeave) {
        setPlayerPosition(playerid, -347.938, -732.888, -15.4212);
    }

    if(actionJobLoader) {
        local playerModal = getPlayerModel(playerid);

        if(playerModal != models["loader"]) {
            players[playerid]["work"] = "loader";
            setPlayerModel(playerid, models["loader"]);
            sendPlayerMessage(playerid, "Вы устроились на работу грузчиком", 255, 127, 80);
            sendPlayerMessage(playerid, "Ящики помечены на карте", 255, 127, 80);
            sendPlayerMessage(playerid, "Ящики нужно грузить в грузовик", 255, 127, 80);
            triggerClientEvent(playerid, "onJobLoaderStart");
            triggerClientEvent(playerid, "onBoxLoading");
        } else {
            setPlayerModel(playerid, models["homeless"]);
            sendPlayerMessage(playerid, "Вы уволились с работы грузчиком", 255, 127, 80);
            triggerClientEvent(playerid, "onClearJobLoadingBlips")

            if(players[playerid]["salary"] != 0) {
                sendPlayerMessage(playerid, "Вы заработали: $" + players[playerid]["salary"], 255, 127, 80);
                players[playerid]["money"] += players[playerid]["salary"];
                getMoney(playerid);
                players[playerid]["salary"] = 0;
                players[playerid]["work"] = "unemployed";
            }
        }

    }

    if(boxLoadingPoint && players[playerid]["work"] == "loader") {
        triggerClientEvent(playerid, "onBoxUnloading");
        setPlayerHandModel(playerid, hands["left"], objects["box"]);
        setPlayerHandModel(playerid, hands["left"], objects["box"]);
        setPlayerAnimStyle(playerid, "common", "CarryBox");
        setPlayerAnimStyle(playerid, "common", "CarryBox");
        players[playerid]["hand"] = objects["box"];
    }

    if(boxUnloadingPoint && players[playerid]["work"] == "loader") {
        triggerClientEvent(playerid, "onBoxLoading");
        setPlayerHandModel(playerid, hands["left"], 0);
        setPlayerHandModel(playerid, hands["left"], 0);
        setPlayerAnimStyle(playerid, "common", "default");
        setPlayerAnimStyle(playerid, "common", "default");
        
        if(players[playerid]["hand"] != 0) {
            players[playerid]["hand"] = 0;
            players[playerid]["salary"] += 1;
            sendPlayerMessage(playerid, "Вы заработали: $1", 255, 127, 80);
    	}
    }
}

function getMoney(playerid) {
    sendPlayerMessage(playerid, "На вашем счету: $" + players[playerid]["money"], 135, 206, 250);
}

addCommandHandler("money", getMoney);
addEventHandler("onScriptInit", init);
addEventHandler("onAction", onAction);
addEventHandler( "onPlayerSpawn", playerSpawn );