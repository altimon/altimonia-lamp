resource "aws_lb_target_group" "altimonia_api" {
  name        = "altimon-api"
  port        = 5000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.altimonia_vpc.id

  health_check {
    enabled = true
    path    = "/"
  }

  depends_on = [aws_alb.altimonia_api_alb]
}

resource "aws_alb" "altimonia_api_alb" {
  name               = "altimonia-api-lb"
  internal           = false
  load_balancer_type = "application"

  subnets = [
    aws_subnet.altimonia_vpc_public_subnet.id,
    aws_subnet.altimonia_vpc_public_subnet_two.id,
  ]

  security_groups = [
    aws_security_group.ssh.id,
    aws_security_group.http.id,
    aws_security_group.https.id,
    aws_security_group.egress_all.id,
  ]

  depends_on = [aws_internet_gateway.altimonia_vpc_internet_gateway]
}

resource "aws_alb_listener" "altimonia_api_http" {
  load_balancer_arn = aws_alb.altimonia_api_alb.arn
  port              = "5000"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.altimonia_api.arn
  }
}
