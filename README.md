

Find this line
exports.tokovoip_script:removePlayerFromRadio(PhoneData.CallData.CallId)

replace this line
exports["mumble-voip"]:SetCallChannel(0)




Find this line
exports.tokovoip_script:addPlayerToRadio(PhoneData.CallData.CallId, 'Phone')

replace this line
exports["mumble-voip"]:SetCallChannel(PhoneData.CallData.CallId, 'Phone')








