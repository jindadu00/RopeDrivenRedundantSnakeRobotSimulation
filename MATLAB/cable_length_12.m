clear,clc

N = 12; %臂体数量
N_static = 0; %不动臂体数量
t_back = 5; %回到原点的时刻
t_span = 10; %时间历程
t_step = t_span/100;
angle = 10; %关节角度幅值
T_bar = 100; %拉力控制
E = 2.6e10;
A = 2.25e-6;
epson = T_bar/(E*A);

t = 0:t_span/99:t_span; 

L_link = 0.1; %臂体长度
L_joint = 0.01; %关节长度
radius = 0.016; %绳孔圆半径

rho = [0; L_link/2 + L_joint; 0]; %臂体质心连体矢径
rho_total = [0; L_link + 2*L_joint; 0]; %臂体段连体矢径
%%
for i = 1:N
    
    if i <= N_static
        body(i).theta_1 = t * 0;
        body(i).theta_2 = t * 0;
    else
        body(i).theta_1 = sin(t/t_back*pi) * angle /180 * pi;
        body(i).theta_2 = t * 0;
    end
    
    for j = 1:3
        body(i).hole_theta(j) = 10 * (i-1) + 120 * (j-1);
        body(i).hole_x(j) = cos(body(i).hole_theta(j) / 180 * pi) * radius;
        body(i).hole_y(j) = sin(body(i).hole_theta(j) / 180 * pi) * radius;
        
        body(i).root(:,j) = [body(i).hole_x(j), 0, body(i).hole_y(j)];
        
        body(i).rho_pre(:,j) = [body(i).hole_x(j), -L_link/2, body(i).hole_y(j)];
        body(i).rho_nex(:,j) = [body(i).hole_x(j), L_link/2, body(i).hole_y(j)];
        
    end
   
end
    
x_b = zeros(100,N);
y_b = zeros(100,N);
z_b = zeros(100,N);
%%
for i = 1:length(t)
    
    for j = 1:N
        
        th_1 = body(j).theta_1(i);
        th_2 = body(j).theta_2(i);
        body(j).A_pre = [cos(th_2), 0, sin(th_2);
            sin(th_1) * sin(th_2), cos(th_1), -sin(th_1) * cos(th_2);
            -cos(th_1) * sin(th_2), sin(th_1), cos(th_1) * cos(th_2)];
        
        if j == 1
            body(j).A = body(j).A_pre;
            body(j).r = body(j).A * rho;
        else
            body(j).A = body(j-1).A * body(j).A_pre;
            body(j).r = body(j-1).r + body(j-1).A * rho + body(j).A * rho;
        end
        
        x_b(i,j) = body(j).r(1);
        y_b(i,j) = body(j).r(2);
        z_b(i,j) = body(j).r(3);
    end
    
    for j = 1:N
        for k = 1:3
            
            L_0 = 0;
            if j == 1
                L_0 = L_0 + sqrt(sum(((body(1).r + body(1).A * body(j).rho_pre(:,k)) - body(j).root(:,k)).^2)); 
            else
                L_0 = L_0 + sqrt(sum(((body(1).r + body(1).A * body(j).rho_pre(:,k)) - body(j).root(:,k)).^2)); 
                for m = 2:j
                    L_0 = L_0 + sqrt(sum(((body(m-1).r + body(m-1).A * body(j).rho_nex(:,k)) - (body(m).r + body(m).A * body(j).rho_pre(:,k))).^2));
                    % 错误在这行
                end
            end
            body(j).cable_length(i,k) = L_0 + (j-1) * L_link ;
            
        end
    end
    
    
    
end

for j = 1:N
        for k = 1:3
            body(j).cable_length(:,k) = (1 - epson) * body(j).cable_length(:,k);
            body(j).cable_length(:,k) = body(j).cable_length(1,k) - body(j).cable_length(:,k);
        end
end

%%
for i = 1:N
    subplot(3,4,i)
    plot(body(i).cable_length,'linewidth',2)
        xlabel('time/s'); ylabel('length/m')
        name = ['cable group',num2str(i)];
        title(name)
end

%%
data = zeros(36,100);
for i = 1 : N
    data((i-1)*3+1:(i-1)*3+3,:) = body(i).cable_length.';
end
save('C:\Users\DELL\Desktop\3-12\3-12\data.txt','data','-ascii');

figure()
for n=1:length(t)
    
    hold off
    plot3(x_b(n,:),y_b(n,:), z_b(n,:),'-o');hold on
    
    axis([-0.4 0.4 -0.1 1.5 -0.6 0.6]);
    
    xlabel('X轴'); ylabel('Y轴'); zlabel('Z轴');
    title(['time=',num2str(t_step*n),'s']);
    box on;
    view(230,35);
    grid minor;
    
    frame=getframe(gcf);
    imind=frame2im(frame);
    [imind,cm] = rgb2ind(imind,256);
end



