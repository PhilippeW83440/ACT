# ACT

[//]: # (Image References)
[image1]: ./img/act.gif

<p align="center">
     <img src="./img/act.gif" alt="Anti-Collision Tests" width="100%" height="100%">
     <br>Anti-Collision Tests
</p>
  
The source of uncertainty that is currently modelled is related to sensor's uncertainty. But the main source of uncertainty is related to other agents intents and driving models.  
  
Depending on:  
* an agent intent  
* an agent driving or behavioral model  
* and contextual information (relative positions, speeds, geometry of the scene, rules and signalling)     
  
An agent in the scene will modify its acceleration. Predicting or anticipating how the surrounding agents could potentially modify their acceleration in the short-term future (up to a few seconds) is of paramount importance for safe driving.  


Possible improvements, Next steps:  
1) **Other agents' Behavioral Model Inference:**
* So far other agents in the scene evolve with constant velocity. Add support for IDM (depending on 5 parameters) to model different longitudinal acceleration models for the different agents.  Assume in a first step that intent is known: other cars are driving within a lane but driving according to an unknown (unknwon parameters) IDM model.
* Infer other agents driving model. Possible ways of doing this are:  
     - With simple DNN Neural Networks (taking into accout some history) or with RNN-LSTM Neural Networks specifically trained for IDM parameters inference  
     - With Variational Autoencoders: they enable to encode hidden variables. So they could be used in a more generic way (beyond some specific IDM or MOBIL models) to encode different  driving or behavioral models
     - With Bayesian Networks   
* Contextual information: unchanged so far, just the sensors fusion output (position+speed per object)  

=> Benchmark performances (safety metric with % of collisions, efficiency metric with time to goal, comfort metric with number of hard braking decisions) with no specific model, DNN model, RNN-LSTM model and Variational Autoencoders model used for non-ego behavioral models inference.  

2) **NN-Enhanced MCTS: by using a NN heuristic and/or NN rollout**   
Reuse ideas from AlphaGo Zero to self train a Neural Network to support and enhance the MCTS based Decision Making process.  
* Providing a heuristic: the first solution proposed online, could be based on a NN trained with RL model free method. This first proposal could be compared online against other possible solutions proposed via a MCTS/POMCP tree search. As MCTS is a sparse sampling method, it makes a lot sense to first "sample" what could potentially be the best solution based on a previous training. By re-using AlphaGo Zero ideas, this training could possibly be continuously improved online or in simulation.  
* Providing an alternative for the random rollout policy: which is used by default to estimate the Q-value of a node appended to the search tree  
  
In a first step just benchmark an RL model free method (pure NN) against an RL model based method (MCTS). Depending on the results, decide how to use it: as a heuristic, rollout ...      
