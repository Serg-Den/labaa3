FROM debian
WORKDIR /var/www/labaOS3.com
RUN apt-get -qq update && \
    apt-get autoclean && \
    apt-get install -y nginx && \
    rm -rf /var/www/* && \
    mkdir /var/www/labaOS3.com && \
    mkdir /var/www/labaOS3.com/img 

COPY index.html /var/www/labaOS3.com

COPY img.jpg /var/www/labaOS3.com/img

RUN chmod -R 754 /var/www/labaOS3.com && \
    useradd Serg && \
    groupadd Denisov && \
    usermod -aG Denisov Serg && \
    chown -R Serg:Denisov /var/www/labaOS3.com

RUN sed -i 's/html/labaOS3.com/g' /etc/nginx/sites-enabled/default && \
    sed -i 's/www-data/Serg/g' /etc/nginx/nginx.conf && \
    sed -i 's/index.htm/index.html/g' /etc/nginx/sites-enabled/default

CMD ["nginx","-g","daemon off;"]
