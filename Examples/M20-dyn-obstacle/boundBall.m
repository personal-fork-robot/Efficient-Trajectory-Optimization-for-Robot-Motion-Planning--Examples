function [c,r,wall,selfmap,wallmap,obs,obsmap] = boundBall()
c{1}=[0 0 0.1];r{1}=0.26;

c{2}=[-0.1,-0.07,-0.04];r{2}=0.26;

c{3}(1,:)=[-0.06,0,-0.17];r{3}(1)=0.16;
c{3}(2,:)=[-0.33,0,-0.15];r{3}(2)=0.16;
c{3}(3,:)=[-0.6,0,-0.15];r{3}(3)=0.16;

c{4}(1,:)=[-0.035,0.02,0.04];r{4}(1)=0.21;

c{5}(1,:)=[0,0.42,0];r{5}(1)=0.1;
c{5}(2,:)=[0,0.24,0];r{5}(2)=0.1;
% c{5}(3,:)=[0,0.06,0];r{5}(3)=0.12;

% c{5}(3,:)=[0,0.12,0];r{5}(3)=0.1;
% c{5}(4,:)=[0,0.03,0];r{5}(4)=0.1;

c{5}(3,:)=[0,0.03,0];r{5}(3)=0.1;

c{6}=[];r{6}=[];

c{7}=[];r{7}=[];

c{8}(1,:)=[0.026,-0.056,-0.056];r{8}(1)=0.07;
c{8}(2,:)=[0.026,-0.16,-0.056];r{8}(2)=0.07;
%% wall
wall.x=[-1,2];
% wall.y=[-0.5,1.5];
wall.y=[-0.5,1];
% wall.y=[-0.6,1.5];% relax
% wall.z=[0,2.5];
wall.z=[0,1.6];

wall.faces=[1 2 6 5;2 3 7 6;3 4 8 7;4 1 5 8];
wall.pnts=[wall.x(1),wall.y(1),wall.z(1);...
wall.x(1),wall.y(2),wall.z(1);...
wall.x(2),wall.y(2),wall.z(1);...
wall.x(2),wall.y(1),wall.z(1);...
wall.x(1),wall.y(1),wall.z(2);...
wall.x(1),wall.y(2),wall.z(2);...
wall.x(2),wall.y(2),wall.z(2);...
wall.x(2),wall.y(1),wall.z(2);...
];

%% construct selcollisionfmap
s=1;
%1-3
for i=1:size(r{3},2)
    selfmap(s).l=[1,1]; selfmap(s).r=[3,i];
    s=s+1;
end
%1-4
selfmap(s).l=[1,1]; selfmap(s).r=[4,1];
s=s+1;
%1-5
for i=1:size(r{5},2)
    selfmap(s).l=[1,1]; selfmap(s).r=[5,i];
    s=s+1;
end
%1-8
for i=1:size(r{8},2)
    selfmap(s).l=[1,1]; selfmap(s).r=[8,i];
    s=s+1;
end
%2-5
for i=1:size(r{2},2)
    for j=1:size(r{5},2)
        selfmap(s).l=[2,i]; selfmap(s).r=[5,j];
        s=s+1;
    end
end
%2-8
for i=1:size(r{2},2)
    for j=1:size(r{8},2)
        selfmap(s).l=[2,i]; selfmap(s).r=[8,j];
        s=s+1;
    end
end
%3-8
for i=1:size(r{3},2)
    for j=1:size(r{8},2)
        selfmap(s).l=[3,i]; selfmap(s).r=[8,j];
        s=s+1;
    end
end
%3-5
for i=1:size(r{3},2)
    for j=1:size(r{5},2)
        selfmap(s).l=[3,i]; selfmap(s).r=[5,j];
        s=s+1;
    end
end
%5-8
for i=1:size(r{5},2)
    for j=1:size(r{8},2)
        selfmap(s).l=[5,i]; selfmap(s).r=[8,j];
        s=s+1;
    end
end

%% construct wall collision map
s=1;
% 4-wall
for i=1:size(r{4},2)
    wallmap(s).ind=[4,i];
    s=s+1;
end
% 5-wall
for i=1:size(r{5},2)
    wallmap(s).ind=[5,i];
    s=s+1;
end
% 8-wall
for i=1:size(r{8},2)
    wallmap(s).ind=[8,i];
    s=s+1;
end

%% obstacle ball approximation (single ball in the example)
% obs.c=[0.25,0.75,0.36];
% obs.r=0.42;
obs.vertices=[0 0.5 0;0.5 0.5 0;0.5 1 0;0 1 0;0 0.5 0.6;0.5 0.5 0.6;0.5 1 0.6;0 1 0.6];
obs.faces=[1 2 3 4;5 6 7 8;1 2 6 5;2 3 7 6;3 4 8 7;4 1 5 8];

obs.c=[0.25,0.75,0.35;...
       0.06,0.56,0.54;...
       0.06,0.94,0.54;...
       0.44,0.94,0.54;...
       0.44,0.56,0.54;...
       ];
obs.r=[0.35,0.1,0.1,0.1,0.1];
% obs.vertices(:,2)=obs.vertices(:,2)+0.25;
% obs.c(2)=obs.c(2)+0.25;
% obs.vertices(5:8,3)=obs.vertices(5:8,3)+0.2;
% obs.c(3)=obs.c(3)+0.2;

%% construct obsmap
s=1;
% 3-obs
for i=1:size(r{3},2)
    for j=1:size(obs.r,2)
        obsmap(s).l=[3,i]; obsmap(s).r=j;
        s=s+1;
    end
end
% 4-obs
for i=1:size(r{4},2)
    for j=1:size(obs.r,2)
        obsmap(s).l=[4,i]; obsmap(s).r=j;
        s=s+1;
    end
end
% 5-obs
for i=1:size(r{5},2)
    for j=1:size(obs.r,2)
        obsmap(s).l=[5,i]; obsmap(s).r=j;
        s=s+1;
    end
end
% 8-obs
for i=1:size(r{8},2)
    for j=1:size(obs.r,2)
        obsmap(s).l=[8,i]; obsmap(s).r=j;
        s=s+1;
    end
end

end