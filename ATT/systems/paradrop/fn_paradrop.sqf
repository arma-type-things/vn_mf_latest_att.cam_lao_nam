// private _baseConfig = missionConfigFile >> "ATT" >> "paradrop" >> "pickups";



[] spawn {
    private [ "_dialog", "_backpack", "_backpackcontents" ];
    markers_reset = getMarkerPos "spawn_marker";
    drop_altitude = 800;

    _dialog = createDialog "mikeforce_paradrop";
    dojump = 0;
    jumper_position = getpos player;

    _backpackcontents = [];

    [ "att_paradrop_event", "onMapSingleClick", { jumper_position = _pos } ] call BIS_fnc_addStackedEventHandler;

    "spawn_marker" setMarkerTextLocal (localize "STR_ATT_Paradrop_Param");

    waitUntil { dialog };
    while { dialog && alive player && dojump == 0 } do {
        "spawn_marker" setMarkerPosLocal jumper_position;

        sleep 0.1;
    };

    if ( dialog ) then {
        closeDialog 0;
        sleep 0.1;
    };

    "spawn_marker" setMarkerPosLocal markers_reset;
    "spawn_marker" setMarkerTextLocal "";

    [ "att_paradrop_event", "onMapSingleClick" ] call BIS_fnc_removeStackedEventHandler;

    if ( dojump > 0 ) then {
        jumper_position = jumper_position getPos [random 250, random 360];
        jumper_position = [ jumper_position select 0, jumper_position select 1, drop_altitude + (random 200) ];
        paradropping = true;
        sleep 0.1;
        cutRsc ["paradrop", "PLAIN", 1];
        playSound "parasound";
        sleep 2;
        _backpack = backpack player;
        if ( _backpack != "" && _backpack != "B_Parachute" ) then {
            _backpackcontents = backpackItems player;
            removeBackpack player;
            sleep 0.1;
        };
        player addBackpack "B_Parachute";

        player setpos jumper_position;

        sleep 4;
        paradropping = false;
        waitUntil { !alive player || isTouchingGround player };
        if ( _backpack != "" && _backpack != "B_Parachute" ) then {
            sleep 2;
            player addBackpack _backpack;
            clearAllItemsFromBackpack player;
            { player addItemToBackpack _x } foreach _backpackcontents;
        };
    };

};