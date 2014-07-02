#! /bin/bash

bundle install --local

bundle exec rackup config.ru &