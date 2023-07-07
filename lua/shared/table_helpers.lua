local tablehlprs = {}

function tablehlprs.merge(table1, table2)
  local mergedTable = {}

  -- Merge table1
  for key, value in pairs(table1) do
    mergedTable[key] = value
  end

  -- Merge table2
  for key, value in pairs(table2) do
    mergedTable[key] = value
  end

  return mergedTable
end

function tablehlprs.merge_arrays(array1, array2)
  local mergedArray = {}

  -- Merge array1
  for i, value in ipairs(array1) do
    table.insert(mergedArray, value)
  end

  -- Merge array2
  for i, value in ipairs(array2) do
    table.insert(mergedArray, value)
  end


  return mergedArray
end

return tablehlprs

