Utilities =
  error: (id)->
    switch id
      when 1 then throw new Error 'Codigo debe ser una cadena de texto'
      when 2 then throw new Error 'Codigo debe ser "xx" o "xxxx"'

  # Processes a code
  #
  # @param {String} code A code in the format DDMM or DD
  #
  # @returns {Object} Object with deparment and Municipality's index 
  #
  processCode: (code)->
    return false if typeof code isnt 'string'
    codes = code.match /^(\d{4}|\d{2})$/
    return false unless codes?

    match   = codes[1]
    deptIdx = parseInt (match.substring 0, 2), 10
    if match.length is 4
      muniIdx = parseInt (match.substring 2, 4), 10

    deptIdx: deptIdx
    muniIdx: muniIdx or null

# During tests data will be loaded from municipios-data.json. This data
# will be appended to the compiled *.js file when running the `build`
# task.
Muni14 =
  data: {}
  get: (code)->
    indices = Utilities.processCode code
    ret     = {}
    if indices
      if indices.deptIdx >= 1 and indices.deptIdx <= 14
        dept = @data[ --indices.deptIdx ]

        departamento: dept[0]
        municipios  : dept.slice 1
        municipio   : (if indices.muniIdx then dept[ indices.muniIdx ]) or null

    else
      null


# exposing to the global namespace
root = exports ? window
root.Muni14 = Muni14
