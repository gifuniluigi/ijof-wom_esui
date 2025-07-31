%CSFE txt-uncertainty VS benchmark SV-BVAR

clear;clc;
addpath('Results')

load SVBVAR_Uncertainty_msfe

date = {'01-Jan-2001','30-Jun-2021'};
date = datemnth(date{1}, (0: months(date{:}))');
date = datetime(date,'ConvertFrom','datenum');
Ft = 80;
Ftt = 70;
Ysize = 50;
S  = 10^5;
S1 = 10^6;
S2 = 10^6.5;
S3 = 10^7;
S4 = 10^4;
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
% For example run from line 35 to 45 to get plot (1,1) of Figure 2. Always
% skip the line starting with "subplot(x,y,z)"
figure(2)
%%%%%%%%%%%%%%%%%% Uncertainty count %%%%%%%%%%%%%%%%%%
subplot(4,5,1)
plot(date,cumsum(-UnCoSVBVAR(1:end,1,1)+BenchSVBVAR(1:end,1,1))/S,'Color', wti_col,'linewidth',lw)
hold on;
plot(date,cumsum(-UnCoSVBVAR(1:end,1,3)+BenchSVBVAR(1:end,1,3))/S,'Color', brent_col,'linewidth',lw)
grid minor
plot(date,zeros(size(date,1),1),'k--','linewidth',2)
ylim([-2 1])
set(gca,'xtick',h1,'FontSize',Ysize);
set(gca,'YTick',-1:1:1)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'Uncertainty';'count'},'FontSize',Ftt)
title('h = 1','FontWeight','bold','FontSize',Ft)

subplot(4,5,2)
plot(date(3:end,:),cumsum(-UnCoSVBVAR(1:end-2,3,1)+BenchSVBVAR(1:end-2,3,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(3:end,:),cumsum(-UnCoSVBVAR(1:end-2,3,3)+BenchSVBVAR(1:end-2,3,3))/S1,'Color', brent_col,'linewidth',lw)
grid minor
plot(date(3:end,:),zeros(size(date,1)-2,1),'k--','linewidth',2)
ylim([-1.5 1])
set(gca,'xtick',h3,'FontSize',Ysize);
set(gca,'YTick',-1:1:1)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 3','FontWeight','bold','FontSize',Ft)

subplot(4,5,3)
plot(date(6:end,:),cumsum(-UnCoSVBVAR(1:end-5,6,1)+BenchSVBVAR(1:end-5,6,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(6:end,:),cumsum(-UnCoSVBVAR(1:end-5,6,3)+BenchSVBVAR(1:end-5,6,3))/S1,'Color', brent_col,'linewidth',lw)
grid minor
plot(date(6:end,:),zeros(size(date,1)-5,1),'k--','linewidth',2)
ylim([-5 1])
set(gca,'xtick',h6,'FontSize',Ysize);
datetick('x','yyyy','keepticks','keeplimits')
set(gca,'YTick',-4:1:1)
ylabel({'';''},'FontSize',Ftt)
title('h = 6','FontWeight','bold','FontSize',Ft)

subplot(4,5,4)
plot(date(12:end,:),cumsum(-UnCoSVBVAR(1:end-11,12,1)+BenchSVBVAR(1:end-11,12,1))/S2,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(12:end,:),cumsum(-UnCoSVBVAR(1:end-11,12,3)+BenchSVBVAR(1:end-11,12,3))/S2,'Color', brent_col,'linewidth',lw)
grid minor
plot(date(12:end,:),zeros(size(date,1)-11,1),'k--','linewidth',2)
ylim([-2.5 1])
set(gca,'xtick',h12,'FontSize',Ysize);
set(gca,'YTick',-2:1:1)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 12','FontWeight','bold','FontSize',Ft)

subplot(4,5,5)
plot(date(24:end,:),cumsum(-UnCoSVBVAR(1:end-23,24,1)+BenchSVBVAR(1:end-23,24,1))/S2,'Color', wti_col,'linewidth',lw)
hold on
plot(date(24:end,:),cumsum(-UnCoSVBVAR(1:end-23,24,3)+BenchSVBVAR(1:end-23,24,3))/S2,'Color', brent_col,'linewidth',lw)
grid minor
plot(date(24:end,:),zeros(size(date,1)-23,1),'k--','linewidth',2)
ylim([-2 1])
set(gca,'xtick',h24,'FontSize',Ysize);
set(gca,'YTick',-1:1:1)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 24','FontWeight','bold','FontSize',Ft)

%%%%%%%%%%%%%%%%%% Boolean count %%%%%%%%%%%%%%%%%%

subplot(4,5,6)
plot(date,cumsum(-UnBoolSVBVAR(1:end,1,1)+BenchSVBVAR(1:end,1,1))/S,'Color', wti_col,'linewidth',lw)
hold on;
plot(date,cumsum(-UnBoolSVBVAR(1:end,1,3)+BenchSVBVAR(1:end,1,3))/S,'Color', brent_col,'linewidth',lw)
grid minor
plot(date,zeros(size(date,1),1),'k--','linewidth',2)
ylim([-1.5 1])
set(gca,'xtick',h1,'FontSize',Ysize);
set(gca,'YTick',-1:1:1)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'Boolean';'count'},'FontSize',Ftt)
title('h = 1','FontWeight','bold','FontSize',Ft,'color','none');

subplot(4,5,7)
plot(date(3:end,:),cumsum(-UnBoolSVBVAR(1:end-2,3,1)+BenchSVBVAR(1:end-2,3,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(3:end,:),cumsum(-UnBoolSVBVAR(1:end-2,3,3)+BenchSVBVAR(1:end-2,3,3))/S1,'Color', brent_col,'linewidth',lw)
grid minor
plot(date(3:end,:),zeros(size(date,1)-2,1),'k--','linewidth',2)
ylim([-2.5 0.5])
set(gca,'xtick',h3,'FontSize',Ysize);
set(gca,'YTick',-2:1:0)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 3','FontWeight','bold','FontSize',Ft,'color','none');

subplot(4,5,8)
plot(date(6:end,:),cumsum(-UnBoolSVBVAR(1:end-5,6,1)+BenchSVBVAR(1:end-5,6,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(6:end,:),cumsum(-UnBoolSVBVAR(1:end-5,6,3)+BenchSVBVAR(1:end-5,6,3))/S1,'Color', brent_col,'linewidth',lw)
grid minor
plot(date(6:end,:),zeros(size(date,1)-5,1),'k--','linewidth',2)
ylim([-4.5 0])
set(gca,'xtick',h6,'FontSize',Ysize);
set(gca,'YTick',-4:1:0)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 6','FontWeight','bold','FontSize',Ft,'color','none');

subplot(4,5,9)
plot(date(12:end,:),cumsum(-UnBoolSVBVAR(1:end-11,12,1)+BenchSVBVAR(1:end-11,12,1))/S2,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(12:end,:),cumsum(-UnBoolSVBVAR(1:end-11,12,3)+BenchSVBVAR(1:end-11,12,3))/S2,'Color', brent_col,'linewidth',lw)
grid minor
plot(date(12:end,:),zeros(size(date,1)-11,1),'k--','linewidth',2)
ylim([-7 2])
set(gca,'xtick',h12,'FontSize',Ysize);
set(gca,'YTick',-6:2:2)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 12','FontWeight','bold','FontSize',Ft,'color','none');

subplot(4,5,10)
plot(date(24:end,:),cumsum(-UnBoolSVBVAR(1:end-23,24,1)+BenchSVBVAR(1:end-23,24,1))/S2,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(24:end,:),cumsum(-UnBoolSVBVAR(1:end-23,24,3)+BenchSVBVAR(1:end-23,24,3))/S2,'Color', brent_col,'linewidth',lw)
grid minor
plot(date(24:end,:),zeros(size(date,1)-23,1),'k--','linewidth',2)
ylim([-4.5 1])
set(gca,'xtick',h24,'FontSize',Ysize);
set(gca,'YTick',-4:1:1)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 24','FontWeight','bold','FontSize',Ft,'color','none');

%%%%%%%%%%%%%%%%%% Uncertainty tfm %%%%%%%%%%%%%%%%%%

subplot(4,5,11)
plot(date,cumsum(-UnOdxSVBVAR(1:end,1,1)+BenchSVBVAR(1:end,1,1))/S4,'Color', wti_col,'linewidth',lw)
hold on;
plot(date,cumsum(-UnOdxSVBVAR(1:end,1,3)+BenchSVBVAR(1:end,1,3))/S4,'Color', brent_col,'linewidth',lw)
grid minor
plot(date,zeros(size(date,1),1),'k--','linewidth',2)
%ylim([-0.5 1])
set(gca,'xtick',h1,'FontSize',Ysize);
%set(gca,'YTick',0:1:1)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'Uncertainty';'tfm'},'FontSize',Ftt)
title('h = 1','FontWeight','bold','FontSize',Ft,'color','none');

subplot(4,5,12)
plot(date(3:end,:),cumsum(-UnOdxSVBVAR(1:end-2,3,1)+BenchSVBVAR(1:end-2,3,1))/S,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(3:end,:),cumsum(-UnOdxSVBVAR(1:end-2,3,3)+BenchSVBVAR(1:end-2,3,3))/S,'Color', brent_col,'linewidth',lw)
grid minor
plot(date(3:end,:),zeros(size(date,1)-2,1),'k--','linewidth',2)
ylim([-4.5 2])
set(gca,'xtick',h3,'FontSize',Ysize);
set(gca,'YTick',-4:2:2)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 3','FontWeight','bold','FontSize',Ft,'color','none');

subplot(4,5,13)
plot(date(6:end,:),cumsum(-UnOdxSVBVAR(1:end-5,6,1)+BenchSVBVAR(1:end-5,6,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(6:end,:),cumsum(-UnOdxSVBVAR(1:end-5,6,3)+BenchSVBVAR(1:end-5,6,3))/S1,'Color', brent_col,'linewidth',lw)
grid minor
plot(date(6:end,:),zeros(size(date,1)-5,1),'k--','linewidth',2)
%ylim([-1 0.5])
set(gca,'xtick',h6,'FontSize',Ysize);
set(gca,'YTick',-1:1:2)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 6','FontWeight','bold','FontSize',Ft,'color','none');

subplot(4,5,14)
plot(date(12:end,:),cumsum(-UnOdxSVBVAR(1:end-11,12,1)+BenchSVBVAR(1:end-11,12,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(12:end,:),cumsum(-UnOdxSVBVAR(1:end-11,12,3)+BenchSVBVAR(1:end-11,12,3))/S1,'Color', brent_col,'linewidth',lw)
grid minor
plot(date(12:end,:),zeros(size(date,1)-11,1),'k--','linewidth',2)
ylim([-2.5 6])
set(gca,'xtick',h12,'FontSize',Ysize);
set(gca,'YTick',-2:2:6)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 12','FontWeight','bold','FontSize',Ft,'color','none');

subplot(4,5,15)
plot(date(24:end,:),cumsum(-UnOdxSVBVAR(1:end-23,24,1)+BenchSVBVAR(1:end-23,24,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(24:end,:),cumsum(-UnOdxSVBVAR(1:end-23,24,3)+BenchSVBVAR(1:end-23,24,3))/S1,'Color', brent_col,'linewidth',lw)
grid minor
plot(date(24:end,:),zeros(size(date,1)-23,1),'k--','linewidth',2)
ylim([-3 2])
set(gca,'xtick',h24,'FontSize',Ysize);
set(gca,'YTick',-2:1:2)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 24','FontWeight','bold','FontSize',Ft,'color','none');

%%%%%%%%%%%%%%%%%% Uncertainty tf-idf %%%%%%%%%%%%%%%%%%

subplot(4,5,16)
plot(date,cumsum(-UnOidfSVBVAR(1:end,1,1)+BenchSVBVAR(1:end,1,1))/S,'Color', wti_col,'linewidth',lw)
hold on;
plot(date,cumsum(-UnOidfSVBVAR(1:end,1,3)+BenchSVBVAR(1:end,1,3))/S,'Color', brent_col,'linewidth',lw)
grid minor
plot(date,zeros(size(date,1),1),'k--','linewidth',2)
ylim([-1 1.5])
set(gca,'xtick',h1,'FontSize',Ysize);
set(gca,'YTick',-1:1:1)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'Uncertainty';'tf-idf'},'FontSize',Ftt)
title('h = 1','FontWeight','bold','FontSize',Ft,'color','none');

subplot(4,5,17)
plot(date(3:end,:),cumsum(-UnOidfSVBVAR(1:end-2,3,1)+BenchSVBVAR(1:end-2,3,1))/S,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(3:end,:),cumsum(-UnOidfSVBVAR(1:end-2,3,3)+BenchSVBVAR(1:end-2,3,3))/S,'Color', brent_col,'linewidth',lw)
grid minor
plot(date(3:end,:),zeros(size(date,1)-2,1),'k--','linewidth',2)
ylim([-9 2])
set(gca,'xtick',h3,'FontSize',Ysize);
set(gca,'YTick',-8:2:2)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 3','FontWeight','bold','FontSize',Ft,'color','none');

subplot(4,5,18)
plot(date(6:end,:),cumsum(-UnOidfSVBVAR(1:end-5,6,1)+BenchSVBVAR(1:end-5,6,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(6:end,:),cumsum(-UnOidfSVBVAR(1:end-5,6,3)+BenchSVBVAR(1:end-5,6,3))/S1,'Color', brent_col,'linewidth',lw)
grid minor
plot(date(6:end,:),zeros(size(date,1)-5,1),'k--','linewidth',2)
ylim([-2 3])
set(gca,'xtick',h6,'FontSize',Ysize);
set(gca,'YTick',-1:1:3)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 6','FontWeight','bold','FontSize',Ft,'color','none');

subplot(4,5,19)
plot(date(12:end,:),cumsum(-UnOidfSVBVAR(1:end-11,12,1)+BenchSVBVAR(1:end-11,12,1))/S2,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(12:end,:),cumsum(-UnOidfSVBVAR(1:end-11,12,3)+BenchSVBVAR(1:end-11,12,3))/S2,'Color', brent_col,'linewidth',lw)
grid minor
plot(date(12:end,:),zeros(size(date,1)-11,1),'k--','linewidth',2)
ylim([-7 4])
set(gca,'xtick',h12,'FontSize',Ysize);
set(gca,'YTick',-6:2:4)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 12','FontWeight','bold','FontSize',Ft,'color','none');

subplot(5,4,20)
plot(date(24:end,:),cumsum(-UnOidfSVBVAR(1:end-23,24,1)+BenchSVBVAR(1:end-23,24,1))/S1,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(24:end,:),cumsum(-UnOidfSVBVAR(1:end-23,24,3)+BenchSVBVAR(1:end-23,24,3))/S1,'Color', brent_col,'linewidth',lw)
grid minor
plot(date(24:end,:),zeros(size(date,1)-23,1),'k--','linewidth',2)
ylim([-4.5 4])
set(gca,'xtick',h24,'FontSize',Ysize);
set(gca,'YTick',-4:2:4)
datetick('x','yyyy','keepticks','keeplimits')
ylabel({'';''},'FontSize',Ftt)
title('h = 24','FontWeight','bold','FontSize',Ft,'color','none');

rmpath('Results')