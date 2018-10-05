FROM jupyter/scipy-notebook
expose 8888

# copy jupyter souce & resource
USER $NB_UID
ADD src $HOME
USER root
RUN chown $NB_UID $HOME/*

# install noto font
USER root
ADD https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip /var/tmp/NotoSansCJKjp-hinted.zip
RUN mkdir /var/tmp/NotoSansCJKjp-hinted
WORKDIR /var/tmp/NotoSansCJKjp-hinted
RUN unzip /var/tmp/NotoSansCJKjp-hinted.zip
RUN mkdir -m 755 -p /usr/local/share/fonts/opentype/noto
RUN cp *.otf /usr/local/share/fonts/opentype/noto
RUN chmod 644 /usr/local/share/fonts/opentype/noto/*.otf
RUN fc-cache -f -v

WORKDIR $HOME
USER $NB_UID
RUN rm -Rf .cache/matplotlib/*
