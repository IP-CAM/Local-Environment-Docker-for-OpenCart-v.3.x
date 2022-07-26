# OpenCart Install

## Requirements

- PHP v7.4+
- MariaDB 5.5.64
- [OpenCart v3.0.3.8](https://www.opencart.com/index.php?route=cms/download/download&download_id=64)

### Optional Requirements

- [mkcert](https://github.com/FiloSottile/mkcert): You can install locally-trusted development certificates using the zero-configuration tool.

## Install

Please use the following docker configuration to install via docker locally. Simply copy the contents of the repository to the root of this directory.

Directory structure of the docker install:

- `docker`
    - `certs`
    - `db`
        - `docker-entrypoint-initdb.d`
            - `create_schemas.sql`
        - `mariadb`
    - `.env`
    - `Dockerfile`
    - `vhost-config`
    - `xdebug-3.1.4.ini`
- `docker-compose.yml`
- `Makefile`

### Make certificates

You will need `mkcert` installed in your local environment to proceed.

Move into the `docker/certs` directory. Run the following command to make your locally-trusted development certificates.

You can change the domains as you see fit.

```shell
mkcert store.mydomain.test store.mydomain.local

Note: the local CA is not installed in the Firefox trust store.
Run "mkcert -install" for certificates to be trusted automatically ⚠️

Created a new certificate valid for the following names 📜
 - "store.mydomain.test"
 - "store.mydomain.local"

The certificate is at "./store.mydomain.test+1.pem" and the key at "./store.mydomain.test+1-key.pem" ✅

It will expire on 26 October 2024 🗓
```

Now you will need to change permissions on the new two new files.

```shell
chmod 777 *.pem
```

Move back out to the `docker` directory and open the `vhost-config` file. Here you can adjust the ServerName,
ServerAlias, ServerAdmin, SSLCertificateFile and SSLCertificateKeyFile accordingly.

### /etc/hosts

Be sure to add the domain you are using to the `/etc/hosts` file. Using the example URL we would add something like this
to the file.

```shell
0.0.0.0 store.mydomain.test store.mydomain.local
```

Save your changes.

### OpenCart Download

Download the OpenCart application and unzip. Move the `uploads` directory into the root of this

### OpenCart Config

Move into your opencart directory and use the following command to add `config.php`.

```shell
cp config-dist.php ./config.php ./admin/config.php
```

### Docker Composer

You can review the `docker-composer.yml` file. Adjust the `app.volumes` if necessary.

## Install

Move to the root of the directory and use the following command to build the application.

```shell
make build
```

Once the build has completed, you should be able to complete your install by opening the site in your browser. Have run
into some issues with database and `dbuser`. Feel free to connect to the database using root user and correcting those
user permissions manually, or you can also use `root` to set up locally.

## Make commands

Check out the Makefile for useful commands.

Spin up the application

```shell
make up
```

Shut down the application

```shell
make down
```

Get into shell of the application

```shell
make shell
```

View logs

```shell
make log
```
