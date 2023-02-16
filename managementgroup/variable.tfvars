# fullcompanyname = "koocorporation"
# shortcompanyname = "koo-corp"

# CompanyManagementGroupName = "koocorporation"
# decomissioned = "decomissioned"
# landingzones = "landingzone"
# corp = "corp"
# online = "online"
# sap = "sap"
# platform = "platform"
# connectivity = "connectivity"
# identity = "identity"
# management = "management"
# sandboxes = "sandboxes"

# koo-corp
#     decomissioned
#     platform
#         connectivity
#         identity
#         management
#     landingzone
#         corp
#         online
#         sap
#     sandbox


{
    mgmt-parent = {
        name = "koo-corp"
        child = ["decomissioned","platform","landingzone","sandbox"]    

        platform = {
            name = "platform"
            child = ["connectivity","identity","mangement"]
        }
        landingzone = {
            name = "landingzone"
            child = ["corp", "online", "sap"]
        }        
    }
}

mgmt = {
    mgmt1 = {
        name = "koo-corp"
        parent = ""
    }
}