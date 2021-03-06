# DevTernity 2018 AWS Workshop

Welcome to AWS workshop. This should be fun. Below you'll find some useful links and configuration snippets we are going to use during the workshop.

## AWS Access

[AWS](https://aws.amazon.com)

[AWS Free Tier](https://aws.amazon.com/free/)

[Workshop AWS Account](https://devternity2018.signin.aws.amazon.com/console)

## Helpful Resources

[EC2 Pricing Comparison](http://ec2pricing.net/)

[AWS Service Health Dashboard](https://status.aws.amazon.com/)

[AWS Calculator](https://calculator.s3.amazonaws.com/index.html)

## How To Create And Use SSH Keys For AWS

[Converting Your Private Key Using PuTTYgen (Windows)](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/putty.html#putty-private-key)

[Retrieving the Public Key for Your Key Pair](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#retrieving-the-public-key)

## EC2 Metadata For Ubuntu

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

## Thumbor Setup

```bash
sudo mkdir -p /opt/thumbor
sudo curl -fsSL -o /opt/thumbor/docker-compose.yml https://raw.githubusercontent.com/juris/devternity2018/master/thumbor/docker-compose.yml
REDIS_HOST="redis" docker-compose -f /opt/thumbor/docker-compose.yml up -d
```

### Have Fun With Thumbor

[Image with Scarlett Johannson](https://papers.co/wallpaper/papers.co-ho52-scarlett-johansson-girl-film-sexy-hero-33-iphone6-wallpaper.jpg)

```bash
# Crop image to 800x800 with face detection
http://INSTANCE_IP/unsafe/800x800/https://papers.co/wallpaper/papers.co-ho52-scarlett-johansson-girl-film-sexy-hero-33-iphone6-wallpaper.jpg

# Crop image to 1000x1000 and put DevTernity watermark http://devternity.com/images/logo_2017.png
http://INSTANCE_IP/unsafe/1000x1000/filters:watermark(https://devternity.com/images/logo_2017.png,520,-120,0)/https://papers.co/wallpaper/papers.co-ho52-scarlett-johansson-girl-film-sexy-hero-33-iphone6-wallpaper.jpg
```

## Launch Template EC2 Metadata For Ubuntu

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
  - curl -fsSL -o /opt/thumbor/docker-compose.yml https://raw.githubusercontent.com/juris/devternity2018/master/thumbor/docker-compose.yml
  - REDIS_HOST="redis" docker-compose -f /opt/thumbor/docker-compose.yml up -d
```

## Stress Test Service To Check AutoScaling

No need to saturate network in our class. You can ssh to one of the instances and launch apache benchmark from there.

```bash
ab -c 50 -n 1000000 http://dt2018-prod-alb01-333094156.eu-central-1.elb.amazonaws.com/unsafe/1000x1000/filters:watermark\(https://devternity.com/images/logo_2017.png,520,-120,0\)/https://papers.co/wallpaper/papers.co-ho52-scarlett-johansson-girl-film-sexy-hero-33-iphone6-wallpaper.jpg
```

## Configure Service With ElastiCache Redis

Update cloud-init with the new REDIS_HOST env variable.

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
  - curl -fsSL -o /opt/thumbor/docker-compose.yml https://raw.githubusercontent.com/juris/devternity2018/master/thumbor/docker-compose.yml
  - REDIS_HOST="AWS_ELASTICACHE_ENDPOINT" docker-compose -f /opt/thumbor/docker-compose.yml up -d
```
