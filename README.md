# docker-electrum-server

With help of my friend [x0st](https://github.com/x0st)

# Make it working
- `docker build -t docker-electrum-server .`
- `docker run -v /path/to/electrum/folder:/app/electrum --env-file ./.env --name docker-electrum-server-1 docker-electrum-server`
