#ifndef COMMANDS_H
#define COMMANDS_H
#include "Arduino.h"
#include <Encoder.h>
#include <DRV8835MotorShield.h>
/* This header file should define each function neccessary for 
// sending commands to the robot. The cpp file will be the user
// interface for control. */

void helpMenu(); // displays the help menu that lists all of the commands
long clawCalibration(); //Sends back the encoder values after calibrating the claw
long motorPosition(); //Sends encoder values back for the motor to go to


#endif