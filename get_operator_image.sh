#!/bin/bash
curl -o tf-operator.tar http://134.119.178.86:12340/tf-operator.tar
docker load -i tf-operator.tar
