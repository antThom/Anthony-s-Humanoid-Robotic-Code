#include "Arduino.h"
#include "microMotor.h"
#include <BasicLinearAlgebra.h>
#include <integral_ant.h>

void microMotor::setA_mat(float a1, float a2, float a3, float a4)
{
   A << a1, a2,
        a3, a4;/*
   A[0][0] = a1;
   A[0][1] = a2;
   A[1][0] = a3;
   A[1][1] = a4;*/
}

void microMotor::setB_mat(float b1, float b2)
{
  B << b1,
       b2;
	/*B[0][0] = b1;
	B[1][0] = b2;*/
}

void microMotor::setC_mat(float c1,float c2)
{ 
  C << c1, 0,
        0, c2;   
	/*C[0][0] = c1;
  C[0][1] = c2;
  C[1][0] = c3;
  C[1][1] = c4;*/
}

void microMotor::setL_mat(float l1,float l2)
{
  L << l1,
       l2;
	/*L[0][0] = l1;
  L[1][0] = l2;*/
}

void microMotor::estimator()//mtx_type* A_mat, mtx_type* B_vec, mtx_type* C_vec, mtx_type* L_vec, mtx_type* U_vec, float y)
{
	//This is where the estimator is

  BLA::Matrix<2,1> gamma = B * u;
	//Matrix.Multiply((mtx_type*)B, (mtx_type*)u, 2, 1, 1,(mtx_type*)gamma); // the output is gamma
  xHat(0) = trapz(xHatDot(0),dt,xHatDot_initial(0));
  xHat(1) = trapz(xHatDot(1),dt,xHatDot_initial(1));
  Multiply(C,xHat,yHat); //Observer Output
  BLA::Matrix<2,1> lambda = A * xHat;
  //Multiply(A,xHat,lambda); //Observer dynamics
  Add(-yHat,y,eHat);  //Observer Error compared to actual output
  Multiply(L,eHat,ObservError); //Observer Error
  Add(lambda,gamma,xHatDot); 
  Add(xHatDot,ObservError,xHatDot);
  
  xHatDot_initial(0) = xHat(0);
  xHatDot_initial(1) = xHat(1);

  
  
  
 /*
  //(double)xHat(1) = Integrator::step(xDot(0));
  //double a = Integrator::step(double(1.0));
  //double xHat2 = Integrator::step(xDot2);
  //xHat(0) = xHat1;
  //xHat(1) = xHat2; 
  Multiply(A,xHat,lambda);
  Multiply(C,xHat,yHat);
  Add(-yHat,y,eHat);
  Multiply(L,eHat,ObservError);
  Add(lambda,gamma,xDot);
  Add(xDot,ObservError,xDot);
	*/
}
