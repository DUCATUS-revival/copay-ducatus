#!/bin/bash
find . -type f -not -path "./post_fixups.sh*" -not -path ".git/*" -exec sed -i 's#http://bws-1.twocatus.org:3232#https://dws.ducatus.io#g' {} +
find . -type f -not -path "./post_fixups.sh*" -not -path ".git/*" -exec sed -i 's/BTC/DTC/g' {} +
find . -type f -not -path "./post_fixups.sh*" -not -path ".git/*" -exec sed -i 's/Bitcoin/Ducatuscoin/g' {} +
find . -type f -not -path "./post_fixups.sh*" -not -path ".git/*" -exec sed -i 's/bitcoin/ducatuscoin/g' {} +
