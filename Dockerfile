FROM nginx
MAINTAINER dev.ukatama@gmail.com

RUN apt-get update -yq
RUN apt-get install -yq wget zip ruby

WORKDIR /usr/local/src
RUN wget http://www.dodontof.com/DodontoF/DodontoF_Ver.1.47.17.zip -q -O DodontoF.zip
RUN unzip DodontoF.zip
RUN rm DodontoF.zip
RUN bash -c 'sed -i -e "1s|/usr/local/bin/ruby|$(which ruby)|" DodontoF_WebSet/public_html/DodontoF/*.rb'
RUN chown -R www-data:www-data DodontoF_WebSet
RUN chmod +x DodontoF_WebSet/public_html/DodontoF/*.rb

WORKDIR /
RUN apt-get remove -yq wget zip
RUN apt-get autoremove -yq
RUN apt-get clean -yq

RUN apt-get install -yq fcgiwrap spawn-fcgi
COPY nginx.conf /etc/nginx/nginx.conf
COPY fcgiwrap /etc/default/fcgiwrap

CMD /etc/init.d/fcgiwrap start && nginx -g "daemon off;"
EXPOSE 80
