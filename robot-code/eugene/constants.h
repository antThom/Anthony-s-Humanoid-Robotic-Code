#ifndef CONSTANTS_H
#define CONSTANTS_H
/* This header file should contain all of the constant variables 
// needed to robot eugene. This includes the encoder pin values, 
// switch sensor pins, motor pins, Controller constants, etc...
*/


char command;

// Switches and Buttons
int wristSwitch=53;		//Limit Switch for wrist calibration
int clawSwitch=51;		//Limit Switch for claw calibration



// Switch States and Button States
int wristState, clawState;



// Encoders
Encoder clawEncoder(49,47);
long clawPosition=-999;
long newClawPosition;
long clawLimit[]={0,0,0}; //Save three values(closeLimit,openLimit,maxDistance)



// Motors
DRV8835MotorShield clawMotor;
int clawSpeed= 300;

#endif
