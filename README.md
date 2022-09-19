# terraform_aws_vpc
VPC周りのリソースをスマートに作成する方法

## 使用する関数/引数
以下の関数/引数を使用する。

- [substr Function](https://www.terraform.io/language/functions/substr)
- [element Function](https://www.terraform.io/language/functions/element)
- [index Function](https://www.terraform.io/language/functions/index_function)
- [count Meta-Argument](https://www.terraform.io/language/meta-arguments/count)

### [cidrsubnets Function](https://www.terraform.io/language/functions/cidrsubnets)を使用した設定
variableで設定されたCIDRからサブネットCIDR×9を自動生成する。
