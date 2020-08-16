%%Obtenemos las matrices de controlabilidad y observabilidad
A=[0 1 0 0;0 -0.0014 0.1271 0;0 0 0 1;0 -0.0025 19.1713 0]; 
B=[0;1.777;0;3.4296]; 
C=[1 0 0 0;0 0 1 0 ]; 
D=[0;0];
Q=[400 0 0 0;0 0 0 0 ;0 0 100 0;0 0 0 0]; R=[1];
C=[1 0 0 0 ;0 0 1 0]; 

D=[0;0]; 
cc=ctrb(A,B) 
ccr=rank(cm) 
ob=obsv(A,C) 
obr=rank(om)
G
P

w = logspace(-2,3,100); 
sv = sigma(ss(A, B, C, D),w); 
sv = 20*log10(sv); semilogx(w, sv) 
title ('Singular Values ')
grid 
xlabel('Frequency (rad/sec)') 
ylabel('Amplitud (dB)')
[G,P,E]=lqr(A,B,Q,R);
