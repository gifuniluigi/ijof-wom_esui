txt1={'1-month','ahead'};
txt2={'3-months','ahead'};
txt3={'6-months','ahead'};
X = categorical({'1','3','6'});%,'12','24'
X = reordercats(X,{'1','3','6'});%,'12','24'
FntAx = 40;
FntLbl = 50;
FntST = 44;
Pos = [0.13 0.890 0.775 0.070]; %0.046
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% 1-variable SVBVAR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Y = [MSPE(1,1,2) MSPE(1,1,1); MSPE(2,1,2) MSPE(2,1,1); MSPE(3,1,2) MSPE(3,1,1)];%; MSPE(4,1,1) MSPE(4,1,2); MSPE(5,1,1) MSPE(5,1,2)
b=bar(X,Y,'BarWidth', 1.5,'FaceColor','flat');
set(b(1,1),'FaceColor',"#800E34")
set(b(1,2),'FaceColor',"#CA8946")
ylim([0 1.2])
set(gca,'YTick',0:1:1.5)
set(gca,'FontSize',FntAx)
ylabel('WTI','FontWeight','bold','FontSize',FntLbl)
grid on
yline(1,'--k','LineWidth',2);
annotation('textbox',Pos,'String','  One-variable  SV-BVAR','FontSize',FntST,'Color','white','BackgroundColor','#000000','EdgeColor','none')

Y = [MSPE(1,2,1) MSPE(1,2,2); MSPE(2,2,1) MSPE(2,2,2); MSPE(3,2,1) MSPE(3,2,2)];%; MSPE(4,2,1) MSPE(4,2,2); MSPE(5,2,1) MSPE(5,2,2)
b=bar(X,Y,'BarWidth', 1.5,'FaceColor','flat');
set(b(1,1),'FaceColor',"#800E34")
set(b(1,2),'FaceColor',"#CA8946")
ylim([0 1.2])
set(gca,'YTick',0:1:1.5)
set(gca,'FontSize',FntAx)
ylabel('RAC','FontWeight','bold','FontSize',FntLbl)
grid on
yline(1,'--k','LineWidth',2);
annotation('textbox',Pos,'String','  One-variable  SV-BVAR','FontSize',FntST,'Color','white','BackgroundColor','#000000','EdgeColor','none')
% hL1=legend({'$\hspace{1pt}\textnormal{No-TOSI}$','$\hspace{1pt}\textnormal{With}$ $\textnormal{TOSI}$'},'Orientation','horizontal',...
%     'NumColumns',3,'FontSize',50,'Interpreter','latex');
% legend('boxoff');
% newPosition = [0.5 0.960 0.12 0.017];
% newUnits = 'normalized';
% set(hL1,'Position', newPosition,'Units', newUnits);

Y = [MSPE(1,3,1) MSPE(1,3,2); MSPE(2,3,1) MSPE(2,3,2); MSPE(3,3,1) MSPE(3,3,2)];%; MSPE(4,3,1) MSPE(4,3,2); MSPE(5,3,1) MSPE(5,3,2)
b=bar(X,Y,'BarWidth', 1.5,'FaceColor','flat');
set(b(1,1),'FaceColor',"#800E34")
set(b(1,2),'FaceColor',"#CA8946")
ylim([0 1.2])
set(gca,'YTick',0:1:1.5)
set(gca,'FontSize',FntAx)
ylabel('BRENT','FontWeight','bold','FontSize',FntLbl)
grid on
yline(1,'--k','LineWidth',2);
annotation('textbox',Pos,'String','  One-variable  SV-BVAR','FontSize',FntST,'Color','white','BackgroundColor','#000000','EdgeColor','none')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% 2-variable SVBVAR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Y = [MSPE(1,1,3) MSPE(1,1,4); MSPE(2,1,3) MSPE(2,1,4); MSPE(3,1,3) MSPE(3,1,4)];%; MSPE(4,1,3) MSPE(4,1,4); MSPE(5,1,3) MSPE(5,1,4)
b=bar(X,Y,'BarWidth', 1.5,'FaceColor','flat');
set(b(1,1),'FaceColor',"#1E3D59")
set(b(1,2),'FaceColor',"#A38C9C")
ylim([0 1.2])
set(gca,'YTick',0:1:1.5)
set(gca,'FontSize',FntAx)
ylabel('WTI','FontWeight','bold','FontSize',FntLbl)
grid on
yline(1,'--k','LineWidth',2);
annotation('textbox',Pos,'String','  Two-variable  SV-BVAR','FontSize',FntST,'Color','white','BackgroundColor','#000000','EdgeColor','none')

Y = [MSPE(1,2,3) MSPE(1,2,4); MSPE(2,2,3) MSPE(2,2,4); MSPE(3,2,3) MSPE(3,2,4)];%; MSPE(4,2,3) MSPE(4,2,4); MSPE(5,2,3) MSPE(5,2,4)
b=bar(X,Y,'BarWidth', 1.5,'FaceColor','flat');
set(b(1,1),'FaceColor',"#1E3D59")
set(b(1,2),'FaceColor',"#A38C9C")
ylim([0 1.2])
set(gca,'YTick',0:1:1.5)
set(gca,'FontSize',FntAx)
ylabel('RAC','FontWeight','bold','FontSize',FntLbl)
grid on
yline(1,'--k','LineWidth',2);
annotation('textbox',Pos,'String','  Two-variable  SV-BVAR','FontSize',FntST,'Color','white','BackgroundColor','#000000','EdgeColor','none')

Y = [MSPE(1,3,3) MSPE(1,3,4); MSPE(2,3,3) MSPE(2,3,4); MSPE(3,3,3) MSPE(3,3,4)];%; MSPE(4,3,3) MSPE(4,3,4); MSPE(5,3,3) MSPE(5,3,4)
b=bar(X,Y,'BarWidth', 1.5,'FaceColor','flat');
set(b(1,1),'FaceColor',"#1E3D59")
set(b(1,2),'FaceColor',"#A38C9C")
ylim([0 1.2])
set(gca,'YTick',0:1:1.5)
set(gca,'FontSize',FntAx)
ylabel('BRENT','FontWeight','bold','FontSize',FntLbl)
grid on
yline(1,'--k','LineWidth',2);
annotation('textbox',Pos,'String','  Two-variable  SV-BVAR','FontSize',FntST,'Color','white','BackgroundColor','#000000','EdgeColor','none')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% 3-variable SVBVAR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Y = [MSPE(1,1,5) MSPE(1,1,6); MSPE(2,1,5) MSPE(2,1,6); MSPE(3,1,5) MSPE(3,1,6)];%; MSPE(4,1,5) MSPE(4,1,6); MSPE(5,1,5) MSPE(5,1,6)
b=bar(X,Y,'BarWidth', 1.5,'FaceColor','flat');
set(b(1,1),'facecolor','#003300') 
set(b(1,2),'facecolor','#CCCCCC')
ylim([0 1.2])
set(gca,'YTick',0:1:1.5)
set(gca,'FontSize',FntAx)
ylabel('WTI','FontWeight','bold','FontSize',FntLbl)
grid on
yline(1,'--k','LineWidth',2);
annotation('textbox',Pos,'String','  Three-variable  SV-BVAR','FontSize',FntST,'Color','white','BackgroundColor','#000000','EdgeColor','none')

Y = [MSPE(1,2,5) MSPE(1,2,6); MSPE(2,2,5) MSPE(2,2,6); MSPE(3,2,5) MSPE(3,2,6)];%; MSPE(4,2,5) MSPE(4,2,6); MSPE(5,2,5) MSPE(5,2,6)
b=bar(X,Y,'BarWidth', 1.5,'FaceColor','flat');
set(b(1,1),'facecolor','#003300') 
set(b(1,2),'facecolor','#CCCCCC')
ylim([0 1.2])
set(gca,'YTick',0:1:1.5)
set(gca,'FontSize',FntAx)
ylabel('RAC','FontWeight','bold','FontSize',FntLbl)
grid on
yline(1,'--k','LineWidth',2);
annotation('textbox',Pos,'String','  Three-variable  SV-BVAR','FontSize',FntST,'Color','white','BackgroundColor','#000000','EdgeColor','none')

Y = [MSPE(1,3,5) MSPE(1,3,6); MSPE(2,3,5) MSPE(2,3,6); MSPE(3,3,5) MSPE(3,3,6)];%; MSPE(4,3,5) MSPE(4,3,6); MSPE(5,3,5) MSPE(5,3,6)
b=bar(X,Y,'BarWidth', 1.5,'FaceColor','flat');
set(b(1,1),'facecolor','#003300') 
set(b(1,2),'facecolor','#CCCCCC')
ylim([0 1.2])
set(gca,'YTick',0:1:1.5)
set(gca,'FontSize',FntAx)
ylabel('BRENT','FontWeight','bold','FontSize',FntLbl)
grid on
yline(1,'--k','LineWidth',2);
annotation('textbox',Pos,'String','  Three-variable  SV-BVAR','FontSize',FntST,'Color','white','BackgroundColor','#000000','EdgeColor','none')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% 4-variable SVBVAR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Y = [MSPE(1,1,7) MSPE(1,1,8); MSPE(2,1,7) MSPE(2,1,8); MSPE(3,1,7) MSPE(3,1,8)];%; MSPE(4,1,7) MSPE(4,1,8); MSPE(5,1,7) MSPE(5,1,8)
b=bar(X,Y,'BarWidth', 1.5,'FaceColor','flat');
set(b(1,1),'facecolor','#367588') 
set(b(1,2),'facecolor','#CDE6CD')
ylim([0 1.2])
set(gca,'YTick',0:1:1.5)
set(gca,'FontSize',FntAx)
ylabel('WTI','FontWeight','bold','FontSize',FntLbl)
grid on
yline(1,'--k','LineWidth',2);
annotation('textbox',Pos,'String','  Four-variable  SV-BVAR','FontSize',FntST,'Color','white','BackgroundColor','#000000','EdgeColor','none')

Y = [MSPE(1,2,7) MSPE(1,2,8); MSPE(2,2,7) MSPE(2,2,8); MSPE(3,2,7) MSPE(3,2,8)];%; MSPE(4,2,7) MSPE(4,2,8); MSPE(5,2,7) MSPE(5,2,8)
b=bar(X,Y,'BarWidth', 1.5,'FaceColor','flat');
set(b(1,1),'facecolor','#367588') 
set(b(1,2),'facecolor','#CDE6CD')
ylim([0 1.2])
set(gca,'YTick',0:1:1.5)
set(gca,'FontSize',FntAx)
ylabel('RAC','FontWeight','bold','FontSize',FntLbl)
grid on
yline(1,'--k','LineWidth',2);
annotation('textbox',Pos,'String','  Four-variable  SV-BVAR','FontSize',FntST,'Color','white','BackgroundColor','#000000','EdgeColor','none')

Y = [MSPE(1,3,7) MSPE(1,3,8); MSPE(2,3,7) MSPE(2,3,8); MSPE(3,3,7) MSPE(3,3,8)];%; MSPE(4,3,7) MSPE(4,3,8); MSPE(5,3,7) MSPE(5,3,8)
b=bar(X,Y,'BarWidth', 1.5,'FaceColor','flat');
set(b(1,1),'facecolor','#367588') 
set(b(1,2),'facecolor','#CDE6CD')
ylim([0 1.2])
set(gca,'YTick',0:1:1.5)
set(gca,'FontSize',FntAx)
ylabel('BRENT','FontWeight','bold','FontSize',FntLbl)
grid on
yline(1,'--k','LineWidth',2);
annotation('textbox',Pos,'String','  Four-variable  SV-BVAR','FontSize',FntST,'Color','white','BackgroundColor','#000000','EdgeColor','none')
