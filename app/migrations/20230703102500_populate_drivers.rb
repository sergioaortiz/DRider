Sequel.migration do
  up do
    drivers = DB[:drivers] # Create a dataset

    # Populate the table
    drivers.insert(legal_id: 1034567897, legal_id_type: 'CC', name: 'Camilo Andres Gonzalez', email: 'camilo452@gmail.com', latitude: '4.612028', longitude: '-74.177950')
    drivers.insert(legal_id: 1025487342, legal_id_type: 'CC', name: 'Diana Carolina Camargo', email: 'diana543@gmail.com', latitude: '4.560531', longitude: '-74.108483')
    drivers.insert(legal_id: 1056121374, legal_id_type: 'CC', name: 'Sergio Daniel Diaz', email: 'sergio344@gmail.com', latitude: '4.583091', longitude: '-74.147811')
    drivers.insert(legal_id: 1023444562, legal_id_type: 'CC', name: 'Christian David Avellaneda', email: 'christian567@gmail.com', latitude: '4.644910', longitude: '-74.141758')
    drivers.insert(legal_id: 1076464647, legal_id_type: 'CC', name: 'David Alexander Romero', email: 'david9083@gmail.com', latitude: '4.629530', longitude: '-74.091070')
    drivers.insert(legal_id: 1014343431, legal_id_type: 'CC', name: 'Sandra Patricia Hernandez', email: 'sandra432@gmail.com', latitude: '4.668208', longitude: '-74.064976')
    drivers.insert(legal_id: 1041654315, legal_id_type: 'CC', name: 'Ana Lucia Ortiz', email: 'analucia8985@gmail.com', latitude: '4.697767', longitude: '-74.051940')
    drivers.insert(legal_id: 1032125456, legal_id_type: 'CC', name: 'Luis Ernesto Ricaurte', email: 'luis234@gmail.com', latitude: '4.718783', longitude: '-74.084398')
    drivers.insert(legal_id: 1078942513, legal_id_type: 'CC', name: 'Juan David Arevalo', email: 'juandavid908@gmail.com', latitude: '4.751075', longitude: '-74.101988')
    drivers.insert(legal_id: 1032132145, legal_id_type: 'CC', name: 'Julian Alfonso Manrrique', email: 'julian_alf32@gmail.com', latitude: '4.744477', longitude: '-74.059189')
  end
end