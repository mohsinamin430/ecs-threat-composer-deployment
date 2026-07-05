output "alb_tg_arn" {
  value = aws_lb_target_group.tg_threatapp.arn
}

output "alb_dns_name" {
  value = aws_lb.alb_threatapp.dns_name
}

output "alb_zone_id" {
  value = aws_lb.alb_threatapp.zone_id
}

output "https_listener_arn" {
  value = aws_lb_listener.https_listener.arn
}

output "http_listener_arn" {
  value = aws_lb_listener.http_listener.arn
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}