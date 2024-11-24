# Ofelia Task Runner

Leverage Ofelia and Taskfiles to do things in a compose stack.

Should you use this? Almost certainly not, I made this specially for me.

```yaml
services:
  ofelia_tasks:
    image: docker-ofelia-task
    container_name: docker-ofelia-task
    hostname: docker-ofelia-task
    environment:
      - TZ=America/Los_Angeles
      - TEST_ENV=Hello World
      - HOST_PWD=${PWD:?}
    volumes:
      - /etc/localtime:/etc/localtime:ro
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - ./tasks:/tasks
      - ./config:/config
```
