#!/bin/bash
echo "-----------------------------------------------------------------------------"
curl -s https://raw.githubusercontent.com/Bitoliy/Nodes/main/Tools/Ward_Activity.sh | bash
echo "-----------------------------------------------------------------------------"

echo "-----------------------------------------------------------------------------"
echo "Выполняем Обновление"
echo "-----------------------------------------------------------------------------"

cd ~/bundlr/validator-rust
git pull origin master
git submodule update --init --recursive
docker-compose up --build -d

echo "-----------------------------------------------------------------------------"
echo "Обновление Завершено"
echo "-----------------------------------------------------------------------------"
