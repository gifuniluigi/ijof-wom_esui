%CSFE txt-uncertainty VS benchmark OLS

clear;clc;
addpath('Results')

load VARmspeUnc

date = {'01-Jan-2001','30-Jun-2021'};
date = datemnth(date{1}, (0: months(date{:}))');
date = datetime(date,'ConvertFrom','datenum');
Ft = 13;
S = 10^5;
h1 = [date(1,1) date(82,1) date(164,1) date(246,1)];
h3 = [date(3,1) date(84,1) date(165,1) date(246,1)];
h6 = [date(6,1) date(86,1) date(166,1) date(246,1)];
h12 = [date(12,1) date(90,1) date(168,1) date(246,1)];
h24 = [date(24,1) date(98,1) date(172,1) date(246,1)];

figure(24)
subplot(5,4,1)
plot(date,cumsum(-UnCoVAR(1:end,1,1)+BenchVAR(1:end,1,1))/S,'linewidth',2)
hold on;
plot(date,cumsum(-UnCoVAR(1:end,1,2)+BenchVAR(1:end,1,2))/S,'linewidth',2)
plot(date,cumsum(-UnCoVAR(1:end,1,3)+BenchVAR(1:end,1,3))/S,'linewidth',2)
grid minor
plot(date,zeros(size(date,1),1),'k--','linewidth',2)
%ylim([-2 1])
set(gca,'xtick',h1);
%set(gca,'YTick',-1:1:1)
datetick('x','yyyy','keepticks','keeplimits')
title('Uncertainty count','FontSize',20);
subtitle('h = 1','FontWeight','bold','FontSize',Ft)

subplot(5,4,2)
plot(date,cumsum(-UnBoolVAR(1:end,1,1)+BenchVAR(1:end,1,1))/S,'linewidth',2)
hold on;
plot(date,cumsum(-UnBoolVAR(1:end,1,2)+BenchVAR(1:end,1,2))/S,'linewidth',2)
plot(date,cumsum(-UnBoolVAR(1:end,1,3)+BenchVAR(1:end,1,3))/S,'linewidth',2)
grid minor
plot(date,zeros(size(date,1),1),'k--','linewidth',2)
%ylim([-2 1])
set(gca,'xtick',h1);
%set(gca,'YTick',-1:1:1)
datetick('x','yyyy','keepticks','keeplimits')
title('Boolean count','FontSize',20);
subtitle('h = 1','FontWeight','bold','FontSize',Ft)

subplot(5,4,3)
plot(date,cumsum(-UnOdxVAR(1:end,1,1)+BenchVAR(1:end,1,1))/S,'linewidth',2)
hold on;
plot(date,cumsum(-UnOdxVAR(1:end,1,2)+BenchVAR(1:end,1,2))/S,'linewidth',2)
plot(date,cumsum(-UnOdxVAR(1:end,1,3)+BenchVAR(1:end,1,3))/S,'linewidth',2)
grid minor
plot(date,zeros(size(date,1),1),'k--','linewidth',2)
%ylim([-0.5 0.2])
set(gca,'xtick',h1);
%set(gca,'YTick',0:0)
datetick('x','yyyy','keepticks','keeplimits')
title('Uncertainty tfm','FontSize',20);
subtitle('h = 1','FontWeight','bold','FontSize',Ft)

subplot(5,4,4)
plot(date,cumsum(-UnOidfVAR(1:end,1,1)+BenchVAR(1:end,1,1))/S,'linewidth',2)
hold on;
plot(date,cumsum(-UnOidfVAR(1:end,1,2)+BenchVAR(1:end,1,2))/S,'linewidth',2)
plot(date,cumsum(-UnOidfVAR(1:end,1,3)+BenchVAR(1:end,1,3))/S,'linewidth',2)
grid minor
plot(date,zeros(size(date,1),1),'k--','linewidth',2)
%ylim([-2 0.2])
set(gca,'xtick',h1);
set(gca,'YTick',-1:1:0)
datetick('x','yyyy','keepticks','keeplimits')
title('Uncertainty tf-idf','FontSize',20);
subtitle('h = 1','FontWeight','bold','FontSize',Ft)

subplot(5,4,5)
plot(date(3:end,:),cumsum(-UnCoVAR(1:end-2,3,1)+BenchVAR(1:end-2,3,1))/S,'linewidth',2)
hold on;
plot(date(3:end,:),cumsum(-UnCoVAR(1:end-2,3,2)+BenchVAR(1:end-2,3,2))/S,'linewidth',2)
plot(date(3:end,:),cumsum(-UnCoVAR(1:end-2,3,3)+BenchVAR(1:end-2,3,3))/S,'linewidth',2)
grid minor
plot(date(3:end,:),zeros(size(date,1)-2,1),'k--','linewidth',2)
%ylim([-1 2])
set(gca,'xtick',h3);
%set(gca,'YTick',0:1:2)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 3','FontSize',Ft)

subplot(5,4,6)
plot(date(3:end,:),cumsum(-UnBoolVAR(1:end-2,3,1)+BenchVAR(1:end-2,3,1))/S,'linewidth',2)
hold on;
plot(date(3:end,:),cumsum(-UnBoolVAR(1:end-2,3,2)+BenchVAR(1:end-2,3,2))/S,'linewidth',2)
plot(date(3:end,:),cumsum(-UnBoolVAR(1:end-2,3,3)+BenchVAR(1:end-2,3,3))/S,'linewidth',2)
grid minor
plot(date(3:end,:),zeros(size(date,1)-2,1),'k--','linewidth',2)
%ylim([-1 2])
set(gca,'xtick',h3);
%set(gca,'YTick',0:1:2)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 3','FontSize',Ft)

subplot(5,4,7)
plot(date(3:end,:),cumsum(-UnOdxVAR(1:end-2,3,1)+BenchVAR(1:end-2,3,1))/S,'linewidth',2)
hold on;
plot(date(3:end,:),cumsum(-UnOdxVAR(1:end-2,3,2)+BenchVAR(1:end-2,3,2))/S,'linewidth',2)
plot(date(3:end,:),cumsum(-UnOdxVAR(1:end-2,3,3)+BenchVAR(1:end-2,3,3))/S,'linewidth',2)
grid minor
plot(date(3:end,:),zeros(size(date,1)-2,1),'k--','linewidth',2)
%ylim([-4 0.2])
set(gca,'xtick',h3);
%set(gca,'YTick',-3:1:0)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 3','FontSize',Ft)

subplot(5,4,8)
plot(date(3:end,:),cumsum(-UnOidfVAR(1:end-2,3,1)+BenchVAR(1:end-2,3,1))/S,'linewidth',2)
hold on;
plot(date(3:end,:),cumsum(-UnOidfVAR(1:end-2,3,2)+BenchVAR(1:end-2,3,2))/S,'linewidth',2)
plot(date(3:end,:),cumsum(-UnOidfVAR(1:end-2,3,3)+BenchVAR(1:end-2,3,3))/S,'linewidth',2)
grid minor
plot(date(3:end,:),zeros(size(date,1)-2,1),'k--','linewidth',2)
%ylim([-1 0.2])
set(gca,'xtick',h3);
%set(gca,'YTick',0:0)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 3','FontSize',Ft)

subplot(5,4,9)
plot(date(6:end,:),cumsum(-UnCoVAR(1:end-5,6,1)+BenchVAR(1:end-5,6,1))/S,'linewidth',2)
hold on;
plot(date(6:end,:),cumsum(-UnCoVAR(1:end-5,6,2)+BenchVAR(1:end-5,6,2))/S,'linewidth',2)
plot(date(6:end,:),cumsum(-UnCoVAR(1:end-5,6,3)+BenchVAR(1:end-5,6,3))/S,'linewidth',2)
grid minor
plot(date(6:end,:),zeros(size(date,1)-5,1),'k--','linewidth',2)
%ylim([-1 0.2])
set(gca,'xtick',h6);
%set(gca,'YTick',0:0)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 6','FontSize',Ft)

subplot(5,4,10)
plot(date(6:end,:),cumsum(-UnBoolVAR(1:end-5,6,1)+BenchVAR(1:end-5,6,1))/S,'linewidth',2)
hold on;
plot(date(6:end,:),cumsum(-UnBoolVAR(1:end-5,6,2)+BenchVAR(1:end-5,6,2))/S,'linewidth',2)
plot(date(6:end,:),cumsum(-UnBoolVAR(1:end-5,6,3)+BenchVAR(1:end-5,6,3))/S,'linewidth',2)
grid minor
plot(date(6:end,:),zeros(size(date,1)-5,1),'k--','linewidth',2)
%ylim([-2 0.2])
set(gca,'xtick',h6);
%set(gca,'YTick',-1:1:0)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 6','FontSize',Ft)

subplot(5,4,11)
plot(date(6:end,:),cumsum(-UnOdxVAR(1:end-5,6,1)+BenchVAR(1:end-5,6,1))/S,'linewidth',2)
hold on;
plot(date(6:end,:),cumsum(-UnOdxVAR(1:end-5,6,2)+BenchVAR(1:end-5,6,2))/S,'linewidth',2)
plot(date(6:end,:),cumsum(-UnOdxVAR(1:end-5,6,3)+BenchVAR(1:end-5,6,3))/S,'linewidth',2)
grid minor
plot(date(6:end,:),zeros(size(date,1)-5,1),'k--','linewidth',2)
%ylim([-16 2])
set(gca,'xtick',h6);
%set(gca,'YTick',-15:5:2)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 6','FontSize',Ft)

subplot(5,4,12)
plot(date(6:end,:),cumsum(-UnOidfVAR(1:end-5,6,1)+BenchVAR(1:end-5,6,1))/S,'linewidth',2)
hold on;
plot(date(6:end,:),cumsum(-UnOidfVAR(1:end-5,6,2)+BenchVAR(1:end-5,6,2))/S,'linewidth',2)
plot(date(6:end,:),cumsum(-UnOidfVAR(1:end-5,6,3)+BenchVAR(1:end-5,6,3))/S,'linewidth',2)
grid minor
plot(date(6:end,:),zeros(size(date,1)-5,1),'k--','linewidth',2)
%ylim([-1 0.2])
set(gca,'xtick',h6);
%set(gca,'YTick',0:0)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 6','FontSize',Ft)

subplot(5,4,13)
plot(date(12:end,:),cumsum(-UnCoVAR(1:end-11,12,1)+BenchVAR(1:end-11,12,1))/S,'linewidth',2)
hold on;
plot(date(12:end,:),cumsum(-UnCoVAR(1:end-11,12,2)+BenchVAR(1:end-11,12,2))/S,'linewidth',2)
plot(date(12:end,:),cumsum(-UnCoVAR(1:end-11,12,3)+BenchVAR(1:end-11,12,3))/S,'linewidth',2)
grid minor
plot(date(12:end,:),zeros(size(date,1)-11,1),'k--','linewidth',2)
%ylim([-1 0.3])
set(gca,'xtick',h12);
%set(gca,'YTick',0:0)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 12','FontSize',Ft)

subplot(5,4,14)
plot(date(12:end,:),cumsum(-UnBoolVAR(1:end-11,12,1)+BenchVAR(1:end-11,12,1))/S,'linewidth',2)
hold on;
plot(date(12:end,:),cumsum(-UnBoolVAR(1:end-11,12,2)+BenchVAR(1:end-11,12,2))/S,'linewidth',2)
plot(date(12:end,:),cumsum(-UnBoolVAR(1:end-11,12,3)+BenchVAR(1:end-11,12,3))/S,'linewidth',2)
grid minor
plot(date(12:end,:),zeros(size(date,1)-11,1),'k--','linewidth',2)
%ylim([-2 0.3])
set(gca,'xtick',h12);
%set(gca,'YTick',-1:1:0)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 12','FontSize',Ft)


subplot(5,4,15)
plot(date(12:end,:),cumsum(-UnOdxVAR(1:end-11,12,1)+BenchVAR(1:end-11,12,1))/S,'linewidth',2)
hold on;
plot(date(12:end,:),cumsum(-UnOdxVAR(1:end-11,12,2)+BenchVAR(1:end-11,12,2))/S,'linewidth',2)
plot(date(12:end,:),cumsum(-UnOdxVAR(1:end-11,12,3)+BenchVAR(1:end-11,12,3))/S,'linewidth',2)
grid minor
plot(date(12:end,:),zeros(size(date,1)-11,1),'k--','linewidth',2)
%ylim([-25 1])
set(gca,'xtick',h12);
%set(gca,'YTick',-20:10:0)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 12','FontSize',Ft)

subplot(5,4,16)
plot(date(12:end,:),cumsum(-UnOidfVAR(1:end-11,12,1)+BenchVAR(1:end-11,12,1))/S,'linewidth',2)
hold on;
plot(date(12:end,:),cumsum(-UnOidfVAR(1:end-11,12,2)+BenchVAR(1:end-11,12,2))/S,'linewidth',2)
plot(date(12:end,:),cumsum(-UnOidfVAR(1:end-11,12,3)+BenchVAR(1:end-11,12,3))/S,'linewidth',2)
grid minor
plot(date(12:end,:),zeros(size(date,1)-11,1),'k--','linewidth',2)
%ylim([-1 0.4])
set(gca,'xtick',h12);
%set(gca,'YTick',0:0)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 12','FontSize',Ft)

subplot(5,4,17)
plot(date(24:end,:),cumsum(-UnCoVAR(1:end-23,24,1)+BenchVAR(1:end-23,24,1))/S,'linewidth',2)
hold on;
plot(date(24:end,:),cumsum(-UnCoVAR(1:end-23,24,2)+BenchVAR(1:end-23,24,2))/S,'linewidth',2)
plot(date(24:end,:),cumsum(-UnCoVAR(1:end-23,24,3)+BenchVAR(1:end-23,24,3))/S,'linewidth',2)
grid minor
plot(date(24:end,:),zeros(size(date,1)-23,1),'k--','linewidth',2)
%ylim([-1 1])
set(gca,'xtick',h24);
%set(gca,'YTick',0:0)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 24','FontSize',Ft)

subplot(5,4,18)
plot(date(24:end,:),cumsum(-UnBoolVAR(1:end-23,24,1)+BenchVAR(1:end-23,24,1))/S,'linewidth',2)
hold on;
plot(date(24:end,:),cumsum(-UnBoolVAR(1:end-23,24,2)+BenchVAR(1:end-23,24,2))/S,'linewidth',2)
plot(date(24:end,:),cumsum(-UnBoolVAR(1:end-23,24,3)+BenchVAR(1:end-23,24,3))/S,'linewidth',2)
grid minor
plot(date(24:end,:),zeros(size(date,1)-23,1),'k--','linewidth',2)
%ylim([-2 0.2])
set(gca,'xtick',h24);
%set(gca,'YTick',-1:1:0)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 24','FontSize',Ft)


subplot(5,4,19)
plot(date(24:end,:),cumsum(-UnOdxVAR(1:end-23,24,1)+BenchVAR(1:end-23,24,1))/S,'linewidth',2)
hold on;
plot(date(24:end,:),cumsum(-UnOdxVAR(1:end-23,24,2)+BenchVAR(1:end-23,24,2))/S,'linewidth',2)
plot(date(24:end,:),cumsum(-UnOdxVAR(1:end-23,24,3)+BenchVAR(1:end-23,24,3))/S,'linewidth',2)
grid minor
plot(date(24:end,:),zeros(size(date,1)-23,1),'k--','linewidth',2)
%ylim([-61 10])
set(gca,'xtick',h24);
%set(gca,'YTick',-60:20:0)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 24','FontSize',Ft)

subplot(5,4,20)
plot(date(24:end,:),cumsum(-UnOidfVAR(1:end-23,24,1)+BenchVAR(1:end-23,24,1))/S,'linewidth',2)
hold on;
plot(date(24:end,:),cumsum(-UnOidfVAR(1:end-23,24,2)+BenchVAR(1:end-23,24,2))/S,'linewidth',2)
plot(date(24:end,:),cumsum(-UnOidfVAR(1:end-23,24,3)+BenchVAR(1:end-23,24,3))/S,'linewidth',2)
grid minor
plot(date(24:end,:),zeros(size(date,1)-23,1),'k--','linewidth',2)
%ylim([-3 0.3])
set(gca,'xtick',h24);
%set(gca,'YTick',-2:1:0)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 24','FontSize',Ft)

hL=legend('WTI','RAC','BRENT','Orientation','horizontal','FontSize',15);
legend('boxoff');
newPosition = [0.45 0.03 0.12 0.017];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);

rmpath('Results')