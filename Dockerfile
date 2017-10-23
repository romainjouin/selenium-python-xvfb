FROM ubuntu:14.04

ENV BROWSER Firefox
ENV DISPLAY :99

#================================================
# Installations
#================================================

RUN apt-get update && apt-get install -y $BROWSER \
        build-essential libssl-dev python-setuptools \
        vim xvfb xz-utils zlib1g-dev

RUN easy_install pip

RUN pip install selenium pyvirtualdisplay requests unittest-xml-reporting

#==================
# Vim highlight
#==================

RUN echo "syntax on" >> /etc/vim/vimrc

#==================
# Xvfb + init scripts
#==================
ADD libs/xvfb_init /etc/init.d/xvfb
RUN chmod a+x /etc/init.d/xvfb

ADD libs/xvfb-daemon-run /usr/bin/xvfb-daemon-run
RUN chmod a+x /usr/bin/xvfb-daemon-run




ENV downloads /downloads
RUN mkdir $downloads

RUN apt-get update && \ 
	apt-get install -y wget libglib2.0-0
	
ENV anaconda_url https://repo.continuum.io/archive/Anaconda3-5.0.0.1-Linux-x86_64.sh
ENV anaconda_path /opt/anaconda
ENV PATH $anaconda_path/bin:$PATH

# If we don't do %matplotlib inline,
# It requires PyQt4 which requires a lot of stuff: ldd /opt/anaconda/lib/libQtGui.so
# libgthread-2.0.so.0 -> apt-get install libglib2.0-0
# libXext.so.6 -> apt-get install libxext6
# ...

# Remove cached package tarballs.
RUN wget -nv -O $downloads/anaconda.sh $anaconda_url && \
	/bin/bash $downloads/anaconda.sh -b -p $anaconda_path && \
	conda update -y conda && \
	conda update -y numpy && \
	conda update -y scipy && \
	conda update -y pandas && \
	rm $downloads/anaconda.sh && \
	conda clean -yt

RUN conda info -a

#============================
# Clean up
#============================
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

RUN ipython -c "print ('Hello World')"
