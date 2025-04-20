"""Tests for the module."""

# -*- coding: utf-8 -*-
#
# This file is part of Invenio.
# Copyright (C) 2024 KTH Royal Institute of Technology.
#
# Invenio is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.

"""Module tests."""


def test_version():
    """Test version import."""
    from v12_sandbox import __version__

    assert __version__
