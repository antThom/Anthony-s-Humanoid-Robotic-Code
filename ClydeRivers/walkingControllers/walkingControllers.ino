#include <LSM6.h>
#include <LSM303.h>
#include <Adafruit_MotorShield.h>
#include <Wire.h>
#include <Encoder.h>
#include "constants.h"
#include "states.h"
#include <math.h>
#include "microMotor.h"

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  AFMS.begin();
  Wire.begin();
  acc_gyr.init();
  acc_gyr.enableDefault();
  acc_gyr.writeReg(LSM6::CTRL1_XL, 0x3c);
  acc_gyr.writeReg(LSM6::CTRL2_G, 0x4c);
  mag.init();
  mag.enableDefault();
  right_leg->setSpeed(0);
  left_leg->setSpeed(0);
  leftLeg.write(0); // Reset to zero count
  rightLeg.write(0); // Reset to zero count
}

void loop() {
  if (Serial.available() > 0)
  {
    inSerial = char(Serial.read()); // Read the character input from the serial monitor
    if (inSerial=='g') // if the input is g then start the program
    {
      Serial.println("Starting the Program..."); Serial.println();
      t0 = millis();
      int&& dt =0;
      while(1)//inSerial=='g' || startWalk==true)
      {
        /*
         * In this section add the code that will run the controller.
         */
      inSerial = char(Serial.read()); // Read serial input and check for the exit condition
      if (inSerial=='e')
      {
        Serial.println("Ending the Program...");
        break;
      }
      delay(5);
      }
    }
    delay(5);
  }
  /*
  if (startWalk)
  {
    
  }
  else
  {
    //void getStates


    //u[0,1] = runController(leftLeg,rightLeg,lSwtchVal,rSwtchVal);
    //right_leg->setSpeed(u[0]);
    //left_leg->setSpeed(u[1]);
  }*/
}
