seal "awskms" {
    region     = "${aws_kms_region}"
    kms_key_id = "${aws_kms_key_id}"
    %{ if aws_access_key != null ~}access_key = "${aws_access_key}"%{~ endif }
    %{ if aws_secret_key != null ~}secret_key = "${aws_secret_key}"%{~ endif }
    %{ if aws_endpoint != null ~}endpoint = "${aws_endpoint}"%{~ endif }
}
