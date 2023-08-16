import gym
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

def run_scf():
    log_dir = "/home/ubuntu/nilm/temp/chacko/scf_exps/"
    os.makedirs(log_dir, exist_ok=True)
    model_dir = "/home/ubuntu/nilm/temp/chacko/scf_exps/models/"
    os.makedirs(model_dir, exist_ok=True)
    # Create log dir
    #log_dir = "tmp/"
    #os.makedirs(log_dir, exist_ok=True)

    env = FabricEnv(fixed_throughput=config.FIXED_THROUGHPUT)
    env = TimeLimit(env, max_episode_steps=config.MAXIMUM_STEPS_PER_EPISODE)
    env = make_vec_env(lambda: env, n_envs=1)
    
    # Initialize wandb
    wandb_config = {
        "policy_type": "MlpPolicy",
        "total_timesteps": config.MAXIMUM_STEPS_PER_EPISODE * config.NUMBER_OF_EPISODES,
        "env_name": "scf_fab",
        "learning_rate": config.LEARNING_RATE}
    
    run = wandb.init(project="scf_fab", config=wandb_config, monitor_gym=True, save_code=True, dir=log_dir)
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

   

    #env.reset(seed=None)

    # Train the agent
    model.learn(
        total_timesteps=config.MAXIMUM_STEPS_PER_EPISODE * config.NUMBER_OF_EPISODES,
        callback=WandbCallback(model_save_path=f"{model_dir}/{run.id}", verbose=2,),
    )


    # Save the agent
    model.save("model_dir")

    evaluate_policy(model, env, n_eval_episodes=10, render=True)
    run.finish()

try:
    run_scf()
except Exception as e:
    wandb.alert(title="Error", text=e)

    
