resource "aws_instance" "thinkdata" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  tags = {
    Name = "Webserver-public"
	}
  
  provisioner "file" {
    source = "script.sh"
    destination = "/tmp/script.sh"
}	
 provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh"
    ]
  }

  connection {
    user = "${var.INSTANCE_USERNAME}"
	private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
    }

 subnet_id = "${aws_subnet.thinkdata-public-1.id}"
 vpc_security_group_ids = ["${aws_security_group.thinkdata.id}"]

 key_name = "${aws_key_pair.thinkdata.key_name}"
 }
 
 

 resource "aws_instance" "thinkdatadb" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
   instance_type = "t2.micro"
  user_data = <<-EOF
                #!/bin/bash
                yum install -y mysql56-server
              EOF
  tags = {
    Name = "DBServer-private"
	}
  

  connection {
    user = "${var.INSTANCE_USERNAME}"
	private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
    }

 subnet_id = "${aws_subnet.thinkdata-private-1.id}"
 vpc_security_group_ids = ["${aws_security_group.thinkdata-db.id}"]

 key_name = "${aws_key_pair.thinkdata.key_name}"
 }
