# HTTPS with Varnish and Nginx as Proxy

```sh 
server {
        listen 443 ssl;
        server_name example.com;
        ssl_certificate /etc/nginx/ssl/nginx.crt;
        ssl_certificate_key /etc/nginx/ssl/nginx.key;
        location / {
            proxy_pass http://127.0.0.1:80;
            proxy_set_header X-Real-IP  $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto https;
            proxy_set_header X-Forwarded-Port 443;
            proxy_set_header Host $host;
        }
}
```

## Varnish config

```sh 
import std;
sub vcl_recv {
  # Ask Varnish to fire 750 status for HTTP requests from external IPs and port 80,
  # and not from SSL Termination Proxy (Nginx).
  if ((client.ip != "127.0.0.1" && std.port(server.ip) == 80) &&
      (req.http.host ~ "^(?i)(www\.)?komelin.com")) {
    set req.http.x-redir = "https://" + req.http.host + req.url;
    return (synth(750, ""));
  }
}
sub vcl_synth {
  # Listen to 750 status from vcl_recv.
  if (resp.status == 750) {
    // Redirect to HTTPS with 301 status.
    set resp.status = 301;
    set resp.http.Location = req.http.x-redir;
    return(deliver);
  }
}
```
