output "opensearch_arn" {
  description = "OpenSearch ARN"
  value       = aws_elasticsearch_domain.main.arn
}


output "opensearch_id" {
  description = "OpenSearch ID"
  value       = aws_elasticsearch_domain.main.id
}
