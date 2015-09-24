#!/bin/sh

NAME=${1}
TAGS=${2:-''}

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

FAIL="${RED}\n
________________  .___.____
\_   _____/  _  \ |   |    |
 |    __)/  /_\  \|   |    |
 |     \/    |    \   |    |___
 \___  /\____|__  /___|_______ \\
     \/         \/            \/
${NC}";

SUCCESS="${GREEN}\n
  _____________ ____________ _________ ___________ _________ _________
 /   _____/    |   \_   ___ \\\\_   ___ \\_   _____//   _____//   _____/
 \_____  \|    |   /    \  \//    \  \/ |    __)_ \_____  \ \_____  \\
 /        \    |  /\     \___\     \____|        \/        \/        \\
/_______  /______/  \______  /\______  /_______  /_______  /_______  /
        \/                 \/        \/        \/        \/        \/
${NC}";

if [ ! $NAME ]; then
    echo "$FAIL"
    echo "You need to pass client's NAME to deploy to:"
    echo " /bin/deploy.sh NAME";
    echo " Possibile NAMEs:";
    echo " $(ls clients)";
    exit;
fi

# Check latest dependency and force install all dependencies if not found
if [ ! -d "vendor/roles/Stouts.postfix/" ]; then
    ansible-galaxy install -r requirements.yml --force
fi

if [ ! $TAGS ]; then
    sudo ansible-playbook playbook.yml -vv -i "clients/$NAME/inventory" --extra-vars="@clients/$NAME/private.yml"
else
    sudo ansible-playbook playbook.yml -vv -i "clients/$NAME/inventory" --extra-vars="@clients/$NAME/private.yml" --tags="$TAGS"
fi

if [ $? -eq 0 ]; then
    echo "$SUCCESS"
else
    echo "$FAIL"
fi
