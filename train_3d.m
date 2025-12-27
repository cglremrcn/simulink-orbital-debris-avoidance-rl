

clear all; close all; clc;


%% PARAMETRELER
agent_installation;

%% MODEL
mdl = 'RL_Satellite_Model';
agentBlk = [mdl '/RL Agent'];

if ~bdIsLoaded(mdl)
    load_system(mdl);
end

% Gercek zamanli izleme
set_param(mdl, 'EnablePacing', 'on');
set_param(mdl, 'PacingRate', '20');  % 20x hiz
set_param(mdl, 'StopTime', '100');    % 100 saniye episode başı

% Modeli ac
open_system(mdl);

%% ENVIRONMENT
env = rlSimulinkEnv(mdl, agentBlk);
env.ResetFcn = @resetFcn;

%% EGITIM AYARLARI 
trainOpts = rlTrainingOptions(...
    'MaxEpisodes', 800, ...           % 800 episode (curriculum icin)
    'MaxStepsPerEpisode', 1000, ...   % DAHA UZUN episode
    'StopTrainingCriteria', 'AverageReward', ...
    'StopTrainingValue', 2000, ...     % Hedef
    'ScoreAveragingWindowLength', 30, ... % Daha yumusak ortalama
    'Verbose', true, ...
    'Plots', 'training-progress', ...
    'SaveAgentCriteria', 'EpisodeReward', ...
    'SaveAgentValue', 400, ...        % Orta seviyede kaydet
    'SaveAgentDirectory', 'savedAgents');

% Checkpoint klasoru olustur
if ~exist('savedAgents', 'dir')
    mkdir('savedAgents');
end

%% VR VIEWER TALİMATI
fprintf('\n');
fprintf('Egitim 5 saniye sonra basliyor...\n');
pause(5);

%% EGITIM BASLAT
fprintf('EGITIM BASLADI \n\n');
trainingStats = train(agentObj, env, trainOpts);

%% SONUC
fprintf('\n');
fprintf('  EGITIM TAMAMLANDI!\n');

% Ajan kaydet
save('DebrisAgent_Final.mat', 'agentObj');
fprintf('Ajan kaydedildi: DebrisAgent_Final.mat\n');
