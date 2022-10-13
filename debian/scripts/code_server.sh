#!/bin/sh
echo "install https://code-server.dev"
if [ -x "$(command -v code-server)" ]; then
  echo "code-server is already installed, exit."
  exit 1
fi

curl -fsSL https://code-server.dev/install.sh | sh
mkdir -p ~/.config/code-server

cat > ~/.config/code-server/config.yaml <<EOF
bind-addr: 0.0.0.0:4000
cert: false

# auth: none

auth: password
password: code-server-password
EOF

echo "config file: ~/.config/code-server/config.yaml"
echo "sudo systemctl enable --now code-server@$USER"
echo "code-server addr: localhost:4000"
echo "password: code-server-password"
echo "NOTICE: Change the password!"
