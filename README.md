# DevTernity 2018 AWS Workshop

Welcome to AWS workshop. This should be fun. Below you'll find some useful links and configuration snippets we are going to use during the workshop.

## AWS access

[Default AWS URL](https://aws.amazon.com)

[DevTernity Account AWS Sign-in URL](https://devternity2018.signin.aws.amazon.com/console)

## Helpful resources

[EC2 Pricing Comparison](http://ec2pricing.net/)

[AWS Service Health Dashboard](https://status.aws.amazon.com/)

[AWS Calculator](https://calculator.s3.amazonaws.com/index.html)

## How to create and use SSH key for AWS

[Converting Your Private Key Using PuTTYgen (Windows)](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/putty.html#putty-private-key)

[Retrieving the Public Key for Your Key Pair](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#retrieving-the-public-key)

## EC2 metadata for Ubuntu

Works on first boot or execute this before stopping an instance:

 `rm /var/lib/cloud/instances/*/sem/config_scripts_user`

```cloud-init
#cloud-config

runcmd:
  - echo "--- Install Dependencies ---"
  - apt-get update
  - apt-get install -y apt-transport-https ca-certificates curl software-properties-common git wget apache2-utils
  - echo "--- Install Docker ---"
  - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  - add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  - apt-get update
  - apt-get install -y docker-ce
  - usermod -aG docker ubuntu
  - echo "--- Install Docker Compose ---"
  - curl -fsSL -o /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/1.23.1/docker-compose-`uname -s`-`uname -m`
  - chmod +x /usr/local/bin/docker-compose
```

## Thumbor setup

```bash
mkdir thumbor
wget https://
docker-compose up -d
```

### Have fun with Thumbor

[Image with Scarlett Johannson](https://papers.co/wallpaper/papers.co-ho52-scarlett-johansson-girl-film-sexy-hero-33-iphone6-wallpaper.jpg)

```bash
Crop image to 800x800 with face detection
http://INSTANCE_IP/unsafe/800x800/https://papers.co/wallpaper/papers.co-ho52-scarlett-johansson-girl-film-sexy-hero-33-iphone6-wallpaper.jpg

Crop image to 1000x1000 and put DevTernity watermark http://devternity.com/images/logo_2017.png
http://INSTANCE_IP/unsafe/1000x1000/filters:watermark(https://devternity.com/images/logo_2017.png,520,-120,0)/https://papers.co/wallpaper/papers.co-ho52-scarlett-johansson-girl-film-sexy-hero-33-iphone6-wallpaper.jpg
```

## Launch template EC2 metadata for Ubuntu

```cloud-init
#cloud-config

runcmd:
  - echo "--- Install Dependencies ---"
  - apt-get update
  - apt-get install -y apt-transport-https ca-certificates curl software-properties-common git apache2-utils
  - echo "--- Install Docker ---"
  - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  - add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  - apt-get update
  - apt-get install -y docker-ce
  - usermod -aG docker ubuntu
  - echo "--- Install Docker Compose ---"
  - curl -fsSL -o /usr/local/bin/docker-compose https://github.com/docker/compose/releases/download/1.23.1/docker-compose-`uname -s`-`uname -m`
  - chmod +x /usr/local/bin/docker-compose
  - echo "--- Deploy Thumbor ---"
  - mkdir -p /opt/thumbor
  - curl -fsSL -o /opt/thumbor/docker-compose https://raw.githubusercontent.com/juris/devternity2018/master/thumbor/docker-compose.yml
  - docker-compose up -d -f /opt/thumbor/docker-compose.yml
```

## Stress test service to check AutoScaling

No need to saturate network in our class. You can ssh to one of the instances and launch apache benchmark from there.

`ab -c 50 -n 1000000 http://ALB_IP/unsafe/1000x1000/filters:watermark\(https://devternity.com/images/logo_2017.png,520,-120,0\)/https://papers.co/wallpaper/papers.co-ho52-scarlett-johansson-girl-film-sexy-hero-33-iphone6-wallpaper.jpg`
