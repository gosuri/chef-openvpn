setup_aws:
	test/terraform/tf.sh setup

teardown_aws:
	test/terraform/tf.sh teardown

.PHONY: setup_aws teardown_aws
