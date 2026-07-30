FROM ubuntu:26.04 AS development

# Install correct development tools
RUN apt-get update && \
    apt-get install -y build-essential

# Setup the working directory
WORKDIR /app

# run setup script to ensure develop with rootless user
ENTRYPOINT ["/app/entrypoint.sh"]

# Run a terminal
CMD ["/bin/bash"]