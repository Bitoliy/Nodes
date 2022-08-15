#!/bin/bash

function logo {
  curl -s https://raw.githubusercontent.com/Bitoliy/Nodes/main/Tools/Ward_Activity.sh | bash
}

function line {
  echo "-----------------------------------------------------------------------------"
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
  git reset --hard
  git fetch
  git checkout 025-helike && cargo update
}

function build_penumbra {
  if [ ! -d $HOME/penumbra/ ]; then
    cd $HOME/penumbra/
    cargo build --release --bin pcli
    sudo rm -f /usr/bin/pcli
    sudo cp target/release/pcli /usr/bin/pcli
  else
    source_git
    cd $HOME/penumbra/
    cargo build --release --bin pcli
    sudo rm -f /usr/bin/pcli
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
  pcli wallet generate
}

function reset_wallet {
  cd $HOME/penumbra/
  pcli wallet reset
}

function rust_update {
  source ~/.cargo/env
  rustup update
  rustup default nightly
}


colors

line
logo
line
echo -e "${RED}Начинаем обновление ${NORMAL}"
line
echo -e "${GREEN}1/2 Обновляем репозиторий ${NORMAL}"
source_git
line
echo -e "${GREEN}2/2 Начинаем строить ${NORMAL}"
rust_update
line
# build_penumbra
wget_bin_pcli
reset_wallet
line
echo -e "${RED}Скрипт завершил свою работу ${NORMAL}"
