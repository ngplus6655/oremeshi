#!/usr/bin/env bash
rails db:create
rails db:migrate
yarn install
yarn upgrade
rails webpacker:install