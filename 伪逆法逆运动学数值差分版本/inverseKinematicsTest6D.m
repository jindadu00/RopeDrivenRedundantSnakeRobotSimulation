clc;
clear;
e=1e-7;
global H
H=10;

X=[100;0;0;0;0;0];

theta=ones(24,1);
theta=inverseKinematics6D(X,theta)
X=forwardKinematics6D(theta)
drawRobot(theta)
% drawWall(-50,50,50,-50,10,15,[10;20],5);
% drawWall(-50,50,50,-50,30,35,[35;30],5);
% drawWall(-50,50,50,-50,50,55,[20;20],5);
% cylinder3([10,20,30],[12,20,30],3,10,[0.1,0.9,0.8],0,0)
theta=inverseKinematicsInitialPSO(X);
drawRobot(theta)
% theta=inverseKinematicsPSO(X,theta);
% drawRobot(theta)