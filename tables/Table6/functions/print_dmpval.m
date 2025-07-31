function print_dmpval(msfe,nmodel,nfore)
%%% compute pvals for DM statistic

dmpval = zeros(nmodel-3,nfore);

for imodel = 1:nmodel-3
    for ihor = 1:nfore
        [~,pval]= dmtest(msfe(1:end-ihor+1,ihor,imodel+3),msfe(1:end-ihor+1,ihor,imodel),ihor);   
        dmpval(imodel,ihor)=pval;
    end
end

models = {'VAR-WTI';'VAR-RAC';'VAR-BRENT';};
horizons = {'Horizon1';'Horizon3';'Horizon6';'Horizon9';'Horizon12';'Horizon18';'Horizon24'};
ind = [1 2 3];
table(round(dmpval(ind,1),3),...
    round(dmpval(ind,3),3),...
    round(dmpval(ind,6),3),...
    round(dmpval(ind,9),3),...
    round(dmpval(ind,12),3),...
    round(dmpval(ind,18),3),...
    round(dmpval(ind,24),3),'RowNames',models,'VariableNames',horizons)

