#ifndef microMotor_h
#define microMotor_h

#include "Arduino.h"
#include <BasicLinearAlgebra.h>

using namespace BLA;
// This Libary should be used  to create an Observer for a DC Brushed Motor.
class microMotor
{ 
  
  public:
  BLA::Matrix<2,2> A;
  BLA::Matrix<2,1> B;
  BLA::Matrix<2,2> C;
  BLA::Matrix<1> u;
  BLA::Matrix<2,2> L;
  BLA::Matrix<2,1> xHatDot = {0,
                           0};
  BLA::Matrix<2,1> xHatDot_initial = {0,
                                   0};                         
  BLA::Matrix<2,1> xHat= {0,
                          0};
  BLA::Matrix<2,1> eHat;
  BLA::Matrix<2,1> ObservError;
  BLA::Matrix<2,1> y;
  BLA::Matrix<2,1> yHat = {0,
                           0};
  BLA::Matrix<2,1> DIFF;
  BLA::Matrix<2,1> DATA;
  BLA::Matrix<2,1> data;                           
  float dt;
  uint32_t timeSpan;
  
	microMotor(int pin);
	void setA_mat(float a1, float a2, float a3, float a4);
	void setB_mat(float b1, float b2);
	void setC_mat(float c1,float c2);
	void setL_mat(float l1,float l2);
  void estimator(); // The output should be xHat

	//~microMotor();
	
};
#endif
