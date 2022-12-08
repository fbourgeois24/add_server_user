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
useradd $username --create-home
groupadd $groupname
usermod -g $groupname $username
groupdel $username
usermod -aG sftp_users $username
# On change le mot de passe de l'utilisateur
echo -e '$password\n$password' | passwd $username
# Ajout de francois au groupe créé pour l'accès aux documents
usermod -aG $groupname francois
# On change le niveau d'accès au dossier de l'utilisateur créé
chmod 770 /home/$username
# Ajout du dossier pour les clés ssh
mkdir /home/$username/.ssh
chgrp $groupname /home/$username/.ssh
chown $username /home/$username/.ssh
echo $ssh_key > /home/$username/.ssh/authorized_keys
chgrp $groupname /home/$username/.ssh/authorized_keys
chown $username /home/$username/.ssh/authorized_keys
chmod 600 /home/$username/.ssh/authorized_keys
chmod 700 /home/$username/.ssh