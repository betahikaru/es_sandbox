#!/bin/bash

function os_check() {
    if [ "$(uname)" == 'Darwin' ]; then
        # OS='Mac'
        return
    elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
        # OS='Linux'
    elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then                                                                                           
        # OS='Cygwin'
    else
        # OS='Other'
    fi
    echo "Your platform ($(uname -a)) is not supported."
    exit 1
}

function install_formula() {
    brew install elasticsearch
    elasticsearch --version
    brew install logstash
    logstash --version
    brew install kibana
    kibana --version
}

os_check
install_formula
