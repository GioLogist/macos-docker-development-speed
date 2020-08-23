# Benchmarks

Benchmarks were ran using [Xenforo](https://xenforo.com/) forum software. This software required us to create a Docker Container with a few components that rely heavily on read speed (specifically, the database). 

- MySQL 
- PHP-FPM
- Nginx

> Note: A few Xenforo add-ons were installed before benchmarking, just for good measure on a real-world use case.

| Environment | Average Speed (in seconds) | Resources Allocated |
| - | - | - | 
| MacOS via Docker Desktop | 0.3756125 | 4gb memory, 6cpus |
| MacOS via Ubuntu VM #1 | 0.19845 | 4gb memory, 6cpus |
| MacOS via Ubuntu VM #2 | 0.1882125 | 4gb memory, 6cpus |
| MacOS via Ubuntu VM #3 | 0.1846125 | 4gb memory, 2cpus |
| MacOS via Ubuntu VM #4 | 0.1865375 | 2gb memory, 2cpus |


As seen above, running a Linux VM on your Mac and then using that VM to run Docker, is significantly faster than just running Docker on your mac.

Its worth noting that the resources allocated didn't make too much of a difference on the speed of our VM. With a larger sample size, they probably would have averaged out nearly identically. For this reason, consider using as few resources as possible, till the container(s) you're running demand more. 