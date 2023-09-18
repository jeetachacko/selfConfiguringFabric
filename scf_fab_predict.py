import gym
#from gym import spaces
#import numpy as np
from gym.wrappers import TimeLimit
import os
import wandb
from stable_baselines3 import DQN
from stable_baselines3.dqn import MlpPolicy
import config 
from wandb.integration.sb3 import WandbCallback
from rl_model.fabric_gym_env import FabricEnv
from stable_baselines3.common.env_util import make_vec_env
from stable_baselines3.common.evaluation import evaluate_policy
from config import discrete_action_space

def run_scf_predict():
    log_dir = "/home/ubuntu/nilm/temp/chacko/scf_exps_client_admsnrt/"
    os.makedirs(log_dir, exist_ok=True)
    model_dir = "/home/ubuntu/nilm/temp/chacko/scf_exps_client_admsnrt/models/"
    os.makedirs(model_dir, exist_ok=True)
    # Create log dir
    #log_dir = "tmp/"
    #os.makedirs(log_dir, exist_ok=True)

    env = FabricEnv(fixed_throughput=config.FIXED_THROUGHPUT, agent_random_start=False)
    env = TimeLimit(env, max_episode_steps=config.MAXIMUM_STEPS_PER_EPISODE)
    env = make_vec_env(lambda: env, n_envs=1)
    
    # Initialize wandb
    wandb_config = {
        "policy_type": "MlpPolicy",
        "total_timesteps": config.MAXIMUM_STEPS_PER_EPISODE * config.NUMBER_OF_EPISODES,
        "env_name": "scf_fab_client_admsnrt",
        "learning_rate": config.LEARNING_RATE}
    
    run = wandb.init(project="scf_fab_client_admsnrt", config=wandb_config, monitor_gym=True, save_code=True, dir=log_dir)
    # Instantiate the agent
    model = DQN(
        MlpPolicy,
        env,
        verbose=1,
        learning_rate=config.LEARNING_RATE,
        learning_starts=config.LEARNING_STARTS,
        exploration_fraction=config.EXPLORATION_FRACTION,
        #tensorboard_log=log_dir,
    )
    model_name = "/home/ubuntu/nilm/temp/chacko/scf_exps_client_admsnrt/models/ai19mrbp/model.zip"
    model.load(model_name)

    obs_temp = env.env_method("reset")[0]
    obs = obs_temp[0]
    initial_obs = obs

    print(f"=== prediction with starting obs[0] {obs[0]} ===")
    done = False
    info = {}
    selected_actions = [env.get_attr("agent")[0].position]
    while not done:
        actions, _ = model.predict(obs)
        obs, reward, _done, _done, info = env.env_method("step", actions)[0]
        print(f"predicted action {discrete_action_space[actions]} resulting in {obs} and {reward} reward")
        if reward < 0 or _done:
            done = True
        else:
            selected_actions.append(discrete_action_space[actions])
    print(f"==== prediction ends {selected_actions}====")
    print(f"recap: {model_name}; {initial_obs}; {selected_actions}; {obs}")


    result = env.env_method("get_results")
    print(f"DQN PREDICT RUN COMPLETE")
    print(f"DQN RESULTS: {str(result)}")

    run.finish()

try:
    run_scf_predict()
except Exception as e:
    wandb.alert(title="Error", text=e)

    
