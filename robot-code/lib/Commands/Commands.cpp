#include "Commands.h"
#include "Arduino.h"
#include <Encoder.h>
#include <DRV8835MotorShield.h>


/* This file is needed for the user interface for eugene */

void helpMenu(){
	Serial.println("Options: ");
  	Serial.println("1: clawCalibration ");
  	Serial.println("2: clawPosition ");
}
long clawCalibration(){
	clawState=digitalRead(clawSwitch);
	clawMotor.setM1Speed(clawSpeed); //Run the claw motor forward and close the claw
	if (clawState==LOW){
		clawMotor.setM1Speed(0);  //Stop the claw motor from moving
		clawLimit[0]=newClawPosition; //Set the closing limit encoder value
	}
	clawMotor.setM1Speed(-clawSpeed);
	delay(100);
	if (clawState==LOW){
		clawMotor.setM1Speed(0);  //Stop the claw motor from moving
		clawLimit[1]=newClawPosition; //Set the closing limit encoder value
	}

	}


long motorPosition(){
	
}