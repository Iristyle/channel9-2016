env_root=/etc/puppetlabs/code/environments/production

module_dir=${env_root}/modules
sudo mkdir -p ${module_dir}
sudo cp -f -R /vagrant/modules/* ${module_dir}
sudo chown -R pe-puppet:pe-puppet ${module_dir}


manifest_dir=${env_root}/manifests
sudo cp -f -R /vagrant/manifests/* ${manifest_dir}
sudo chown -R pe-puppet:pe-puppet ${manifest_dir}
