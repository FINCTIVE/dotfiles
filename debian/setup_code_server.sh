#!/bin/sh

echo "install https://code-server.dev"

curl -fsSL https://code-server.dev/install.sh | sh
mkdir -p ~/.config/code-server

cat > ~/.config/code-server/config.yaml <<EOF
bind-addr: 0.0.0.0:4000
cert: false

# auth: none

auth: password
password: code-server-password
EOF

# check systemd
if command -v systemctl &> /dev/null
then
    sudo systemctl enable --now code-server@$USER
    echo "code-server addr: localhost:4000"
    echo "password: code-server-password"
    echo "NOTICE: Change the password!"
fi