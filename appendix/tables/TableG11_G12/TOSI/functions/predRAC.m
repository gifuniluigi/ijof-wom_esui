function[Y_pred] = predRAC(Ypred1,Ypred2,Ypred3,Ypred4,Ypred5)

Y_pred=zeros(size(Ypred1,1),size(Ypred1,2),size(Ypred1,3));
Y_pred(:,1,:)=Ypred1(:,1,:);
Y_pred(:,3,:)=Ypred2(:,3,:);
Y_pred(:,6,:)=(Ypred2(:,6,:)+Ypred3(:,6,:))/2;
Y_pred(:,12,:)=Ypred4(:,12,:);
Y_pred(:,24,:)=Ypred5(:,24,:);


