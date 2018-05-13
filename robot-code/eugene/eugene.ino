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
    Serial.println(command);
  }
  switch (command) {
    case 'c':
      num = 1;
      clawSpeed = clawCalibration(clawSpeed, num);
      clawMotor.setM1Speed(clawSpeed);
      while (clawState == LOW) {
        clawState = digitalRead(clawSwitch);
        newClawPosition = clawEncoder.read();
      }
      if (clawState == HIGH) {
        clawMotor.setM1Speed(0);
        clawLimit[0] = newClawPosition;
        Serial.print("close= "); Serial.print(clawLimit[0]); Serial.println();
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


    case 'p':
      Serial.println("Enter in a desired claw motor position: ");
      delay(3000);
      ref = Serial.read() - 'O'; //Convert the reference from char to int
      Serial.print("ref1= "); Serial.print(ref); Serial.println(Serial.available()); Serial.println();
      newClawPosition = clawEncoder.read();
      Serial.println("past ref");
      clawSpeed = motorPosition(ref, clawLimit[0], clawLimit[1], newClawPosition);
      clawMotor.setM1Speed(clawSpeed);
      while (newClawPosition != ref) {
        newClawPosition = clawEncoder.read();
        //Serial.println(newClawPosition);
      }
      if (newClawPosition == ref) {
        clawMotor.setM1Speed(0);
      }
      break;
    default:
      //Serial.println("Invalid Input");
      break;
  }
  delay(5);
  Serial.flush();
}
