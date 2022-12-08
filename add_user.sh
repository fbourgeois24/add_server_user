#!/bin/bash
echo "Ajout d'un nouvel utilisateur"
echo "ATTENTION les caractères spéciaux peuvent causer des problèmes !!!"
read -p "Nom d'utilisateur : " username
read -p "Nom du groupe : " groupname
# On retire les espaces dans le nom du groupe
groupname="${groupname/ /_}"
read -p "Mot de passe : " password
read -p "Clé publique : " ssh_key
echo ''
# Création de l'utilisateur
sudo useradd $username --create-home
sudo groupadd $groupname
sudo usermod -g $groupname $username 
sudo usermod -aG sftp_users $username
# On change le mot de passe de l'utilisateur
echo -e '$password\n$password' | sudo passwd $username
# Ajout de francois au groupe créé pour l'accès aux documents
sudo usermod -aG $groupname francois
# On change le niveau d'accès au dossier de l'utilisateur créé
sudo chmod 770 /home/$username
# Ajout du dossier pour les clés ssh
mkdir /home/$username/.ssh
sudo chgrp $groupname /home/$username/.ssh
sudo chown $username /home/$username/.ssh
echo $ssh_key > /home/$username/.ssh/authorized_keys
sudo chgrp $groupname /home/$username/.ssh/authorized_keys
sudo chown $username /home/$username/.ssh/authorized_keys
sudo chmod 600 /home/$username/.ssh/authorized_keys
sudo chmod 700 /home/$username/.ssh