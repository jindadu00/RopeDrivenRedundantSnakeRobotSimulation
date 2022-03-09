function output = inverseKinematicsPSO(X,theta)
%输入：目标位姿X，目前的关节角tempTheta，允许的误差error
%输出：解出来的关节角theta


% 设置种群参数
%   需要自行配置
sizepop = 10;                    % 初始种群个数
dim = 24;                          % 空间维数
ger = 25;                       % 最大迭代次数     
xlimit_max = (pi/3)*ones(dim,1);    % 设置位置参数限制(矩阵的形式可以多维)
xlimit_min = -(pi/3)*ones(dim,1);
vlimit_max = 0.8*ones(dim,1);       % 设置速度限制
vlimit_min = -0.8*ones(dim,1);
c_1 = 0.8;                        % 惯性权重
c_2 = 0.3;                        % 自我学习因子
c_3 = 0.3;                        % 群体学习因子 
cRatio=0.6;                       % 冷却系数∈[0,1)

%  生成初始种群
%  首先随机生成初始种群位置
%  然后随机生成初始种群速度
%  然后初始化个体历史最佳位置，以及个体历史最佳适应度
%  然后初始化群体历史最佳位置，以及群体历史最佳适应度
pop_x=ones(dim,sizepop);
pop_v=ones(dim,sizepop);

% 初始种群的位置
% 第一个位置为上一次位置，速度为零
pop_x(:,1) = theta;

for j=2:sizepop
    pop_x(:,j) = theta+(xlimit_max - xlimit_min)*(rand-0.5)/3;
end

for i=1:dim
    for j=2:sizepop
        pop_v(i,j) = vlimit_min(i)+(vlimit_max(i) - vlimit_min(i))*rand;  % 初始种群的速度
    end
end

for i=2:dim
    for j=1:sizepop
        if  pop_x(i,j) > xlimit_max(i)
            pop_x(i,j) = xlimit_max(i);
        end
        if  pop_x(i,j) < xlimit_min(i)
            pop_x(i,j) = xlimit_min(i);
        end
    end
end

gbest = pop_x;                                % 每个个体的历史最佳位置
fitness_gbest=zeros(sizepop);
for i = 1:sizepop
    q=inverseKinematics6D(X,pop_x(:,i));
    dq=q-theta;
    fitness_gbest(i) = norm(q)*(1+norm(dq)^0.01);
end                                           % 每个个体的历史最佳适应度
zbest = pop_x(:,1);                           % 种群的历史最佳位置
fitness_zbest = fitness_gbest(1);             % 种群的历史最佳适应度
for j=1:sizepop
    if fitness_gbest(j) < fitness_zbest       % 如果求最小值，则为<; 如果求最大值，则为>; 
        zbest = pop_x(:,j);
        fitness_zbest=fitness_gbest(j);
    end
end


% 粒子群迭代
%    更新速度并对速度进行边界处理    
%    更新位置并对位置进行边界处理
%    进行自适应变异
%    计算新种群各个个体位置的适应度
%    新适应度与个体历史最佳适应度做比较
%    个体历史最佳适应度与种群历史最佳适应度做比较
%    再次循环或结束

iter = 1;                        %迭代次数
while iter <= ger
%     iter
    fitness_pop=zeros(sizepop,1);
    for j=1:sizepop
        %    更新速度并对速度进行边界处理 
        pop_v(:,j)= c_1 * pop_v(:,j)*(1-cRatio*iter/ger) + c_2*rand*(gbest(:,j)-pop_x(:,j))*(1-cRatio+cRatio*iter/ger)+c_3*rand*(zbest-pop_x(:,j))*(1-cRatio+cRatio*iter/ger);% 速度更新
        for i=1:dim
            if  pop_v(i,j) > vlimit_max(i)*(1-cRatio*iter/ger)
                pop_v(i,j) = vlimit_max(i)*(1-cRatio*iter/ger);
            end
            if  pop_v(i,j) < vlimit_min(i)*(1-cRatio*iter/ger)
                pop_v(i,j) = vlimit_min(i)*(1-cRatio*iter/ger);
            end
        end
        
        %    更新位置并对位置进行边界处理
        pop_x(:,j) = pop_x(:,j) + pop_v(:,j);% 位置更新
        for i=1:dim
            if  pop_x(i,j) > xlimit_max(i)
                pop_x(i,j) = xlimit_max(i);
            end
            if  pop_x(i,j) < xlimit_min(i)
                pop_x(i,j) = xlimit_min(i);
            end
        end
        
%         %    进行自适应变异
%         if rand > 0.85
%             i=ceil(dim*rand);
%             pop_x(i,j)=xlimit_min(i) + (xlimit_max(i) - xlimit_min(i)) * rand;
%         end
  
        %    计算新种群各个个体位置的适应度
        q=inverseKinematics6D(X,pop_x(:,j));
        dq=q-theta;
        fitness_pop(j) = norm(q)*(1+norm(dq)^0.01);   % 当前个体的适应度，增加dq惩罚项

        
        %    新适应度与个体历史最佳适应度做比较
        if fitness_pop(j) < fitness_gbest(j)       % 如果求最小值，则为<; 如果求最大值，则为>; 
            gbest(:,j) = pop_x(:,j);               % 更新个体历史最佳位置            
            fitness_gbest(j) = fitness_pop(j);     % 更新个体历史最佳适应度
        end   
        
        %    个体历史最佳适应度与种群历史最佳适应度做比较
        if fitness_gbest(j) < fitness_zbest        % 如果求最小值，则为<; 如果求最大值，则为>; 
            zbest = gbest(:,j);                    % 更新群体历史最佳位置  
            fitness_zbest=fitness_gbest(j);        % 更新群体历史最佳适应度  
        end    
    end
    
%     fitness_zbest
    iter = iter+1;
end
output=inverseKinematics6D(X,zbest);
end

