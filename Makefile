ANSIBLE_COMMAND = ansible-playbook

init:
	${ANSIBLE_COMMAND} initHost.yaml
connect:
	ansible -i inventory -m ping all
deploy:
	${ANSIBLE_COMMAND} main.yaml
