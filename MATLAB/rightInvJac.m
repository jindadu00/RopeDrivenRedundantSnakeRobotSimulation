function [output] = rightInvJac(theta,flag)
%输入：六个关节的theta
%输出：末端(x,y,z)关于(thetai)的雅可比
InvMat=Jacob(theta,flag);
output=InvMat'/(InvMat*InvMat');
end

