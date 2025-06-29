FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    curl build-essential git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install uv

ENV DBT_TARGET=prod
ENV DBT_PROFILES_DIR=/root/.dbt

WORKDIR /usr/app

COPY pyproject.toml .
COPY uv.lock .  
RUN uv sync

COPY profiles.yml /root/.dbt/profiles.yml

COPY . .

CMD ["uv", "run", "dbt", "run"]
# CMD ["tail", "-f", "/dev/null"]