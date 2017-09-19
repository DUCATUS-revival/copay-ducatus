#!/bin/bash
find . -type f -not -path "./post_fixups.sh*" -not -path ".git/*" -exec sed -i 's#https://dws.ducatus.io#http://bws-1.twocatus.org:3232#g' {} +
find . -type f -not -path "./post_fixups.sh*" -not -path ".git/*" -exec sed -i 's/BTC/DTC/g' {} +
find . -type f -not -path "./post_fixups.sh*" -not -path ".git/*" -exec sed -i 's/Bitcoin/Ducatuscoin/g' {} +
find . -type f -not -path "./post_fixups.sh*" -not -path ".git/*" -exec sed -i 's/bitcoin/ducatuscoin/g' {} +
