# docker-dns

##### Run a dns proxy in docker with wildcard host support

This is intended to be used within (but not limited to) a local docker development environment, typically in combination with some type of reverse proxy that supports virtualhosts like nginx. In this configuration, `docker-dns` allows you to simplify local container access by automatically setting up easier doamins like `hello.docker.local`

#### Quickstart:

`docker run -p 53:53/udp -d --restart always finboxio/docker-dns`

Once this container is running, configure your system to route DNS queries through localhost and you're all set.

#### Configuration:

`docker-dns` can be configured through the use of a few environment variables:

-  `-e PORT=${PORT:-53}` sets the port the DNS server will listen on
-  `-e EXTERNAL_DNS=${IP:-8.8.8.8}` sets the DNS server to which queries that cannot be resolved locally are proxied
-  `-e HOSTS_FILE=${FILE:-/etc/docker-dns/hosts} -v $FILE:$FILE` sets the host file to read for resolving queries locally. This should look like a typical /etc/hosts file, but additionally supports wildcard entries. The default hosts file included in this image is shown below, but you are free to mount your own:
	
	```
	127.0.0.1 		*.docker.local
	192.168.99.100 	*.rancher.local
	```

> Note:
> 
> The second is really only effective if you have a rancher host running in a virtual machine with the IP 192.168.99.100. I do some development against a local rancher cluster spun up via [rancher-mac](https://github.com/finboxio/mac-ranch), so this is actually a reasonably useful default for me.
> 

#### Using with a reverse proxy

[jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy) makes this really easy:

`docker run -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro --restart always jwilder/nginx-proxy`

> Note: 
> 
> Your system may have a default web server already running on port 80. If that's the case you'll either need to disable it or choose a different port. If you're on mac and aren't using the default apache server you can disable it with 
> 
> `sudo launchctl unload -w /System/Library/LaunchDaemons/org.apache.httpd.plist`
> 

Now, you can start up any container with `VIRTUAL_HOST` set to a `docker.local` domain and access it from the browser without having to expose/keep track of all the different ports you're using!

`docker run -d -p 80 -e VIRTUAL_HOST=hello.docker.local -e VIRTUAL_PORT=80 tutum/hello-world && open http://hello.docker.local`

#### \#winning