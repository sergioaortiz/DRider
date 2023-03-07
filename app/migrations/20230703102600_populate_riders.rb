Sequel.migration do
  up do
    riders = DB[:riders] # Create a dataset

    # Populate the table
    riders.insert(legal_id: 1026589764, legal_id_type: 'CC', name: 'Sergio Andres Aya', email: 'sergioaortiz2302@gmail.com', phone_number: 3012899410, latitude: '4.644876', longitude: '-74.106605')
    riders.insert(legal_id: 1026597874, legal_id_type: 'CC', name: 'Camila Andrea Gutierres', email: 'camila3456@gmail.com', phone_number: 3154897845, latitude: '4.555602', longitude: '-74.103238')
    riders.insert(legal_id: 1287984567, legal_id_type: 'CC', name: 'David Camilo Diaz', email: 'david_0956@gmail.com', phone_number: 3165548987, latitude: '4.745532', longitude: '-74.035968')
    riders.insert(legal_id: 1098784545, legal_id_type: 'CC', name: 'Felipe Andres Barbosa', email: 'felipe123@gmail.com', phone_number: 3958745612, latitude: '4.718175', longitude: '-74.142155')
    riders.insert(legal_id: 1056987584, legal_id_type: 'CC', name: 'Mariana Alejandra Puentes', email: 'mariana874@gmail.com', phone_number: 3654128795, latitude: '4.679309', longitude: '-74.054211')
  end
end