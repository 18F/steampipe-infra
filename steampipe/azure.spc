connection "azure_all" {
  type        = "aggregator"
  plugin      = "azure"
  connections = ["OCIO_EDEDEV_C1"]
}

connection "OCIO_EDEDEV_C1" {
  plugin          = "azure"
  tenant_id      = "9ce70869-60db-44fd-abe8-d2767077fc8f"
  subscription_id = "01f9b1b1-a130-4031-ba25-71771007d3ca"
  #client_id      = "00000000-0000-0000-0000-000000000000"
  #client_secret  = "~dummy@3password"
}

# connection "OCIO_EDEPRD_C1" {
#   plugin          = "azure"
#   #tenant_id      = "00000000-0000-0000-0000-000000000000"
#   subscription_id = "0f6a757d-15f9-4ca7-8dfe-491052a1c6d9"
#   #client_id      = "00000000-0000-0000-0000-000000000000" 
#   #client_secret  = "~dummy@3password"
#} 