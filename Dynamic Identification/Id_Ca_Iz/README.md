# Parameter identification for Ca and Iz
Here I introduce a method to identify two important parameters in lateral dynamic model only by kinetic data. 
The speficic dynamic model and identification method are presented in the document. Besides, I provid a matlab function with cvx to 
implement this algorithm

## lateral dynamic model
![image](https://github.com/CeHao1/Racing_Car/blob/master/Dynamic%20Identification/Id_Ca_Iz/image/1.png)
### (1)	vehicle dynamic
![image](https://github.com/CeHao1/Racing_Car/blob/master/Dynamic%20Identification/Id_Ca_Iz/image/2.png)  
derive lateral force (combined wheels)  
![image](https://github.com/CeHao1/Racing_Car/blob/master/Dynamic%20Identification/Id_Ca_Iz/image/3.png)
### (2)	slip angle
![image](https://github.com/CeHao1/Racing_Car/blob/master/Dynamic%20Identification/Id_Ca_Iz/image/4.png)  
combine into bicycle  
![image](https://github.com/CeHao1/Racing_Car/blob/master/Dynamic%20Identification/Id_Ca_Iz/image/5.png)  
the following two figures show the slip angle of four wheels and its combined value. The blue line is the real slip angle. The red line is derived value by the formula   
![image](https://github.com/CeHao1/Racing_Car/blob/master/Dynamic%20Identification/Id_Ca_Iz/image/6.png)
![image](https://github.com/CeHao1/Racing_Car/blob/master/Dynamic%20Identification/Id_Ca_Iz/image/7.png)
### (3)	lateral tire dynamic
small angle linear model  
![image](https://github.com/CeHao1/Racing_Car/blob/master/Dynamic%20Identification/Id_Ca_Iz/image/8.png)  
tanh model  
![image](https://github.com/CeHao1/Racing_Car/blob/master/Dynamic%20Identification/Id_Ca_Iz/image/9.png)
Where, Fy denotes the lateral of a single wheel, not a combined wheel.  

## 2. Para Id of C_α and I_zz. 
Slow speed and steering angle ensure linear lateral dynamic  
### (1) linear Cα fit
![image](https://github.com/CeHao1/Racing_Car/blob/master/Dynamic%20Identification/Id_Ca_Iz/image/10.png)  
add two equations:  
![image](https://github.com/CeHao1/Racing_Car/blob/master/Dynamic%20Identification/Id_Ca_Iz/image/11.png)
### (2) Iz fit
![image](https://github.com/CeHao1/Racing_Car/blob/master/Dynamic%20Identification/Id_Ca_Iz/image/12.png) 
Finally, I adopt the least square to fit the linear tire model with side slip angle and later force. Then, the Iz is identified by least square as well. The following two figures express the result of indentification.  
![image](https://github.com/CeHao1/Racing_Car/blob/master/Dynamic%20Identification/Id_Ca_Iz/image/13.png)
![image](https://github.com/CeHao1/Racing_Car/blob/master/Dynamic%20Identification/Id_Ca_Iz/image/14.png)
