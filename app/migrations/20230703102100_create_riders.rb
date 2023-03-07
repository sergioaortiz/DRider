Sequel.migration do
  up do
    create_table(:riders) do
    primary_key :id
    Integer :legal_id, null: false
    String :legal_id_type, null: false
    String :name, null: false
    String :email, null: false
    Bignum :phone_number, null: false
    String :latitude, null: false
    String :longitude, null: false
    end
  end

  down do
    drop_table(:riders)
  end
end