#include <Encoder.h>
#include <DRV8835MotorShield.h>
#include "constants.h"
#include "Commands.h"

 
void setup() {
  // put your setup code here, to run once:
  pinMode(wristSwitch,INPUT);
  pinMode(clawSwitch,INPUT);
  Serial.begin(9600);
  helpMenu();

}

void loop() {
  // put your main code here, to run repeatedly:
  newClawPosition=clawEncoder.read();
  clawState=digitalRead(clawSwitch);
  wristState=digitalRead(wristSwitch);
  
  if (Serial.available()){
    command=Serial.read();
    switch(command):{
     case 1:
      clawCalibration();
      break;
    }
   }
  /*if (clawState==LOW){
    clawMotor.setM1Speed(clawSpeed);
  }
  else{
    clawMotor.setM1Speed(0);
  }
    
  */
  delay(5);
}
