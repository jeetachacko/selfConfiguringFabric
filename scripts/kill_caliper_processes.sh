#!/bin/bash

# !TODO! Update hardcoded values

ps -ef|grep caliper| awk '{print $2}' | xargs kill -9 $2