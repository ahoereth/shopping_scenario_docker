docker run \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -v $HOME/.Xauthority:/home/developer/.Xauthority:ro \
  -v `pwd`/logs:/home/shopper/logs:rw \
  --net=host \
  shopping_scenario $@
