resource "aws_key_pair" "thinkdata" {
  key_name = "thinkdata"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}
