Sequel.migration do
    up do
        create_table(:rides) do
        primary_key :id
        foreign_key :id_driver, :drivers
        foreign_key :id_rider, :riders        
        DateTime :starting_time, null: false
        DateTime :final_time
        String :starting_latitude, null: false
        String :starting_longitude, null: false
        String :final_latitude
        String :final_longitude
        end
    end

    down do
        drop_table(:rides)
    end
end