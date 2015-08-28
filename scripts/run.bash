#!/bin/bash
bash -c "roscore&"
bash -c "roslaunch --wait shopping_scenario_executive shopping_scenario.launch&"
bash -c "roslaunch --wait shopping_scenario_executive shopping_scenario_simulation.launch"
