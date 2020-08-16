//clear 
//clc 
// MATRIZ DE ESTADOS 
A=[0 1 0 0;0 -0.0014 0.1271 0;0 0 0 1;0 -0.0025 19.1713 0]; B=[0;1.777;0;3.4296]; C=[1 0 0 0;0 0 1 0 ]; D=[0;0];
sys = syslin("c",A, B, C);
Ap=sys.A; Bp=sys.B; Cp=sys.C; Dp=sys.D;

[ns,nc]=size(Bp); 

Ain=[Ap Bp; 0*ones(nc,ns) 0*ones(nc,nc)];
Bin=[0*ones(ns,nc); eye(nc)];
Cin=[Cp 0*ones(2,1)];
Din=0*ones(2,nc);

C=Cin'*Cin    
C=diag([400 0 100 0 0]) 
rho=1; 
R = rho*eye(nc);
//now we calculate B 
B=Bin*inv(R)*Bin';
A=Ain; 
X=riccati(A,B,C,'c','eigen');   //the value of the gain G 
G=inv(R)*Bin'*X; //<--this value is important mtfk;
