#!/bin/bash
curl -o tf-operator.tar http://134.119.178.86:10090/containers/tf-operator.tar
docker load -i tf-operator.tar
