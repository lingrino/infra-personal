account_id_auth = 230833635140

assume_role_name         = "Admin"
assume_role_session_name = "Local"

keypair_main_name = "main-20190906183126795100000001"

# Increase this number by 1 to automatically rotate keys for supported IAM users
# This operation is safe to do anytime
rotate_iam_keys = 2

tags = {
  terraform = true
}
