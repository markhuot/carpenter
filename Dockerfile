FROM ubuntu:latest
MAINTAINER Mark Huot <mark@markhuot.com>

# Base install
RUN apt-get update -y
RUN apt-get install -y vim git-core build-essential g++ libssl-dev curl wget apache2-utils libxml2-dev php5-cli

# Install NVM
RUN git clone https://github.com/creationix/nvm.git /.nvm
RUN echo ". /.nvm/nvm.sh" >> /etc/bash.bashrc

# Install node.js
RUN /bin/bash -c '. /.nvm/nvm.sh && nvm install v0.10.18 && nvm use v0.10.18 && nvm alias default v0.10.18 && ln -s /.nvm/v0.10.18/bin/node /usr/bin/node && ln -s /.nvm/v0.10.18/bin/npm /usr/bin/npm'

# Install Grunt CLI
RUN npm install --silent -g grunt-cli bower

# Install RVM
RUN curl -L https://get.rvm.io | bash -s stable
RUN echo "source /usr/local/rvm/scripts/rvm" >> /etc/bash.bashrc

# Update $PATH with RVM
ENV PATH /usr/local/rvm/bin:$PATH

# Check requirements
RUN rvm requirements

# Install Ruby
RUN rvm install 2.0.0 --default

# Update $PATH with RVM
ENV PATH /usr/local/rvm/gems/ruby-2.0.0-p481/bin:/usr/local/rvm/gems/ruby-2.0.0-p481@global/bin:/usr/local/rvm/rubies/ruby-2.0.0-p481/bin:$PATH

# Install Bundler
RUN gem install bundler --no-ri --no-rdoc

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/
RUN mv /composer.phar /usr/bin/composer

# Add Compiler
ADD ./compile.sh /usr/bin/walle-compile
RUN chmod 755 /usr/bin/walle-compile