﻿#include "R3F_TIRED_Configuration.sqf"

FNC_PrintToRPT =
{
	diag_log text _this;
};

R3F_TIRED_FNCT_Voile_Noir =
{
	_level = _this select 0;

	if (_level < R3F_TIRED_SHORTNESS_THRESHOLD ) then
	{
		playSound "heartbeat_1";
		playSound "heartbeat_1";
		addCamShake [2, 1, 25];
	};
};

R3F_TIRED_ForceWalk = false;

R3F_TIRED_FNCT_Overburdened =
{
	[localize "STR_R3F_WEIGHT_Overburdened",1] call dayz_rollingMessages;
	
	if (!R3F_TIRED_ForceWalk) then
	{
		R3F_TIRED_ForceWalk = true;
		[] spawn
		{
			private "_vel";
			
			while {R3F_TIRED_Accumulator > R3F_TIRED_BLACKOUT_LEVEL} do {
				if (vehicle player == player) then
				{
					_vel = velocity player;

					if ((abs(_vel select 0)) > 2 || (abs(_vel select 1)) > 2) then
					{
						player setVelocity [-(_vel select 0),-(_vel select 1),_vel select 2];
						player forceWalk true;
						
					};
				};
				uiSleep 0.001;
			};
			R3F_TIRED_ForceWalk = false;
			player forceWalk false;
			["",1] call dayz_rollingMessages;
		};
	};
};