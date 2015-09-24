# ansible-playbook-symfony

Ansible playbook to configure server and install symfony2 apps.

## Add new client

```bash
mkdir clients/NAME
echo "YOUR_HOST ansible_ssh_host=YOUR_IP" > clients/NAME/inventory
```

Don't forget to replace `NAME`, `YOUR_HOST` and `YOUR_IP` with actual values.

Edit parameters such as passwords, logins, etc:

```bash
cp clients/private.yml.dist clients/NAME/private.yml
nano clients/NAME/private.yml
```

## Add new app

Add your app settings to `vars/symfony2-yourapp.yml` and include this file from `playbook.yml`.

Add new records to:

```
vars/apache.yml
vars/mysql.yml
vars/cron.yml
```

## Test

Run:

```
cd tests
cp Vagrantfile.dist Vagrantfile
nano Vagrantfile # Put your github oauth key
vagrant up --provision
```

Add `192.168.2.2 vagrant-crm.com` to `/etc/hosts` and open `vagrant-crm.com` in your browser to see result.

## Run

To provision and deploy your app to servers listed at `clients/NAME/inventory`, run:

```bash
bin/deploy.sh NAME
```

Second time you may pass tags to run only needed part of playbook:

```bash
bin/deploy.sh NAME EXTRA_TAGS
```
