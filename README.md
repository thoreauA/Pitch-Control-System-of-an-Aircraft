# Pitch-Control-System-of-an-Aircraft

This project is meant to find an optimal controller for a pitch control system.
A solution using a Linear Quadratic Controller (LQR) is proposed, analyzing its
performance with respect to a desired pitch angle. The result is compared with a
PI controller. 
Considering the presence of disturbances and noises (measurements noise), it has 
been introduced and defined a Kalman filter estimator and a Linear Quadratic 
Gaussian (LQG) controller has been used. 
Since the aircraft pitch is determined by the longitudinal dynamics it has been 
taken into consideration just the three equationts describing the longitudinal 
dynamics, decoupling them from the other equations (in general six equations are 
necessary to describe the aircraft dynamics). These equations are nonlinear, 
linearization and using the small disturbance theory a state space system has been 
found.
The simulations of these systems are implemented in Matlab and Simulink.


