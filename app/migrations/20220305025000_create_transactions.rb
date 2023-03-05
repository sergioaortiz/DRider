Sequel.migration do
    up do
        create_table(:transactions) do
        primary_key :id
        foreign_key :id_ride, :rides
        String :reference, null: false
        Integer :amount, null: false
        DateTime :created_at, null: false
        end
    end

    down do
        drop_table(:transactions)
    end
end