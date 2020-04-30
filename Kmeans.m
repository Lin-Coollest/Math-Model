clc,clear
%% 读取鸢尾花数据集（内置数据集
load fisheriris

%%%%包含的数据有以下两个部分
%%% 监测数据meas
%矩阵150*4
%每一行是一个观测结果
%每一列是一种特征属性
%4列如下：萼片长度、萼片宽度、花瓣长度、花瓣宽度

%%%种类标记
%species 是鸢尾花种类
%setosa 山鸢尾，versicolor 多的鸢尾，virginica 弗吉尼亚鸢尾

%% 二维数据(数据简介)
%这里抽取花瓣长度和花瓣宽度,分别对应meas矩阵中的3，4列
%第一幅图有贪色标记表示不同类别的鸢尾花
figure;
%提取了种类的数目进行分类标记
speciesNum = grp2idx(species);
gscatter(meas(:,3),meas(:,4),speciesNum,['r','g','b'])
xlabel('花瓣长度')
ylabel('花瓣宽度')
title('真实标记')%标题
set(gca,'FontSize',12)%字体大小
set(gca,'FontWeight','bold')%字体粗细

%第二幅图没有进行标记
figure;
scatter(meas(:,3),meas(:,4),150,'.')
xlabel('花瓣长度')
ylabel('花瓣宽度')
title('无标记')%标题
set(gca,'FontSize',12)%字体大小
set(gca,'FontWeight','bold')%字体粗细

%% K-means聚类
data=[meas(:,3),meas(:,4)]; %提取花瓣的两个特征列
k=3;    %定义分成的类别数
t=0;    %定义迭代次数
n=size(data,1);     %获取样本数目(data的行数)
cen=zeros(k,2);     %定义类别中心的坐标
sp=zeros(n,1);      %分类结果存储
cen_new=zeros(k,2);   %存储均值的矩阵(同时也是每次迭代中新生成的类中心)
A=[];   %ABC分别存储各个分类的行矩阵
B=[];
C=[];

%随机在data中确定k个初始的类中心点存在cen中
for i=1:k
    sj=randi(n);
    cen(i,1)=data(sj,1);
    cen(i,2)=data(sj,2);
end

%while循环不断迭代
while 1
    %计算每个样本点到类中心的欧氏距离，并将每个点指派到最近的那个中心的类别去
    for i=1:n
        %mins=((data(i,1)-cen(1,1))+(data(i,2)-cen(1,2))).^2;
        mins=norm(data(i,:)-cen(1,:))^2;   %先做一次给min赋初值(差的二范数平方表示欧氏距离)
        sp(i)=1;    %假定结果是分到第一类
        for j=2:k
            %dis=((data(i,1)-cen(j,1))+(data(i,2)-cen(j,2))).^2;
            dis=norm(data(i,:)-cen(j,:))^2;
            if dis < mins    %接下来不断比较当前的距离和min的大小
                mins=dis;   %更新最小值
                sp(i)=j;    %更新分类结果
            end
        end
    end

    %计算新分类结果的均值
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
    
%     fprintf('进行迭代次数为：%d\n', t);
    %判断两次的中心点相同即停止迭代
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





