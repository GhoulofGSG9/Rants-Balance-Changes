local oldResolveString = Locale.ResolveString

local modStrings = {
}

function Locale.ResolveString(indexString)
    return modStrings[indexString] or oldResolveString(indexString)
end