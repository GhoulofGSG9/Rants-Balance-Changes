local oldFunc = BuildTechData
function BuildTechData()
    local techData = oldFunc()

    local replaceTechData = {
        [kTechId.CatPack] = {
            [kTechDataId] = kTechId.CatPack,
            [kTechDataAllowStacking] = true,
            [kTechDataIgnorePathingMesh] = true,
            [kTechDataMapName] = CatPack.kMapName,
            [kTechDataDisplayName] = "CAT_PACK",
            [kTechDataCostKey] = kCatPackCost,
            [kTechDataModel] = CatPack.kModelName,
            [kTechDataTooltipInfo] = "CAT_PACK_TOOLTIP",
            [kTechDataSpawnHeightOffset] = kCommanderDropSpawnHeight,
            [kCommanderSelectRadius] = 0.375,
            [kTechDataOverrideCoordsMethod] = AlignDroppack,
        },
        [kTechId.AmmoPack] = {
            [kTechDataId] = kTechId.AmmoPack,
            [kTechDataAllowStacking] = true,
            [kTechDataIgnorePathingMesh] = true,
            [kTechDataMapName] = AmmoPack.kMapName,
            [kTechDataDisplayName] = "AMMO_PACK",
            [kTechDataCostKey] = kAmmoPackCost,
            [kTechDataModel] = AmmoPack.kModelName,
            [kTechDataTooltipInfo] = "AMMO_PACK_TOOLTIP",
            [kTechDataSpawnHeightOffset] = kCommanderDropSpawnHeight,
            [kCommanderSelectRadius] = 0.375,
            [kTechDataOverrideCoordsMethod] = AlignDroppack,
        }
    }

    for i = #techData, 1, -1 do
        local techEntry = techData[i]
        local techId = techEntry[kTechDataId]

        if techId and replaceTechData[techId] then
            techData[i] = replaceTechData[techId]
        end
    end

    return techData
end