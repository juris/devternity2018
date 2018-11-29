# resource "aws_launch_template" "thumbor_lt" {
#   name = "thumbor_lt"

#   image_id               = "ami-0bdf93799014acdc4"
#   instance_type          = "t2.micro"
#   key_name               = "${aws_key_pair.default_ssh_key.id}"
#   vpc_security_group_ids = ["${aws_security_group.thumbor_sg.id}"]
#   user_data              = "${base64encode(file("tf-data/cloud-init-asg"))}"

#   monitoring {
#     enabled = true
#   }

#   block_device_mappings {
#     device_name = "/dev/sda1"

#     ebs {
#       volume_size = 8
#     }
#   }

#   tag_specifications {
#     resource_type = "instance"

#     tags = "${merge(
#     local.common_tags,
#     map(
#       "Name", "${local.common_tags["project"]}-${local.common_tags["env"]}-asg-thumbor01"
#     )
#   )}"
#   }
# }

# resource "aws_autoscaling_group" "thumbor_asg" {
#   name               = "thumbor_asg"
#   availability_zones = ["eu-central-1a", "eu-central-1b"]
#   desired_capacity   = 1
#   max_size           = 2
#   min_size           = 1
#   default_cooldown   = 60
#   health_check_type  = "ELB"
#   target_group_arns  = ["${aws_lb_target_group.thumbor_tg.arn}"]

#   launch_template = {
#     id      = "${aws_launch_template.thumbor_lt.id}"
#     version = "$$Latest"
#   }
# }

# resource "aws_autoscaling_policy" "high_cpu_scaleup" {
#   name                      = "high_cpu_scaleup"
#   adjustment_type           = "ChangeInCapacity"
#   autoscaling_group_name    = "${aws_autoscaling_group.thumbor_asg.name}"
#   policy_type               = "TargetTrackingScaling"
#   estimated_instance_warmup = 10

#   target_tracking_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ASGAverageCPUUtilization"
#     }

#     target_value = 50.0
#   }
# }