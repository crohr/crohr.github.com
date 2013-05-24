---
title: "How to build and publish base boxes for Docker?"
layout: post
tags:
  - docker
  - lxc
  - ubuntu

---

If you don't know about it yet, go check out [Docker](http://docker.io), which makes manipulating LXC containers painless.

Docker comes with a [registry](https://index.docker.io) where you can find images to use for your containers. You can also create and upload your own images in this repository, which is the subject of this article.

* Create an account on the Docker index website: <https://index.docker.io>.

* On your box, login:

          $> docker login
          Username (): crohr
          Password: 
          Email (): cyril.rohr@gmail.com
          Login Succeeded

* For debian-based boxes, just use the [mkimage-debian.sh script in contrib/](https://github.com/dotcloud/docker/blob/master/contrib):

          $> ./mkimage-debian.sh crohr/ubuntu lucid http://archive.ubuntu.com/ubuntu
          ...
          + img=f7e10b978e8c
          + docker tag f7e10b978e8c crohr/ubuntu lucid
          + '[' lucid = wheezy ']'
          + docker run -i -t crohr/ubuntu:lucid echo success
          success
          + '[' lucid '!=' sid -a lucid '!=' unstable ']'
          ++ docker run crohr/ubuntu:lucid cat /etc/debian_version
          + ver=squeeze/sid
          + docker tag f7e10b978e8c crohr/ubuntu squeeze/sid
          2013/05/24 17:05:40 error: Illegal tag name: squeeze/sid

    Note: The second tag is not created, but it does not matter (?).

* Then, check that your image is indeed created:

          $> docker images
          REPOSITORY          TAG                 ID                  CREATED
          crohr/ubuntu        lucid               f7e10b978e8c        34 minutes ago
          ubuntu              latest              8dbd9e392a96        6 weeks ago
          ubuntu              12.10               b750fe79269d        8 weeks ago
          ubuntu              12.04               8dbd9e392a96        6 weeks ago
          ubuntu              quantal             b750fe79269d        8 weeks ago
          ubuntu              precise             8dbd9e392a96        6 weeks ago

* Now push it to the central repository:

          $> docker push crohr/ubuntu
          The push refers to a repository [crohr/ubuntu] (len: 1)
          Processing checksums
          Sending image list
          Pushing repository crohr/ubuntu to registry-1.docker.io (1 tags)
          Pushing f7e10b978e8c15bde845374c490862befb181f0943a0ae2076d070573a435b16
          145858560/145858560 (100%)
          Pushing tags for rev [f7e10b978e8c15bde845374c490862befb181f0943a0ae2076d070573a435b16] on {registry-1.docker.io/users/crohr/ubuntu/lucid}

That's it! Now other people can pull your images using `docker pull crohr/ubuntu`.
