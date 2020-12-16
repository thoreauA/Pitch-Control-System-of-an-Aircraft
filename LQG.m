%% LQG

% plant matrices
A= [-2.02 1 0; -6.9868 -2.9476 0; 0 1 0];
B=[0.16; 11.7304; 0];
C=[0 0 1];
D=[0];

%transfer function of the system
sys=ss(A,[B ones(3,1)],C,D,'StateName',{'alpha' 'q' 'theta'}, 'InputName', {'delta_e' 'w'});
%[b, a] = ss2tf(A,[B B],C,D);
%tf_sys=tf(b,a);


%Kalman State Estimator
Qn=0.00004; % sigma ^ 2 = (noise power) / (sample time), variance (standard deviation -> sqrt)
Rn=0.0001; % sigma ^ 2 = (noise power) / (sample time)
[kalmf,L,P] = kalman(sys,Qn,Rn);


% LQ-optimal
R=1;
Q=[100 0 0; 0 200 0; 0 0 500];

%Riccati equation,
[X,Lr,G] = care(A,B,Q); %G gain matrix of lq

%open and start the simulation (lqg.slx must be in the same folder of this
%script)
open('lqg.slx'); %open the file
sim('lqg.slx'); %start the simulation with the updated files



% variando Rn o Qn sottostimando la varianza i risultati peggiorano. Prova
% ad esempio con Rn=0.0000007.

% L=(P*C')Rn^(-1), dove P è data dalla Riccati equation. Se cambi Rn e Qn
% la P cambia sempre, la L non è detto (se Rn=Qn allora non cambia, per 
% come è stato scritto il sistema). 





