#include "states.h"
#include "Arduino.h"
#include <Encoder.h>


uint8_t runController(Encoder leftEnc, Encoder rightEnc, bool lswVal, bool rswVal)
{
  return 0;
}

bool getSwitchVal(bool switchPin, int &dt)
{
  bool swVal;
  uint16_t Lcount, Rcount = 0;
  int Lt0,Lt1,Rt0,Rt1;
  swVal = bool(digitalRead(switchPin));
  if (swVal) // if the switch is clicked
  {
    if (switchPin == 8)
    { 
      Lcount++;  //increment the counter
      if (Lcount == 0)  //If its the first click
        {
          Lt0=millis();  //Initialize the timer
        }
      else
      {    
        Lt1=millis();
        dt = getSwitchTime(Lt1,Lt0);
        Lt0=Lt1;
      } 
    }
    else if (switchPin == 10)
    {
      Rcount++;   //increment the counter
      if (Rcount == 0)
        {
          Rt0=millis(); //Initialize the timer
        } 
      else
      {
        Rt1=millis();
        dt = getSwitchTime(Rt1,Rt0);
        Rt0=Rt1;
      }
    }
  }
  return swVal;
}

float* getMagVal(LSM303 mag)
{
  float m[3];
  mag.read();
  m[0] = mag.m.x; //magnet reading in x direction
  m[1] = mag.m.y; //magnet reading in y direction
  m[2] = mag.m.z; //magnet reading in z direction
  return m;
}

float* getAcc(LSM6 ACC)
{
  float acc[3];
  ACC.readAcc();
  acc[0] = ACC.a.x; //acceleration reading in x direction
  acc[1] = ACC.a.y; //acceleration reading in y direction
  acc[2] = ACC.a.z; //acceleration reading in z direction
  return acc;
}

float* getGyro(LSM6 GYRO)
{
  float gyro[3];
  GYRO.readGyro();
  gyro[0] = GYRO.g.x; //gyro reading in x direction
  gyro[1] = GYRO.g.y; //gyro reading in y direction
  gyro[2] = GYRO.g.z; //gyro reading in z direction
  return gyro;
}

int getEncoder(Encoder enc)
{
  int encVal;
  encVal = enc.read();
  return encVal;
}

int getSwitchTime(int t1,int t0)
{
  return t1-t0;
}
