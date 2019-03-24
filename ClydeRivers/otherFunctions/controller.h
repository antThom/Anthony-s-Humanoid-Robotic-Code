#ifndef CONTROLLER_H
#define CONTROLLER_H
#include "Arduino.h"
#include <Encoder.h>
#include <Adafruit_MotorShield.h>
#include <LSM6.h>
#include <LSM303.h>

uint8_t runController(Encoder leftEnc, Encoder rightEnr, bool LswVal, bool RswVal);
void getStates(Encoder leftEnc, Encoder rightEnr, bool LswVal, bool RswVal, LSM303 mag, LSM6 acc_gyr);
#endif