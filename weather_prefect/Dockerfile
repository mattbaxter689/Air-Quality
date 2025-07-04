FROM prefecthq/prefect:3.4.7-python3.11

# Install Docker CLI
RUN apt-get update && apt-get install -y \
    ca-certificates curl gnupg lsb-release \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list \
    && apt-get update && apt-get install -y docker-ce-cli \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN pip install prefect-docker docker evidently psycopg2-binary SQLAlchemy pandas

COPY flows flows
COPY deploy.py deploy.py
COPY entrypoint.sh entrypoint.sh

# Make entrypoint executable
RUN chmod +x entrypoint.sh

ENTRYPOINT ["/bin/bash", "-c", "./entrypoint.sh"]
# ENTRYPOINT [ "tail", "-f", "/dev/null" ]