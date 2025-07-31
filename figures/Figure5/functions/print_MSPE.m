function [MSPE]=print_MSPE(msfe)

ind = [1 2 3];
int = [4 5 6];
 
MSPE=zeros(3,3);

MSPE(1,:)=round(squeeze(mean(msfe(1:end,1,ind)))./squeeze(mean(msfe(1:end,1,int))),3)';
MSPE(2,:)=round(squeeze(mean(msfe(1:end-2,3,ind)))./squeeze(mean(msfe(1:end-2,3,int))),3)';
MSPE(3,:)=round(squeeze(mean(msfe(1:end-5,6,ind)))./squeeze(mean(msfe(1:end-5,6,int))),3)';
 