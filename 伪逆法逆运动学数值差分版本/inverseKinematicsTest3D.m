clc;
clear;
e=1e-7;
global H
H=10;
X=[65;5;5];

theta=ones(24,1);
theta=inverseKinematics3D(X,theta)
X=forwardKinematics3D(theta)
drawRobot(theta)
% theta=inverseKinematicsInitialPSO(X);
% drawRobot(theta)
% theta=inverseKinematicsPSO(X,theta);
% drawRobot(theta)