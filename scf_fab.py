from gym.wrappers import TimeLimit, Monitor
import os
import wandb
from stable_baselines3 import DQN
from stable_baselines3.dqn import MlpPolicy
from stable_baselines3.common.cmd_util import make_vec_env
import config_vars 
import wandb_config_vars
from wandb.integration.sb3 import WandbCallback
from rl_model.fabric_gym_env import FabricEnv
from stable_baselines3.common.env_util import make_vec_env
from stable_baselines3.common.evaluation import evaluate_policy

try:
    run_scf()
except Exception as e:
    wandb.alert(title="Error", text=e)

def scf_rn():
    # Create log dir
    log_dir = "tmp/"
    os.makedirs(log_dir, exist_ok=True)

    env = FabricEnv(fixed_throughput=config_vars.FIXED_THROUGHPUT)
    env = TimeLimit(env, max_episode_steps=config_vars.MAXIMUM_STEPS_PER_EPISODE)
    env = make_vec_env(lambda: env, n_envs=1)

    # Initialize wandb
    config = {
        "policy_type": "MlpPolicy",
        "total_timesteps": config_vars.MAXIMUM_STEPS_PER_EPISODE * config_vars.NUMBER_OF_EPISODES,
        "env_name": "scf_fab",
        "learning_rate": config_vars.LEARNING_RATE}
    
    run = wandb.init(project="scf_fab", config=config, sync_tensorboard=True, monitor_gym=True, save_code=True)
    # Instantiate the agent
    model = DQN(
        MlpPolicy,
        env,
        verbose=1,
        learning_rate=config_vars.LEARNING_RATE,
        learning_starts=config_vars.LEARNING_STARTS,
        exploration_fraction=config_vars.EXPLORATION_FRACTION,
        tensorboard_log=log_dir,
    )

    model_dir = "models/"
    os.makedirs(model_dir, exist_ok=True)

    # Train the agent
    model.learn(
        total_timesteps=config_vars.MAXIMUM_STEPS_PER_EPISODE * config_vars.NUMBER_OF_EPISODES,
        callback=WandbCallback(radient_save_freq=100, model_save_path=f"models/{run.id}", verbose=2,),
    )


    # Save the agent
    model.save("model_dir")

    evaluate_policy(model, env, n_eval_episodes=10, render=True)
    run.finish()



    
