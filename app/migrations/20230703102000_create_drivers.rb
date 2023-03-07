Sequel.migration do
  up do
    create_table(:drivers) do
    primary_key :id
    Integer :legal_id, null: false
    String :legal_id_type, null: false
    String :name, null: false
    String :email, null: false
    String :latitude, null: false
    String :longitude, null: false
    end
  end

  down do
    drop_table(:drivers)
  end
end