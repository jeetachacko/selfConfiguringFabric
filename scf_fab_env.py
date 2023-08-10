from gym import Env
from gym.spaces import Box, MultiDiscrete
import config_vars
import numpy as np

class FabricEnv(Env):
    def __init__(self):
        
        self.action_space = MultiDiscrete([len(config_vars.max_message_count), len(config_vars.batch_timeout), len(config_vars.absolute_max_bytes), len(config_vars.preferred_max_bytes), len(config_vars.snapshot_interval_size), len(config_vars.admission_rate)])
        self.observation_space = Box(low=0, high=np.inf, shape=(3,))
        self.state = 0 

