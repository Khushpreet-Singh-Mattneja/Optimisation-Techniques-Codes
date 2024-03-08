clc 
clear all

% Phase1:To input the parameters:

A = [1 2;1 1;1 -1;1 -2];
B = [10;6;2;1];
C = [2 1];

% Phase 2:Plot lines on the graph

x = 0:1:max(B);
y = zeros(size(A, 1),length(x));
figure;
hold on;

for i = 1:size(A, 1)
    y(i,:) = max(0,(B(i)-A(i,1).*x)./A(i,2));
    plot(x,y(i);
end
xlabel('Value of X');
ylabel('Value of Y');

% Phase 3: Find corner point with axes, that is line intercept

intercept_pts = [];

for i = 1:size(A, 1)
    pos_x = find(x == 0);
    pos_y = find(y_values(i,:) == 0);
    l = [x([pos_x,pos_y]); y_values([pos_x,pos_y])]';
    intercept_pts = [intercept_pts; l];
end
 
% Phase 4: Finding intersection of lines with each other

intersection_pts = [];

for i=1:size(A,1)
    A1=A(i,:);
    B1=B(i);
    for j=i+1:size(A,1)
        A2=A(j,:);
        B2=B(j);
        A3=[A1; A2];
        B3=[B1; B2];
        X=A3\B3;
        intersection_pts=[intersection_pts; X'];
    end
end

% Phase5: Write all critical points

critical_pts = [intercept_pts;intersection_pts];
critical_pts = unique(critical_pts,'rows');

% % Phase 6: Feasible region points

for i = 1:size(A,1)
    b1 = critical_pts(:, 1); %x1
    b2 = critical_pts(:, 2); %x2

    constraint = round(A(i, 1).*b1 + A(i, 2).*b2-B(i));
    % if(i==1 ||i==2)
    %     s = find(constraint < 0);
    % else
        s = find(constraint > 0);
    critical_pts(s, :) = [];
end

% Phase 7: Objective function value

for i=1:size(critical_pts,1)
    fn(i)=(sum(critical_pts(i,:).*C));
end
optim=max(fn);

