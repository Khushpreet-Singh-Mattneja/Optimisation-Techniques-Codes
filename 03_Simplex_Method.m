clc
clear all
 
A=[1 4;3 1; 1 1];
B=[24;21;9];
C=[-3 -6];
s = eye(size(A,1));
a = [A s B];
cost= zeros(1,size(a,2));
variables = 2;
 
cost(1:variables) = C;
 
basic = variables+1:1:size(a,2)-1;
zjcj = cost(basic)*a-cost;
simplex = [zjcj;a];
arr2tab=array2table(simplex);
arr2tab.Properties.VariableNames = {'x1','x2','s1','s2','s3','z'}
 
if(zjcj>=0)
    fprintf('optimum');
else
    fprintf('Not optimum');
end