# Pure Pursuit Controller
## Vehicle kinetic model 
Firstly, we consider the Ackermann turning for kinetic  
![image](https://github.com/CeHao1/Racing_Car/blob/master/Controller/pure%20pursuit/image/1.png)  
The movement can be expressed as  
![image](https://github.com/CeHao1/Racing_Car/blob/master/Controller/pure%20pursuit/image/2.png)  
Where, L denotes wheel base and R the turning radius. δ denotes steering angle.  
## Pursuit model
Here we need plan a trajectory at first and find the target point, which the vehicle should always pursuit.  
![image](https://github.com/CeHao1/Racing_Car/blob/master/Controller/pure%20pursuit/image/3.png)  
The lookahead distance in the graph is ld and the target point is (gx,gy)  
By law of sin, we can deduce the following formula:  
![image](https://github.com/CeHao1/Racing_Car/blob/master/Controller/pure%20pursuit/image/4.png)  
Combine the Ackermann turning formula and pursuit formula, we have:  
![image](https://github.com/CeHao1/Racing_Car/blob/master/Controller/pure%20pursuit/image/5.png)  
However, how to define and select the lookahead distance ld is important. The higher velocity, the farther distance should be predicted. Therefore, we introduce the dynamic lookahead distance Lf  
![image](https://github.com/CeHao1/Racing_Car/blob/master/Controller/pure%20pursuit/image/6.png)  
Where, L0 denotes a basic distance and kx denotes a coefficient that amplify the distance according to velocity. If the vehicle runs in higher speed, the lookahead distance will be higher correspondingly. 

## Demo
Let's watch a video of the application of pure pursuit
https://www.youtube.com/watch?v=aVt3t_vjC1w
