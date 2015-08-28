docker run \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -v $HOME/.Xauthority:/home/developer/.Xauthority:ro \
  --net=host \
  shopping_scenario
