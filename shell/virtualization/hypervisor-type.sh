#!/bin/bash
set -euo pipefail

sudo dmidecode \
    | grep -i -e manufacturer -e product -e vendor

# Ansible also can be used for this
# > ansible trusty_guest -m setup -a "filter=ansible_virtualization_*"
# trusty_guest | SUCCESS => {
    # "ansible_facts": {
        # "ansible_virtualization_role": "host",
        # "ansible_virtualization_type": "kvm"
    # },
    # "changed": false
# }
