function [DM]=print_dmpval(msfe,nmodel,nfore)
%%% compute pvals for DM statistic

dmpval = zeros(nmodel-2,nfore);

for imodel = 1:nmodel-2
    for ihor = 1:nfore
        [~,pval]= dmtest(msfe(1:end-ihor+1,ihor,imodel+2),msfe(1:end-ihor+1,ihor,imodel),ihor);   
        dmpval(imodel,ihor)=pval;
    end
end

ind = [1 2];
DM=round(dmpval(ind,1),3)';

