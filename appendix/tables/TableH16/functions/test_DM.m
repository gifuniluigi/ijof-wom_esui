function pvalue=test_DM(benchmark,alternative,H,nested_flag)

T=size(benchmark,1);

differential=benchmark-alternative;

var=NeweyWest(differential,H);

tdm=sqrt(T)*mean(differential)/sqrt(var);

if nested_flag == 0
    % Models are not nested, 2-sided test. Compute pvalue only if tdm>0,
    % otherwise if tdm<=0, set pvalue to 1
    if tdm > 0
        pvalue=2*tcdf(-abs(tdm),T);
    else
        pvalue = 1;
    end
else
    % Models are nested, 1-sided test
     pvalue=1-tcdf(tdm,T);
end
