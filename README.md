# MintegiMoves

Minimal CMS for the website:

- http://mintegimoves.com

## Docker

### Install server basics
    ./server_setup.sh

### Restore backups

Go to S3 to get the backups

    docker exec -i a324c67ea86f mysql -uroot -proot hpq < /tmp/hpq.20180629.daily.sql
    mv /tmp/public/paperclip/production/* /var/apps/MintegiMoves/public/paperclip/production/

### Redeploy

    ssh root@mintegimoves.com
    cd /var/apps/MintegiMoves
    git pull
    docker-compose restart app
    docker-compose restart web

### Consoling

    docker-compose exec app bundle exec rails c
    docker-compose exec db mysql -uroot -p hpq
