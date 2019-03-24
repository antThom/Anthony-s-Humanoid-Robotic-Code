#ifndef STATES_H
#define STATES_H
#include "Arduino.h"
#include <Encoder.h>
#include <Adafruit_MotorShield.h>
#include <LSM6.h>
#include <LSM303.h>

uint8_t runController(Encoder leftEnc, Encoder rightEnr, bool LswVal, bool RswVal);
bool getSwitchVal(bool switchPin, int &dt);
float* getMagVal(LSM303 mag);
float* getAcc(LSM6 ACC);
float* getGyro(LSM6 GYRO);
int getEncoder(Encoder enc);
int getSwitchTime(int t1, int t0);
//void displayStates(
#endif
