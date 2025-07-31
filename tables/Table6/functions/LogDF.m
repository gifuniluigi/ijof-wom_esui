function[TableDF, TableDM] = LogDF(M1, M2)

M1yhat = permute(M1.alpl,[1 3 2]);
M2yhat = permute(M2.alpl,[1 3 2]);

M1_yhat1  = M1yhat(:,:,1);          M2_yhat1  = M2yhat(:,:,1);
M1_yhat3  = M1yhat(1:end-2,:,3);    M2_yhat3  = M2yhat(1:end-2,:,3); 
M1_yhat6  = M1yhat(1:end-5,:,6);    M2_yhat6  = M2yhat(1:end-5,:,6); 
M1_yhat12 = M1yhat(1:end-11,:,12);  M2_yhat12 = M2yhat(1:end-11,:,12);
M1_yhat24 = M1yhat(1:end-23,:,24);  M2_yhat24 = M2yhat(1:end-23,:,24);

DM_L1  = zeros(3,1);
DM_L3  = zeros(3,1);
DM_L6  = zeros(3,1);
DM_L12 = zeros(3,1);
DM_L24 = zeros(3,1);

for i=1:3
    tempre = EvalFore([M1_yhat1(:,i), M2_yhat1(:,i)],2);
    DM_L1(i)  = [tempre.DM(2)];

    tempre = EvalFore([M1_yhat3(:,i), M2_yhat3(:,i)],2);
    DM_L3(i)  = [tempre.DM(2)];

    tempre = EvalFore([M1_yhat6(:,i), M2_yhat6(:,i)],2);
    DM_L6(i)  = [tempre.DM(2)];

    tempre = EvalFore([M1_yhat12(:,i), M2_yhat12(:,i)],2);
    DM_L12(i) = [tempre.DM(2)];

    tempre = EvalFore([M1_yhat24(:,i), M2_yhat24(:,i)],2);
    DM_L24(i) = [tempre.DM(2)];
end

TableDF = [round(mean(M1_yhat1(:,1))',3) round(mean(M1_yhat1(:,3))',3);
           round(mean(M2_yhat1(:,1))',3) round(mean(M2_yhat1(:,3))',3);
           round(mean(M1_yhat3(:,1))',3) round(mean(M1_yhat3(:,3))',3);
           round(mean(M2_yhat3(:,1))',3) round(mean(M2_yhat3(:,3))',3);
           round(mean(M1_yhat6(:,1))',3) round(mean(M1_yhat6(:,3))',3);
           round(mean(M2_yhat6(:,1))',3) round(mean(M2_yhat6(:,3))',3);
           round(mean(M1_yhat12(:,1))',3) round(mean(M1_yhat12(:,3))',3);
           round(mean(M2_yhat12(:,1))',3) round(mean(M2_yhat12(:,3))',3);
           round(mean(M1_yhat24(:,1))',3) round(mean(M1_yhat24(:,3))',3);
           round(mean(M2_yhat24(:,1))',3) round(mean(M2_yhat24(:,3))',3)];

ALPL = cat(2,num2str(TableDF(2,1)),' & ',num2str(TableDF(2,2)),' & ',...
      num2str(TableDF(4,1)),' & ',num2str(TableDF(4,2)),' & ',...
      num2str(TableDF(6,1)),' & ',num2str(TableDF(6,2)),' & ',...
      num2str(TableDF(8,1)),' & ',num2str(TableDF(8,2)),' & ',...
      num2str(TableDF(10,1)),' & ',num2str(TableDF(10,2)))

%Drop RAC values
DM_L1 = DM_L1([1 3],1);
DM_L3 = DM_L3([1 3],1);
DM_L6 = DM_L6([1 3],1);
DM_L12= DM_L12([1 3],1);
DM_L24= DM_L24([1 3],1);

TableDM = [DM_L1' DM_L3' DM_L6' DM_L12' DM_L24'];

TableDM(TableDM<=0.01)=3; TableDM(TableDM<=0.05)=2; TableDM(TableDM<=0.10)=1; TableDM(TableDM<1)=0;

DM_Test = TableDM

end