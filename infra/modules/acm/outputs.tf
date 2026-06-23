output "nameservers" {
  value = aws_route53_zone.hosted_zone.name_servers
}

output "acm_certificate_arn" {
  value = aws_acm_certificate.cert.arn
}