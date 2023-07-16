data "http" "request" {
  url = "https://raw.githubusercontent.com/otokki2100/lang-code/main/${var.proxy_frontend.script}"
}
