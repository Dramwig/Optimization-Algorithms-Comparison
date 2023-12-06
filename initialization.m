function Positions = initialization(SearchAgents_no,dim)
    weeks = dim/4;
    Positions=rand([SearchAgents_no,weeks*4]); %容器艇购买，丢弃；操作手购买，丢弃；
    Positions(1:SearchAgents_no,1:weeks)=Positions(1:SearchAgents_no,1:weeks)*20;
    Positions(1:SearchAgents_no,weeks*1+1:weeks*2)=Positions(1:SearchAgents_no,weeks*1+1:weeks*2)*2;
    Positions(1:SearchAgents_no,weeks*2+1)=Positions(1:SearchAgents_no,weeks*2+1)*35+25*ones([SearchAgents_no,1]);%第一个不能大于六十
    Positions(1:SearchAgents_no,weeks*2+2:weeks*3)=Positions(1:SearchAgents_no,weeks*2+2:weeks*3)*100;
    Positions(1:SearchAgents_no,weeks*3+1:weeks*4)=Positions(1:SearchAgents_no,weeks*3+1:weeks*4)*2;
    for i = 1:SearchAgents_no
        for j = 1:weeks*4
            Positions(i,j)=round(Positions(i,j));
        end
    end
end