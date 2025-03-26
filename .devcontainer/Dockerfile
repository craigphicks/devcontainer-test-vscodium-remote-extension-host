# Use an appropriate base image
# FROM mcr.microsoft.com/devcontainers/base:debian-12
FROM debian:bookworm-slim
# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive


# Create a non-root user and group
# Do this first so that /home/${USERNAME} directory exists
ARG USERNAME=codiserv
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME

    # Add these to allow user to have sudo ability
    # && echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME \
    # && chmod 0440 /etc/sudoers.d/$USERNAME

# Remove root password for security
RUN passwd -d root


# Install vscodium remote extension host server version
# The version MUST match the vecodium version number of the client! - or it will fail.
# Set build-time environment variables
ARG VSCODIUM_VERSION
ARG SERVER_INSTALL_NAME
ARG USERNAME

# Output the values of the environment variables
RUN echo "VSCODIUM_VERSION=${VSCODIUM_VERSION}"
#RUN echo "SERVER_INSTALL_LOCATION=${SERVER_INSTALL_LOCATION}"

RUN apt-get update && apt-get install -y curl
RUN rm -rf /var/lib/apt/lists/*

#RUN mkdir -p ${SERVER_INSTALL_LOCATION} && chown $USERNAME:$USERNAME ${SERVER_INSTALL_LOCATION}

#RUN [ -d ${SERVER_INSTALL_LOCATION} ] || exit 1

ARG FN=VSCodium-linux-x64-${VSCODIUM_VERSION}

# RUN echo "Downloading VSCodium Remote Server... ${FN}" \
#   && wget -qO /tmp/${SERVER_INSTALL_NAME}.tar.gz "https://github.com/VSCodium/vscodium/releases/download/${VSCODIUM_VERSION}/${FN}.tar.gz" \  
#   && echo "Extracting..." \
#   && tar -v --strip 1 -xzf /tmp/${SERVER_INSTALL_NAME}.tar.gz -C "/home/${USERNAME}/.${SERVER_INSTALL_NAME}" \
#   && rm -f /tmp/vscodium-server.tar.gz

ARG BINDIR=/usr/local/bin 
COPY --chown=$USERNAME:$USERNAME init-vscodium-server.sh ${BINDIR}/
# Make setup.sh executable
RUN chmod +x ${BINDIR}/init-vscodium-server.sh

USER $USERNAME


ARG REH_PACKAGE="vscodium-reh-linux-x64-${VSCODIUM_VERSION}.tar.gz"

# e.g.            https://github.com/VSCodium/vscodium/releases/download/1.97.2.25045/vscodium-reh-linux-x64-1.97.2.25045.tar.gz
ARG DOWNLOAD_URL="https://github.com/VSCodium/vscodium/releases/download/${VSCODIUM_VERSION}/${REH_PACKAGE}"

ARG REHDIR="/home/${USERNAME}/.${SERVER_INSTALL_NAME}"

# Create VSCodium server directory and extract in one RUN command
RUN mkdir -p ${REHDIR} && \
    chown ${USERNAME}:${USERNAME} ${REHDIR} && \
    curl -L --fail --show-error --retry 5 -o "/tmp/${REH_PACKAGE}" ${DOWNLOAD_URL} && \
    cd "${REHDIR}" && \
    tar -xf "/tmp/${REH_PACKAGE}" && \
    rm "/tmp/${REH_PACKAGE}"



# RUN echo "Downloading VSCodium Remote Server... ${FN}" 
# RUN curl -fsSL "https://github.com/VSCodium/vscodium/releases/download/${VSCODIUM_VERSION}/${FN}.tar.gz" -o /tmp/vscodium-server.tar.gz
# #RUN wget -qO /tmp/${SERVER_INSTALL_NAME}.tar.gz "https://github.com/VSCodium/vscodium/releases/download/${VSCODIUM_VERSION}/${FN}.tar.gz" 
# RUN ls -alt /tmp/${SERVER_INSTALL_NAME}.tar.gz
# RUN echo "Extracting..." 
# RUN mkdir -p "/home/${USERNAME}/.${SERVER_INSTALL_NAME}" 
# RUN tar -v --strip 1 -xzf /tmp/${SERVER_INSTALL_NAME}.tar.gz -C "/home/${USERNAME}/.${SERVER_INSTALL_NAME}" 
# RUN ls -alt "/home/${USERNAME}/.${SERVER_INSTALL_NAME}"

# RUN rm -f /tmp/vscodium-server.tar.gz



  #  && chmod +x "/home/${USERNAME}/.${SERVER_INSTALL_NAME}"

  



# Copy setup.sh into the container with the correct ownership

# Set the working directory
# Note for devcontainers: Should match the value of workspaceFolder
WORKDIR /workspace


# Switch to non-root user
