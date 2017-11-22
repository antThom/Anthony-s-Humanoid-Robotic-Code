#include <Encoder.h>
#include <DRV8835MotorShield.h>
#include "constants.h"
#include "Commands.h"


void setup() {
  // put your setup code here, to run once:
  pinMode(wristSwitch, INPUT);
  pinMode(clawSwitch, INPUT);
  
  Serial.begin(9600);
  helpMenu();

}

void loop() {
  // put your main code here, to run repeatedly:
  newClawPosition = clawEncoder.read();
  clawState = digitalRead(clawSwitch);
  wristState = digitalRead(wristSwitch);

  if (Serial.available()) {
    command = Serial.read();
    switch (command) {
      case '1':
        int num = 1;
        clawSpeed = clawCalibration(clawSpeed, num);
        clawMotor.setM1Speed(clawSpeed);
        while (clawState == LOW) {
          clawState = digitalRead(clawSwitch);
          newClawPosition = clawEncoder.read();
        }
        if (clawState == HIGH) {
          clawMotor.setM1Speed(0);
          clawLimit[0] = newClawPosition;
          Serial.print("close= "); Serial.print(clawLimit[0]);Serial.println();
          num++;
          delay(150);
        }
        clawSpeed = clawCalibration(clawSpeed, num);
        clawMotor.setM1Speed(clawSpeed);
        delay(200);
        clawState = digitalRead(clawSwitch);
        while (clawState == LOW) {
          clawState = digitalRead(clawSwitch);
          newClawPosition = clawEncoder.read();
        }
        if (clawState == HIGH) {
          clawMotor.setM1Speed(0);
          clawLimit[1] = newClawPosition;
          Serial.print("open= "); Serial.print(clawLimit[1]);
          num++;
        }
        clawMotor.setM1Speed(200);
        delay(100);
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
