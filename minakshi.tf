provider "aws" {
  profile = "minakshi"
  region  = "us-east-1"
}
resource "aws_instance" "ec2demo" {
  ami= "ami-0a01a5636f3c4f21c"
  instance_type = "t2.micro"

  tags ={
   Name = "demo Instance"
  }
}
resource "aws_ebs_volume" "ebs-vol" {
 availability_zone = aws_instance.ec2demo.availability_zone
 size = 1
 tags = {
        Name = "new-volume"
 }

}

resource "aws_volume_attachment" "attach_ebs_2" {
 device_name = "/dev/sdh"
 volume_id = aws_ebs_volume.ebs-vol.id
 instance_id = aws_instance.ec2demo.id
}

resource "aws_eip" "elasticip" {
  instance = aws_instance.ec2demo.id
  vpc = true
}



resource "aws_security_group" "security-ssh" {
  name = "security-group"


  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["49.36.144.145/32"]
  }


  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]



}
}
