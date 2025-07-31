%This script generates Figure 3
% For best results, run the code on a Windows laptop, this will ensure the 
% event labels align exactly as they do in the manuscript. The code will also 
% execute on macOS, but you may notice that some event labels aren’t perfectly aligned.

clear; clc;

addpath('Results')
addpath('Functions')

dated = {'01-Jan-1982','1-Jun-2021'}; %sample period: 1982M01-2021M06

load BertFtTr
load VaderFtTr
bstvar = [BertFtTr VaderFtTr];

Sentiment = standardize(bstvar);
[~,Tosi,~,~] = getPCA(Sentiment,1);

%PCA
Tosi=Tosi*(-1);
Tosi=normalize(Tosi);
Tosi=Tosi*100 + 100;

t = datemnth(dated{1}, (0: months(dated{:}))');
t = datetime(t,'ConvertFrom','datenum');
% Oil events
[~,m1]=intersect(t,'01-Apr-1983');  % Missile Attacks on Iran
[~,m2]=intersect(t,'01-Sep-1984');  % Civilian target truce Iran-Iraq War
[~,m3]=intersect(t,'01-Aug-1989'); % OPEC raises production
[~,m4]=intersect(t,'01-Aug-1990');  % First Gulf War
[~,m5]=intersect(t,'01-Dec-1991');  % Soviet Union Collapse
[~,m6]=intersect(t,'01-Mar-1996');  % Sea Empress Recovery
[~,m7]=intersect(t,'01-Jul-1997');  % Kazakhstan enters oil market
[~,m8]=intersect(t,'01-Jan-1998');  % Asian economic crisis
[~,m9]=intersect(t,'01-Aug-1998');  % Oil Price Crisis
[~,m10]=intersect(t,'01-Jan-2001');  % OPEC's Cut
[~,m11]=intersect(t,'01-Sep-2001');  % 9/11 Attack
[~,m12]=intersect(t,'01-Jan-2003'); % Iraq War
[~,m13]=intersect(t,'01-Nov-2008'); % Global Financial Crisis
[~,m14]=intersect(t,'01-Nov-2010'); % Deepwater Horizon oil spill recovery
[~,m15]=intersect(t,'01-Jun-2016'); % Venezuelan Protests
[~,m16]=intersect(t,'01-May-2020'); % COVID - 19

% Recessions
[~,m17]=intersect(t,'01-Jan-1982');%1
[~,m18]=intersect(t,'01-Nov-1982');%1
[~,m19]=intersect(t,'01-Jul-1990');%2
[~,m20]=intersect(t,'01-Mar-1991');%2
[~,m21]=intersect(t,'01-Mar-2001');%3
[~,m22]=intersect(t,'01-Nov-2001');%3
[~,m23]=intersect(t,'01-Dec-2007');%4
[~,m24]=intersect(t,'01-Jun-2009');%4
[~,m25]=intersect(t,'01-Feb-2020');%5
[~,m26]=intersect(t,'01-Apr-2020');%5

x=[t(m17,1), t(m17,1), t(m18,1), t(m18,1),...
    t(m19,1), t(m19,1), t(m20,1), t(m20,1),...
    t(m21,1), t(m21,1), t(m22,1), t(m22,1),...
    t(m23,1), t(m23,1), t(m24,1), t(m24,1),...
    t(m25,1), t(m25,1), t(m26,1), t(m26,1)];   

y=[-400, 400, 400, -400,...
    -400, 400, 400, -400,...
    -400, 400, 400, -400,...
    -400, 400, 400, -400,...
    -400, 400, 400, -400];  
Front1=13;
Front2=14;
Front3=15;

Col1='r';
Col2=[0 0.4470 0.7410];
Col3=[.7 .7 .7];

figure(5)
a = fill(x, y, Col3,'FaceAlpha',0.4,'LineStyle',"none");
hold on
plot(t,Tosi,'Color',[0 0 0],'LineWidth',2)
title('TOSI','FontSize',26,'Color','k')
ylim([-400 400])
set(gca,'YTick',-400:100:400)
set(gca,'FontSize',20)

% yyaxis right


txt1 = {'Missile attacks';'on Iran'};
text(t(m1+8,1),-90,txt1,'FontSize',Front1,'HorizontalAlignment','center','Color',Col1); 
anArrow8 = annotation('arrow');
anArrow8.Position = [0.167, 0.455, -0.013, 0.028] ;

txt2 = {'Civilian target truce';'Iran-Iraq War'};
text(t(m2-5,1),325,txt2,'FontSize',Front1,'HorizontalAlignment','center','Color',Col2); 
anArrow8 = annotation('arrow');
anArrow8.Position = [0.175, 0.815, 0.000, -0.027] ;

txt3 = {'OPEC raises';'oil production'}; 
text(t(m3,1),335,txt3,'FontSize',Front2,'HorizontalAlignment','center','Color',Col2); 
anArrow8 = annotation('arrow');
anArrow8.Position = [0.279, 0.830, 0.000, -0.022] ;

txt4 = {'First Gulf';'War'};
text(t(m4-36,1),-200,txt4,'FontSize',Front3,'HorizontalAlignment','center','Color',Col1); 
anArrow8 = annotation('arrow');
anArrow8.Position = [0.265, 0.337, 0.028, 0.044] ;

txt5 = {'Soviet Union';'collapse'}; 
text(t(m5+1,1),-299,txt5,'FontSize',Front2,'HorizontalAlignment','center','Color',Col1); 
anArrow8 = annotation('arrow');
anArrow8.Position = [0.328, 0.250, 0, 0.150] ;

txt6 = {'Sea Empress';'recovery'}; 
text(t(m6-29,1),325,txt6,'FontSize',Front3,'HorizontalAlignment','center','Color',Col2);
anArrow8 = annotation('arrow');
anArrow8.Position = [0.387, 0.830, 0.0160, 0.000] ;

txt7 = {'Kazakhstan enters';'oil market'};
text(t(m7+20,1),322,txt7,'FontSize',Front2,'HorizontalAlignment','center','Color',Col2); 
anArrow8 = annotation('arrow');
anArrow8.Position = [0.447, 0.820, -0.015, -0.020] ;

txt8 = {'Asian';'economic';'crisis'};
text(t(m8-29,1),-61,txt8,'FontSize',Front2,'HorizontalAlignment','center','Color',Col1); 
anArrow8 = annotation('arrow');
anArrow8.Position = [0.418, 0.430, 0.020, 0.000] ;

txt9 = {'Oil Price';'crisis'};
text(t(m9-30,1),-160,txt9,'FontSize',Front3,'HorizontalAlignment','center','Color',Col1); 
anArrow8 = annotation('arrow');
anArrow8.Position = [0.430, 0.350, 0.020, 0.000] ;

txt10 = {'OPEC''s cut'};
text(t(m10-5,1),-200,txt10,'FontSize',Front1,'HorizontalAlignment','center','Color',Col1,'Rotation',90); 
anArrow8 = annotation('arrow');
anArrow8.Position = [0.497, 0.380, 0, 0.030] ;

txt11 = {'9/11 attack'}; 
text(t(m11-1,1),-320,txt11,'FontSize',Front3,'HorizontalAlignment','center','Color',Col1,'Rotation',90); 
anArrow8 = annotation('arrow');
anArrow8.Position = [0.517, 0.255, 0, 0.030] ;

txt12 = 'Iraq War';
text(t(m12+30,1),-183,txt12,'FontSize',Front3,'HorizontalAlignment','center','Color',Col1); 
anArrow8 = annotation('arrow');
anArrow8.Position = [0.570, 0.330, -0.017, 0.000] ;

txt13 = {'Great';'Recession'}; 
text(t(m13,1),-300,txt13,'FontSize',Front3,'HorizontalAlignment','center','Color',Col1); 
anArrow8 = annotation('arrow');
anArrow8.Position = [0.656, 0.240, 0.000, 0.040] ;

txt14 = {'Deepwater Horizon';'oil spill recovery'};
text(t(m14,1),335,txt14,'FontSize',Front2,'HorizontalAlignment','center','Color',Col2);
anArrow8 = annotation('arrow');
anArrow8.Position = [0.697, 0.830, 0.000, -0.022] ;

txt15 = {'Venezuelan';'protests'}; 
text(t(m15-45,1),-198,txt15,'FontSize',Front1,'HorizontalAlignment','center','Color',Col1); 
anArrow8 = annotation('arrow');
anArrow8.Position = [0.759, 0.340, 0.020, 0.055] ;

txt16 = 'COVID - 19'; 
text(t(m16-36,1),-290,txt16,'FontSize',Front3,'HorizontalAlignment','center','Color',Col1);
anArrow8 = annotation('arrow');
anArrow8.Position = [0.860, 0.220, 0.014, 0.000] ;
grid on

rmpath('Results')
rmpath('Functions')
