#turbot/steampipe
FROM turbot/steampipe:latest

# Setup prerequisites (as root) 
USER root:0
RUN apt-get update -y \
 && apt-get install -y git

#6 Install Azure CLI for Authorization
RUN apt-get install -y ca-certificates curl apt-transport-https lsb-release gnupg
RUN mkdir -p /etc/apt/keyrings
RUN curl -sLS https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor
RUN apt-get install -y azure-cli

# #Add root certs inside docker image 
# COPY ./nca1.crt .  
# COPY ./NCA-DPI1.crt . 
# COPY ./NCA-DPI1_t.crt . 

# #Copy certs on the image
# RUN cp ./nca1.crt /usr/local/share/ca-certificates/nca1.crt \
#     && cp ./NCA-DPI1.crt /usr/local/share/ca-certificates/NCA-DPI1.crt \
#     && cp ./NCA-DPI1_t.crt /usr/local/share/ca-certificates/NCA-DPI1_t.crt \
#     && update-ca-certificates

#Removes workspace directory if exists.
RUN rm -rf /workspace

# Install the azure and steampipe plugins for Steampipe (as steampipe user).
USER steampipe:0

#Install Plugins
RUN steampipe plugin install steampipe \
    && steampipe plugin install azure \
    && steampipe plugin install azuread \   
    && steampipe plugin update --all 

# A mod may be installed to a working directory
RUN  git clone --depth 1 https://github.com/turbot/steampipe-mod-azure-compliance.git /workspace
WORKDIR /workspace       
