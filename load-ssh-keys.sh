# Ensure the user's .ssh directory exists
mkdir -p ~/.ssh
# Copy Github keys to local .ssh directory
curl  -sSf https://github.com/mcajben.keys -o ~/.ssh/authorized_keys
