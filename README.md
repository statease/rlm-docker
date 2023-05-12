# RLM server

RLM server in a Docker container.

## Running the App

Run:

    docker compose up -d --build

Then navigate to localhost:5054.

## Deploying the App

First create a context called "remote" that points to the server.

    docker context create remote --docker "host=ssh://root@your.server.com"

Then activate it:

    docker context use remote

Then run docker compose on the server:

    docker compose -f docker-compose.prod.yml up -d --build

To get back to your local context use:

    docker context use default

## Activation

The RLM web service should be available at http://your.server.com:5054. You can try
activating with that interface. You may need to manually activate, though,
as RLM seems to pull the wrong hostid. To do this go to the "edit license file" menu
item in the RLM web interface. Inspect the log for something like:

    rlms  | 11/10 16:07 (statease) Wrong Hostid - licenses may not be available
    rlms  | 11/10 16:07 (statease)  (expected: a9092e4003ea, we are: 0242ac130002)

Manually activate with the expected hostid and paste the resulting license file into
the web interface.

## Debugging

While connected to the remote context you can run `docker ps` to get the container id,
then `docker exec -t <container_id> bash` to get a shell. Then cd into `statease-rlm`
and you can look at the license file or debug log.


## SSL

There is a docker-compose-ssl.yml that will run RLM with SSL. You'll need certs
first. The easiest way to get them is to use certbot:

    snap install --classic certbot
    certbot certonly --standalone -d your_domain
    mkdir certs
    cp /etc/letsencrypt/live/your_domain/* certs

Then run the docker compose with the docker-compose-ssl.yml file. You may need
to mess around with the paths/permissions in the file and in these
instructions. You may also need to open ports 80/443 to get the cert.
