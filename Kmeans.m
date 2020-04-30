clc,clear
%% ��ȡ�β�����ݼ����������ݼ�
load fisheriris

%%%%������������������������
%%% �������meas
%����150*4
%ÿһ����һ���۲���
%ÿһ����һ����������
%4�����£���Ƭ���ȡ���Ƭ��ȡ����곤�ȡ�������

%%%������
%species ���β������
%setosa ɽ�β��versicolor ����β��virginica ���������β

%% ��ά����(���ݼ��)
%�����ȡ���곤�Ⱥͻ�����,�ֱ��Ӧmeas�����е�3��4��
%��һ��ͼ��̰ɫ��Ǳ�ʾ��ͬ�����β��
figure;
%��ȡ���������Ŀ���з�����
speciesNum = grp2idx(species);
gscatter(meas(:,3),meas(:,4),speciesNum,['r','g','b'])
xlabel('���곤��')
ylabel('������')
title('��ʵ���')%����
set(gca,'FontSize',12)%�����С
set(gca,'FontWeight','bold')%�����ϸ

%�ڶ���ͼû�н��б��
figure;
scatter(meas(:,3),meas(:,4),150,'.')
xlabel('���곤��')
ylabel('������')
title('�ޱ��')%����
set(gca,'FontSize',12)%�����С
set(gca,'FontWeight','bold')%�����ϸ

%% K-means����
data=[meas(:,3),meas(:,4)]; %��ȡ���������������
k=3;    %����ֳɵ������
t=0;    %�����������
n=size(data,1);     %��ȡ������Ŀ(data������)
cen=zeros(k,2);     %����������ĵ�����
sp=zeros(n,1);      %�������洢
cen_new=zeros(k,2);   %�洢��ֵ�ľ���(ͬʱҲ��ÿ�ε����������ɵ�������)
A=[];   %ABC�ֱ�洢����������о���
B=[];
C=[];

%�����data��ȷ��k����ʼ�������ĵ����cen��
for i=1:k
    sj=randi(n);
    cen(i,1)=data(sj,1);
    cen(i,2)=data(sj,2);
end

%whileѭ�����ϵ���
while 1
    %����ÿ�������㵽�����ĵ�ŷ�Ͼ��룬����ÿ����ָ�ɵ�������Ǹ����ĵ����ȥ
    for i=1:n
        %mins=((data(i,1)-cen(1,1))+(data(i,2)-cen(1,2))).^2;
        mins=norm(data(i,:)-cen(1,:))^2;   %����һ�θ�min����ֵ(��Ķ�����ƽ����ʾŷ�Ͼ���)
        sp(i)=1;    %�ٶ�����Ƿֵ���һ��
        for j=2:k
            %dis=((data(i,1)-cen(j,1))+(data(i,2)-cen(j,2))).^2;
            dis=norm(data(i,:)-cen(j,:))^2;
            if dis < mins    %���������ϱȽϵ�ǰ�ľ����min�Ĵ�С
                mins=dis;   %������Сֵ
                sp(i)=j;    %���·�����
            end
        end
    end

    %�����·������ľ�ֵ
    for i =1:n
       switch sp(i)
           case 1
               A=[A;data(i,:)];
               ua=mean(A);
               cen_new(sp(i),:)=ua;
           case 2
               B=[B;data(i,:)];
               ub=mean(B);
               cen_new(sp(i),:)=ub;
           case 3
               C=[C;data(i,:)];
               uc=mean(C);
               cen_new(sp(i),:)=uc;
           otherwise
       end
    end
    
%     fprintf('���е�������Ϊ��%d\n', t);
    %�ж����ε����ĵ���ͬ��ֹͣ����
%     res=norm(cen_new - cen );
%     if res < 1e-3
%         break;
%     end
%     if t==10
%         break;
%     else
%         cen=cen_new;
%     end
    if t==200
       break; 
    end
    t=t+1;
   
end





