output "alb_tg" {
  value = aws_lb_target_group.tg-threatapp.arn
}

output "alb_dns_name" {
  value = aws_lb.alb-threatapp.dns_name
}

output "alb_zone_id" {
  value = aws_lb.alb-threatapp.zone_id
}