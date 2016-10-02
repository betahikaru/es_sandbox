#!/bin/bash

function init_configure() {
    current_dir=`dirname $0`
    conf_dir=${current_dir}/../conf
    cp ${conf_dir}/logstash/template/twitter.conf.template ${conf_dir}/logstash/twitter.conf 
}

init_configure
