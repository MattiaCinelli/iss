##############################
ENVIRONMENT_PREFIX=$(shell pwd)
ENVIRONMENT_NAME=iss_venv
VENV_NAME=${ENVIRONMENT_PREFIX}/${ENVIRONMENT_NAME}
VENV_BIN=${VENV_NAME}/bin
VENV_PYTHON=${VENV_BIN}/python3

# Virtualenv for project
dev: requirements.txt
	echo " "
	echo " Creating virtual environment... "
	echo " "
	${VENV_BIN}/pip-sync requirements.txt
	python3 -m ipykernel install --user --name=${ENVIRONMENT_NAME}
	. ${ENVIRONMENT_NAME}/bin/activate

requirements.txt: venv
	echo " "
	echo " requirements.txt "
	echo " "
	${VENV_BIN}/pip-compile requirements.in --output-file requirements.txt

venv: requirements.in
	echo " "
	echo " Compiling requirements... "
	echo " "
	python3 -m venv ${ENVIRONMENT_NAME}
	${VENV_BIN}/pip3 install --upgrade 'pip'
	${VENV_BIN}/pip3 install pip-tools 'numpy' 'scipy' 'setuptools>=41.0.0' 'ipykernel' 'keras'
	${VENV_BIN}/pip3 install --upgrade jupyter_client
	

