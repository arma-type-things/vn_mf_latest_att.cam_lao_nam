/*
	File: fn_create_vehicle_safely.sqf
	Author:  Savage Game Design
	Public: No
	
	Description:
		Creates a vehicle, with almost no risk of collision. Probabilistic - will not always find a place.
		Taken from official-antistasi-community/A3-Antistasi (MIT License). Though I wrote the code there originally, so no copyright issues exist.
	
	Parameter(s):
		_vehicleType - Type of vehicle to create [String]
		_pos - Position to spawn vehicle at [Position3D]
		_radius - Radius in which the vehicle can be spawned, 0 for exact positioning [Number, defaults to 0]
		_attempts - Attempts to place the vehicle. More attempts takes longer, but gives a higher chance of success [Number, defaults to 3]
		_force - Force the vehicle to spawn at the 'safest' place. Note: In testing, this almost always damaged the vehicle [Boolean, defaults to false]
	
	Returns:
		Vehicle created, or objNull if not possible. [Object]

	Example(s):
		["myVehicleClass", [1,1,1]] call para_g_fnc_create_vehicle_safely
*/

params ["_vehicleType", "_pos", ["_radius", 0], ["_attempts", 3], ["_force", false]];

private _spawnPosition = [];
private _willCollide = true;

private _vehicle = createVehicle [_vehicleType, [0,0,2000], [], 0, "NONE"];
//Disable simulation while we're testing. Save performance AND avoid it blowing up.
_vehicle enableSimulation false;

private _finished = false;

for "_i" from 1 to _attempts do {
	//We keep changing around the start position, to avoid findEmptyPosition repeatedly returning the same thing.
	//Makes the function more likely to succeed.
	private _randomOffset = [random (_radius - _radius / 2), random (_radius - _radius / 2), 0];
	_spawnPosition = (_pos vectorAdd _randomOffset) findEmptyPosition [0, (_radius / 2), _vehicleType];
	
	if !(_spawnPosition isEqualTo []) then {
		_willCollide = [_vehicle, _spawnPosition] call para_g_fnc_vehicle_will_collide_at_pos;
		_finished = !_willCollide;
	};
	
	if (_finished) exitWith {};
};

if (_willCollide && _force) then {
	_spawnPosition = [_spawnPosition, _pos] select (_spawnPosition isEqualTo []);
	_willCollide = false;
};


if !(_willCollide) exitWith {
	_vehicle setPos _spawnPosition;
	_vehicle enableSimulation true;
	_vehicle;
};

deleteVehicle _vehicle;
objNull;