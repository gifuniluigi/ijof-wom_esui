%% ROC AUROC Brent 1-month ahead forecast

clear; clc;

% Add path to functions
addpath('data');

% Sample forecast and actual values
Sp = readtable('Sp.csv');       Sp = table2array(Sp(:,2));
Se = readtable('Se.csv');       Se = table2array(Se(:,2));
SpT = readtable('SpT.csv');     SpT = table2array(SpT(:,2));
SeT = readtable('SeT.csv');     SeT = table2array(SeT(:,2));
SpK = readtable('SpK.csv');     SpK = table2array(SpK(:,2));
SeK = readtable('SeK.csv');     SeK = table2array(SeK(:,2));
SpKT = readtable('SpKT.csv');   SpKT = table2array(SpKT(:,2));
SeKT = readtable('SeKT.csv');   SeKT = table2array(SeKT(:,2));

GvsBKLauroc = readtable('GvsBKLauroc.csv');   GvsBKLauroc = table2array(GvsBKLauroc(:,2));
BKLauroc = readtable('BKLauroc.csv');         BKLauroc = table2array(BKLauroc(:,2));
GvsKauroc = readtable('GvsKauroc.csv');       GvsKauroc = table2array(GvsKauroc(:,2));
Kauroc = readtable('Kauroc.csv');             Kauroc = table2array(Kauroc(:,2));

date = {'01-Jan-2001','1-Jun-2021'};
t = datemnth(date{1}, (0: months(date{:}))');
t = datetime(t,'ConvertFrom','datenum');
rw = 48;
Col3 = [.7 .7 .7];

%Recessions
[~,m1]=intersect(t,'01-Apr-2008');%1
[~,m2]=intersect(t,'01-Jul-2009');%1
[~,m3]=intersect(t,'01-Jul-2011');%2
[~,m4]=intersect(t,'01-Apr-2013');%2
[~,m5]=intersect(t,'01-Jan-2020');%3
[~,m6]=intersect(t,'01-Jun-2020');%3

x=[t(m1,1), t(m1,1), t(m2,1), t(m2,1),...
   t(m3,1), t(m3,1), t(m4,1), t(m4,1),...
   t(m5,1), t(m5,1), t(m6,1), t(m6,1)];   

y=[0, 1, 1, 0,...
   0, 1, 1, 0,...
   0, 1, 1, 0];


figure;
subplot(3,2,1)
plot(1-SpT, SeT, 'LineWidth', 3,'Color',"#1E3D59"); hold on;
plot(1-Sp, Se, 'LineWidth', 3,'Color',"#A38C9C"); hold on; hold on;
plot([0 1],[0 1],'LineWidth', 3,'Color','red','LineStyle','--')
xlabel({'FP rate';''},'FontSize',20);
ylabel({'TP rate';''},'FontSize',20);
title('ROC curves','FontSize',20);
legend({'SVBVAR with WIP & TOSI','SVBVAR with WIP','45° benchmark line'},'Location','southeast','FontSize',10);
grid on 
grid minor

subplot(3,2,2)
plot(1-SpKT, SeKT, 'LineWidth', 3,'Color',"#1E3D59"); hold on;
plot(1-SpK, SeK, 'LineWidth', 3,'Color',"#A38C9C"); hold on; hold on;
plot([0 1],[0 1],'LineWidth', 3,'Color','red','LineStyle','--')
xlabel({'FP rate';''},'FontSize',20);
ylabel({'TP rate';''},'FontSize',20);
title('ROC curves','FontSize',20);
legend({'SVBVAR with REA & TOSI','SVBVAR with REA','45° benchmark line'},'Location','southeast','FontSize',10);
grid on 
grid minor

subplot(3,2,3:4)
a = fill(x, y, Col3,'FaceAlpha',0.4,'LineStyle',"none"); hold on
plot(t(rw+1:end), GvsBKLauroc, 'LineWidth', 3,'Color',"#1E3D59", 'LineStyle', '--', 'Marker','x'); hold on;
plot(t(rw+1:end), BKLauroc, 'LineWidth', 3,'Color',"#A38C9C", 'LineStyle', '--', 'Marker','x');hold on;
qw{1} = plot(nan, 'LineStyle','-','Marker','x','LineWidth', 3,'Color',"#1E3D59");
qw{2} = plot(nan, 'LineStyle','-','Marker','x','LineWidth', 3,'Color',"#A38C9C");
ylabel({'AUROC';''},'FontSize',20);
ylim([0.35 0.75])
set(gca,'YTick',0.3:0.1:0.7)
legend([qw{:}],{'SVBVAR with WIP & TOSI','SVBVAR with WIP'},'Location','southeast','FontSize',15);
ax = gca;
ax.XAxis.FontWeight='bold';
ax.XAxis.FontSize=15;
grid on 
grid minor

subplot(3,2,5:6)
b = fill(x, y, Col3,'FaceAlpha',0.4,'LineStyle',"none"); hold on
plot(t(rw+1:end), GvsKauroc, 'LineWidth', 3,'Color',"#1E3D59", 'LineStyle', '--', 'Marker','x'); hold on;
plot(t(rw+1:end), Kauroc, 'LineWidth', 3,'Color',"#A38C9C", 'LineStyle', '--', 'Marker','x');hold on;
qw{1} = plot(nan, 'LineStyle','-','Marker','x','LineWidth', 3,'Color',"#1E3D59");
qw{2} = plot(nan, 'LineStyle','-','Marker','x','LineWidth', 3,'Color',"#A38C9C");
ylabel({'AUROC';''},'FontSize',20);
ylim([0.27 0.75])
set(gca,'YTick',0.3:0.1:0.7)
legend([qw{:}],{'SVBVAR with REA & TOSI','SVBVAR with REA'},'Location','southeast','FontSize',15);
ax = gca;
ax.XAxis.FontWeight='bold';
ax.XAxis.FontSize=15;
grid on 
grid minor

%close path
rmpath('data');
