FROM bjing/dev-container-base:latest

ARG MINIMAL_INSTALL
ARG GHC_VERSION
ARG CABAL_VERSION
ARG INSTALL_STACK
ARG INSTALL_CABAL
ARG INSTALL_HLS
ARG ADJUST_BASHRC

#ENV BOOTSTRAP_HASKELL_MINIMAL=${MINIMAL_INSTALL}
ENV BOOTSTRAP_HASKELL_NONINTERACTIVE=1
ENV BOOTSTRAP_HASKELL_GHC_VERSION=${GHC_VERSION}
ENV BOOTSTRAP_HASKELL_CABAL_VERSION=${CABAL_VERSION}
ENV BOOTSTRAP_HASKELL_INSTALL_STACK=${INSTALL_STACK}
ENV BOOTSTRAP_HASKELL_INSTALL_HLS=${INSTALL_HLS}
ENV BOOTSTRAP_HASKELL_ADJUST_BASHRC=${ADJUST_BASHRC}


#######################
# Install dependencies
#######################
USER root
RUN apt-get update
RUN apt-get install -y build-essential libffi-dev libffi8ubuntu1 libgmp-dev libgmp10 libncurses-dev libncurses6 libtinfo6


#######################
# Set up user
#######################
ARG USERNAME=code
ARG USER_HOME=/home/$USERNAME

# Set the default user. Omit if you want to keep the default as root.
USER $USERNAME


#######################
# Install Haskell
#######################
RUN mkdir -p $USER_HOME/install/
COPY scripts/install_haskell.sh $USER_HOME/install/install_haskell.sh
WORKDIR $USER_HOME/install/
RUN ./install_haskell.sh


RUN mkdir $USER_HOME/app
WORKDIR $USER_HOME/app

CMD ["sleep", "infinity"]
