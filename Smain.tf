resource "aws_key_pair" "ssh_key" {
  key_name = "ssh_secure1"
  public_key = file(var.ssh_pub_path)
}