/*
   In this code we will be running code that will be drive a motor with an encoder
   and will captue the encoder counts as the motor drives. We will them upload this
   to matlab to run some data analysis to create an dynamic model of the motor.

   RUN THIS INTO pUTTY and SAVE AS TXT FILE THEN UPLOAD INTO MATLAB
*/
#include <Encoder.h>

Encoder motorEnc(18, 19);
int DC[11] = {0, 50, 55, 60, 65, 70, 75, 80, 85, 90, 100};
int dir1 = 52;
int dir2 = 50;
int mot = 12;
unsigned long enco;
int dt = millis();
int duration = 10;
unsigned long Time;
int runTime = 3;
int index = 0;

void setup() {
  // put your setup code here, to run once:
  pinMode(dir1, OUTPUT);
  pinMode(dir2, OUTPUT);
  pinMode(mot, OUTPUT);
  Serial.begin(9600);
  Serial.flush();
  for (int i = 0; i<=10; i++)
  {
    DC[i] = map(DC[i], 0, 100, 0, 255);
    //Serial.println(DC[i]);
  }


  Serial.print("encoder, time, dutyCycle");
  Serial.println();

}

void loop() {
  // put your main code here, to run repeatedly:
  
    while (dt<=duration){
    //Drive motor forward
    if(dt%2==0 || dt!=0)
    {
      index+=1;
      if(index>10)
        index=10;
    }
    digitalWrite(dir1,LOW); //Set 1 of 2 direction pins to high to drive the motor in one direction
    digitalWrite(dir2,HIGH);  //Set the other direction pin to low
    analogWrite(mot,DC[index]);     //Input a PWM signal into the motor driver
    enco=motorEnc.read();    //Read the encoder values
    Time=millis();           //Get the time since the code started running
    dt=(dt+Time)/1000;
    Serial.print(enco); Serial.print(","); Serial.print(Time); Serial.print(","); Serial.print(DC[index]);Serial.print(",");Serial.print(dt);
    Serial.println();
    delay(10);
    }

    while (dt<=10+duration){
    analogWrite(mot,DC[0]);
    enco=motorEnc.read();    //Read the encoder values
    Time=millis();
    dt=(dt+Time)/1000;
    Serial.print(enco); Serial.print(","); Serial.print(Time); Serial.print(","); Serial.print(DC[0]);
    Serial.println();
    }
    Serial.end();
  
}
