# att-mf-cam_lao_nam

Dev notes (to be removed):

```
this addEventHandler ["GetIn",
{
  _maxwell = getMarkerPos "zone_dharma";
  _soc_trang = getMarkerPos "zone_soc_trang";
  _pleiku = getMarkerPos "marker_pleiku_base";
  _migGroup = [[(_maxwell select 0),(_maxwell select 1),500], east, (configfile >> "CfgGroups" >> "East" >> "VN_PAVN" >> "vn_o_group_air_army" >> "vn_o_group_air_11")] call BIS_fnc_spawnGroup;
  _migGroup reveal [this, 3.5];
  _startWp1 = _migGroup addWaypoint [_soc_trang, 0];
  _targetWp1 = _migGroup addWaypoint [_pleiku, 1];
  _targetWp1 setWaypointType "SAD";
  [[blufor, "HQ"], "Four Migs spotted scrambling out of Maxwell! Repeat: Four Migs spotted scrambling out of Maxwell!"] remoteExec ["sideChat"];
}];
```