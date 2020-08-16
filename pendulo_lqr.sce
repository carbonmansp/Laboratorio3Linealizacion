// Form the state space model (pendulo)
A = [0     1    0    0
0  -0.0014  0.1271  0
0     0    0    1
0  -0.0025  19.1713  0];
B = [0; 1.7777; 0; 3.4296];
C = [1 0 0 0  //dy1
0 0 1 0];//dy2
D=[0;0];
//inputs u and e; outputs dy1 and dy2
P = syslin("c",A, B, C, D);
Q=[800 0 0 0;0 0 0 0;0 0 200 0;0 0 0 0] //Weights on states
R=1; //Weight on input
// Discretize it
dt=0.5;
Pd=dscr(P, dt);

// The noise variances
Q_e=1; //additive input noise variance
R_vv=0.0001*eye(2,2); //measurement noise variance
Q_ww=Pd.B*Q_e*Pd.B'; //input noise adds to regular input u
Qwv=sysdiag(Q_ww,R_vv);
//The compensator weights
Q_xx=diag([0.1 0 5 0]); //Weights on states
R_uu   = 0.3; //Weight on input
Qxu=sysdiag(Q_xx,R_uu);

//----syntax [K,X]=lqg(P,Qxu,Qwv)---
J=lqg(Pd,Qxu,Qwv);

//----syntax [K,X]=lqg(P_aug,r)---
// Form standard LQG model
[Paug,r]=lqg2stan(Pd,Qxu,Qwv); // Form standard LQG model
J1=lqg(Paug,r);


//  Form the closed loop
Sys=Pd/.(-J);
// Compare real and Estimated states for initial state evolution
t = 0:dt:30;
// Simulate system evolution for initial state [1;0;0;0;
y = flts(zeros(t),Sys,eye(8,1));
clf;
plot2d(t',y')
e=gce();e.children.polyline_style=2;
L=legend(["$dy_1$","$dy_2$"]);L.font_size=4;
xlabel('Time (s)')
