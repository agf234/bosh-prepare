#!/bin/bash
#
# Script to setup a bosh ambient, before any deployment.
# Works on CentOS and Fedora
#
# Autor: Andres Lucas Garcia Fiorini
# Date:  01/02/2017
#
echo "
      \`:                                                                                  
    \`'''':                                                                                
  \`'''''''',                                                                              
 '''''''''''',        ##      ###\`  ######### ;######'  #########,  #######.  +#######\`  \`
;''''+  +'''''       ####     ###\`     ###   ,###  ###' ###:  :### ###'  ### :####;\`\`\`    
;'''+    +''''      #'####\`   ###\`     ###   ###+  :### ###;.,+##' ###   ###+ #####:      
;''+ '+   +'''     #:  ####\`  ###\`     ###   ###+  :### ###;:###   ###   ####  '#####     
;'+ +''+   +''    #:    ####. ###\`     ###   ###+  :### ###; :###  ###   ###;    #####    
;+     ++   ''   ######. ####,.####### ###    ###';###\` ###;  ,### '###;+### .########    
;'''''''''''''  :++++++\`  #++#  ;++++# #+#     '+++++   +++,   ,+++ .+++++;  .+++++#'     
''''''''''''''                                                                            
 ,'''''''''';                                                                             
   ,'''''''                                                                               
     ,'''                                                                                 
"

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
if [ $? != 0 ];
then
  echo "Error installing gpg keys for rvm"
  exit 254;
fi
if ! /usr/local/rvm/bin/rvm list;
then
\curl -sSL https://get.rvm.io | bash -s stable --ruby
if [ $? != 0 ];
then
  echo "Error in rvm install"
  exit 253;
fi
fi
source /etc/profile
source ~/.profile
source ~/.bash_profile
source ~/.bashrc

if ! rvm use 1.9.3;
then
rvm install 1.9.3
if [ $? != 0 ];
then
  echo "Error en yum install"
  exit 252;
fi

rvm use 1.9.3
if [ $? != 0 ];
then
  echo "Error en yum install"
  exit 251;
fi
fi
source /etc/profile
source ~/.profile
source ~/.bash_profile
source ~/.bashrc

yum install -y gcc gcc-c++ ruby ruby-devel mysql-devel postgresql-devel postgresql-libs sqlite-devel libxslt-devel libxml2-devel patch openssl wget
if [ $? != 0 ];
then
  echo "Error en yum install..."
  exit 250;
fi

gem install yajl
if [ $? != 0 ];
then
  echo "Error en gem install yajl"
  exit 249;
fi

wget https://s3.amazonaws.com/bosh-init-artifacts/bosh-init-0.0.99-linux-amd64
if [ $? != 0 ];
then
  echo "Error en bosh-init install"
  exit 248;
fi


chmod +x bosh-init-*
if [ $? != 0 ];
then
  echo "Error en bosh-init install"
  exit 247;
fi


mv bosh-init-* /usr/local/bin/bosh-init
if [ $? != 0 ];
then
  echo "Error en bosh-init install"
  exit 246;
fi


gem install bosh_cli --no-ri --no-rdoc
if [ $? != 0 ];
then
  echo "Error in bosh_cli install "
  exit 245;
fi


