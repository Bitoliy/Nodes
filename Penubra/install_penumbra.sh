#!/bin/bash

function logo {
  curl -s https://raw.githubusercontent.com/Bitoliy/Nodes/main/Tools/Ward_Activity.sh | bash
}

function line {
  echo -e "-----------------------------------------------------------------------------"
}

function colors {
  GREEN="\e[1m\e[32m"
  RED="\e[1m\e[39m"
  NORMAL="\e[0m"
}

function install_tools {
  curl -s https://raw.githubusercontent.com/Bitoliy/Nodes/main/Tools/install_ufw.sh | bash &>/dev/null
  curl -s https://raw.githubusercontent.com/Bitoliy/Nodes/main/Tools/install_rust.sh | bash &>/dev/null
  source ~/.cargo/env
  rustup default nightly
  sleep 1
}

function source_git {
  if [ ! -d $HOME/penumbra/ ]; then
    git clone https://github.com/penumbra-zone/penumbra
  fi
  cd $HOME/penumbra
  git fetch
  git checkout 025-helike && cargo update
}

function build_penumbra {
  if [ ! -d $HOME/penumbra/ ]; then
    cd $HOME/penumbra/
    cargo build --release --bin pcli
    sudo cp target/release/pcli /usr/bin/pcli
  else
    source_git
    cd $HOME/penumbra/
    cargo build --release --bin pcli
    sudo cp target/release/pcli /usr/bin/pcli
  fi
}

function wget_bin_pcli {
  mkdir -p $HOME/penumbra/target/release/
  wget -O  $HOME/penumbra/target/release/pcli https://doubletop-bin.ams3.digitaloceanspaces.com/penumbra/025-helike/pcli
  sudo chmod +x $HOME/penumbra/target/release/pcli
  sudo cp $HOME/penumbra/target/release/pcli /usr/bin/pcli
}

function generate_wallet {
  cd $HOME/penumbra/
  mkdir -p $HOME/.local/share/penumbra-testnet-archive/
  pcli wallet generate
}

colors

line
logo
line
echo -e "${RED}Начинаем установку ${NORMAL}"
line
echo -e "${GREEN}1/5 Устанавливаем софт ${NORMAL}"
line
install_tools
line
echo -e "${GREEN}2/5 Клонируем репозиторий ${NORMAL}"
line
source_git
line
echo -e "${GREEN}3/5 Начинаем строить ${NORMAL}"
line
# build_penumbra
wget_bin_pcli
line
echo -e "${GREEN}4/5 Создаем кошелек ${NORMAL}"
line
generate_wallet
line
echo -e "${GREEN}5/5 Кошелек успешно создан, следуйте по гайду дальше ${NORMAL}"
line
echo -e "${RED}Скрипт завершил свою работу ${NORMAL}"
