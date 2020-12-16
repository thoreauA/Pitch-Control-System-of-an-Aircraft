%% PID controller aereo

% plant matrices
A= [-2.02 1 0; -6.9868 -2.9476 0; 0 1 0];
B=[0.16; 11.7304; 0];
C=[0 0 1];
D=0;

%transfer function of the system
sys=ss(A,B,C,D,'StateName',{'alpha' 'q' 'theta'}, 'InputName', {'delta_e'});
[b, a] = ss2tf(A,B,C,D);
tf_sys=tf(b,a)

%tuning of the PI controller
[C_pi,info] = pidtune(sys,'PI')

%closed loop system
T_pi = feedback(C_pi*tf_sys, 1);

%step response
opt = stepDataOptions('InputOffset',0,'StepAmplitude',0.2);

figure
step(T_pi,opt,'b')
grid on;

% different values of PI, robuster
C_pi.Kp=0.5;
C_pi.Ki=0.028734;
%new closed loop system
T_pi = feedback(C_pi*tf_sys, 1);

%step response
opt = stepDataOptions('InputOffset',0,'StepAmplitude',0.2);

figure
step(T_pi,opt,'b')
grid on;

%check of robustness w.r.t. uncertanty in the plant 
gamma=ureal('gamma',11.73,'range',[10 12]);
b=[0, 0, gamma, 22.5775];
a=[1.0000, 4.9676, 12.9410, 0];
tf_usys=tf(b,a);
T_upi=feedback(C_pi*tf_usys,1);

figure
step(T_upi,opt,'r')
grid on;
