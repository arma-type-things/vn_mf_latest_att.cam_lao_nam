/*
    File: fn_zone_marker_show_info.sqf
    Author:  Savage Game Design
    Public: No

    Description:
        Internal use. Shows the information about the given marker on the map.
        Only one zone can be displayed at a time. Only calling this function
        will not update the tooltip's position. Use para_c_fnc_zone_marker_init and
        para_c_fnc_zone_markerAdd to set up the system.

    Parameter(s):
        _marker - Zone marker [STRING, defaults to nil]
        _info - Information to be displayed [ARRAY of strings]

    Returns:
        Information about the zone [TEXT]

    Example(s):
        ["zone_locationName"] call para_c_fnc_zone_marker_show_info;
*/
#include "..\..\..\configs\ui\ui_def_idc.inc"
params ["_marker"];

// Copy the info to display from the hashMap, otherwise display the raw variable
private _markerInfo = +(para_c_zone_markers_map getOrDefault [_marker, ["default", []]]);
_markerInfo params ["_type", ["_params", []]];

private _typeFunctionName = getText (missionConfigFile >> "gamemode" >> "zoneMarkerTypes" >> _type >> "function");
private _typeFunction = missionNamespace getVariable _typeFunctionName;

private _info = "";
if (_type == "default" || isNil "_typeFunction") then {
  _info = [_marker];
} else {
  _info = [_marker, _params] call _typeFunction;
};

private _map = findDisplay 12;
private _ctrlMap = _map displayCtrl 51;
_ctrlZoneMarkerInfo = _map displayCtrl PARA_RSCDISPLAYMAP_ZONEINFO_IDC;
//--- Get max text width (workaround for multiline ctrlTextWidth)
private _titleSize = 1.5;
private _cfgRscStructuredText = configFile >> "RscStructuredText";
private _textSize = getNumber (_cfgRscStructuredText >> "size");
private _textFont = getText (_cfgRscStructuredText >> "Attributes" >> "font");
private _maxTextW = selectMax (_info apply {
    private _sizeModifier = [1, _titleSize] select (_info select 0 == _x);
    _x getTextWidth [_textFont, _textSize * _sizeModifier]
});
_maxTextW = _maxTextW + 2 * 0.016;
_ctrlZoneMarkerInfo setVariable ["MaxTextWidth", _maxTextW];
//--- Set the text
_info set [0, format ["<t size='%2'>%1</t>", _info select 0, _titleSize]];
_ctrlZoneMarkerInfo ctrlSetStructuredText parseText (_info joinString "<br/>");
[_marker] call para_c_fnc_zone_marker_update_info_position;
_ctrlZoneMarkerInfo ctrlShow true;
_info
