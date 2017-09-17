#!/bin/bash
find . -type f -not -path "./post_fixups.sh*" -exec sed -i 's#http://127.0.0.1:3232#http://bws-1.twocatus.org:3232#g' {} +
find . -type f -not -path "./post_fixups.sh*" -exec sed -i 's/BTC/DTC/g' {} +
find . -type f -not -path "./post_fixups.sh*" -exec sed -i 's/Bitcoin/Ducatuscoin/g' {} +
find . -type f -not -path "./post_fixups.sh*" -exec sed -i 's/bitcoin/ducatuscoin/g' {} +
