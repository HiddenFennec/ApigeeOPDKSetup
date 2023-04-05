[all:vars]
ansible_connection=ssh
ansible_user=apigee

[all]
${IP1}
${IP2}
${IP3}
${IP4}
${IP5}

[ds]
${IP1}
${IP2}
${IP3}

[ms]
${IP1}

[rmp]
${IP2}
${IP3}

[sax]
${IP4}
${IP5}