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

    sudo su - odoo

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

    exit
#  " 9. Create the odoo.conf file using the nano text editor: "

    sudo nano /odoo/151/odoo.conf

    [options]
    ; Database operations password:
    admin_passwd = PASSWORD
    db_host = False
    db_port = False
    db_user = odoo
    db_password = False
    addons_path = /opt/odoo/odoo/addons,/opt/odoo/odoo-custom-addons

#  " 10. Create the odoo.service file with: "

    sudo nano /etc/systemd/system/odoo.service
    cat <<EOF >filename
    first line
    second line
    third line
    EOF
    #    Paste the following contents into the file:

    [Unit]
    Description=Odoo
    Requires=postgresql.service
    After=network.target postgresql.service
    [Service]
    Type=simple
    SyslogIdentifier=odoo
    PermissionsStartOnly=true
    User=odoo
    Group=odoo
    ExecStart=/opt/odoo/odoo-venv/bin/python3 /opt/odoo/odoo/odoo-bin -c /etc/odoo.conf
    StandardOutput=journal+console
    [Install]
    WantedBy=multi-user.target


#  "  11. Update the service list: "

    sudo systemctl daemon-reload

#  "  1. Enable the Odoo service on system startup: "

    sudo systemctl enable --now odoo

# "  3. The journalctl file contains all the information about the running service: "

    sudo journalctl -u odoo

    

     




    





    


    
    
git clone  https://github.com/BS-Eg/DockerBS
cd /DockerBS
cp -r -f runme.sh /odoo
cd /odoo
chmod +x  runme.sh
./runme.sh
