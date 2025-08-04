function [MSPE]=print_MSPE(msfe)

ind = [1 2];
int = [3 4];
 
MSPE=zeros(1,2);

MSPE(1,:)=round(squeeze(mean(msfe(1:end,1,ind)))./squeeze(mean(msfe(1:end,1,int))),3)';

 