#!/usr/bin/env sh
# -*- coding: utf-8 -*-
#
# Copyright (C) 2024 KTH.
#
# KTH-RDM is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.

# Quit on errors
set -uo errexit

# Quit on unbound symbols
set -o nounset

# In invenio.cfg make sure you set:
# USERS_RESOURCES_ADMINISTRATION_ENABLED = True

# Create roles
echo "Creating roles ..."

echo "Creating Community creator role ..."
# Check CONFIG_KTH_COMMUNITY_CREATOR_ROLE to match the role name in the configuration
invenio roles create kth-community-creator
echo "kth-community-creator role created successfully!"

echo "Creating Community administration-moderation role ..."
invenio roles create administration-moderation
echo "administration-moderation role created successfully!"

echo "Creating Community administration role ..."
invenio roles create administration
echo "administration role created successfully!"

echo "Roles created successfully!"

# Allow access
echo "Allow Access ..."

echo "Allow administration-moderation to role administration-moderation ..."
invenio access allow administration-moderation role administration-moderation

echo "Allow administration-access to role administration ..."
invenio access allow administration-access role administration

echo "Allow superuser-access to role administration ..."
invenio access allow superuser-access role administration

echo "Roles created successfully!"

# invenio users activate admin@inveniosoftware.org
