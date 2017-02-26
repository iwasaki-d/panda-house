ActiveRecord::Schema.define(version: 20170226071809) do

  create_table "houses", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "rent",       null: false
    t.string   "address",    null: false
    t.integer  "age",        null: false
    t.string   "remark"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
