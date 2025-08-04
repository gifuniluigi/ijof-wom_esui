function [DM] = print_dmpval(msfe,nmodel,nfore)

%%% compute pvals for DM statistic
dmpval = zeros(nmodel-2,nfore);

for imodel = 1:nmodel-2
    for ihor = 1:nfore
        [~,pval]= dmtest(msfe(1:end-ihor+1,ihor,imodel+2),msfe(1:end-ihor+1,ihor,imodel),ihor);
        dmpval(imodel,ihor)=pval;
    end
end

ind = [1 2];
dmpval_round = [round(dmpval(ind,1),3)' ...
                round(dmpval(ind,3),3)' ...
                round(dmpval(ind,6),3)' ...
                round(dmpval(ind,12),3)' ...
                round(dmpval(ind,24),3)'];

dmpval_round(round(dmpval_round(:,:),3)<=0.01)=3;
dmpval_round(round(dmpval_round(:,:),3)<=0.05)=2;
dmpval_round(round(dmpval_round(:,:),3)<=0.10)=1;
dmpval_round(round(dmpval_round(:,:),3)<1)=0;

DM = dmpval_round;
