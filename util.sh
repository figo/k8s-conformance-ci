#!/bin/sh

# echo_env_var writes an environment variable and its value to
# ENVS_FILE as long as the value is not empty
function echo_env_var() {
  if [ -n "$(echo "${1}" | sed 's/^[^=]*=//g')" ]; then 
    echo "${1}" >> "${2}"
    export "${1}"
  fi
}