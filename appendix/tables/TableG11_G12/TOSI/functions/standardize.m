function [y]=standardize(x)

y=0*x;
m=mean(x);
s=std(x);
[r,c] = size(x);

for i = 1:c
    for j = 1:r
        y(j,i) = (x(j,i) - m(1,i))./(s(1,i));
    end
end