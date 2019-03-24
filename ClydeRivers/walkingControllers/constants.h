#ifndef CONSTANTS_H
#define CONSTANTS_H

//Pin Assignment
const int Lswitch = 8; 
const int Rswitch = 10;

bool lSwtchVal;
bool rSwtchVal;

uint8_t u[2] ={0,0};

Encoder leftLeg(19,3);
Encoder rightLeg(2,18);
int lEncVal;
int rEncVal;

LSM6 acc_gyr;
const float gyroGain = 70;    //mdps/LSB from dataSheet
const float accGain = 0.061;  //mg/LSB from dataSheet
const float GRAVITY = 256.0;  //BYTES
float acc[3];
float gyro[3];

LSM303 mag;
const float magGain = 6842.0; //LSB/gauss;
float m[3];

Adafruit_MotorShield AFMS = Adafruit_MotorShield();
Adafruit_DCMotor *right_leg = AFMS.getMotor(2);
Adafruit_DCMotor *left_leg = AFMS.getMotor(1);

long *Rdtime, *Ldtime;

bool startWalk = true;
int inSerial;
float t0,t1,t2,t3;

//Constant
float pi = 3.141592654;
float swtchOffset = pi;
float milli2sec = 1/1000;
float gravity = 9.81;


#endif
