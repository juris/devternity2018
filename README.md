# DevTernity 2018 AWS Workshop

Welcome to AWS workshop. This should be fun. Below you'll find some useful links and configuration snippets we are going to use during the workshop.

## AWS Access

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
  - apt-get install -y apt-transport-https ca-certificates curl software-properties-common git
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
Crop image to 500x500 with face detection
http://YOUR_IP/unsafe/500x500/https://papers.co/wallpaper/papers.co-ho52-scarlett-johansson-girl-film-sexy-hero-33-iphone6-wallpaper.jpg

Crop image to 600x600 and put DevTernity watermark http://devternity.com/images/logo_2017.png
http://YOUR_IP/unsafe/600x600/filters:watermark(https://devternity.com/images/logo_2017.png,300,-30,50)/https://papers.co/wallpaper/papers.co-ho52-scarlett-johansson-girl-film-sexy-hero-33-iphone6-wallpaper.jpg
```