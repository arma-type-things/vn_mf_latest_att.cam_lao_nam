/*
	File: fn_resupply_building_with_crate.sqf
	Author:  Savage Game Design
	Public: No

	Description:
		Resupply building request to server.

	Parameter(s):
		_target - building target [OBJECT, defaults to objNull]

	Returns: nothing

	Example(s):
		[_target] call para_c_fnc_resupply_building_with_crate;
*/

params
[
	["_target", objNull] 		// 0 : OBJECT
];

if (isNull _target) exitWith {diag_log "ERROR: Paradigm: Attempting to resupply null object"};

private _building = _target getVariable ["para_g_building", objNull];

if (isNull _building) exitWith {diag_log "ERROR: Paradigm: Attempted to resupply an object which is not a buildable"};

if !(_building getVariable ["para_g_building_constructed", false]) exitWith {
	["TaskFailed",["",localize "STR_para_build_cantresupplyunbuiltbuilding"]] call para_c_fnc_show_notification;
};

private _targetType = _building getVariable ["para_g_buildclass", ""];

if (_targetType == "") exitWith {diag_log format ["ERROR: Paradigm: Resupplying an object of class %1 that has no build type set.", typeOf _target]};

private _gamemodeConfig = missionConfigFile >> "gamemode";
private _supplyType = getText (_gamemodeConfig >> "buildables" >> _targetType >> "resupply");
private _validSupplyConfigs = "getText (_x >> 'supplyType') == _supplyType" configClasses (_gamemodeConfig >> "supplydrops" >> "construction");
private _validClasses = _validSupplyConfigs apply {getText (_x >> "className")};
private _nearbySupplies = _target nearEntities [_validClasses, 20] select {isNull attachedTo _x};

if !(_nearbySupplies isEqualTo []) then
{
	["resupplybuilding", [_target, "CRATE"]] call para_c_fnc_call_on_server;
} else {
	["TaskFailed",["",localize "STR_vn_mf_nosupplydropnearby"]] call para_c_fnc_show_notification;
};
