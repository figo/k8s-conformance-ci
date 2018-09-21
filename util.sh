#!/bin/sh

# echo_env_var writes an environment variable and its value to
# ENVS_FILE as long as the value is not empty
function echo_env_var() {
  if [ -n "$(echo "${1}" | sed 's/^[^=]*=//g')" ]; then 
    echo "${1}" >> "${2}"
    export "${1}"
  fi
}

# only return when all pods in kube-system are ready
function wait_until_pods_running() {
   until kubectl get pods -n kube-system --no-headers | awk -F" " '{print $2}' | awk -F"/" '{s+=($1!=$2)} END {exit s}';
   do
      sleep 5.2;
      kubectl get pods -n kube-system --no-headers;
   done;
   echo "all pods in kube-system are ready";
}
