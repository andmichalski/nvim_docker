FROM ubuntu:18.04

MAINTAINER Andrzej Michalski andrzej@michalski.in

ENV \
        SHELL="/bin/bash" \
        WORKSPACE="/mnt/workspace" \
	NVIM_CONFIG="/root/.config/nvim" \
	NVIM_PROVIDER_PYLIB="python3_neovim_provider"

RUN apt-get update && apt-get install -y \	
	git \
	curl \
	python-pip \
	python3-pip \
	python3-dev \
	bash \
	python3-dev \
	gcc \
	musl-dev \
	git \
	yarn \
	software-properties-common \
	python-autopep8 \
	silversearcher-ag

# FZF
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf; ~/.fzf/install

# Neovim
RUN add-apt-repository ppa:neovim-ppa/stable
RUN apt-get update && apt-get install -y neovim

# Plugins
RUN mkdir -p "/root/.config/nvim/plugged"
# Common
RUN git -C "/root/.config/nvim/plugged" clone --depth 1 https://github.com/scrooloose/nerdtree \
&& git -C "/root/.config/nvim/plugged" clone --depth 1 https://github.com/jistr/vim-nerdtree-tabs \
&& git -C "/root/.config/nvim/plugged" clone --depth 1 https://github.com/christoomey/vim-tmux-navigator \
&& git -C "/root/.config/nvim/plugged" clone --depth 1 https://github.com/Yggdroot/indentLine \
&& git -C "/root/.config/nvim/plugged" clone --depth 1 https://github.com/tpope/vim-surround \
&& git -C "/root/.config/nvim/plugged" clone --depth 1 https://github.com/tpope/vim-commentary \
&& git -C "/root/.config/nvim/plugged" clone --depth 1 https://github.com/airblade/vim-gitgutter \
&& git -C "/root/.config/nvim/plugged" clone --depth 1 https://github.com/pseewald/vim-anyfold \
&& git -C "/root/.config/nvim/plugged" clone --depth 1 https://github.com/numirias/semshi \
# Completion
&& git -C "/root/.config/nvim/plugged" clone --depth 1 https://github.com/SirVer/ultisnips \
&& git -C "/root/.config/nvim/plugged" clone --depth 1 https://github.com/honza/vim-snippets \
&& git -C "/root/.config/nvim/plugged" clone --depth 1 https://github.com/neoclide/coc.nvim \
&& git -C "/root/.config/nvim/plugged" clone --depth 1 https://github.com/junegunn/fzf.vim \
# Python 
&& git -C "/root/.config/nvim/plugged" clone --depth 1 https://github.com/nvie/vim-flake8 \
&& git -C "/root/.config/nvim/plugged" clone --depth 1 https://github.com/fisadev/vim-isort \
&& git -C "/root/.config/nvim/plugged" clone --depth 1 https://github.com/tell-k/vim-autopep8 \
&& git -C "/root/.config/nvim/plugged" clone --depth 1 https://github.com/tenfyzhong/autoflake.vim \
&& git -C "/root/.config/nvim/plugged" clone --depth 1 https://github.com/Konfekt/FastFold \
# Testing
&& git -C "/root/.config/nvim/plugged" clone --depth 1 https://github.com/janko/vim-test

# Change shell to bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Copy config files
COPY config /root/.config/nvim/

WORKDIR /root

RUN pip3 install pynvim isort

RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'


# Coc extenstions
WORKDIR /root/.config/coc/extensions
    
# NODE
RUN curl -sL https://deb.nodesource.com/setup_current.x | bash - && \
  apt-get install -y nodejs
COPY config/package.json .
RUN npm install
RUN npm install -g neovim

COPY entrypoint.sh /usr/local/bin/

VOLUME "${WORKSPACE}"
VOLUME "${NVIM_CONFIG}"

WORKDIR /root
RUN nvim --headless -c 'UpdateRemotePlugins | qa'

ENTRYPOINT ["sh", "/usr/local/bin/entrypoint.sh"]

