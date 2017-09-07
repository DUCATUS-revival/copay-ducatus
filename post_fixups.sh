#!/bin/bash
cp networks.js node_modules/bitcore-lib/lib/
find . -type f -exec sed -i 's#http://127.0.0.1:3232#http://127.0.0.1:3232#g' {} +
