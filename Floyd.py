#!/usr/bin/env python
# coding: utf-8

# # Floyd算法

# 先给定路径图（矩阵的形式，不相邻的就是inf）

# In[17]:


import numpy as np


# In[18]:


weight=np.array([
    [0,5,float('inf'),7],
    [float('inf'),0,4,2],
    [3,3,0,2],
    [float('inf'),float('inf'),1,0]
])


# 接下来创建一个零矩阵，维数等同于节点数

# In[19]:


n=4#节点数
dist=weight.copy()#复制一下边权值矩阵作为两点之间的距离矩阵
print(dist)

path=np.zeros((n,n))#路径存储
for i in range(n):
    for j in range(n):
        path[i,j]=-1
print(path)


# 接下来开始循环

# In[22]:


for k in range(n):
    for i in range(n):
        for j in range(n):
            if dist[i,j]>dist[i,k]+dist[k,j]:
                dist[i,j]=dist[i,k]+dist[k,j]
                path[i][j]=k


# 打印输出

# In[21]:


print(dist)
print(path)

