#! /bin/bash

ps -ef|grep rack | awk '{print $2}'|xargs kill -9