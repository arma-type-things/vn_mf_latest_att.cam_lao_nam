/*
	File: fn_action_paradrop.sqf
	Author: Arma Type Things
	Public: No
	
	Description:
		Adds action to paradrop using GREUH paradrop

	Parameter(s):
		_agent - existing object [Object]
		_str_loc - localized string [String]
		_location - requested supplies [String]
		_image - image path [String]
	
	Returns: nothing
	
	Example(s):
		call ATT_fnc_action_paradrop
*/

private _baseConfig = missionConfigFile >> "ATT" >> "paradrop";

{
	private _pickupConfig = _x;

	private _object = missionNamespace getVariable [configName _pickupConfig, objNull];
	if (!isNull _object) then {
		_object setVariable ["#para_InteractionOverlay_ConfigClass", "Paradrop"];
        private _image = getText(_pickupConfig >> "image");
        [
            _object,
            createHashMapFromArray [
                ["iconPath", _image],
                ["function", "ATT_fnc_paradrop"],
                ["text", localize "STR_ATT_paradrop"]
            ]
        ] call para_c_fnc_wheel_menu_add_obj_action;
	};
} forEach ("true" configClasses (_baseConfig >> "pickups"))