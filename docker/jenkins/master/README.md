# Jenkins Master on Docker

This recipe is a remix of the dockerized Jenkins master setup described in the Riot Games Engineering blog [post](https://engineering.riotgames.com/news/taking-control-your-docker-image). I found this blog series a good and elucidating resource. It cleared things up for me on how to containerize the Jenkins master.

I adjusted this recipe to use Debian Stretch in place of Jessie. It also uses the Sun/Oracle JDK in place of OpenJDK. I made small adjustments to Debian updates, Tini setup, and the Jenkins download. I downsized the memory footprint of the Jenkins master to 2gb for use in a laptop or small server environment. This should be raised to Riot Games recommendation (8gb) or as deployment needs and preferences dictate.

Care should be taken in maintenance to upgrade the JDK and Jenkins versions as new releases of these become available. This recipe uses setup scripts from the [CloudBees Jenkins](https://github.com/jenkinsci/docker) reference container. These scripts are included here for convenience and it is advised to consider updating them as CloudBees makes changes.

To build this set of containers use:

```
docker-compose build
```

To run the containers use:

```
docker-compose up -d
```

The Jenkins master will be available on the NGINX front end at `localhost:80`. Adjust the port mapping if needed to avoid ports conflict with other containers or services.

