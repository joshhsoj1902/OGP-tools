#!/bin/bash

mkdir working;
cd working;

wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar;
java -jar BuildTools.jar;

