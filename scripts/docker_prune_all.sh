#!/bin/bash
#
# Copyright (C) 2022-2024 KTH.

# ----------------------
# DO NOT USE IT IN PROD!
# ----------------------

# Prune all except images

invenio-cli services destroy
docker system prune --volumes --force && docker container prune --force && docker network prune --force
