function [] = testCol(theta,bias)
    global H
    global robotRadius
    robotRadius=2;
    H=10;

    wallsInfo(1).left=-50;
    wallsInfo(1).right=50;
    wallsInfo(1).top=50;
    wallsInfo(1).bottom=-50;
    wallsInfo(1).front=10;
    wallsInfo(1).back=12;
    wallsInfo(1).center=[0;0];
    wallsInfo(1).radius=5;

    wallsInfo(2).left=-50;
    wallsInfo(2).right=50;
    wallsInfo(2).top=50;
    wallsInfo(2).bottom=-50;
    wallsInfo(2).front=30;
    wallsInfo(2).back=32;
    wallsInfo(2).center=[0;0];
    wallsInfo(2).radius=5;

    wallsInfo(3).left=-50;
    wallsInfo(3).right=50;
    wallsInfo(3).top=50;
    wallsInfo(3).bottom=-50;
    wallsInfo(3).front=50;
    wallsInfo(3).back=52;
    wallsInfo(3).center=[0;0];
    wallsInfo(3).radius=5;

    for i = 1:length(wallsInfo)
        drawWall(wallsInfo(i).left,...
            wallsInfo(i).right,...
            wallsInfo(i).top,...
            wallsInfo(i).bottom,...
            wallsInfo(i).front,...
            wallsInfo(i).back,...
            wallsInfo(i).center,...
            wallsInfo(i).radius);
    end
    bias=0;
    theta=ones(24,1)*0.02;
    drawRobot(theta,bias)
end

