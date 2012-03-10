Muni14 = (require '../muni14.coffee').Muni14
# Load data for tests
Muni14.data = require '../data/municipios-data.json'

describe 'Muni14', ->
  it 'should have 14 departaments', ->
    expect(Muni14.data.length).toEqual 14

  it 'should only accept strings as codes', ->
    expect(Muni14.get 1).toEqual null

  it 'should only accept codes like "XXXX" and "XX"', ->
    expect(Muni14.get "10000").toEqual null

  it 'should return null when department code has no match', ->
    codes = ['0010', '1510', '15', '00']
    for code in codes
      expect(Muni14.get code).toEqual null

  it 'should return null when municipality code has no match', ->
    codes = ['0100', '0113', '0214', '1419']
    for code in codes
      expect(Muni14.get(code).municipio).toEqual null

  deps =
    '01': ['Ahuachapán',   12]
    '02': ['Santa Ana',    13]
    '03': ['Sonsonate',    16]
    '04': ['Chalatenango', 33]
    '05': ['La Libertad',  22]
    '06': ['San Salvador', 19]
    '07': ['Cuscatlán',    16]
    '08': ['La Paz',       22]
    '09': ['Cabañas',       9]
    '10': ['San Vicente',  13]
    '11': ['Usulután',     23]
    '12': ['San Miguel',   20]
    '13': ['Morazán',      26]
    '14': ['La Unión',     18]

  describe 'departaments', ->
    it 'should have valid codes', ->
      for code, val of deps
        expect(Muni14.get(code).departamento).toEqual val[0]

    it 'should have correct number of municipalities', ->
      for code, val of deps
        expect(Muni14.get(code).municipios.length).toEqual val[1]

    describe 'municipio', ->
      munis = 
        '0101': 'Ahuachapán'
        '0111': 'Tacuba'
        '0203': 'Coatepeque'
        '0213': 'Texistepeque'
        '0301': 'Acajutla'
        '0433': 'Tejutla'
        '0505': 'Comasagua'
        '0618': 'Soyapango'
        '0712': 'San Ramón'
        '0802': 'El Rosario '
        '0906': 'San Isidro'
        '1004': 'San Esteban Catarina'
        '1121': 'San Simón'
        '1220': 'Uluazapa'       
        '1307': 'El Rosario'       
        '1412': 'Pasaquina'

      for code, name of munis
        it "code #{code} is #{name}", ->
          expect(Muni14.get(code).municipio).toEqual name
