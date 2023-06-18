# Dockerfile
FROM cytopia/ansible:2.13-infra

RUN apk add --no-cache --update --virtual=build linux-headers gcc musl-dev python3-dev libffi-dev openssl-dev cargo make bash

RUN ansible-galaxy collection install azure.azcollection
RUN pip install --no-cache-dir --prefer-binary azure-cli==2.34.0
RUN pip install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt

# https://docs.ansible.com/ansible/latest/collections/community/general/
RUN ansible-galaxy collection install community.general

WORKDIR /ansible
COPY entry-point.sh /entry-point.sh

# Add /ansible to PATH
ENV PATH="/ansible:${PATH}"

ENTRYPOINT [ "/entry-point.sh" ]
