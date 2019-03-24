#include "controller.h"
#include "Arduino.h"
#include <Encoder.h>

uint8_t runController(Encoder leftEnc, Encoder rightEnc, bool lswVal, bool rswVal)
{
	
}
void getStates(Encoder leftEnc, Encoder rightEnr, bool LswVal, bool RswVal, LSM303 mag, LSM6 acc_gyr)
{
  const int Lswitch = 8; 
  const int Rswitch = 10;
  float acc[3];
  float gyro[3];
  float m[3];
  // Read the switch values
  LswVal = digitalRead(Lswitch); 
  RswVal = digitalRead(Rswitch);
  // Read the encoder values
  lEncVal = leftEnc.read();
  rEncVal = rightEnr.read();
  
  // Read IMU values
  mag.read();
  m[0] = mag.m.x; //magnet reading in x direction
  m[1] = mag.m.y; //magnet reading in y direction
  m[2] = mag.m.z; //magnet reading in z direction
  
  acc_gyr.readAcc();
  acc[0] = acc_gyr.a.x; //acceleration reading in x direction
  acc[1] = acc_gyr.a.y; //acceleration reading in y direction
  acc[2] = acc_gyr.a.z; //acceleration reading in z direction
  
  acc_gyr.readGyro();
  gyro[0] = acc_gyr.g.x; //gyro reading in x direction
  gyro[1] = acc_gyr.g.y; //gyro reading in y direction
  gyro[2] = acc_gyr.g.z; //gyro reading in z direction
}