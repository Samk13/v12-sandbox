#!/usr/bin/env sh
# -*- coding: utf-8 -*-
#
# Copyright (C) 2022-2024 KTH.

echo "Vocabularies Import: names  ..."
# invenio vocabularies import -v names -f app_data/vocabularies-future.yaml
# Make sure you import funders first, then awards ORDER MATTER!
echo "Vocabularies Import: funders ..."
# invenio vocabularies import -v funders -f app_data/vocabularies-future.yaml
echo "Vocabularies Import: awards ..."
# It takes long time to import awards, so we do it in the background
# ~40 minutes to index 65643 items
# 65643 items succeeded
# Uncomment on deploy, Takes long time to index
# preferably run in separatlly after the deployment
# invenio vocabularies import -v awards -f app_data/vocabularies-future.yaml
echo "Done!"
