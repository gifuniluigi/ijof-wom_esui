%CSFE TOSI vs RW and TOSI vs Benchmark

clear; clc;

% Add path to functions
addpath('Results')

load msfeBenchSVBVAR
load msfeRW
load msfeTOSI

date = {'01-Jan-2001','30-Jun-2021'};
date = datemnth(date{1}, (0: months(date{:}))');
date = datetime(date,'ConvertFrom','datenum');
Ysize = 50;
Ft = 100;
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
% For example run from line 32 to 41 to get plot (1,1) of Figure 4.
figure(4)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TOSI vs RW %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(date,cumsum(-msfeTOSI(1:end,1,1)+msfeRW(1:end,1,1))/10^6,'Color', wti_col,'linewidth',lw)
hold on;
plot(date,cumsum(-msfeTOSI(1:end,1,3)+msfeRW(1:end,1,3))/10^6,'Color', brent_col,'linewidth',lw)
plot(date,zeros(size(date,1),1),'k--','linewidth',2)
grid minor
ylim([-0.5 4])
set(gca,'xtick',h1,'FontSize',Ysize);
% set(gca,'YTick',0:1:1,'FontSize',Ysize)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 1','FontSize',Ft)

plot(date(3:end,:),cumsum(-msfeTOSI(1:end-2,3,1)+msfeRW(1:end-2,3,1))/10^6,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(3:end,:),cumsum(-msfeTOSI(1:end-2,3,3)+msfeRW(1:end-2,3,3))/10^6,'Color', brent_col,'linewidth',lw)
plot(date(3:end,:),zeros(size(date,1)-2,1),'k--','linewidth',2)
grid minor
ylim([-4.5 15])
set(gca,'xtick',h3,'FontSize',Ysize);
set(gca,'YTick',0:5:15)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 3','FontSize',Ft)

plot(date(6:end,:),cumsum(-msfeTOSI(1:end-5,6,1)+msfeRW(1:end-5,6,1))/10^6,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(6:end,:),cumsum(-msfeTOSI(1:end-5,6,3)+msfeRW(1:end-5,6,3))/10^6,'Color', brent_col,'linewidth',lw)
plot(date(6:end,:),zeros(size(date,1)-5,1),'k--','linewidth',2)
grid minor
ylim([-9.5 25])
set(gca,'xtick',h6,'FontSize',Ysize);
set(gca,'YTick',-5:5:25)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 6','FontSize',Ft)

plot(date(12:end,:),cumsum(-msfeTOSI(1:end-11,12,1)+msfeRW(1:end-11,12,1))/10^6,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(12:end,:),cumsum(-msfeTOSI(1:end-11,12,3)+msfeRW(1:end-11,12,3))/10^6,'Color', brent_col,'linewidth',lw)
plot(date(12:end,:),zeros(size(date,1)-11,1),'k--','linewidth',2)
grid minor
ylim([-17 40])
set(gca,'xtick',h12,'FontSize',Ysize);
set(gca,'YTick',-10:10:40)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 12','FontSize',Ft)

plot(date(24:end,:),cumsum(-msfeTOSI(1:end-23,24,1)+msfeRW(1:end-23,24,1))/10^6,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(24:end,:),cumsum(-msfeTOSI(1:end-23,24,3)+msfeRW(1:end-23,24,3))/10^6,'Color', brent_col,'linewidth',lw)
plot(date(24:end,:),zeros(size(date,1)-23,1),'k--','linewidth',2)
grid minor
ylim([-45 63])
set(gca,'xtick',h24,'FontSize',Ysize);
set(gca,'YTick',-40:20:60)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 24','FontSize',Ft)

%%%%%%%%%%%%%%%%%%%%%%%%%% TOSI vs Benchmark %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(date,cumsum(-msfeTOSI(1:end,1,1)+msfeBenchSVBVAR(1:end,1,1))/10^5,'Color', wti_col,'linewidth',lw)
hold on;
plot(date,cumsum(-msfeTOSI(1:end,1,3)+msfeBenchSVBVAR(1:end,1,3))/10^5,'Color', brent_col,'linewidth',lw)
plot(date,zeros(size(date,1),1),'k--','linewidth',2)
grid minor
ylim([-1 10])
set(gca,'xtick',h1,'FontSize',Ysize);
% set(gca,'YTick',0:1:3,'FontSize',Ysize)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 1','FontSize',Ft)

plot(date(3:end,:),cumsum(-msfeTOSI(1:end-2,3,1)+msfeBenchSVBVAR(1:end-2,3,1))/10^5,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(3:end,:),cumsum(-msfeTOSI(1:end-2,3,3)+msfeBenchSVBVAR(1:end-2,3,3))/10^5,'Color', brent_col,'linewidth',lw)
plot(date(3:end,:),zeros(size(date,1)-2,1),'k--','linewidth',2)
grid minor
ylim([-15 40])
set(gca,'xtick',h3,'FontSize',Ysize);
% set(gca,'YTick',0:5:15,'FontSize',Ysize)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 3','FontSize',Ft)

plot(date(6:end,:),cumsum(-msfeTOSI(1:end-5,6,1)+msfeBenchSVBVAR(1:end-5,6,1))/10^5,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(6:end,:),cumsum(-msfeTOSI(1:end-5,6,3)+msfeBenchSVBVAR(1:end-5,6,3))/10^5,'Color', brent_col,'linewidth',lw)
plot(date(6:end,:),zeros(size(date,1)-5,1),'k--','linewidth',2)
grid minor
ylim([-18 70])
set(gca,'xtick',h6,'FontSize',Ysize);
% set(gca,'YTick',0:1:3,'FontSize',Ysize)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 6','FontSize',Ft)

plot(date(12:end,:),cumsum(-msfeTOSI(1:end-11,12,1)+msfeBenchSVBVAR(1:end-11,12,1))/10^5,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(12:end,:),cumsum(-msfeTOSI(1:end-11,12,3)+msfeBenchSVBVAR(1:end-11,12,3))/10^5,'Color', brent_col,'linewidth',lw)
plot(date(12:end,:),zeros(size(date,1)-11,1),'k--','linewidth',2)
grid minor
ylim([-15 200])
set(gca,'xtick',h12,'FontSize',Ysize);
set(gca,'YTick',0:50:200)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 12','FontSize',Ft)

plot(date(24:end,:),cumsum(-msfeTOSI(1:end-23,24,1)+msfeBenchSVBVAR(1:end-23,24,1))/10^5,'Color', wti_col,'linewidth',lw)
hold on;
plot(date(24:end,:),cumsum(-msfeTOSI(1:end-23,24,3)+msfeBenchSVBVAR(1:end-23,24,3))/10^5,'Color', brent_col,'linewidth',lw)
plot(date(24:end,:),zeros(size(date,1)-23,1),'k--','linewidth',2)
grid minor
ylim([-40 100])
set(gca,'xtick',h24,'FontSize',Ysize);
set(gca,'YTick',-25:25:100)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 24','FontSize',Ft)

hL=legend('WTI','RAC','BRENT','Orientation','horizontal','FontSize',15);
legend('boxoff');
newPosition = [0.45 0.03 0.12 0.017];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);

rmpath('Results')