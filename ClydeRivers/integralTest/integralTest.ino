// Real Time integral calculator
#include <integral_ant.h>
float data;
float dt, t0, t1, t2,reimann,timeSpan;
float IC[2] = {0.0, 0.0};
int n = 0;
int c = 0;
float xDot_hat[2][1] = {{0.0},{0.0}};
float x_hat[2][1] = {{0.0},{0.0}};
float IC_mat[2][1] = {{0.0},{0.0}};


void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  t0 = millis();
  t1 = millis();
  timeSpan = (t1 - t0)/1000;
  t2 = 0;
}

void loop() {
  // put your main code here, to run repeatedly:
  while (timeSpan <= 10)
  {
    
    t1 = millis();
    dt = (t1 - t2) / 1000;
    xDot_hat[0][0] = LinfuncTest(timeSpan);
    xDot_hat[1][0] = quadfuncTest(timeSpan);
    //MatrixIntegral(xDot_hat,2, dt, IC_mat,2);
    x_hat[0][0] = trapz(xDot_hat[0][0],dt,IC[0]);
    x_hat[1][0] = trapz(xDot_hat[1][0],dt,IC[1]);
    IC[0] = x_hat[0][0];
    IC[1] = x_hat[1][0];
    //Serial.print(xDot_hat[0][0]); Serial.print("  "); Serial.print(xDot_hat[1][0]); Serial.println();
    
     /*// This section below is for a single integral
    data = LinfuncTest(timeSpan);
    reimann = integral(data, dt, IC);
    //reimann = trapz(data, dt, IC);
    IC = reimann;
    //Serial.print(t1); Serial.print("  "); Serial.print(t2); Serial.print("  "); Serial.print(dt);Serial.print("  "); Serial.print(timeSpan);
    Serial.println(data);*/
    
    t2 = t1;
    delay(25);
    timeSpan = (t1 - t0)/1000;
    
  }
  if(n==0)
  {
  Serial.println();
  //Serial.print("Area: "); Serial.print(IC); Serial.println();
  Serial.print("xHat1: "); Serial.print(x_hat[0][0]); Serial.println();
  Serial.print("xHat2: "); Serial.print(x_hat[1][0]); Serial.println();
  n=1;
  }
}
