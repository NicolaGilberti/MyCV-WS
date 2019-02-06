class CreateCurriculums < ActiveRecord::Migration[5.2]
  def change
    create_table :curriculums do |t|
      t.string  :reset_password_token
      t.string :email  
      t.string :password  
      t.string :name  
      t.string :image  
      t.string :location  
      t.string :gender  
      t.string :birthday  
      t.string :hometown  
      t.string :age_range  
      t.string :biography  
      t.string :it_languages  
      t.string :language_spoken  
      t.string :education_from 
      t.string :education_to 
      t.string :education_org_name 
      t.string :education_title 
      t.string :work_from 
      t.string :work_to 
      t.string :work_org_name 
      t.string :work_position 
      t.string :communication_skills 
      t.string :organisational_skills 
      t.string :other_skills 
      t.string :driving_licence 
      t.string :application_type 
      t.string :facebook_auth
      t.string :github_auth
      t.string :linkedin_auth
      t.timestamps
    end
  end
end
