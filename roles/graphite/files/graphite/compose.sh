#!/bin/bash

sudo docker-compose up &> ./compose.log &
disown
