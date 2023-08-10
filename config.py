import random
from dotenv import load_dotenv
from itertools import product
import os

load_dotenv()


"""
=== GENERAL CONFIG ===
"""

ALGORITHM = os.getenv("ALGORITHM")

# mongodb settings
MONGODB_HOST = os.getenv("MONGODB_HOST")

# env config
TEST_NETWORK_EXTENDED_DIR = os.getenv("TEST_NETWORK_EXTENDED_DIR")

# Tx duration in Hyperledger caliper
TX_DURATION = 10 # caliper tx duration - TODO check with caliper config

# "reward vs penalty?, rather we can assign score for every agent action (changing configuration)"
MOVE_PENALTY = 1 
THROUGHPUT_REWARD_WEIGHT = 1.5
SUCCESS_REWARD_WEIGHT = 1
LATENCY_REWARD_WEIGHT = 1.2

# if action picked is not possible to execute, give pinalty
INVALID_ACTION_PINALTY = 99

# if objective achieved, multiply reward by this value.
OBJECTIVE_REWARD_MULTIPLIER=5

# training config
EXPECTED_THROUGHPUT = 10 # default expected throughput
MAXIMUM_STEPS_PER_EPISODE = 30

# notification config
CHAT_ID = os.getenv("CHAT_ID")
BOT_TOKEN = os.getenv("BOT_TOKEN")

# digital ocean spaces settings
SPACE_KEY = os.getenv("SPACE_KEY")
SPACE_SECRET = os.getenv("SPACE_SECRET")
SPACE_NAME = os.getenv("SPACE_NAME")
SPACE_REGION = os.getenv("SPACE_REGION")

# rebuild transaction limit
REBUILD_LIMIT = 50000

"""
=== DQN CONFIG ===
"""
# possible value combination for action space (see PossibleAction)
possible_block_size = [10,50,100,150,200,250,300,350,400,450,500,600,700,800,900,1000,]

discrete_action_space = possible_block_size

DQN_SIZE = 800 # max throughput TODO check with saturation_check.py


def set_dqn_expected_throughput(fixed_throughput):
    global EXPECTED_THROUGHPUT
    if fixed_throughput:
        EXPECTED_THROUGHPUT = fixed_throughput
    else:
        EXPECTED_THROUGHPUT = random.randrange(50, DQN_SIZE, 50) or 10
    return EXPECTED_THROUGHPUT
