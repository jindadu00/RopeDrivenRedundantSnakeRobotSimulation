function output = forwardKinematics6D(theta)
global H

T1 =[cos(theta(1)), -sin(theta(1)), 0, 0;
sin(theta(1)),  cos(theta(1)), 0, 0;
          0,            0, 1, 0;
          0,            0, 0, 1];
 
 
T2 =[ cos(theta(2)), -sin(theta(2)), 0, 0;
           0,            0, 1, 0;
-sin(theta(2)), -cos(theta(2)), 0, 0;
           0,            0, 0, 1];
 
 
T3 =[cos(theta(3)), -sin(theta(3)),  0, H;
          0,            0, -1, 0;
sin(theta(3)),  cos(theta(3)),  0, 0;
          0,            0,  0, 1];
 
 
T4 =[ cos(theta(4)), -sin(theta(4)), 0, 0;
           0,            0, 1, 0;
-sin(theta(4)), -cos(theta(4)), 0, 0;
           0,            0, 0, 1];
 
 
T5 =[cos(theta(5)), -sin(theta(5)),  0, H;
          0,            0, -1, 0;
sin(theta(5)),  cos(theta(5)),  0, 0;
          0,            0,  0, 1];
 
 
T6 =[ cos(theta(6)), -sin(theta(6)), 0, 0;
           0,            0, 1, 0;
-sin(theta(6)), -cos(theta(6)), 0, 0;
           0,            0, 0, 1];
 
 
T7 =[cos(theta(7)), -sin(theta(7)),  0, H;
          0,            0, -1, 0;
sin(theta(7)),  cos(theta(7)),  0, 0;
          0,            0,  0, 1];
 
 
T8 =[ cos(theta(8)), -sin(theta(8)), 0, 0;
           0,            0, 1, 0;
-sin(theta(8)), -cos(theta(8)), 0, 0;
           0,            0, 0, 1];
 
 
T9 =[cos(theta(9)), -sin(theta(9)),  0, H;
          0,            0, -1, 0;
sin(theta(9)),  cos(theta(9)),  0, 0;
          0,            0,  0, 1];
 
 
T10 =[ cos(theta(10)), -sin(theta(10)), 0, 0;
            0,             0, 1, 0;
-sin(theta(10)), -cos(theta(10)), 0, 0;
            0,             0, 0, 1];
 
 
T11 =[cos(theta(11)), -sin(theta(11)),  0, H;
           0,             0, -1, 0;
sin(theta(11)),  cos(theta(11)),  0, 0;
           0,             0,  0, 1];
 
 
T12 =[ cos(theta(12)), -sin(theta(12)), 0, 0;
            0,             0, 1, 0;
-sin(theta(12)), -cos(theta(12)), 0, 0;
            0,             0, 0, 1];

        
 
 
T13 =[cos(theta(13)), -sin(theta(13)),  0, H;
          0,            0, -1, 0;
sin(theta(13)),  cos(theta(13)),  0, 0;
          0,            0,  0, 1];
 
 
T14 =[ cos(theta(14)), -sin(theta(14)), 0, 0;
           0,            0, 1, 0;
-sin(theta(14)), -cos(theta(14)), 0, 0;
           0,            0, 0, 1];
 
 
T15 =[cos(theta(15)), -sin(theta(15)),  0, H;
          0,            0, -1, 0;
sin(theta(15)),  cos(theta(15)),  0, 0;
          0,            0,  0, 1];
 
 
T16 =[ cos(theta(16)), -sin(theta(16)), 0, 0;
           0,            0, 1, 0;
-sin(theta(16)), -cos(theta(16)), 0, 0;
           0,            0, 0, 1];
 
 
T17 =[cos(theta(17)), -sin(theta(17)),  0, H;
          0,            0, -1, 0;
sin(theta(17)),  cos(theta(17)),  0, 0;
          0,            0,  0, 1];
 
 
T18 =[ cos(theta(18)), -sin(theta(18)), 0, 0;
           0,            0, 1, 0;
-sin(theta(18)), -cos(theta(18)), 0, 0;
           0,            0, 0, 1];
 
 
T19 =[cos(theta(19)), -sin(theta(19)),  0, H;
          0,            0, -1, 0;
sin(theta(19)),  cos(theta(19)),  0, 0;
          0,            0,  0, 1];
 
 
T20 =[ cos(theta(20)), -sin(theta(20)), 0, 0;
            0,             0, 1, 0;
-sin(theta(20)), -cos(theta(20)), 0, 0;
            0,             0, 0, 1];
 
 
T21 =[cos(theta(21)), -sin(theta(21)),  0, H;
           0,             0, -1, 0;
sin(theta(21)),  cos(theta(21)),  0, 0;
           0,             0,  0, 1];
 
 
T22 =[ cos(theta(22)), -sin(theta(22)), 0, 0;
            0,             0, 1, 0;
-sin(theta(22)), -cos(theta(22)), 0, 0;
            0,             0, 0, 1];
              

T23 =[cos(theta(23)), -sin(theta(23)),  0, H;
           0,             0, -1, 0;
sin(theta(23)),  cos(theta(23)),  0, 0;
           0,             0,  0, 1];
 
 
T24 =[ cos(theta(24)), -sin(theta(24)), 0, 0;
            0,             0, 1, 0;
-sin(theta(24)), -cos(theta(24)), 0, 0;
            0,             0, 0, 1];     


T2=T1*T2;
T3=T2*T3;
T4=T3*T4;
T5=T4*T5;
T6=T5*T6;
T7=T6*T7;
T8=T7*T8;
T9=T8*T9;
T10=T9*T10;
T11=T10*T11;
T12=T11*T12;
T13=T12*T13;
T14=T13*T14;
T15=T14*T15;
T16=T15*T16;
T17=T16*T17;
T18=T17*T18;
T19=T18*T19;
T20=T19*T20;
T21=T20*T21;
T22=T21*T22;
T23=T22*T23;
T24=T23*T24;

P0=T24*[H;0;0;1];
% T24(1:3,1:3)
[yaw,pitch,roll] = dcm2angle(T24(1:3,1:3));
output=[P0(1:3);yaw;pitch;roll];
end

