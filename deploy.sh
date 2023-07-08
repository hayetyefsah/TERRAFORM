#!/bin/bash
​
apt  -y update && apt -y upgrade
​
apt -y install git
apt -y install pip
apt install python3.11
apt install python3.11-venv
pip install flask
apt install net-tools
git clone https://github.com/hfdevEX/app_flask.git
cd ./app_flask
sed -i 's/load_balancer/localhost:5022/' client.py
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
flask --app server run -p 5022 >> log_server.txt &
netstat -planet | grep "5022" > \dev\null
while [ $? -ne 0 ]
do
sleep 1
netstat -planet | grep "5022" > \dev\null
done
# ​
# flask --app client run  -p 5011 --host 0.0.0.0  --debug >> log_client.txt &
# ​
# ​
# netstat -planet | grep "5011" > \dev\null
# while [ $? -ne 0 ]
# do
# ​
# sleep 1
# netstat -planet | grep "5011" > \dev\null
# done
# echo "server"
