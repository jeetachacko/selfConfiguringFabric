"""
agent should choose from the available action, send it to environment to receive updated state and benchmarking result then calculate evaluation function result
"""
import random
from config import max_message_count
from enum import Enum


class PossibleAction(Enum):
    INCREASE_BLOCK_SIZE = 0
    DECREASE_BLOCK_SIZE = 1


class Agent:
    def __init__(self, random_start=True):
        if random_start:
            self.block_size_choice = random.choice(max_message_count)
        else:
            self.block_size_choice = 10

    @property
    def position(self):
        return self.block_size_choice

    # get available actions based on state
    def available_actions(self):
        max_size = self.block_size_choice == max_message_count[-1]
        min_size = self.block_size_choice == max_message_count[0]

        possible_actions = list(PossibleAction)
        
        if max_size:
            self._remove_action(possible_actions, PossibleAction.INCREASE_BLOCK_SIZE)

        if min_size:
            self._remove_action(possible_actions, PossibleAction.DECREASE_BLOCK_SIZE)

        return tuple(possible_actions)

    def _remove_action(self, arr, act):
        try:
            arr.remove(act)
        except ValueError:
            pass
    
    # directly move from one action to another
    def move(self, agent_pos):
        self.block_size_choice = agent_pos

    # one step from one possible action to neighbour action
    def step(self, choice):
        size_idx = max_message_count.index(self.block_size_choice)
        if choice == PossibleAction.INCREASE_BLOCK_SIZE:
            self.block_size_choice = max_message_count[size_idx + 1]
        elif choice == PossibleAction.DECREASE_BLOCK_SIZE:
            self.block_size_choice = max_message_count[size_idx - 1]