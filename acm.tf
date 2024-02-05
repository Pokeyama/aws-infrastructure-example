# Certificate Upload
resource "aws_acm_certificate" "example_cert" {
  certificate_chain = file("example.crt")  # Path to the certificate chain file
  certificate_body  = file("example.pem")  # Path to the certificate body file
  private_key       = file("example.key")  # Path to the private key file

  tags = {
    Name = "example-ssl"  # Tags for identifying and labeling the ACM certificate
  }
}