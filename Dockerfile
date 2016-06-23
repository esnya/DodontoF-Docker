FROM nginx
MAINTAINER dev.ukatama@gmail.com

RUN apt-get update -yq
RUN apt-get install -yq wget zip ruby

WORKDIR /usr/local/src
RUN wget http://www.dodontof.com/DodontoF/DodontoF_Ver.1.48.10.zip -q -O DodontoF.zip \
    && unzip DodontoF.zip \
    && rm DodontoF.zip \
    && bash -c 'sed -i -e "1s|/usr/local/bin/ruby|$(which ruby)|" DodontoF_WebSet/public_html/DodontoF/*.rb' \
    && chown -R www-data:www-data DodontoF_WebSet \
    && chmod +x DodontoF_WebSet/public_html/DodontoF/*.rb

WORKDIR /
RUN apt-get remove -yq wget zip \
    && apt-get autoremove -yq \
    && apt-get clean -yq

RUN apt-get install -yq fcgiwrap spawn-fcgi
COPY nginx.conf /etc/nginx/nginx.conf
COPY fcgiwrap /etc/default/fcgiwrap

CMD /etc/init.d/fcgiwrap start && nginx -g "daemon off;"
EXPOSE 80
