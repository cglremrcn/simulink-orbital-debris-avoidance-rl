clear agent; clear agentObj; clear obsInfo; clear actInfo;

% parameters
Ts = 0.1;           
x0 = 7000000;       
y0 = 0; vx0 = 0; vy0 = 7546;
mu = 3.986e14; m_sat = 1000; max_thrust = 10000;

% observation
obsInfo = rlNumericSpec([4 1]);
obsInfo.Name = 'Observation';

actInfo = rlNumericSpec([2 1]);
actInfo.Name = 'Action';
actInfo.LowerLimit = [-1; -pi]; 
actInfo.UpperLimit = [ 1;  pi];

% creating agent
agentObj = rlPPOAgent(obsInfo, actInfo);
agentObj.SampleTime = Ts; 

disp('--- agentObj BAŞARIYLA OLUŞTURULDU ---');