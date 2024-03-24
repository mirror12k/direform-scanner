FROM ubuntu:22.04
RUN apt-get update && apt-get install -y nano jq curl wget python3-pip && pip install llm-shell weasel stonemill
RUN useradd -ms /bin/bash runuser
USER runuser
WORKDIR /app
CMD ["bash"]
