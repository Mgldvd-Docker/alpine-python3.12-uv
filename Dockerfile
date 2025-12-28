FROM python:3.12-alpine

RUN apk add --no-cache \
    bash \
    sudo \
    curl \
    ca-certificates \
    neovim \
    coreutils \
    git

RUN adduser -D -u 1000 -s /bin/bash master && \
    printf 'master ALL=(ALL) NOPASSWD:ALL\n' > /etc/sudoers.d/master && \
    chmod 0440 /etc/sudoers.d/master

USER master
WORKDIR /home/master

RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
    printf 'source $HOME/.local/bin/env\n' >> /home/master/.bashrc

ENV PATH="/home/master/.local/bin:${PATH}"

RUN cat << 'EOF' >> /home/master/.bashrc
export PS1="\n\
\[\033[38;2;255;249;143m\] \w\n\
\[\033[38;2;49;94;146m\] ⏹\
\[\033[38;2;255;95;71m\]⏹\
\[\033[38;2;255;182;53m\]⏹\
\[\033[0m\] \
\[\033[38;2;120;150;255m\]python3.12-uv \
\[\033[38;2;140;170;255m\]❱ \
\[\033[0m\] "
alias ll="ls -Xalhv --color=auto --group-directories-first"
alias vim="nvim"
EOF

USER root
RUN mkdir -p /app && chown -R master:master /app
RUN chown -R master:master /home/master

USER master
WORKDIR /app

CMD ["sleep", "infinity"]
