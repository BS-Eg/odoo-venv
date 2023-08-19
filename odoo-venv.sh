# " Install Odoo on Ubuntu "

# " Step 1: Update Repository "

    apt update && apt upgrade -y
    apt install git -y
    
    cd /
    mkdir -p odoo      
    mkdir -p odoo/151      
    mkdir -p odoo/161
    mkdir -p odoo/code
    
    cd /odoo/151

# " Step 2: Install Odoo Dependencies "

    sudo apt install -y build-essential wget python3-dev python3-venv python3-wheel libfreetype6-dev libxml2-dev libzip-dev libldap2-dev libsasl2-dev python3-setuptools node-less libjpeg-dev zlib1g-dev libpq-dev libxslt1-dev libldap2-dev libtiff5-dev libjpeg8-dev libopenjp2-7-dev liblcms2-dev libwebp-dev libharfbuzz-dev libfribidi-dev libxcb1-dev


# " Step 3: Create Odoo User "

    sudo useradd -m -d /opt/odoo -U -r -s /bin/bash odoo

# " Step 4: Create User odoo in Postgresql

    sudo su - postgres -c "createuser -s odoo"

# " Step 5: Install Last Version From wkhtmltopdf "

    sudo apt install wkhtmltopdf -y
    
# " clone Last Specify Requierd Version From odoo To Specify Location "

    git clone https://www.github.com/odoo/odoo --depth 1 --branch 15.0 /odoo/151


# " 1. Switch to the odoo user with the sudo su command: "

##    sudo su - odoo

# " Create Virtual venv Called .env
    
    python3 -m venv .env

#  " Activate this venv derive "

    source .env/bin/activate

# " Install wheel And Requierd "

    pip3 install wheel
    pip3 install -r odoo/requirements.txt
    
# " exit from venv mode  "
    
    deactivate

# " 7. Create a separate directory for custom addons:"

    mkdir /odoo/151/custom

    
# " 8. Switch back to the sudo user with: "

##    exit

#  " 9. Create the odoo.conf file using the nano text editor: "

    sudo touch /odoo/151/odoo.conf


        echo "[options] " >> odoo.conf
        echo "; Database operations password: " >> odoo.conf
        echo "admin_passwd = PASSWORD " >> odoo.conf
        echo "db_host = False " >> odoo.conf
        echo "db_port = False " >> odoo.conf
        echo "db_user = odoo " >> odoo.conf
        echo "db_password = False " >> odoo.conf
        echo "addons_path = /opt/odoo/odoo/addons,/opt/odoo/odoo-custom-addons " >> odoo.conf


#  " 10. Create the odoo.service file with: "

    touch /lib/systemd/system/odoo.service

        echo "[Unit]">>odoo.service
        echo "Description=Odoo">>odoo.service
        echo "Requires=postgresql.service">>odoo.service
        echo "After=network.target postgresql.service">>odoo.service
        echo "[Service]">>odoo.service
        echo "Type=simple">>odoo.service
        echo "SyslogIdentifier=odoo">>odoo.service
        echo "PermissionsStartOnly=true">>odoo.service
        echo "User=odoo">>odoo.service
        echo "Group=odoo">>odoo.service
        echo "ExecStart=/opt/odoo/odoo-venv/bin/python3 /odoo/151/odoo-bin -c /odoo/151/odoo.conf">>odoo.service
        echo "StandardOutput=journal+console">>odoo.service
        echo "[Install]">>odoo.service
        echo "WantedBy=multi-user.target">>odoo.service">>odoo.service

    #    Paste the following contents into the file:

 


#  "  11. Update the service list: "

    sudo systemctl daemon-reload

#  "  1. Enable the Odoo service on system startup: "

    sudo systemctl enable --now odoo

# "  3. The journalctl file contains all the information about the running service: "

    sudo journalctl -u odoo

    
