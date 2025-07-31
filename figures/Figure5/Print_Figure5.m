%%% This file produces the results reported in Figure 5

clear;
clc;

% Add path to functions
addpath('functions');
MSPE=zeros(3,3,2);

for i=1:8
    load (sprintf('SVBVARcmb%d.mat',i))
    % compute and display MSPEs
    MSPE(:,:,i)=print_MSPE(msfe);
end

txt1={'1-month','ahead'};
txt2={'3-months','ahead'};
txt3={'6-months','ahead'};
X = categorical({'1','3','6'});%,'12','24'
X = reordercats(X,{'1','3','6'});%,'12','24'
FntAx = 40;
FntLbl = 50;
FntST = 44;
Pos = [0.13 0.890 0.775 0.070]; %0.046

% Figures saved individually, do not run all sections in one go.
% For best results, run the code on a Windows laptop, this will ensure the 
% sides of plots align exactly as they do in the manuscript. The code will also 
% execute on macOS, but you may notice that titles and plots aren’t perfectly aligned.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% 1-variable SVBVAR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Y = [MSPE(1,1,2) MSPE(1,1,1); MSPE(2,1,2) MSPE(2,1,1); MSPE(3,1,2) MSPE(3,1,1)];
b=bar(X,Y,'BarWidth', 1.5,'FaceColor','flat');
set(b(1,1),'FaceColor',"#CA8946")
set(b(1,2),'FaceColor',"#800E34")
ylim([0 1.2])
set(gca,'YTick',0:1:1.5)
set(gca,'FontSize',FntAx)
ylabel('WTI','FontWeight','bold','FontSize',FntLbl)
grid on
yline(1,'--k','LineWidth',2);
annotation('textbox',Pos,'String','  1- vs. 2-variable SV-BVAR (with TOSI)','FontSize',FntST,'Color','white','BackgroundColor','#000000','EdgeColor','none')

Y = [MSPE(1,2,2) MSPE(1,2,1); MSPE(2,2,2) MSPE(2,2,1); MSPE(3,2,2) MSPE(3,2,1)];
b=bar(X,Y,'BarWidth', 1.5,'FaceColor','flat');
set(b(1,1),'FaceColor',"#CA8946")
set(b(1,2),'FaceColor',"#800E34")
ylim([0 1.2])
set(gca,'YTick',0:1:1.5)
set(gca,'FontSize',FntAx)
ylabel('RAC','FontWeight','bold','FontSize',FntLbl)
grid on
yline(1,'--k','LineWidth',2);
annotation('textbox',Pos,'String','  1- vs. 2-variable SV-BVAR (with TOSI)','FontSize',FntST,'Color','white','BackgroundColor','#000000','EdgeColor','none')

Y = [MSPE(1,3,2) MSPE(1,3,1); MSPE(2,3,2) MSPE(2,3,1); MSPE(3,3,2) MSPE(3,3,1)];
b=bar(X,Y,'BarWidth', 1.5,'FaceColor','flat');
set(b(1,1),'FaceColor',"#CA8946")
set(b(1,2),'FaceColor',"#800E34")
ylim([0 1.2])
set(gca,'YTick',0:1:1.5)
set(gca,'FontSize',FntAx)
ylabel('BRENT','FontWeight','bold','FontSize',FntLbl)
grid on
yline(1,'--k','LineWidth',2);
annotation('textbox',Pos,'String','  1- vs. 2-variable SV-BVAR (with TOSI)','FontSize',FntST,'Color','white','BackgroundColor','#000000','EdgeColor','none')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% 2-variable SVBVAR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Y = [MSPE(1,1,4) MSPE(1,1,3); MSPE(2,1,4) MSPE(2,1,3); MSPE(3,1,4) MSPE(3,1,3)];
b=bar(X,Y,'BarWidth', 1.5,'FaceColor','flat');
set(b(1,1),'FaceColor',"#367588")
set(b(1,2),'FaceColor',"#8B3675")
ylim([0 1.2])
set(gca,'YTick',0:1:1.5)
set(gca,'FontSize',FntAx)
ylabel('WTI','FontWeight','bold','FontSize',FntLbl)
grid on
yline(1,'--k','LineWidth',2);
annotation('textbox',Pos,'String','  2- vs. 3-variable SV-BVAR (with TOSI)','FontSize',FntST,'Color','white','BackgroundColor','#000000','EdgeColor','none')

Y = [MSPE(1,2,4) MSPE(1,2,3); MSPE(2,2,4) MSPE(2,2,3); MSPE(3,2,4) MSPE(3,2,3)];
b=bar(X,Y,'BarWidth', 1.5,'FaceColor','flat');
set(b(1,1),'FaceColor',"#367588")
set(b(1,2),'FaceColor',"#8B3675")
ylim([0 1.2])
set(gca,'YTick',0:1:1.5)
set(gca,'FontSize',FntAx)
ylabel('RAC','FontWeight','bold','FontSize',FntLbl)
grid on
yline(1,'--k','LineWidth',2);
annotation('textbox',Pos,'String','  2- vs. 3-variable SV-BVAR (with TOSI)','FontSize',FntST,'Color','white','BackgroundColor','#000000','EdgeColor','none')

Y = [MSPE(1,3,4) MSPE(1,3,3); MSPE(2,3,4) MSPE(2,3,3); MSPE(3,3,4) MSPE(3,3,3)];
b=bar(X,Y,'BarWidth', 1.5,'FaceColor','flat');
set(b(1,1),'FaceColor',"#367588")
set(b(1,2),'FaceColor',"#8B3675")
ylim([0 1.2])
set(gca,'YTick',0:1:1.5)
set(gca,'FontSize',FntAx)
ylabel('BRENT','FontWeight','bold','FontSize',FntLbl)
grid on
yline(1,'--k','LineWidth',2);
annotation('textbox',Pos,'String','  2- vs. 3-variable SV-BVAR (with TOSI)','FontSize',FntST,'Color','white','BackgroundColor','#000000','EdgeColor','none')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% 3-variable SVBVAR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Y = [MSPE(1,1,6) MSPE(1,1,5); MSPE(2,1,6) MSPE(2,1,5); MSPE(3,1,6) MSPE(3,1,5)];
b=bar(X,Y,'BarWidth', 1.5,'FaceColor','flat');
set(b(1,1),'facecolor',"#CCCCCC") 
set(b(1,2),'facecolor',"#003300")
ylim([0 1.2])
set(gca,'YTick',0:1:1.5)
set(gca,'FontSize',FntAx)
ylabel('WTI','FontWeight','bold','FontSize',FntLbl)
grid on
yline(1,'--k','LineWidth',2);
annotation('textbox',Pos,'String','  3- vs. 4-variable SV-BVAR (with TOSI)','FontSize',FntST,'Color','white','BackgroundColor','#000000','EdgeColor','none')

Y = [MSPE(1,2,6) MSPE(1,2,5); MSPE(2,2,6) MSPE(2,2,5); MSPE(3,2,6) MSPE(3,2,5)];
b=bar(X,Y,'BarWidth', 1.5,'FaceColor','flat');
set(b(1,1),'facecolor',"#CCCCCC") 
set(b(1,2),'facecolor',"#003300")
ylim([0 1.2])
set(gca,'YTick',0:1:1.5)
set(gca,'FontSize',FntAx)
ylabel('RAC','FontWeight','bold','FontSize',FntLbl)
grid on
yline(1,'--k','LineWidth',2);
annotation('textbox',Pos,'String','  3- vs. 4-variable SV-BVAR (with TOSI)','FontSize',FntST,'Color','white','BackgroundColor','#000000','EdgeColor','none')

Y = [MSPE(1,3,6) MSPE(1,3,5); MSPE(2,3,6) MSPE(2,3,5); MSPE(3,3,6) MSPE(3,3,5)];
b=bar(X,Y,'BarWidth', 1.5,'FaceColor','flat');
set(b(1,1),'facecolor',"#CCCCCC") 
set(b(1,2),'facecolor',"#003300")
ylim([0 1.2])
set(gca,'YTick',0:1:1.5)
set(gca,'FontSize',FntAx)
ylabel('BRENT','FontWeight','bold','FontSize',FntLbl)
grid on
yline(1,'--k','LineWidth',2);
annotation('textbox',Pos,'String','  3- vs. 4-variable SV-BVAR (with TOSI)','FontSize',FntST,'Color','white','BackgroundColor','#000000','EdgeColor','none')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% 4-variable SVBVAR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Y = [MSPE(1,1,8) MSPE(1,1,7); MSPE(2,1,8) MSPE(2,1,7); MSPE(3,1,8) MSPE(3,1,7)];
b=bar(X,Y,'BarWidth', 1.5,'FaceColor','flat');
set(b(1,1),'facecolor',"#1E3D59")
set(b(1,2),'facecolor',"#A38C9C") 
ylim([0 1.2])
set(gca,'YTick',0:1:1.5)
set(gca,'FontSize',FntAx)
ylabel('WTI','FontWeight','bold','FontSize',FntLbl)
grid on
yline(1,'--k','LineWidth',2);
annotation('textbox',Pos,'String','  4- vs. 5-variable SV-BVAR (with TOSI)','FontSize',FntST,'Color','white','BackgroundColor','#000000','EdgeColor','none')

Y = [MSPE(1,2,8) MSPE(1,2,7); MSPE(2,2,8) MSPE(2,2,7); MSPE(3,2,8) MSPE(3,2,7)];
b=bar(X,Y,'BarWidth', 1.5,'FaceColor','flat');
set(b(1,1),'facecolor',"#1E3D59")
set(b(1,2),'facecolor',"#A38C9C") 
ylim([0 1.2])
set(gca,'YTick',0:1:1.5)
set(gca,'FontSize',FntAx)
ylabel('RAC','FontWeight','bold','FontSize',FntLbl)
grid on
yline(1,'--k','LineWidth',2);
annotation('textbox',Pos,'String','  4- vs. 5-variable SV-BVAR (with TOSI)','FontSize',FntST,'Color','white','BackgroundColor','#000000','EdgeColor','none')

Y = [MSPE(1,3,8) MSPE(1,3,7); MSPE(2,3,8) MSPE(2,3,7); MSPE(3,3,8) MSPE(3,3,7)];
b=bar(X,Y,'BarWidth', 1.5,'FaceColor','flat');
set(b(1,1),'facecolor',"#1E3D59")
set(b(1,2),'facecolor',"#A38C9C") 
ylim([0 1.2])
set(gca,'YTick',0:1:1.5)
set(gca,'FontSize',FntAx)
ylabel('BRENT','FontWeight','bold','FontSize',FntLbl)
grid on
yline(1,'--k','LineWidth',2);
annotation('textbox',Pos,'String','  4- vs. 5-variable SV-BVAR (with TOSI)','FontSize',FntST,'Color','white','BackgroundColor','#000000','EdgeColor','none')

%close path
rmpath('functions');