
pkill Fulcrum

rm -rf  /home/reza/ln-dev/fulcrum-data/
mkdir -p /home/reza/ln-dev/fulcrum-data/

/home/reza/ln-dev/fulcrum/Fulcrum -C /home/reza/ln-dev/fulcrum/fulcrum-quick-config.conf > ./FULCRUM_LOG  2>&1 &

sleep 2

