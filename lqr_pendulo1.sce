// Form the state space model (assume full state output)
A = [0 1 0 0;0 -0.0014 0.1271 0;0 0 0 1;0 -0.025 19.1713 0];
B = [0;1.7777;0;3.4296];
C = [1 0 0 0  //dy1
     0 0 1 0];//dy2
D=[0;0];
//inputs u and e; outputs dy1 and dy2
P = syslin("c",A, B, C, D);
//The compensator weights
Q=[800 0 0 0;0 0 0 0;0 0 200 0;0 0 0 0] //Weights on states
R=1; //Weight on input
K=lqr(P,Q,R);
dt=0.1;
Pd=dscr(P, dt);
Pda=Pd.a
Pdb=Pd.b
Pdc=Pd.c
Pdd=Pd.d
//  Set the noise covariance matrices
Q_e=0.1; //additive input noise variance
R_vv=0.01*eye(2,2); //measurement noise variance
Q_ww=Pd.B*Q_e*Pd.B'; //input noise adds to regular input u
//----syntax [K,X]=lqe(P,Qww,Rvv [,Swv])---
H=lqe(Pd,Q_ww,R_vv); //observer gain
Qcom=sysdiag(Q,R);
Qobs=sysdiag(Q_ww,R_vv);
J=lqg(Pd,Qcom,Qobs);
Ja=J.a
Jb=J.b
Jc=J.c
Jd=J.d
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
