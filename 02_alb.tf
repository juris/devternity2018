# resource "aws_lb" "default_alb" {
#   name               = "${local.common_tags["project"]}-${local.common_tags["env"]}-alb01"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = ["${aws_security_group.thumbor_sg.id}"]
#   subnets            = ["${aws_default_subnet.default_az1a.id}", "${aws_default_subnet.default_az1b.id}"]

#   tags = "${merge(
#     local.common_tags,
#     map(
#       "Name", "${local.common_tags["project"]}-${local.common_tags["env"]}-alb01"
#     )
#   )}"
# }

# resource "aws_lb_listener" "thumbor_listener" {
#   load_balancer_arn = "${aws_lb.default_alb.arn}"
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = "${aws_lb_target_group.thumbor_tg.arn}"
#   }
# }

# resource "aws_lb_target_group" "thumbor_tg" {
#   name                 = "thumbor-tg"
#   port                 = "80"
#   protocol             = "HTTP"
#   vpc_id               = "${aws_default_vpc.default_vpc.id}"
#   deregistration_delay = "10"

#   health_check {
#     interval            = "10"
#     healthy_threshold   = "2"
#     unhealthy_threshold = "2"
#     path                = "/healthcheck"
#   }
# }

# # resource "aws_lb_target_group_attachment" "thumbor_tg_attachment" {
# #   target_group_arn = "${aws_lb_target_group.thumbor_tg.arn}"
# #   target_id        = "${aws_instance.thumbor.id}"
# #   port             = "80"
# # }
