# resource "aws_instance" "thumbor" {
#   ami                    = "ami-0bdf93799014acdc4"
#   instance_type          = "t2.micro"
#   availability_zone      = "eu-central-1a"
#   vpc_security_group_ids = ["${aws_security_group.thumbor_sg.id}"]
#   key_name               = "${aws_key_pair.default_ssh_key.id}"
#   subnet_id              = "${aws_default_subnet.default_az1a.id}"

#   # Comment out user_data before commit
#   user_data = "${file("tf-data/cloud-init")}"

#   tags = "${merge(
#     local.common_tags,
#     map(
#       "Name", "${local.common_tags["project"]}-${local.common_tags["env"]}-thumbor01"
#     )
#   )}"
# }

# # Comment out user_data before commit
# resource "aws_eip" "thumbor_eip" {
#   instance = "${aws_instance.thumbor.id}"
#   vpc      = true
# }
