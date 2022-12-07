#!/bin/bash
echo "Ajout d'un nouvel utilisateur"
echo "ATTENTION les caractères spéciaux peuvent causer des problèmes !!!"
read -p "Nom d'utilisateur : " username
read -sp "Clé publique : " ssh_key
echo ''

echo "Création de l'utilisateur"
sudo useradd $username --create-home -G sftp_users 
echo "Ajout de francois au groupe créé pour l'accès aux documents"
sudo usermod -G $username francois
echo "On change le nivea d'accès au dossier de l'utilisateur créé"
sudo chmod 770 /home/$username
echo "Ajout du dossier pour les clés ssh"
cd /home/$username/
mkdir .ssh
sudo chgrp $username .ssh
sudo chown $username .ssh
cd ./.ssh/
echo $ssh_key > authorized_keys
sudo chgrp $username authorized_keys
sudo chown $username authorized_keys
sudo chmod 600 authorized_keys
cd ..
sudo chmod 700 .ssh