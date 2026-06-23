#ALB & target group
resource "aws_lb" "alb-threatapp" {
    load_balancer_type = "application"
    name = "alb-threatapp"
    internal = false
    security_groups = [aws_security_group.alb-sg.id]
    subnets = [var.public_subnet_1_id, var.public_subnet_2_id]
}

resource "aws_lb_target_group" "tg-threatapp" {
    target_type = "ip"
    name = "tg-threatapp"
    port = 8080
    protocol = "HTTP"
    vpc_id = var.vpc_id
    health_check {
        path = "/health"
        protocol = "HTTP"
        matcher = "200-399"
    }
}

resource "aws_lb_listener" "alb-listener" {
    load_balancer_arn = aws_lb.alb-threatapp.arn
    port = 443
    protocol = "HTTPS"
    ssl_policy = "ELBSecurityPolicy-2016-08"
    certificate_arn = var.acm_certificate_arn
    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.tg-threatapp.arn
    }
}

#ALB security group, allow traffic from port 80
resource "aws_security_group" "alb-sg" {
    name = "alb-sg"
    description = "Security group for ALB"
    vpc_id = var.vpc_id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}