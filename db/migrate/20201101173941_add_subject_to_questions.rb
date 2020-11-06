class AddSubjectToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_reference :questions, :subject, foreign_key: true
  end
end
