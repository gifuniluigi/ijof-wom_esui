function print_dmpval(msfe,nmodel,nfore)
%%% compute pvals for DM statistic

dmpval = zeros(nmodel-3,nfore);

for imodel = 1:nmodel-3
    for ihor = 1:nfore
        [~,pval]= dmtest(msfe(1:end-ihor+1,ihor,imodel+3),msfe(1:end-ihor+1,ihor,imodel),ihor);
        dmpval(imodel,ihor)=pval;
    end
end

models = {'P-value_WTI';'P-value_RAC';'P-value_BRENT';};
horizons = {'Horizon1';'Horizon3';'Horizon6';'Horizon12';'Horizon24'};
ind = [1 2 3];
table(round(dmpval(ind,1),3),...
    round(dmpval(ind,3),3),...
    round(dmpval(ind,6),3),...
    round(dmpval(ind,12),3),...
    round(dmpval(ind,24),3),'RowNames',models,'VariableNames',horizons)

dmpval(round(dmpval(:,:),3)<=0.01)=3;
dmpval(round(dmpval(:,:),3)<=0.05)=2;
dmpval(round(dmpval(:,:),3)<=0.10)=1;
dmpval(round(dmpval(:,:),3)<1)=0;

models = {'DM-WTI';'DM-RAC';'DM-BRENT';};
horizons = {'Horizon1';'Horizon3';'Horizon6';'Horizon12';'Horizon24'};
ind = [1 2 3];
table(dmpval(ind,1),dmpval(ind,3),dmpval(ind,6),dmpval(ind,12),dmpval(ind,24),...
    'RowNames',models,'VariableNames',horizons)
