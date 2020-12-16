%% LQR controller for pitch control

% plant matrices
A= [-2.02 1 0; -6.9868 -2.9476 0; 0 1 0];
B=[0.16; 11.7304; 0];
C=[0 0 1];
D=0;

%transfer function of the system
sys=ss(A,B,C,D,'StateName',{'alpha' 'q' 'theta'}, 'InputName', {'delta_e'});
[b, a] = ss2tf(A,B,C,D);
tf_sys=tf(b,a);

% LQR parameters 
R=1;
Q=[100 0 0; 0 200 0; 0 0 500];

%Riccati equation,
[X,L,G] = care(A,B,Q);

%error in steady-state
Nbar=rscale(A,B,C,D,G);

%closed loop system
sys_cl = ss(A-B*G,B,C,D);
[bc, ac] = ss2tf(A-B*G,B,C,D);

%step response
opt = stepDataOptions('InputOffset',0,'StepAmplitude',0.2*Nbar);%Nbar can be written here instead of in the system

figure
step(sys_cl,opt,'r')
ylabel('pitch angle (rad)')
title('step response')
grid on

%check of robustness w.r.t. uncertanty in the plant 
gamma=ureal('gamma',11.7304,'range',[10 12]);
bc=[0, 0, gamma, 22.5775]; %numertor of the tf
ac=[1.0000  169.4599  597.4191  504.8487]; %denominator of the tf
tf_usys=tf(bc,ac);

figure
step(tf_usys,opt,'r')
grid on;


