function C = C_Mat_gen(in1)
%C_MAT_GEN
%    C = C_MAT_GEN(IN1)

%    This function was generated by the Symbolic Math Toolbox version 8.0.
%    02-Jan-2019 17:11:42

dphi1 = in1(15,:);
dphi2 = in1(16,:);
dth1 = in1(12,:);
dth2 = in1(13,:);
dth3 = in1(14,:);
phi1 = in1(7,:);
phi2 = in1(8,:);
th1 = in1(4,:);
th2 = in1(5,:);
th3 = in1(6,:);
t2 = cos(th2);
t3 = sin(th2);
t4 = cos(th3);
t5 = sin(th3);
t6 = cos(phi1);
t7 = sin(phi1);
t8 = cos(phi2);
t9 = sin(phi2);
t10 = th1-th2;
t11 = sin(t10);
t12 = t2.^2;
t13 = t6.^2;
t14 = th1-th3;
t15 = sin(t14);
t16 = t2.*t5.*(1.0./8.0);
t17 = t4.^2;
t18 = t8.^2;
t19 = t7.^2;
t20 = dphi2.*t5.*t8;
t21 = dth3.*t4.*t9;
t22 = t20+t21;
t23 = dphi1.*t3.*t6;
t24 = dth2.*t2.*t7;
t25 = t23+t24;
t26 = t9.^2;
C = reshape([0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,dth1.*sin(th1).*(-9.0./4.0),dth1.*cos(th1).*(-9.0./4.0),0.0,0.0,dth1.*t11.*(-5.0./8.0),dth1.*t15.*(-1.0./8.0),0.0,0.0,dth2.*t3.*(-5.0./4.0),dth2.*t2.*(-5.0./4.0),dphi1.*t2.*t7.*(-3.0./4.0)-dth2.*t3.*t6.*(3.0./4.0),dth2.*t11.*(5.0./8.0),dphi1.*t6.*t7.*t12.*(-3.0./1.6e1)-dth2.*t2.*t3.*t13.*(3.0./1.6e1),-dth2.*(-t16+t3.*t4.*(1.0./8.0)+t3.*t4.*t6.*t8.*(1.0./1.6e1))-dphi1.*t2.*t4.*t7.*t8.*(1.0./1.6e1),dth2.*(t6.*t7.*(3.0./1.6e1)-t6.*t7.*t12.*(3.0./1.6e1))+dphi1.*t2.*t3.*t19.*(3.0./1.6e1),t5.*t9.*(dphi1.*t2.*t7+dth2.*t3.*t6).*(1.0./1.6e1),dth3.*t5.*(-1.0./4.0),dth3.*t4.*(-1.0./4.0),dphi2.*t4.*t9.*(-1.0./4.0)-dth3.*t5.*t8.*(1.0./4.0),dth3.*t15.*(1.0./8.0),-dth3.*(t16-t3.*t4.*(1.0./8.0)+t2.*t5.*t6.*t8.*(1.0./1.6e1))-dphi2.*t2.*t4.*t6.*t9.*(1.0./1.6e1),dphi2.*t8.*t9.*t17.*(-1.0./1.6e1)-dth3.*t4.*t5.*t18.*(1.0./1.6e1),t3.*t7.*(dphi2.*t4.*t9+dth3.*t5.*t8).*(1.0./1.6e1),dth3.*(t8.*t9.*(1.0./1.6e1)-t8.*t9.*t17.*(1.0./1.6e1))+dphi2.*t4.*t5.*t26.*(1.0./1.6e1),0.0,0.0,dphi1.*t3.*t6.*(-3.0./4.0)-dth2.*t2.*t7.*(3.0./4.0),0.0,dphi1.*t2.*t3.*t13.*(-3.0./1.6e1)-dth2.*t6.*t7.*t12.*(3.0./1.6e1),t4.*t8.*t25.*(-1.0./1.6e1),dth2.*t2.*t3.*t19.*(3.0./1.6e1)+dphi1.*t3.^2.*t6.*t7.*(3.0./1.6e1),t5.*t9.*t25.*(1.0./1.6e1),0.0,0.0,dphi2.*t5.*t8.*(-1.0./4.0)-dth3.*t4.*t9.*(1.0./4.0),0.0,t2.*t6.*t22.*(-1.0./1.6e1),dphi2.*t4.*t5.*t18.*(-1.0./1.6e1)-dth3.*t8.*t9.*t17.*(1.0./1.6e1),t3.*t7.*t22.*(1.0./1.6e1),dth3.*t4.*t5.*t26.*(1.0./1.6e1)+dphi2.*t5.^2.*t8.*t9.*(1.0./1.6e1)],[8,8]);