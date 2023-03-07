Sequel.migration do
  up do
    users = DB[:users] # Create a dataset

    # Populate the table
    users.insert(name: 'Test', email: 'test@test.com', password: '$2a$12$6SXt2H3la8wfVggNbsfWw.HVwRljbyKQjnSm3EKN8HjopFBpG/klK', state: 1, created_at: Time.now, updated_at: Time.now)
  end
end