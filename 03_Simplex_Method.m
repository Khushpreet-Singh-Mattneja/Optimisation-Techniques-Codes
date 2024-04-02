clc
clear all
 
A=[1 4;3 1; 1 1];
B=[24;21;9];
C=[2 5];
 
s = eye(size(A,1));
a = [A s B];
cost= zeros(1,size(a,2));
variables = 2;
 
cost(1:variables) = C;
 
basic = variables+1:1:(size(a,2)-1);
zjcj = cost(basic)*a-cost;
simplex = [zjcj;a];
arr=array2table(simplex);
arr.Properties.VariableNames = {'x1','x2','s1','s2','s3','z'}
 
if(zjcj<=0)
    fprintf('Not optimum');
    enter = find(min(zjcj))+1;
    ratio =  min(simplex(2:size(a,1)+1,size(a,2))./simplex(2:size(a,1)+1,enter));
    if(ratio<0)
        printf('LPP has Unbounded Solution');
    else
        pivot = simplex(find(ratio)+1,enter);
        for i = 1:size(simplex,1)-1
            for j = 1:size(simplex,2)-1
                if (j~=enter && i~=find(ratio)+1)
                    simplex(i,j) = simplex(i,j)*pivot-simplex(i+1,j)*simplex(i,j+1)
                elseif(i== find(ratio)+1)
                    simplex(i) = simplex(i)/pivot;
                end
 
 
            end
        end
 
    end
 
 
 
 
end
