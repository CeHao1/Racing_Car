# tanh tire model
## Introduction
Tire dynamic model is the key for racing vehicle control. Especially at very high speed, the tire works in the nonlinear or saturate area, where the vehicle easily gets slip and out of control. So, here I propose a very simple model that can well fit the tire lateral dynamic model, which is called tanh tire model. The tanh tire model can work as well as brush tire and require less computation.  
Now I submitted a paper named Parameter Identification of Racing Vehicle Dynamic Model based on Forgetting Factor-Recursive Least Square  
More detail can be found in link https://github.com/CeHao1/papers/blob/master/conference/Parameter%20Identification%20of%20Racing%20Vehicle%20Dynamic%20Model%20based%20on%20Forgetting%20Factor-Recursive%20Least%20Square.pdf  
## Method
### Traditional Tire Model
Nowadays, there are three standard tire models including linear model, magic formula (Pacejka’s model) and brush tire model (Fiala tire model). The first linear model is not accurate at high speed or large slip angle for its saturation. Besides, magic formula is a well fitted empirical model but has too many coefficients. The last brush tire is derived physically while sometime it’s not corresponding to real data. Because wheel load Fz and friction ratio µ are different between theory and reality.  
Therefore, I proposed another tire model named tanh tire model that can easily derive the lateral tire dynamic.  
### tanh tire model
First of all, we need to compute the slip angle and lateral force according to lateral dynamic. Here I adopt the bicycle to derive the variables.  
![image](https://github.com/CeHao1/Racing_Car/blob/master/Dynamic%20Identification/tanh%20model/image/1.png)  
Then, we can use tanh model to fit the tire dynamic. The formation of tanh model is quite simple  
![image](https://github.com/CeHao1/Racing_Car/blob/master/Dynamic%20Identification/tanh%20model/image/2.png)  
Where, Fy and α denote lateral force and slip angle of front and rear force respectively. Two coefficients A and k denote the saturation and scale parameters. Here I adopt least square method to fit the model.  
![image](https://github.com/CeHao1/Racing_Car/blob/master/Dynamic%20Identification/tanh%20model/image/2.5.png)  
## Result
### Static experiments in Simulink/ Carsim
To verify the tanh model, I firstly implemented a simulation in Simulink/ Carsim and compare it with brush tire model.  
![image](https://github.com/CeHao1/Racing_Car/blob/master/Dynamic%20Identification/tanh%20model/image/3.png)  
The result shows that tanh model can work as well as brush tire model and require only two parameters.
### Real racing car experiment
Later, I collected the data from a real racing car Mazda Roadster in racing track at high speed (150km/h) and used the tanh model to fit. Here are the results:  
![image](https://github.com/CeHao1/Racing_Car/blob/master/Dynamic%20Identification/tanh%20model/image/4.jpg)  
![image](https://github.com/CeHao1/Racing_Car/blob/master/Dynamic%20Identification/tanh%20model/image/5.jpg)  
It’s easy to find that the lateral dynamic has a strong saturation characteristic, however tanh model can fit this well. It’s true that different car or tire have different tire model, while the tanh tire model can be adjusted by online method which I state in the reference by iterative least square.  
## Summary
The tanh tire model is an empirical tire model with a simple formation. It can well simulate the lateral tire force for racing car at high speed. In a single run, it’s better to use tanh model to compute lateral force and then update the coefficient after a period of time.

