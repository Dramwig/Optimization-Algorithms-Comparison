function [Xbest, Scorebest,Convergence_curve] = AOA(Materials_no,Max_iter,fobj, dim,lb,ub,C3,C4)
% Initialization
C1=2;C2=6;
u=.9;l=.1;   %paramters in Eq. (12)
X=initialization(Materials_no,dim);%initial positions Eq. (4)
den=rand(Materials_no,dim); % Eq. (5)
vol=rand(Materials_no,dim);
acc=lb+rand(Materials_no,dim)*(ub-lb);% Eq. (6)
for i=1:Materials_no
    Y(i)=fobj(X(i,:));
end
[Scorebest, Score_index] = min(Y);
Xbest = X(Score_index,:);
den_best=den(Score_index,:);
vol_best=vol(Score_index,:);
acc_best=acc(Score_index,:);
acc_norm=acc;
for t = 1:Max_iter
    TF=exp(((t-Max_iter)/(Max_iter)));   % Eq. (8)
    if TF>1
        TF=1;
    end
    d=exp((Max_iter-t)/Max_iter)-(t/Max_iter); % Eq. (9)
    acc=acc_norm;
    r=rand();
    for i=1:Materials_no
        den(i,:)=den(i,:)+r*(den_best-den(i,:));   % Eq. (7)
        vol(i,:)=vol(i,:)+r*(vol_best-vol(i,:));
        if TF<.45%collision
            mr=randi(Materials_no);
            acc_temp(i,:)=(den(mr,:)+(vol(mr,:).*acc(mr,:)))./(rand*den(i,:).*vol(i,:));   % Eq. (10)
        else
            acc_temp(i,:)=(den_best+(vol_best.*acc_best))./(rand*den(i,:).*vol(i,:));   % Eq. (11)
        end
    end
    
    acc_norm=((u*(acc_temp-min(acc_temp(:))))./(max(acc_temp(:))-min(acc_temp(:))))+l;   % Eq. (12)
    
    for i=1:Materials_no
        if TF<.4
            for j=1:size(X,2)
                mrand=randi(Materials_no);
                Xnew(i,j)=X(i,j)+C1*rand*acc_norm(i,j).*(X(mrand,j)-X(i,j))*d;  % Eq. (13)
            end
        else
            for j=1:size(X,2)
                p=2*rand-C4;  % Eq. (15)
                T=C3*TF;
                if T>1
                    T=1;
                end
                if p<.5
                    Xnew(i,j)=Xbest(j)+C2*rand*acc_norm(i,j).*(T*Xbest(j)-X(i,j))*d;  % Eq. (14)
                else
                    Xnew(i,j)=Xbest(j)-C2*rand*acc_norm(i,j).*(T*Xbest(j)-X(i,j))*d;
                end
            end
        end
    end
    
    Xnew=fun_checkpositions(dim,Xnew,Materials_no,lb,ub);
    for i=1:Materials_no
        v=fobj( Xnew(i,:));
        if v<Y(i)
            X(i,:)=Xnew(i,:);
            Y (i)=v;
        end
        
    end
    [var_Ybest,var_index] = min(Y);
    Convergence_curve(t)=var_Ybest;
    if var_Ybest<Scorebest
        Scorebest=var_Ybest;
        Score_index=var_index;
        Xbest = X(var_index,:);
        den_best=den(Score_index,:);
        vol_best=vol(Score_index,:);
        acc_best=acc_norm(Score_index,:);
    end
    
end

end

function vec_pos=fun_checkpositions(dim,vec_pos,var_no_group,lb,ub)
Lb=lb*ones(1,dim);
Ub=ub*ones(1,dim);
for i=1:var_no_group
    isBelow1 = vec_pos(i,:) < Lb;
    isAboveMax = (vec_pos(i,:) > Ub);
    if isBelow1 == true
        vec_pos(i,:) =Lb;
    elseif find(isAboveMax== true)
        vec_pos(i,:) = Ub;
    end
end
end


