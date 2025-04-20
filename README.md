# v12-sandbox

Welcome to your InvenioRDM instance.

## Getting started

Run the following commands in order to start your new InvenioRDM instance:

```console
uv venv
source venv/bin/activate
uv sync -n
cd site 
uv sync -n
cd ..
docker compose -f docker-compose.full.yml up -d

docker exec -it v12-sandbox-worker-1
0c941a2d81ac:/opt/invenio/var/instance$ ./wipe_recreate.sh

