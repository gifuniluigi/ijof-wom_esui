%CSFE txt-sentiment (6-10) VS benchmark OLS

clear;clc;
addpath('Results')

load VARmspeSent

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

figure(23)
subplot(5,5,1)
plot(date,cumsum(-TfmtxVAR(1:end,1,1)+BenchVAR(1:end,1,1))/S,'linewidth',2)
hold on;
plot(date,cumsum(-TfmtxVAR(1:end,1,2)+BenchVAR(1:end,1,2))/S,'linewidth',2)
plot(date,cumsum(-TfmtxVAR(1:end,1,3)+BenchVAR(1:end,1,3))/S,'linewidth',2)
plot(date,zeros(size(date,1),1),'k--','linewidth',2)
grid minor
%ylim([-3 3])
set(gca,'xtick',h1);
set(gca,'YTick',-2:2:4)
datetick('x','yyyy','keepticks','keeplimits')
title('Sentiment tfm','FontSize',20);
subtitle('h = 1','FontWeight','bold','FontSize',Ft)

subplot(5,5,2)
plot(date,cumsum(-SeTfIdfVAR(1:end,1,1)+BenchVAR(1:end,1,1))/S,'linewidth',2)
hold on;
plot(date,cumsum(-SeTfIdfVAR(1:end,1,2)+BenchVAR(1:end,1,2))/S,'linewidth',2)
plot(date,cumsum(-SeTfIdfVAR(1:end,1,3)+BenchVAR(1:end,1,3))/S,'linewidth',2)
plot(date,zeros(size(date,1),1),'k--','linewidth',2)
grid minor
%ylim([-2 1])
set(gca,'xtick',h1);
%set(gca,'YTick',-5:2.5:5)
datetick('x','yyyy','keepticks','keeplimits')
title('Sentiment tf-idf','FontSize',20);
subtitle('h = 1','FontWeight','bold','FontSize',Ft)

subplot(5,5,3)
plot(date,cumsum(-VaderVAR(1:end,1,1)+BenchVAR(1:end,1,1))/S,'linewidth',2)
hold on;
plot(date,cumsum(-VaderVAR(1:end,1,2)+BenchVAR(1:end,1,2))/S,'linewidth',2)
plot(date,cumsum(-VaderVAR(1:end,1,3)+BenchVAR(1:end,1,3))/S,'linewidth',2)
plot(date,zeros(size(date,1),1),'k--','linewidth',2)
grid minor
%ylim([-2 1])
set(gca,'xtick',h1);
set(gca,'YTick',-10:2:2)
datetick('x','yyyy','keepticks','keeplimits')
title('VADER','FontSize',20);
subtitle('h = 1','FontWeight','bold','FontSize',Ft)

subplot(5,5,4)
plot(date,cumsum(-OpSenVAR(1:end,1,1)+BenchVAR(1:end,1,1))/S,'linewidth',2)
hold on;
plot(date,cumsum(-OpSenVAR(1:end,1,2)+BenchVAR(1:end,1,2))/S,'linewidth',2)
plot(date,cumsum(-OpSenVAR(1:end,1,3)+BenchVAR(1:end,1,3))/S,'linewidth',2)
plot(date,zeros(size(date,1),1),'k--','linewidth',2)
grid minor
%ylim([-2 1])
set(gca,'xtick',h1);
set(gca,'YTick',-5:2.5:5)
datetick('x','yyyy','keepticks','keeplimits')
title('Opinion Sentiment','FontSize',20);
subtitle('h = 1','FontWeight','bold','FontSize',Ft)

subplot(5,5,5)
plot(date,cumsum(-BertVAR(1:end,1,1)+BenchVAR(1:end,1,1))/S,'linewidth',2)
hold on;
plot(date,cumsum(-BertVAR(1:end,1,2)+BenchVAR(1:end,1,2))/S,'linewidth',2)
plot(date,cumsum(-BertVAR(1:end,1,3)+BenchVAR(1:end,1,3))/S,'linewidth',2)
plot(date,zeros(size(date,1),1),'k--','linewidth',2)
grid minor
%ylim([-3 3])
set(gca,'xtick',h1);
set(gca,'YTick',-2:2:10)
datetick('x','yyyy','keepticks','keeplimits')
title('BERT','FontSize',20);
subtitle('h = 1','FontWeight','bold','FontSize',Ft)

subplot(5,5,6)
plot(date(3:end,:),cumsum(-TfmtxVAR(1:end-2,3,1)+BenchVAR(1:end-2,3,1))/S,'linewidth',2)
hold on;
plot(date(3:end,:),cumsum(-TfmtxVAR(1:end-2,3,2)+BenchVAR(1:end-2,3,2))/S,'linewidth',2)
plot(date(3:end,:),cumsum(-TfmtxVAR(1:end-2,3,3)+BenchVAR(1:end-2,3,3))/S,'linewidth',2)
plot(date(3:end,:),zeros(size(date,1)-2,1),'k--','linewidth',2)
grid minor
%ylim([-1 4])
set(gca,'xtick',h3);
%set(gca,'YTick',0:2:4)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 3','FontSize',Ft)

subplot(5,5,7)
plot(date(3:end,:),cumsum(-SeTfIdfVAR(1:end-2,3,1)+BenchVAR(1:end-2,3,1))/S,'linewidth',2)
hold on;
plot(date(3:end,:),cumsum(-SeTfIdfVAR(1:end-2,3,2)+BenchVAR(1:end-2,3,2))/S,'linewidth',2)
plot(date(3:end,:),cumsum(-SeTfIdfVAR(1:end-2,3,3)+BenchVAR(1:end-2,3,3))/S,'linewidth',2)
plot(date(3:end,:),zeros(size(date,1)-2,1),'k--','linewidth',2)
grid minor
%ylim([-2 1])
set(gca,'xtick',h3);
%set(gca,'YTick',-1:1:1)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 3','FontSize',Ft)

subplot(5,5,8)
plot(date(3:end,:),cumsum(-VaderVAR(1:end-2,3,1)+BenchVAR(1:end-2,3,1))/S,'linewidth',2)
hold on;
plot(date(3:end,:),cumsum(-VaderVAR(1:end-2,3,2)+BenchVAR(1:end-2,3,2))/S,'linewidth',2)
plot(date(3:end,:),cumsum(-VaderVAR(1:end-2,3,3)+BenchVAR(1:end-2,3,3))/S,'linewidth',2)
plot(date(3:end,:),zeros(size(date,1)-2,1),'k--','linewidth',2)
grid minor
%ylim([-3 1])
set(gca,'xtick',h3);
%set(gca,'YTick',-2:1:1)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 3','FontSize',Ft)

subplot(5,5,9)
plot(date(3:end,:),cumsum(-OpSenVAR(1:end-2,3,1)+BenchVAR(1:end-2,3,1))/S,'linewidth',2)
hold on;
plot(date(3:end,:),cumsum(-OpSenVAR(1:end-2,3,2)+BenchVAR(1:end-2,3,2))/S,'linewidth',2)
plot(date(3:end,:),cumsum(-OpSenVAR(1:end-2,3,3)+BenchVAR(1:end-2,3,3))/S,'linewidth',2)
plot(date(3:end,:),zeros(size(date,1)-2,1),'k--','linewidth',2)
grid minor
%ylim([-2 1])
set(gca,'xtick',h3);
%set(gca,'YTick',-1:1:1)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 3','FontSize',Ft)

subplot(5,5,10)
plot(date(3:end,:),cumsum(-BertVAR(1:end-2,3,1)+BenchVAR(1:end-2,3,1))/S,'linewidth',2)
hold on;
plot(date(3:end,:),cumsum(-BertVAR(1:end-2,3,2)+BenchVAR(1:end-2,3,2))/S,'linewidth',2)
plot(date(3:end,:),cumsum(-BertVAR(1:end-2,3,3)+BenchVAR(1:end-2,3,3))/S,'linewidth',2)
plot(date(3:end,:),zeros(size(date,1)-2,1),'k--','linewidth',2)
grid minor
%ylim([-3 4])
set(gca,'xtick',h3);
%set(gca,'YTick',-2:2:4)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 3','FontSize',Ft)

subplot(5,5,11)
plot(date(6:end,:),cumsum(-TfmtxVAR(1:end-5,6,1)+BenchVAR(1:end-5,6,1))/S,'linewidth',2)
hold on;
plot(date(6:end,:),cumsum(-TfmtxVAR(1:end-5,6,2)+BenchVAR(1:end-5,6,2))/S,'linewidth',2)
plot(date(6:end,:),cumsum(-TfmtxVAR(1:end-5,6,3)+BenchVAR(1:end-5,6,3))/S,'linewidth',2)
plot(date(6:end,:),zeros(size(date,1)-5,1),'k--','linewidth',2)
grid minor
%ylim([-5 2])
set(gca,'xtick',h6);
%set(gca,'YTick',-4:2:2)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 6','FontSize',Ft)

subplot(5,5,12)
plot(date(6:end,:),cumsum(-SeTfIdfVAR(1:end-5,6,1)+BenchVAR(1:end-5,6,1))/S,'linewidth',2)
hold on;
plot(date(6:end,:),cumsum(-SeTfIdfVAR(1:end-5,6,2)+BenchVAR(1:end-5,6,2))/S,'linewidth',2)
plot(date(6:end,:),cumsum(-SeTfIdfVAR(1:end-5,6,3)+BenchVAR(1:end-5,6,3))/S,'linewidth',2)
plot(date(6:end,:),zeros(size(date,1)-5,1),'k--','linewidth',2)
grid minor
%ylim([-5 2])
set(gca,'xtick',h6);
%set(gca,'YTick',-4:2:2)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 6','FontSize',Ft)

subplot(5,5,13)
plot(date(6:end,:),cumsum(-VaderVAR(1:end-5,6,1)+BenchVAR(1:end-5,6,1))/S,'linewidth',2)
hold on;
plot(date(6:end,:),cumsum(-VaderVAR(1:end-5,6,2)+BenchVAR(1:end-5,6,2))/S,'linewidth',2)
plot(date(6:end,:),cumsum(-VaderVAR(1:end-5,6,3)+BenchVAR(1:end-5,6,3))/S,'linewidth',2)
plot(date(6:end,:),zeros(size(date,1)-5,1),'k--','linewidth',2)
grid minor
%ylim([-5 2])
set(gca,'xtick',h6);
%set(gca,'YTick',-5:2.5:5)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 6','FontSize',Ft)

subplot(5,5,14)
plot(date(6:end,:),cumsum(-OpSenVAR(1:end-5,6,1)+BenchVAR(1:end-5,6,1))/S,'linewidth',2)
hold on;
plot(date(6:end,:),cumsum(-OpSenVAR(1:end-5,6,2)+BenchVAR(1:end-5,6,2))/S,'linewidth',2)
plot(date(6:end,:),cumsum(-OpSenVAR(1:end-5,6,3)+BenchVAR(1:end-5,6,3))/S,'linewidth',2)
plot(date(6:end,:),zeros(size(date,1)-5,1),'k--','linewidth',2)
grid minor
%ylim([-5 2])
set(gca,'xtick',h6);
%set(gca,'YTick',-4:2:2)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 6','FontSize',Ft)

subplot(5,5,15)
plot(date(6:end,:),cumsum(-BertVAR(1:end-5,6,1)+BenchVAR(1:end-5,6,1))/S,'linewidth',2)
hold on;
plot(date(6:end,:),cumsum(-BertVAR(1:end-5,6,2)+BenchVAR(1:end-5,6,2))/S,'linewidth',2)
plot(date(6:end,:),cumsum(-BertVAR(1:end-5,6,3)+BenchVAR(1:end-5,6,3))/S,'linewidth',2)
plot(date(6:end,:),zeros(size(date,1)-5,1),'k--','linewidth',2)
grid minor
%ylim([-5 2])
set(gca,'xtick',h6);
%set(gca,'YTick',-4:2:2)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 6','FontSize',Ft)

subplot(5,5,16)
plot(date(12:end,:),cumsum(-TfmtxVAR(1:end-11,12,1)+BenchVAR(1:end-11,12,1))/S,'linewidth',2)
hold on;
plot(date(12:end,:),cumsum(-TfmtxVAR(1:end-11,12,2)+BenchVAR(1:end-11,12,2))/S,'linewidth',2)
plot(date(12:end,:),cumsum(-TfmtxVAR(1:end-11,12,3)+BenchVAR(1:end-11,12,3))/S,'linewidth',2)
plot(date(12:end,:),zeros(size(date,1)-11,1),'k--','linewidth',2)
grid minor
%ylim([-13 1])
set(gca,'xtick',h12);
%set(gca,'YTick',-10:5:0)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 12','FontSize',Ft)

subplot(5,5,17)
plot(date(12:end,:),cumsum(-SeTfIdfVAR(1:end-11,12,1)+BenchVAR(1:end-11,12,1))/S,'linewidth',2)
hold on;
plot(date(12:end,:),cumsum(-SeTfIdfVAR(1:end-11,12,2)+BenchVAR(1:end-11,12,2))/S,'linewidth',2)
plot(date(12:end,:),cumsum(-SeTfIdfVAR(1:end-11,12,3)+BenchVAR(1:end-11,12,3))/S,'linewidth',2)
plot(date(12:end,:),zeros(size(date,1)-11,1),'k--','linewidth',2)
grid minor
%ylim([-14 1])
set(gca,'xtick',h12);
%set(gca,'YTick',-10:5:0)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 12','FontSize',Ft)

subplot(5,5,18)
plot(date(12:end,:),cumsum(-VaderVAR(1:end-11,12,1)+BenchVAR(1:end-11,12,1))/S,'linewidth',2)
hold on;
plot(date(12:end,:),cumsum(-VaderVAR(1:end-11,12,2)+BenchVAR(1:end-11,12,2))/S,'linewidth',2)
plot(date(12:end,:),cumsum(-VaderVAR(1:end-11,12,3)+BenchVAR(1:end-11,12,3))/S,'linewidth',2)
plot(date(12:end,:),zeros(size(date,1)-11,1),'k--','linewidth',2)
grid minor
%ylim([-12 1])
set(gca,'xtick',h12);
%set(gca,'YTick',-10:5:0)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 12','FontSize',Ft)

subplot(5,5,19)
plot(date(12:end,:),cumsum(-OpSenVAR(1:end-11,12,1)+BenchVAR(1:end-11,12,1))/S,'linewidth',2)
hold on;
plot(date(12:end,:),cumsum(-OpSenVAR(1:end-11,12,2)+BenchVAR(1:end-11,12,2))/S,'linewidth',2)
plot(date(12:end,:),cumsum(-OpSenVAR(1:end-11,12,3)+BenchVAR(1:end-11,12,3))/S,'linewidth',2)
plot(date(12:end,:),zeros(size(date,1)-11,1),'k--','linewidth',2)
grid minor
%ylim([-14 1])
set(gca,'xtick',h12);
%set(gca,'YTick',-10:5:0)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 12','FontSize',Ft)

subplot(5,5,20)
plot(date(12:end,:),cumsum(-BertVAR(1:end-11,12,1)+BenchVAR(1:end-11,12,1))/S,'linewidth',2)
hold on;
plot(date(12:end,:),cumsum(-BertVAR(1:end-11,12,2)+BenchVAR(1:end-11,12,2))/S,'linewidth',2)
plot(date(12:end,:),cumsum(-BertVAR(1:end-11,12,3)+BenchVAR(1:end-11,12,3))/S,'linewidth',2)
plot(date(12:end,:),zeros(size(date,1)-11,1),'k--','linewidth',2)
grid minor
%ylim([-14 1])
set(gca,'xtick',h12);
%set(gca,'YTick',-10:5:0)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 12','FontSize',Ft)

subplot(5,5,21)
plot(date(24:end,:),cumsum(-TfmtxVAR(1:end-23,24,1)+BenchVAR(1:end-23,24,1))/S,'linewidth',2)
hold on;
plot(date(24:end,:),cumsum(-TfmtxVAR(1:end-23,24,2)+BenchVAR(1:end-23,24,2))/S,'linewidth',2)
plot(date(24:end,:),cumsum(-TfmtxVAR(1:end-23,24,3)+BenchVAR(1:end-23,24,3))/S,'linewidth',2)
plot(date(24:end,:),zeros(size(date,1)-23,1),'k--','linewidth',2)
grid minor
%ylim([-21 1])
set(gca,'xtick',h24);
%set(gca,'YTick',-20:10:0)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 24','FontSize',Ft)

subplot(5,5,22)
plot(date(24:end,:),cumsum(-SeTfIdfVAR(1:end-23,24,1)+BenchVAR(1:end-23,24,1))/S,'linewidth',2)
hold on;
plot(date(24:end,:),cumsum(-SeTfIdfVAR(1:end-23,24,2)+BenchVAR(1:end-23,24,2))/S,'linewidth',2)
plot(date(24:end,:),cumsum(-SeTfIdfVAR(1:end-23,24,3)+BenchVAR(1:end-23,24,3))/S,'linewidth',2)
plot(date(24:end,:),zeros(size(date,1)-23,1),'k--','linewidth',2)
grid minor
%ylim([-22 1])
set(gca,'xtick',h24);
%set(gca,'YTick',-20:10:0)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 24','FontSize',Ft)

subplot(5,5,23)
plot(date(24:end,:),cumsum(-VaderVAR(1:end-23,24,1)+BenchVAR(1:end-23,24,1))/S,'linewidth',2)
hold on;
plot(date(24:end,:),cumsum(-VaderVAR(1:end-23,24,2)+BenchVAR(1:end-23,24,2))/S,'linewidth',2)
plot(date(24:end,:),cumsum(-VaderVAR(1:end-23,24,3)+BenchVAR(1:end-23,24,3))/S,'linewidth',2)
plot(date(24:end,:),zeros(size(date,1)-23,1),'k--','linewidth',2)
grid minor
%ylim([-21 1])
set(gca,'xtick',h24);
%set(gca,'YTick',-20:10:0)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 24','FontSize',Ft)

subplot(5,5,24)
plot(date(24:end,:),cumsum(-OpSenVAR(1:end-23,24,1)+BenchVAR(1:end-23,24,1))/S,'linewidth',2)
hold on;
plot(date(24:end,:),cumsum(-OpSenVAR(1:end-23,24,2)+BenchVAR(1:end-23,24,2))/S,'linewidth',2)
plot(date(24:end,:),cumsum(-OpSenVAR(1:end-23,24,3)+BenchVAR(1:end-23,24,3))/S,'linewidth',2)
plot(date(24:end,:),zeros(size(date,1)-23,1),'k--','linewidth',2)
grid minor
%ylim([-22 1])
set(gca,'xtick',h24);
%set(gca,'YTick',-20:10:0)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 24','FontSize',Ft)

subplot(5,5,25)
plot(date(24:end,:),cumsum(-BertVAR(1:end-23,24,1)+BenchVAR(1:end-23,24,1))/S,'linewidth',2)
hold on;
plot(date(24:end,:),cumsum(-BertVAR(1:end-23,24,2)+BenchVAR(1:end-23,24,2))/S,'linewidth',2)
plot(date(24:end,:),cumsum(-BertVAR(1:end-23,24,3)+BenchVAR(1:end-23,24,3))/S,'linewidth',2)
plot(date(24:end,:),zeros(size(date,1)-23,1),'k--','linewidth',2)
grid minor
%ylim([-22 1])
set(gca,'xtick',h24);
%set(gca,'YTick',-20:10:0)
datetick('x','yyyy','keepticks','keeplimits')
title('h = 24','FontSize',Ft)

hL=legend('WTI','RAC','BRENT','Orientation','horizontal','FontSize',15);
legend('boxoff');
newPosition = [0.45 0.03 0.12 0.017];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);

rmpath('Results')