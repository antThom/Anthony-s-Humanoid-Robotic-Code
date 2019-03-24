clear all; close all; clc;
%% Arm Dynanmics
syms x y z th1 th2 th3 phi1 phi2 real;
syms dx dy dz dth1 dth2 dth3 dphi1 dphi2 real;
syms l1 l2 l3 l4 l5 I1 I2 I3 I4 I5 m1 m2 m3 m4 m5 g real;
q = [x;y;z;th1;th2;th3;phi1;phi2];
dq = [dx;dy;dz;dth1;dth2;dth3;dphi1;dphi2];
qActuated = [th1;th2;th3;phi1;phi2];

%% Find Location of each end point
ER = [x + l1*sin(th1)/2,y + l1*cos(th1)/2,z]';
E = [x+(l1+l2)*sin(th1)/2,y+(l1+l2)*cos(th1)/2,z]';
FR = [x+(l1+l2)*sin(th1)/2 + l3*sin(th2)/2,y+(l1+l2)*cos(th1)/2 + l3*cos(th2)/2,z+l2*cos(phi1)*sin(th2)/2]';
WR = [x+(l1+l2)*sin(th1)/2 + (l3+l4)*sin(th2)/2,y+(l1+l2)*cos(th1)/2 + (l3+l4)*cos(th2)/2,z+l2*cos(phi1)*sin(th2)/2]';
T = [x+(l1+l2)*sin(th1)/2 + (l3+l4)*sin(th2)/2 + l5*sin(th3)/2,y+(l1+l2)*cos(th1)/2 + (l3+l4)*cos(th2)/2 + l5*cos(th3)/2,z+l2*cos(phi1)*sin(th2)/2 + l5*cos(phi2)*sin(th3)/2]';

P = [ER,E,FR,WR,T];

%% Find the Velocity of each end point
VER = jacobian(ER,q)*dq;
VE = jacobian(E,q)*dq;
VFR = jacobian(FR,q)*dq;
VWR = jacobian(WR,q)*dq;
VT = jacobian(T,q)*dq;

V = [VER,VE,VFR,VWR,VT];

%% Kinetic Energy
KE1 = 0.5*VER'*m1*VER;
KE2 = 0.5*VE'*m2*VE;
KE3 = 0.5*VFR'*m3*VFR;
KE4 = 0.5*VWR'*m4*VWR;
KE5 = 0.5*VT'*m5*VT;

KE = simplify(KE1 + KE2 + KE3 + KE4 + KE5);

%% Potential Energy
PE = [m1,m2,m3,m4,m5]*g*P'*[0;0;1];

%% Dynamics Matrices
mass = [1,1,1,1,1];
len = [0.5,0.5,0.5,0.5,0.5];
Inertia = [0.5,0.5,0.5,0.5,0.5];
gravity = 9.81;
KE = simplify(subs(KE,[m1,m2,m3,m4,m5,l1,l2,l3,l4,l5,I1,I2,I3,I4,I5],[mass,len,Inertia]));
PE = simplify(subs(PE,[m1,m2,m3,m4,m5,l1,l2,l3,l4,l5,I1,I2,I3,I4,I5,g],[mass,len,Inertia,gravity]));
% [D, C, G, B] = LagrangianDynamics(KE, PE, q, dq, qActuated);
% 
% matlabFunction(D, 'File', 'D_Mat_gen', 'Vars', {[q;dq]});
% matlabFunction(C, 'File', 'C_Mat_gen', 'Vars', {[q;dq]});
% matlabFunction(G, 'File', 'G_Mat_gen', 'Vars', {[q;dq]});
% matlabFunction(B, 'File', 'B_Mat_gen', 'Vars', {[q;dq]});
%% Simulate the Dynamics
tSpan = [0,5];
x0 = ones(16,1);

[T,Y]=ode45(@armD,tSpan,x0);

figure(1)
plot(T,Y(1));







%% User Function
function xDot = armD(t,y)
q=y(1:8);
dq=y(9:end);

D = D_Mat_gen([q;dq]);
C = C_Mat_gen([q;dq]);
G = G_Mat_gen([q;dq]);
B = B_Mat_gen([q;dq]);
ddq = inv(D)*(-G-C*dq);

xDot=[dq;ddq];
end

