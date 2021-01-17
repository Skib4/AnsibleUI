# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_16_205256) do

  create_table "hosts", force: :cascade do |t|
    t.string "hostname"
    t.string "ip_addr"
    t.string "description"
    t.integer "ssh_port"
    t.string "ssh_user"
    t.string "password_digest"
    t.string "author"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password"
    t.string "passwordssh"
  end

  create_table "playbooks", force: :cascade do |t|
    t.string "author"
    t.text "description"
    t.string "name"
    t.string "url"
    t.text "body"
    t.string "path"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "runsnumber"
  end

  create_table "posts", force: :cascade do |t|
    t.string "author"
    t.string "title"
    t.text "body"
    t.boolean "published"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "runs", force: :cascade do |t|
    t.text "result"
    t.text "command"
    t.string "playbook_path"
    t.string "author"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "playbook_id"
    t.integer "host_id"
    t.string "hostname"
    t.string "playbook_name"
    t.text "output"
    t.index ["host_id"], name: "index_runs_on_host_id"
    t.index ["playbook_id"], name: "index_runs_on_playbook_id"
  end

# Could not dump table "users" because of following StandardError
#   Unknown type 'inet' for column 'current_sign_in_ip'

end
