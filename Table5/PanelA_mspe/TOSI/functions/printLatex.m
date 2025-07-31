function printLatex(T)

Tarr=table2array(T);
WTI=cat(2,num2str(Tarr(1,1)),' \\ ',num2str(Tarr(1,2)),' \\ ',num2str(Tarr(1,3)),' \\ ',num2str(Tarr(1,4)),' \\ ',num2str(Tarr(1,5)))
BRENT=cat(2,num2str(Tarr(3,1)),' \\ ',num2str(Tarr(3,2)),' \\ ',num2str(Tarr(3,3)),' \\ ',num2str(Tarr(3,4)),' \\ ',num2str(Tarr(3,5)))
end