resource "aws_apigatewayv2_stage" "gateway_stage" {
  api_id = aws_apigatewayv2_api.gateway_api.id

  name        = "$default"
  auto_deploy = true
}
