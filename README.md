# ----------------------------- Project PART 1 -----------------------------

## --- Recherches ---
Pour commencer, phase de 'recherches' afin de déterminer quelles ressources nous allons utiliser pour la base de notre partie I du projet. Ces ressources inclues les fichiers et informations obtenues durant les UEs qui ont été suivies durant l'année.

Pour cette partie, le cours de Ansible, accompagné de la documentation Ansible, sont nos références principales et c'est sur cette base que nous allons partir pour créer le Vagrantfile, ainsi que les fichiers qui vont suivre.


## --- Process ---
1. Initialiser avec `vagrant init`
2. Mise en place de l'infrastructure
3. Création des clefs rsa
4. Création des fichiers provision
    * Renseigner les installations et paramètres réseaux dans les fichiers provision
    * Configurer les authorisations des clefs et les ajouts dans les fichiers provision
    * Renseigner le provision pour l'accès au playbook ansible
5. Installation des services via les playbook

## --- Comment ça marche ---

### --- Mise en place ---
Create and start all servers
`vagrant up`

Afin de bien faire les provisions des fichiers
`vagrant provision`

Vérification du réseau interne entre les serveurs
`vagrant ssh control`
`vagrant ping s0.infra`
`vagrant ping s1.infra`
`vagrant ping s2.infra`
`vagrant ping s3.infra`
`vagrant ping s4.infra`

Répéter cette dernière procédure en se connectant à s0.infra et faire un ping des autres serveurs

### --- Manipulation ---
Seulement arrêter un des serveur
`vagrant halt s1.infra`
`vagrant halt s2.infra`

Pour détruire un serveur
`vagrant destroy s1.infra`
`vagrant destroy s2.infra`

Pour reprovisionner la VM
`vagrant reload --provision`

Relancer les serveurs et faire de nouveau fonctionner le site
`vagrant up --provision s1.infra`
`vagrant provision control`


