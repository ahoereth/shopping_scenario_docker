
dir=tmp
mkdir -p $dir

########
## Shopping Scenario
## Cannot live in the Dockerfile because of ssh.
git clone git@github.com:code-iai/shopping_scenario.git $dir/shopping_scenario

dir=$dir/src
mkdir -p $dir

########
## Knowrob
git clone -b indigo-devel https://github.com/knowrob/knowrob.git $dir/stacks/knowrob
git clone -b indigo-devel https://github.com/knowrob/knowrob_addons $dir/stacks/knowrob_addons

##########
## IAI
git clone https://github.com/code-iai/iai_common_msgs.git $dir/iai_common_msgs
git clone https://github.com/code-iai/designator_integration_lisp.git $dir/designator_integration_lisp
git clone https://github.com/code-iai/iai_cad_tools.git $dir/iai_cad_tools
git clone https://github.com/code-iai/robot_state_chain_publisher.git $dir/robot_state_chain_publisher
git clone https://github.com/ros/roslisp_common.git $dir/roslisp_common

##########
## Cram
git clone https://github.com/cram-code/cram_core.git $dir/cram_core
git clone https://github.com/cram-code/cram_pr2.git $dir/cram_pr2
git clone https://github.com/cram-code/cram_highlevel $dir/cram_highlevel
git clone https://github.com/cram-code/cram_physics $dir/cram_physics
git clone https://github.com/cram-code/cram_bridge.git $dir/cram_bridge

##########
## Build
sudo docker build -t shopping_scenario .

##########
## Cleanup
#rm -rf ./tmp/src ./tmp/shopping_scenario
