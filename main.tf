module "network" {
  source = "./network"
}
module "security" {
  source = "./Security"
}

module "ec2" {
 source = "./ec2"
 my_public_subnet = module.network.network_output
 eip_ec2 = module.network.eip_output
 my_sg = module.network.sg_output
 file-path = module.security.shell_path
 priv-key-path = module.security.priv_key
 pub-key-path = module.security.pub_key
 secure_key_name = module.security.shh_key
 remoteCommande = [ "" ]
}

