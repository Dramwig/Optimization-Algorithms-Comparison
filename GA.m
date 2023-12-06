function [best_v,best_gen,Convergence_curve]=GA(SearchAgents_no,Max_iter,dim,fobj)
    log_v=[];log_w=[];log_r=[];
    best_gen=[];best_v=90000000;best_w=0;
    %初始化
    gen=initialization(SearchAgents_no,dim);
    %开始迭代
    t=1;%迭代次数
    r=10;
    gen_new=gen;
    while t<=Max_iter
        %disp(['r:',num2str(r)]);
        t=t+1;
        gen = gen_new;
        %计算 目标函数值 竞争优度
        v=[];w=[];
        for i = 1:SearchAgents_no
            v(i)=fobj(gen(i,:));
        end
        w=ones([1,SearchAgents_no])*sum(v)./v;
        %最优解替换
        for i = 1:SearchAgents_no
            if v(i)<best_v
                best_v=v(i);
                best_w=w(i);
                best_gen=gen(i,:);
                new=1; %有新的最优解产生
            end
        end
        %记录
        log_v(end+1)=best_v;
        log_w(end+1)=best_w;
        log_r(end+1)=r;
        %轮盘选择choose的权重w
        w=w/sum(w);
        %多次交配、变异、产生子代
        for o = 1:SearchAgents_no/2
            %选择两个个体
            p1=choose(w);p2=choose(w);
            g1=gen(p1,:);g2=gen(p2,:);
            %交配
            q_rand = rand();
            if q_rand<0.9 && p1~=p2
                ran1 = randi([1,size(gen,2)]);
                ran2 = randi([1,size(gen,2)]);
                if ran1 > ran2 %让 ran1<ran2
                    k = ran1;
                    ran1 = ran2;
                    ran2 = k;
                end
                %交叉互换
                for i = ran1:ran2 
                    k=g1(i);
                    g1(i)=g2(i);
                    g2(i)=k;
                end
    
            end
            %变异1：单点变异
            q_rand = rand();
            if(q_rand<0.5)
                ran1 = randi([1,size(gen,2)]);
                g1(ran1)=g1(ran1)+round((rand-0.5)*r);%温度加权!
            end
            q_rand = rand();
            if(q_rand<0.5)
                ran1 = randi([1,size(gen,2)]);
                g2(ran1)=g2(ran1)+round((rand-0.5)*r);%温度加权!
            end
            %变异2：区间变异
            q_rand = rand();
            if(q_rand<0.2)
                ran1 = randi([1,size(gen,2)]);
                ran2 = ran1+round(randi([0,size(gen,2)-ran1])*rand);
                q_rand = rand()/2+0.75;
                for i = ran1:ran2 
                    g1(i)=round(round(g1(i)*q_rand));
                end
            end
            %变异3：区间变异
            q_rand = rand();
            if(q_rand<0.2)
                ran1 = randi([1,size(gen,2)]);
                ran2 = ran1+round(randi([0,size(gen,2)-ran1])*rand);
                for i = ran1:ran2 
                    g2(i)=g2(i)+round((rand-0.5)*(rand+0.5)*r*2);%温度加权!
                end
            end
            %变异4：区间变异
            q_rand = rand();
            if(q_rand<0.1)
                ran1 = randi([1,size(gen,2)]);
                ran2 = ran1+round(randi([0,size(gen,2)-ran1])*rand*rand);
                q_rand = round((rand-0.5)*r);%温度加权!
                for i = ran1:ran2 
                    g2(i)=g2(i)+q_rand;
                end
            end
            %存储为下一代 
            gen_new(o*2-1,:)=g1;
            gen_new(o*2,:)=g2;
            %加入最优解
            w=ones(size(w))./w; %概率翻转
            w=w/sum(w);
            gen(choose(w),:)=best_gen;
        end
        %输出
%         if new==1
%             new=0;
%             disp([num2str(t),': ',num2str(best_v),' T:',num2str(r)]);
%         end
    end
    
%     save best_ans best_gen best_v best_w; %保存答案
%     clear g1 g2 i j k new q_rand r t v w weeks o p1 p2 ran1 ran2;
%     
%     disp(['ans:',num2str(best_v)]);
%     figure(1);
%     subplot(1,3,1);
%         plot(log_v);
%         title('目标函数值变化曲线');
%         xlabel('遗传代数');
%         ylabel('目标函数值');
%     subplot(1,3,2);
%         plot(log_w);
%         title('最优子代在种群中的竞争力曲线');
%         xlabel('遗传代数');
%         ylabel('竞争优度');
%     subplot(1,3,3);
%         plot(log_r);
%         title('淬火温度曲线');
%         xlabel('遗传代数');
%         ylabel('淬炼温度');
%    save log log_v log_w log_r; %保存迭代数据
    Convergence_curve =  log_v;
end

function p = choose(w)
    %轮盘选择 w为权重
    %w=[0.5,1]
    q=w(1);
    for i = 2:size(w,2)
        q(i)=q(i-1)+w(i);%累积概率
    end
    q_rand = rand();
        k=1;%为选择的路径编号
        for i = 1:size(w,2)
            if q_rand>q(i)
                k=i+1;
            end
        end
    p=k;
end



