#!/usr/bin/env python
# coding: utf-8

# In[36]:


network=  [ [0,1,0,2,0,0],
                    [1,0,2,4,3,0],
                    [0,2,0,0,1,4],
                    [2,4,0,0,6,0],
                    [0,3,1,6,0,2],
                    [0,0,4,0,2,0] ]

def Djs(network,s,d):
    print(" Start finding... ")
    path=[]                     #s-d最短路径
    n=len(network)                #邻接矩阵维数(也就是节点数量)
    
    sig=[0 for i in range(n)]     #标记列表(初始的时候大家都没被标记，都是0)
    sig[s-1]=1
    
    fmax=999                           #定义无穷大，不相邻的节点距离即为fmax
    dis=[fmax for i in range(n)]   #s到其他节点的最短距离
    par=[-1 for i in range(n)]        #父节点
    w=[[0 for i in range(n)] for j in range(n)]     
    
    for i in range(n):
        for j in range(n):
            if network[i][j]!=0:
                w[i][j]=network[i][j] #邻接矩阵转化成权值矩阵
            else:
                w[i][j]=fmax
            if i==s-1 and network[i][j]!=0:  #第一步 s的相邻的节点最短距离就是本身的直接距离
                dis[j]=network[i][j]
            
    for i in range(n-1):  #除了起始节点之外的节点遍历一下
        min=fmax #给最小值赋初值  后面不断更新
        for j in range(n):
            if sig[j]==0 and dis[j]<min:
                min=dis[j]
                u=j
        sig[u]=1  #将找到的当前遍历中的最小距离对应的点设置为已读
        for v in range(n):  #接下来遍历与节点u直连的节点
            if dis[v]>dis[u]+w[u][v]:
                dis[v]=dis[u]+w[u][v]  #把当前最短路径赋给当前节点的dis
                par[v]=u+1  #更新父节点
    j=d-1#j是序号
    path.append(d)
    while(par[j]!=-1):
            path.append(par[j])
            j=par[j]-1     #实际上是从终点倒着添加节点到path中去
    path.append(s)#再加入初始节点使路径完整
    path.reverse()#倒序回来 是路径变成正向的
    print(path)
    print(dis)
        

Djs(network,1,6)


# In[ ]:




