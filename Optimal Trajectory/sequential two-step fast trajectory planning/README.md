# Sequential two-step fast trajectory planning
The algorithm was built according to the reference: A Sequential Two-Step Algorithm for Fast Generation of Vehicle Racing Trajectories  
The convex solver is CVX based on Matlab.The official website is: http://cvxr.com/cvx/ Please install the cvx according to the operating system.

## function description
![image](https://github.com/CeHao1/Racing_Car/blob/master/Optimal%20Trajectory/sequential%20two-step%20fast%20trajectory%20planning/image/01.png)  
![image](https://github.com/CeHao1/Racing_Car/blob/master/Optimal%20Trajectory/sequential%20two-step%20fast%20trajectory%20planning/image/02.png)  

## inplementation
To implement the method, we need: 
1.Lateral Model  
2.Longitudinal Model  
3.Centerline Curvature  
4.Track Width  
### The alogorithm is from reference
![image](https://github.com/CeHao1/Racing_Car/blob/master/Optimal%20Trajectory/sequential%20two-step%20fast%20trajectory%20planning/image/1.png)  
## Results
### Typical C-shape curve
The figure below shows the planned optimal trajectory and the lap time at each iteration. The red o in the figure means start point.  
![image](https://github.com/CeHao1/Racing_Car/blob/master/Optimal%20Trajectory/sequential%20two-step%20fast%20trajectory%20planning/image/21.png)
![image](https://github.com/CeHao1/Racing_Car/blob/master/Optimal%20Trajectory/sequential%20two-step%20fast%20trajectory%20planning/image/22.png)  
### Typical S-shape curve
![image](https://github.com/CeHao1/Racing_Car/blob/master/Optimal%20Trajectory/sequential%20two-step%20fast%20trajectory%20planning/image/31.png)
![image](https://github.com/CeHao1/Racing_Car/blob/master/Optimal%20Trajectory/sequential%20two-step%20fast%20trajectory%20planning/image/32.png)  
## Analysis
This fast-generating algorithm is to derive the less curvature trajecotory rather than optimal lap time. So, I believe this can be a good initial value for the optimal time trajectory algorithm. Actually, the trajectory of human driver is not the same as optimal result, especially when drifting driving is condierded. The best way to reach the true time optimal trajecotry should consist heuristic exploration.
