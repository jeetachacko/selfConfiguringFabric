"""
agent should choose from the available action, send it to environment to receive updated state and benchmarking result then calculate evaluation function result
"""
import random
from config import function_type
from enum import Enum


class PossibleAction(Enum):
    INCREASE_FUNCTION_TYPE = 0
    DECREASE_FUNCTION_TYPE = 1

class Agent:
    def __init__(self, random_start=True):
        if random_start:
            self.function_type_choice = random.choice(function_type)
        else:
            self.function_type_choice = random.choice(function_type)

    @property
    def position(self):
        return (self.function_type_choice)

    # get available actions based on state
    def available_actions(self):
        max_function_type = self.function_type_choice == function_type[-1]
        min_function_type = self.function_type_choice == function_type[0]
        possible_actions = list(PossibleAction)
        if max_function_type:
            self._remove_action(possible_actions, PossibleAction.INCREASE_FUNCTION_TYPE)
        if min_function_type:
            self._remove_action(possible_actions, PossibleAction.DECREASE_FUNCTION_TYPE)
        return tuple(possible_actions)

    def _remove_action(self, arr, act):
        try:
            arr.remove(act)
        except ValueError:
            pass
    
    # directly move from one action to another
    def move(self, agent_pos):
        self.function_type_choice = agent_pos        
    # one step from one possible action to neighbour action
    def step(self, choice):
        function_type_idx = function_type.index(self.function_type_choice)
        if choice == PossibleAction.INCREASE_FUNCTION_TYPE:
            self.function_type_choice = function_type[function_type_idx + 1]
        elif choice == PossibleAction.DECREASE_FUNCTION_TYPE:
            self.function_type_choice = function_type[function_type_idx - 1]
        else:
            raise ValueError("Invalid action")
