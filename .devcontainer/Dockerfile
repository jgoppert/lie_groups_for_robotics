FROM ubuntu:jammy-20221130
LABEL maintainer="James Goppert <james.goppert@gmail.com>"

# Set default shell during Docker image build to bash
SHELL ["/bin/bash", "-c"]

ARG NB_USER=user
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

# copy in cleaning script
COPY .devcontainer/docker_clean.sh /docker_clean.sh
RUN chmod +x /docker_clean.sh

# install base packages
RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get install --no-install-recommends -y \
		sudo \
		&& \
	/docker_clean.sh

# add user
RUN adduser --disabled-password \
  --gecos "Default user" \
  --uid ${NB_UID} \
  ${NB_USER} && \
  adduser user sudo && \
  echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# switch to user
USER ${NB_USER}

# install scripts
COPY .devcontainer/install.sh /tmp/install.sh
COPY requirements.txt /tmp
RUN /tmp/install.sh && /docker_clean.sh

# setup .bashrc
RUN mkdir -p /home/user/.bash_completion.d && \
  echo "source $HOME/.venv-lgfr/bin/activate" >> ~/.bashrc

# enable entrypoint
ENV PATH="$HOME/bin:$PATH"
COPY .devcontainer/entrypoint.sh /
RUN sudo chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]

# vim: set et fenc=utf-8 ff=unix ft=dockerfile sts=0 sw=2 ts=2 :
