clc
clear all

A=[1 3 1 0 0; 3 2 0 1 0; 0 2 0 0 1]; 
B=[6; 6;6];
C=[2 3 0 0 0];

n = size(A,2);
m = size(A,1);

if (n>m)
    nCm = nchoosek(n,m);
    pairs = nchoosek(1:n,m);
    sol = [];
    for i=1:nCm
        y = zeros(n,1);
        x = A(:,pairs(i,:))\B;
        if all(x>=0 & x~=inf & x~=-inf)
             y(pairs(i,:))=x;
             sol=[sol, y];
         end
    end
else
    error('nCm does not exists!')
end
Z=C*sol;
[Zmax, Zindex]=max(Z);
bfs=sol(:,Zindex);
optimal_value=[bfs' Zmax];
optimal_bfs=array2table(optimal_value)
optimal_bfs.Properties.VariableNames={'x1','x2','s1','s2','s3','Z'};
