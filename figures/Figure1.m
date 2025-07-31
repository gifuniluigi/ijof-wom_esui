%CSFE txt-sentiment VS benchmark SV-BVAR

clear;clc;
addpath('Results')

load SVBVAR_Sentiment_msfe

date = {'01-Jan-2001','30-Jun-2021'};
date = datemnth(date{1}, (0: months(date{:}))');
date = datetime(date,'ConvertFrom','datenum');
Ft = 80;
Ftt = 70;
Ysize = 50;
S = 10^5;
S1 = 10^6;
S2 = 10^6.5;
S3 = 10^7;
lw = 10;
h1 = [date(1,1) date(82,1) date(164,1) date(246,1)];
h3 = [date(3,1) date(84,1) date(165,1) date(246,1)];
h6 = [date(6,1) date(86,1) date(166,1) date(246,1)];
h12 = [date(12,1) date(90,1) date(168,1) date(246,1)];
h24 = [date(24,1) date(98,1) date(172,1) date(246,1)];
wti_col = 'b';
brent_col = [0.6 0 0];
rac_col = 'g';

% Figures saved individually, do not run all sections in one go.
% For example run from line 33 to 43 to get plot (1,1) of Figure 1. Always
% skip the line starting with "subplot(x,y,z)"
f = figure(1);
%%%%%%%%%%%%%%%%%% Sentiment count %%%%%%%%%%%%%%%%%%
subplot(10,5,1)
plot(date,cumsum(-SentCoSVBVAR(1:end,1,1)+BenchSVBVAR(1:end,1,1))/S,'Color', wti_col, 'linewidth',lw)
hold on;
plot(date,cumsum(-SentCoSVBVAR(1:end,1,3)+BenchSVBVAR(1:end,1,3))/S,'Color', brent_col, 'linewidth',lw)
plot(date,zeros(size(date,1),1),'k--','linewidth',2)
grid minor
%ylim([-0.5 3])
set(gca,'xtick',h1,'FontSize',Ysize);
set(gca,'YTick',-1:1:3)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'Sentiment';'count'},'FontSize',Ftt)
title('h = 1','FontWeight','bold','FontSize',Ft)

subplot(10,5,2)
plot(date(3:end,:),cumsum(-SentCoSVBVAR(1:end-2,3,1)+BenchSVBVAR(1:end-2,3,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(3:end,:),cumsum(-SentCoSVBVAR(1:end-2,3,3)+BenchSVBVAR(1:end-2,3,3))/S1,'Color', brent_col,'linewidth',lw)
plot(date(3:end,:),zeros(size(date,1)-2,1),'k--','linewidth',2)
grid minor
%ylim([-0.5 1.5])
set(gca,'xtick',h3,'FontSize',Ysize);
set(gca,'YTick',-2:1:1)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 3','FontWeight','bold','FontSize',Ft)

subplot(10,5,3)
plot(date(6:end,:),cumsum(-SentCoSVBVAR(1:end-5,6,1)+BenchSVBVAR(1:end-5,6,1))/S2,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(6:end,:),cumsum(-SentCoSVBVAR(1:end-5,6,3)+BenchSVBVAR(1:end-5,6,3))/S2,'Color', brent_col,'linewidth',lw)
plot(date(6:end,:),zeros(size(date,1)-5,1),'k--','linewidth',2)
grid minor
%ylim([-1 1.5])
set(gca,'xtick',h6,'FontSize',Ysize);
set(gca,'YTick',-2:1:0)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 6','FontWeight','bold','FontSize',Ft)

subplot(10,5,4)
plot(date(12:end,:),cumsum(-SentCoSVBVAR(1:end-11,12,1)+BenchSVBVAR(1:end-11,12,1))/S2,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(12:end,:),cumsum(-SentCoSVBVAR(1:end-11,12,3)+BenchSVBVAR(1:end-11,12,3))/S2,'Color', brent_col,'linewidth',lw)
plot(date(12:end,:),zeros(size(date,1)-11,1),'k--','linewidth',2)
grid minor
%ylim([-2 2])
set(gca,'xtick',h12,'FontSize',Ysize);
set(gca,'YTick',-3:1:0)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 12','FontWeight','bold','FontSize',Ft)

subplot(10,5,5)
plot(date(24:end,:),cumsum(-SentCoSVBVAR(1:end-23,24,1)+BenchSVBVAR(1:end-23,24,1))/S2,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(24:end,:),cumsum(-SentCoSVBVAR(1:end-23,24,3)+BenchSVBVAR(1:end-23,24,3))/S2,'Color', brent_col,'linewidth',lw)
plot(date(24:end,:),zeros(size(date,1)-23,1),'k--','linewidth',2)
grid minor
%ylim([-5 6])
set(gca,'xtick',h24,'FontSize',Ysize);
set(gca,'YTick',-3:1:1)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 24','FontWeight','bold','FontSize',Ft)

%%%%%%%%%%%%%%%%%% Financial Stability %%%%%%%%%%%%%%%%%%

subplot(10,5,6)
plot(date,cumsum(-FinStabSVBVAR(1:end,1,1)+BenchSVBVAR(1:end,1,1))/S,'Color', wti_col,'linewidth',lw)
hold on;
plot(date,cumsum(-FinStabSVBVAR(1:end,1,3)+BenchSVBVAR(1:end,1,3))/S,'Color', brent_col,'linewidth',lw)
plot(date,zeros(size(date,1),1),'k--','linewidth',2)
grid minor
ylim([-1 1.5])
set(gca,'xtick',h1,'FontSize',Ysize);
set(gca,'YTick',-1:1:1)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'Financial';'Stability'},'FontSize',Ftt)
title('h = 1','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,7)
plot(date(3:end,:),cumsum(-FinStabSVBVAR(1:end-2,3,1)+BenchSVBVAR(1:end-2,3,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(3:end,:),cumsum(-FinStabSVBVAR(1:end-2,3,3)+BenchSVBVAR(1:end-2,3,3))/S1,'Color', brent_col,'linewidth',lw)
plot(date(3:end,:),zeros(size(date,1)-2,1),'k--','linewidth',2)
grid minor
%ylim([-0.5 1.5])
set(gca,'xtick',h3,'FontSize',Ysize);
set(gca,'YTick',-3:1:1)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 3','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,8)
plot(date(6:end,:),cumsum(-FinStabSVBVAR(1:end-5,6,1)+BenchSVBVAR(1:end-5,6,1))/S2,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(6:end,:),cumsum(-FinStabSVBVAR(1:end-5,6,3)+BenchSVBVAR(1:end-5,6,3))/S2,'Color', brent_col,'linewidth',lw)
plot(date(6:end,:),zeros(size(date,1)-5,1),'k--','linewidth',2)
grid minor
%ylim([-1 2])
set(gca,'xtick',h6,'FontSize',Ysize);
set(gca,'YTick',-4:1:1)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 6','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,9)
plot(date(12:end,:),cumsum(-FinStabSVBVAR(1:end-11,12,1)+BenchSVBVAR(1:end-11,12,1))/S3,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(12:end,:),cumsum(-FinStabSVBVAR(1:end-11,12,3)+BenchSVBVAR(1:end-11,12,3))/S3,'Color', brent_col,'linewidth',lw)
plot(date(12:end,:),zeros(size(date,1)-11,1),'k--','linewidth',2)
grid minor
%ylim([-2 3])
set(gca,'xtick',h12,'FontSize',Ysize);
set(gca,'YTick',-4:1:1)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 12','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,10)
plot(date(24:end,:),cumsum(-FinStabSVBVAR(1:end-23,24,1)+BenchSVBVAR(1:end-23,24,1))/S3,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(24:end,:),cumsum(-FinStabSVBVAR(1:end-23,24,3)+BenchSVBVAR(1:end-23,24,3))/S3,'Color', brent_col,'linewidth',lw)
plot(date(24:end,:),zeros(size(date,1)-23,1),'k--','linewidth',2)
grid minor
%ylim([-5 8])
set(gca,'xtick',h24,'FontSize',Ysize);
set(gca,'YTick',-2:1:0)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 24','FontWeight','bold','FontSize',Ft,'color','none');

%%%%%%%%%%%%%%%%%% Financial Liability %%%%%%%%%%%%%%%%%%

subplot(10,5,11)
plot(date,cumsum(-FinLiabSVBVAR(1:end,1,1)+BenchSVBVAR(1:end,1,1))/S,'Color', wti_col,'linewidth',lw)
hold on;
plot(date,cumsum(-FinLiabSVBVAR(1:end,1,3)+BenchSVBVAR(1:end,1,3))/S,'Color', brent_col,'linewidth',lw)
plot(date,zeros(size(date,1),1),'k--','linewidth',2)
grid minor
%ylim([-0.5 3])
set(gca,'xtick',h1,'FontSize',Ysize);
set(gca,'YTick',-1:1:2)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'Financial';'Liability'},'FontSize',Ftt)
title('h = 1','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,12)
plot(date(3:end,:),cumsum(-FinLiabSVBVAR(1:end-2,3,1)+BenchSVBVAR(1:end-2,3,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(3:end,:),cumsum(-FinLiabSVBVAR(1:end-2,3,3)+BenchSVBVAR(1:end-2,3,3))/S1,'Color', brent_col,'linewidth',lw)
plot(date(3:end,:),zeros(size(date,1)-2,1),'k--','linewidth',2)
grid minor
%ylim([-0.5 1.5])
set(gca,'xtick',h3,'FontSize',Ysize);
set(gca,'YTick',-2:1:0)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 3','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,13)
plot(date(6:end,:),cumsum(-FinLiabSVBVAR(1:end-5,6,1)+BenchSVBVAR(1:end-5,6,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(6:end,:),cumsum(-FinLiabSVBVAR(1:end-5,6,3)+BenchSVBVAR(1:end-5,6,3))/S1,'Color', brent_col,'linewidth',lw)
plot(date(6:end,:),zeros(size(date,1)-5,1),'k--','linewidth',2)
grid minor
%ylim([-1 3])
set(gca,'xtick',h6,'FontSize',Ysize);
set(gca,'YTick',-6:2:0)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 6','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,14)
plot(date(12:end,:),cumsum(-FinLiabSVBVAR(1:end-11,12,1)+BenchSVBVAR(1:end-11,12,1))/S2,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(12:end,:),cumsum(-FinLiabSVBVAR(1:end-11,12,3)+BenchSVBVAR(1:end-11,12,3))/S2,'Color', brent_col,'linewidth',lw)
plot(date(12:end,:),zeros(size(date,1)-11,1),'k--','linewidth',2)
grid minor
%ylim([-2 3])
set(gca,'xtick',h12,'FontSize',Ysize);
set(gca,'YTick',-1:1:3)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 12','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,15)
plot(date(24:end,:),cumsum(-FinLiabSVBVAR(1:end-23,24,1)+BenchSVBVAR(1:end-23,24,1))/S2,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(24:end,:),cumsum(-FinLiabSVBVAR(1:end-23,24,3)+BenchSVBVAR(1:end-23,24,3))/S2,'Color', brent_col,'linewidth',lw)
plot(date(24:end,:),zeros(size(date,1)-23,1),'k--','linewidth',2)
grid minor
%ylim([-4 6])
set(gca,'xtick',h24,'FontSize',Ysize);
set(gca,'YTick',-6:2:0)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 24','FontWeight','bold','FontSize',Ft,'color','none');

%%%%%%%%%%%%%%%%%% Afinn %%%%%%%%%%%%%%%%%%

subplot(10,5,16)
plot(date,cumsum(-AfinnSVBVAR(1:end,1,1)+BenchSVBVAR(1:end,1,1))/S,'Color', wti_col,'linewidth',lw)
hold on;
plot(date,cumsum(-AfinnSVBVAR(1:end,1,3)+BenchSVBVAR(1:end,1,3))/S,'Color', brent_col,'linewidth',lw)
plot(date,zeros(size(date,1),1),'k--','linewidth',2)
grid minor
%ylim([-0.5 3])
set(gca,'xtick',h1,'FontSize',Ysize);
%set(gca,'YTick',0:1:3)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'Afinn';''},'FontSize',Ftt)
title('h = 1','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,17)
plot(date(3:end,:),cumsum(-AfinnSVBVAR(1:end-2,3,1)+BenchSVBVAR(1:end-2,3,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(3:end,:),cumsum(-AfinnSVBVAR(1:end-2,3,3)+BenchSVBVAR(1:end-2,3,3))/S1,'Color', brent_col,'linewidth',lw)
plot(date(3:end,:),zeros(size(date,1)-2,1),'k--','linewidth',2)
grid minor
%ylim([-0.5 1.5])
set(gca,'xtick',h3,'FontSize',Ysize);
set(gca,'YTick',-1:1:1)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 3','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,18)
plot(date(6:end,:),cumsum(-AfinnSVBVAR(1:end-5,6,1)+BenchSVBVAR(1:end-5,6,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(6:end,:),cumsum(-AfinnSVBVAR(1:end-5,6,3)+BenchSVBVAR(1:end-5,6,3))/S1,'Color', brent_col,'linewidth',lw)
plot(date(6:end,:),zeros(size(date,1)-5,1),'k--','linewidth',2)
grid minor
%ylim([-1 1.5])
set(gca,'xtick',h6,'FontSize',Ysize);
set(gca,'YTick',-3:1:2)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 6','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,19)
plot(date(12:end,:),cumsum(-AfinnSVBVAR(1:end-11,12,1)+BenchSVBVAR(1:end-11,12,1))/S2,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(12:end,:),cumsum(-AfinnSVBVAR(1:end-11,12,3)+BenchSVBVAR(1:end-11,12,3))/S2,'Color', brent_col,'linewidth',lw)
plot(date(12:end,:),zeros(size(date,1)-11,1),'k--','linewidth',2)
grid minor
%ylim([-2 2])
set(gca,'xtick',h12,'FontSize',Ysize);
%set(gca,'YTick',-1:1:2)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 12','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,20)
plot(date(24:end,:),cumsum(-AfinnSVBVAR(1:end-23,24,1)+BenchSVBVAR(1:end-23,24,1))/S2,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(24:end,:),cumsum(-AfinnSVBVAR(1:end-23,24,3)+BenchSVBVAR(1:end-23,24,3))/S2,'Color', brent_col,'linewidth',lw)
plot(date(24:end,:),zeros(size(date,1)-23,1),'k--','linewidth',2)
grid minor
%ylim([-5 6])
set(gca,'xtick',h24,'FontSize',Ysize);
set(gca,'YTick',-4:1:1)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 24','FontWeight','bold','FontSize',Ft,'color','none');

%%%%%%%%%%%%%%%%%% Harvard IV %%%%%%%%%%%%%%%%%%

subplot(10,5,21)
plot(date,cumsum(-HarvSVBVAR(1:end,1,1)+BenchSVBVAR(1:end,1,1))/S,'Color', wti_col,'linewidth',lw)
hold on;
plot(date,cumsum(-HarvSVBVAR(1:end,1,3)+BenchSVBVAR(1:end,1,3))/S,'Color', brent_col,'linewidth',lw)
plot(date,zeros(size(date,1),1),'k--','linewidth',2)
grid minor
%ylim([-0.5 3])
set(gca,'xtick',h1,'FontSize',Ysize);
set(gca,'YTick',-2:1:1)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'Harvard-IV';''},'FontSize',Ftt)
title('h = 1','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,22)
plot(date(3:end,:),cumsum(-HarvSVBVAR(1:end-2,3,1)+BenchSVBVAR(1:end-2,3,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(3:end,:),cumsum(-HarvSVBVAR(1:end-2,3,3)+BenchSVBVAR(1:end-2,3,3))/S1,'Color', brent_col,'linewidth',lw)
plot(date(3:end,:),zeros(size(date,1)-2,1),'k--','linewidth',2)
grid minor
%ylim([-0.3 1.5])
set(gca,'xtick',h3,'FontSize',Ysize);
set(gca,'YTick',-2:1:1)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 3','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,23)
plot(date(6:end,:),cumsum(-HarvSVBVAR(1:end-5,6,1)+BenchSVBVAR(1:end-5,6,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(6:end,:),cumsum(-HarvSVBVAR(1:end-5,6,3)+BenchSVBVAR(1:end-5,6,3))/S1,'Color', brent_col,'linewidth',lw)
plot(date(6:end,:),zeros(size(date,1)-5,1),'k--','linewidth',2)
grid minor
%ylim([-0.5 2])
set(gca,'xtick',h6,'FontSize',Ysize);
set(gca,'YTick',-6:2:0)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 6','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,24)
plot(date(12:end,:),cumsum(-HarvSVBVAR(1:end-11,12,1)+BenchSVBVAR(1:end-11,12,1))/S2,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(12:end,:),cumsum(-HarvSVBVAR(1:end-11,12,3)+BenchSVBVAR(1:end-11,12,3))/S2,'Color', brent_col,'linewidth',lw)
plot(date(12:end,:),zeros(size(date,1)-11,1),'k--','linewidth',2)
grid minor
%ylim([-1.5 1.5])
set(gca,'xtick',h12,'FontSize',Ysize);
set(gca,'YTick',-5:1:0)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 12','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,25)
plot(date(24:end,:),cumsum(-HarvSVBVAR(1:end-23,24,1)+BenchSVBVAR(1:end-23,24,1))/S2,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(24:end,:),cumsum(-HarvSVBVAR(1:end-23,24,3)+BenchSVBVAR(1:end-23,24,3))/S2,'Color', brent_col,'linewidth',lw)
plot(date(24:end,:),zeros(size(date,1)-23,1),'k--','linewidth',2)
grid minor
%ylim([-4 6])
set(gca,'xtick',h24,'FontSize',Ysize);
set(gca,'YTick',-4:1:1)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 24','FontWeight','bold','FontSize',Ft,'color','none');

%%%%%%%%%%%%%%%%%% Sentiment tfm %%%%%%%%%%%%%%%%%%

subplot(10,5,26)
plot(date,cumsum(-TfmtxSVBVAR(1:end,1,1)+BenchSVBVAR(1:end,1,1))/S,'Color', wti_col,'linewidth',lw)
hold on;
plot(date,cumsum(-TfmtxSVBVAR(1:end,1,3)+BenchSVBVAR(1:end,1,3))/S,'Color', brent_col,'linewidth',lw)
plot(date,zeros(size(date,1),1),'k--','linewidth',2)
grid minor
ylim([-1 3])
set(gca,'xtick',h1,'FontSize',Ysize);
set(gca,'YTick',-1:1:3)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'Sentiment';'tfm'},'FontSize',Ftt)
title('h = 1','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,27)
plot(date(3:end,:),cumsum(-TfmtxSVBVAR(1:end-2,3,1)+BenchSVBVAR(1:end-2,3,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(3:end,:),cumsum(-TfmtxSVBVAR(1:end-2,3,3)+BenchSVBVAR(1:end-2,3,3))/S1,'Color', brent_col,'linewidth',lw)
plot(date(3:end,:),zeros(size(date,1)-2,1),'k--','linewidth',2)
grid minor
%ylim([-0.5 1.5])
set(gca,'xtick',h3,'FontSize',Ysize);
set(gca,'YTick',0:1:2)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 3','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,28)
plot(date(6:end,:),cumsum(-TfmtxSVBVAR(1:end-5,6,1)+BenchSVBVAR(1:end-5,6,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(6:end,:),cumsum(-TfmtxSVBVAR(1:end-5,6,3)+BenchSVBVAR(1:end-5,6,3))/S1,'Color', brent_col,'linewidth',lw)
plot(date(6:end,:),zeros(size(date,1)-5,1),'k--','linewidth',2)
grid minor
%ylim([-1 3])
set(gca,'xtick',h6,'FontSize',Ysize);
%set(gca,'YTick',0:1:3)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 6','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,29)
plot(date(12:end,:),cumsum(-TfmtxSVBVAR(1:end-11,12,1)+BenchSVBVAR(1:end-11,12,1))/S2,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(12:end,:),cumsum(-TfmtxSVBVAR(1:end-11,12,3)+BenchSVBVAR(1:end-11,12,3))/S2,'Color', brent_col,'linewidth',lw)
plot(date(12:end,:),zeros(size(date,1)-11,1),'k--','linewidth',2)
grid minor
%ylim([-2 3])
set(gca,'xtick',h12,'FontSize',Ysize);
%set(gca,'YTick',-1:1:3)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 12','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,30)
plot(date(24:end,:),cumsum(-TfmtxSVBVAR(1:end-23,24,1)+BenchSVBVAR(1:end-23,24,1))/S2,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(24:end,:),cumsum(-TfmtxSVBVAR(1:end-23,24,3)+BenchSVBVAR(1:end-23,24,3))/S2,'Color', brent_col,'linewidth',lw)
plot(date(24:end,:),zeros(size(date,1)-23,1),'k--','linewidth',2)
grid minor
%ylim([-4 6])
set(gca,'xtick',h24,'FontSize',Ysize);
set(gca,'YTick',-1:1:6)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 24','FontWeight','bold','FontSize',Ft,'color','none');

%%%%%%%%%%%%%%%%%% Sentiment tf-idf %%%%%%%%%%%%%%%%%%

subplot(10,5,31)
plot(date,cumsum(-SeTfIdfSVBVAR(1:end,1,1)+BenchSVBVAR(1:end,1,1))/S,'Color', wti_col,'linewidth',lw)
hold on;
plot(date,cumsum(-SeTfIdfSVBVAR(1:end,1,3)+BenchSVBVAR(1:end,1,3))/S,'Color', brent_col,'linewidth',lw)
plot(date,zeros(size(date,1),1),'k--','linewidth',2)
grid minor
%ylim([-0.5 3.5])
set(gca,'xtick',h1,'FontSize',Ysize);
%set(gca,'YTick',0:1:3)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'Sentiment';'tf-idf'},'FontSize',Ftt)
title('h = 1','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,32)
plot(date(3:end,:),cumsum(-SeTfIdfSVBVAR(1:end-2,3,1)+BenchSVBVAR(1:end-2,3,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(3:end,:),cumsum(-SeTfIdfSVBVAR(1:end-2,3,3)+BenchSVBVAR(1:end-2,3,3))/S1,'Color', brent_col,'linewidth',lw)
plot(date(3:end,:),zeros(size(date,1)-2,1),'k--','linewidth',2)
grid minor
%ylim([-5 15])
set(gca,'xtick',h3,'FontSize',Ysize);
set(gca,'YTick',-1:1:3)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 3','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,33)
plot(date(6:end,:),cumsum(-SeTfIdfSVBVAR(1:end-5,6,1)+BenchSVBVAR(1:end-5,6,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(6:end,:),cumsum(-SeTfIdfSVBVAR(1:end-5,6,3)+BenchSVBVAR(1:end-5,6,3))/S1,'Color', brent_col,'linewidth',lw)
plot(date(6:end,:),zeros(size(date,1)-5,1),'k--','linewidth',2)
grid minor
ylim([-7 6])
set(gca,'xtick',h6,'FontSize',Ysize);
set(gca,'YTick',-6:2:6)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 6','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,34)
plot(date(12:end,:),cumsum(-SeTfIdfSVBVAR(1:end-11,12,1)+BenchSVBVAR(1:end-11,12,1))/S2,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(12:end,:),cumsum(-SeTfIdfSVBVAR(1:end-11,12,3)+BenchSVBVAR(1:end-11,12,3))/S2,'Color', brent_col,'linewidth',lw)
plot(date(12:end,:),zeros(size(date,1)-11,1),'k--','linewidth',2)
grid minor
ylim([-7 2])
set(gca,'xtick',h12,'FontSize',Ysize);
set(gca,'YTick',-6:2:2)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 12','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,35)
plot(date(24:end,:),cumsum(-SeTfIdfSVBVAR(1:end-23,24,1)+BenchSVBVAR(1:end-23,24,1))/S3,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(24:end,:),cumsum(-SeTfIdfSVBVAR(1:end-23,24,3)+BenchSVBVAR(1:end-23,24,3))/S3,'Color', brent_col,'linewidth',lw)
plot(date(24:end,:),zeros(size(date,1)-23,1),'k--','linewidth',2)
grid minor
%ylim([-5 6])
set(gca,'xtick',h24,'FontSize',Ysize);
set(gca,'YTick',-2:1:3)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 24','FontWeight','bold','FontSize',Ft,'color','none');

%%%%%%%%%%%%%%%%%% VADER %%%%%%%%%%%%%%%%%%

subplot(10,5,36)
plot(date,cumsum(-VaderSVBVAR(1:end,1,1)+BenchSVBVAR(1:end,1,1))/S,'Color', wti_col,'linewidth',lw)
hold on;
plot(date,cumsum(-VaderSVBVAR(1:end,1,3)+BenchSVBVAR(1:end,1,3))/S,'Color', brent_col,'linewidth',lw)
plot(date,zeros(size(date,1),1),'k--','linewidth',2)
grid minor
%ylim([-0.5 3])
set(gca,'xtick',h1,'FontSize',Ysize);
%set(gca,'YTick',0:1:3)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'VADER';''},'FontSize',Ftt)
title('h = 1','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,37)
plot(date(3:end,:),cumsum(-VaderSVBVAR(1:end-2,3,1)+BenchSVBVAR(1:end-2,3,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(3:end,:),cumsum(-VaderSVBVAR(1:end-2,3,3)+BenchSVBVAR(1:end-2,3,3))/S1,'Color', brent_col,'linewidth',lw)
plot(date(3:end,:),zeros(size(date,1)-2,1),'k--','linewidth',2)
grid minor
ylim([-1.5 1.5])
set(gca,'xtick',h3,'FontSize',Ysize);
set(gca,'YTick',-1:1:1)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 3','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,38)
plot(date(6:end,:),cumsum(-VaderSVBVAR(1:end-5,6,1)+BenchSVBVAR(1:end-5,6,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(6:end,:),cumsum(-VaderSVBVAR(1:end-5,6,3)+BenchSVBVAR(1:end-5,6,3))/S1,'Color', brent_col,'linewidth',lw)
plot(date(6:end,:),zeros(size(date,1)-5,1),'k--','linewidth',2)
grid minor
%ylim([-1 2])
set(gca,'xtick',h6,'FontSize',Ysize);
set(gca,'YTick',-3:1:2)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 6','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,39)
plot(date(12:end,:),cumsum(-VaderSVBVAR(1:end-11,12,1)+BenchSVBVAR(1:end-11,12,1))/S3,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(12:end,:),cumsum(-VaderSVBVAR(1:end-11,12,3)+BenchSVBVAR(1:end-11,12,3))/S3,'Color', brent_col,'linewidth',lw)
plot(date(12:end,:),zeros(size(date,1)-11,1),'k--','linewidth',2)
grid minor
%ylim([-2 3])
set(gca,'xtick',h12,'FontSize',Ysize);
set(gca,'YTick',-3:1:1)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 12','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,40)
plot(date(24:end,:),cumsum(-VaderSVBVAR(1:end-23,24,1)+BenchSVBVAR(1:end-23,24,1))/S3,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(24:end,:),cumsum(-VaderSVBVAR(1:end-23,24,3)+BenchSVBVAR(1:end-23,24,3))/S3,'Color', brent_col,'linewidth',lw)
plot(date(24:end,:),zeros(size(date,1)-23,1),'k--','linewidth',2)
grid minor
ylim([-0.5 2])
set(gca,'xtick',h24,'FontSize',Ysize);
set(gca,'YTick',0:1:2)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 24','FontWeight','bold','FontSize',Ft,'color','none');

%%%%%%%%%%%%%%%%%% Opinion Sentiment %%%%%%%%%%%%%%%%%%

subplot(10,5,41)
plot(date,cumsum(-OpSenSVBVAR(1:end,1,1)+BenchSVBVAR(1:end,1,1))/S,'Color', wti_col,'linewidth',lw)
hold on;
plot(date,cumsum(-OpSenSVBVAR(1:end,1,3)+BenchSVBVAR(1:end,1,3))/S,'Color', brent_col,'linewidth',lw)
plot(date,zeros(size(date,1),1),'k--','linewidth',2)
grid minor
ylim([-1.5 2])
set(gca,'xtick',h1,'FontSize',Ysize);
set(gca,'YTick',-1:1:2)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'Opinion';'Sentiment'},'FontSize',Ftt)
title('h = 1','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,42)
plot(date(3:end,:),cumsum(-OpSenSVBVAR(1:end-2,3,1)+BenchSVBVAR(1:end-2,3,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(3:end,:),cumsum(-OpSenSVBVAR(1:end-2,3,3)+BenchSVBVAR(1:end-2,3,3))/S1,'Color', brent_col,'linewidth',lw)
plot(date(3:end,:),zeros(size(date,1)-2,1),'k--','linewidth',2)
grid minor
ylim([-1 1])
set(gca,'xtick',h3,'FontSize',Ysize);
set(gca,'YTick',-1:1:1)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 3','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,43)
plot(date(6:end,:),cumsum(-OpSenSVBVAR(1:end-5,6,1)+BenchSVBVAR(1:end-5,6,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(6:end,:),cumsum(-OpSenSVBVAR(1:end-5,6,3)+BenchSVBVAR(1:end-5,6,3))/S1,'Color', brent_col,'linewidth',lw)
plot(date(6:end,:),zeros(size(date,1)-5,1),'k--','linewidth',2)
grid minor
%ylim([-1 3])
set(gca,'xtick',h6,'FontSize',Ysize);
set(gca,'YTick',-1:1:4)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 6','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,44)
plot(date(12:end,:),cumsum(-OpSenSVBVAR(1:end-11,12,1)+BenchSVBVAR(1:end-11,12,1))/S2,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(12:end,:),cumsum(-OpSenSVBVAR(1:end-11,12,3)+BenchSVBVAR(1:end-11,12,3))/S2,'Color', brent_col,'linewidth',lw)
plot(date(12:end,:),zeros(size(date,1)-11,1),'k--','linewidth',2)
grid minor
%ylim([-2 3])
set(gca,'xtick',h12,'FontSize',Ysize);
%set(gca,'YTick',-1:1:3)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 12','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,45)
plot(date(24:end,:),cumsum(-OpSenSVBVAR(1:end-23,24,1)+BenchSVBVAR(1:end-23,24,1))/S2,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(24:end,:),cumsum(-OpSenSVBVAR(1:end-23,24,3)+BenchSVBVAR(1:end-23,24,3))/S2,'Color', brent_col,'linewidth',lw)
plot(date(24:end,:),zeros(size(date,1)-23,1),'k--','linewidth',2)
grid minor
ylim([-2.5 1])
set(gca,'xtick',h24,'FontSize',Ysize);
set(gca,'YTick',-2:1:1)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 24','FontWeight','bold','FontSize',Ft,'color','none');

%%%%%%%%%%%%%%%%%% BERT %%%%%%%%%%%%%%%%%%

subplot(10,5,46)
plot(date,cumsum(-BertSVBVAR(1:end,1,1)+BenchSVBVAR(1:end,1,1))/S,'Color', wti_col,'linewidth',lw)
hold on;
plot(date,cumsum(-BertSVBVAR(1:end,1,3)+BenchSVBVAR(1:end,1,3))/S,'Color', brent_col,'linewidth',lw)
plot(date,zeros(size(date,1),1),'k--','linewidth',2)
grid minor
ylim([-0.5 8])
set(gca,'xtick',h1,'FontSize',Ysize);
set(gca,'YTick',0:2:8)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'BERT';''},'FontSize',Ftt)
title('h = 1','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,47)
plot(date(3:end,:),cumsum(-BertSVBVAR(1:end-2,3,1)+BenchSVBVAR(1:end-2,3,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(3:end,:),cumsum(-BertSVBVAR(1:end-2,3,3)+BenchSVBVAR(1:end-2,3,3))/S1,'Color', brent_col,'linewidth',lw)
plot(date(3:end,:),zeros(size(date,1)-2,1),'k--','linewidth',2)
grid minor
ylim([-1.5 3])
set(gca,'xtick',h3,'FontSize',Ysize);
set(gca,'YTick',-1:1:3)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 3','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,48)
plot(date(6:end,:),cumsum(-BertSVBVAR(1:end-5,6,1)+BenchSVBVAR(1:end-5,6,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(6:end,:),cumsum(-BertSVBVAR(1:end-5,6,3)+BenchSVBVAR(1:end-5,6,3))/S1,'Color', brent_col,'linewidth',lw)
plot(date(6:end,:),zeros(size(date,1)-5,1),'k--','linewidth',2)
grid minor
ylim([-2 8])
set(gca,'xtick',h6,'FontSize',Ysize);
set(gca,'YTick',-1:1:8)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 6','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,49)
plot(date(12:end,:),cumsum(-BertSVBVAR(1:end-11,12,1)+BenchSVBVAR(1:end-11,12,1))/S2,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(12:end,:),cumsum(-BertSVBVAR(1:end-11,12,3)+BenchSVBVAR(1:end-11,12,3))/S2,'Color', brent_col,'linewidth',lw)
plot(date(12:end,:),zeros(size(date,1)-11,1),'k--','linewidth',2)
grid minor
ylim([-0.5 8])
set(gca,'xtick',h12,'FontSize',Ysize);
set(gca,'YTick',0:2:8)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 12','FontWeight','bold','FontSize',Ft,'color','none');

subplot(10,5,50)
plot(date(24:end,:),cumsum(-BertSVBVAR(1:end-23,24,1)+BenchSVBVAR(1:end-23,24,1))/S2,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(24:end,:),cumsum(-BertSVBVAR(1:end-23,24,3)+BenchSVBVAR(1:end-23,24,3))/S2,'Color', brent_col,'linewidth',lw)
plot(date(24:end,:),zeros(size(date,1)-23,1),'k--','linewidth',2)
grid minor
ylim([-3 1])
set(gca,'xtick',h24,'FontSize',Ysize);
set(gca,'YTick',-2:1:1)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 24','FontWeight','bold','FontSize',Ft,'color','none');

rmpath('Results')