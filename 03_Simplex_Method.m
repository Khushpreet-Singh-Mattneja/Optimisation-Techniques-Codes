clc
clear all

% Phase-1: Input Matrix Parameters 

A=[1 4;3 1; 1 1];
B=[24;21;9];
C=[2 5];
 
%Phase-2: Input Slack Matrix and Cost Matrix 

s = eye(size(A,1));
a = [A s B];
cost = zeros(1,size(a,2));
variables = 2;
cost(1:variables) = C;

%Phase3: Creating Simplex Table 

basic = variables+1:1:(size(a,2)-1);
zjcj = cost(basic)*a-cost;
simplex = [zjcj;a];
arr = array2table(simplex);
arr.Properties.VariableNames = {'x1','x2','s1','s2','s3','z'}
row = size(simplex,1);
col = size(simplex,2);

% Phase4: Solving for the Optimal Table 

while any(simplex(1,:)<0)
    fprintf('Not optimum\n');

    enter = find(simplex(1,:) == min(simplex(1,:)));
    ratio = simplex(2:row,col)./simplex(2:row,enter);

    if min(ratio) < 0
        fprintf('LPP has Unbounded Solution\n');
        break;
    else
        leave = find(ratio == min(ratio))+1;
        pivot = simplex(leave,enter);
        for i = 1:row
            for j = 1:col
                if (j~=enter && i~=leave)
                    simplex(i,j) = simplex(i,j)- (simplex(i,enter)*simplex(leave,j))/pivot;
                end

            end
        end
        simplex(leave,:) = simplex(leave,:)/pivot;
        simplex(:,enter) = 0;
        simplex(leave,enter) = 1;
    end
end
