output "jenkins_public_ip" {
  description = "Public IP of the Jenkins Server"
  value       = aws_instance.jenkins_server.public_ip
}

output "jenkins_url" {
  description = "URL to access Jenkins"
  value       = "http://${aws_instance.jenkins_server.public_ip}:8080"
}