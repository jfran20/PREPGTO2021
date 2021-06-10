#!/bin/sh
apt-get update
apt-get -y install libcurl4-openssl-dev libssl-dev libxml2-dev libudunits2-dev libgdal-dev libfontconfig1-dev pandoc

# run app
Rscript packages.R
