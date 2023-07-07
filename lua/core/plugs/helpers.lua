local helpers = {}

function helpers.is_installable(target)
    return target.get_plugs
end

return helpers