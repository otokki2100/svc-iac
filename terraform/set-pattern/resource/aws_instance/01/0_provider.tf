provider "aws" {
  region                   = "ap-northeast-2"
  shared_credentials_files = ["~/.aws/config"]
  profile                  = "hostway_bmt_skk"
}
