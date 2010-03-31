# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100329202253) do

  create_table "categories", :force => true do |t|
    t.integer  "priority"
    t.string   "name"
    t.text     "memo"
    t.datetime "updated_on"
  end

  create_table "facilities", :force => true do |t|
    t.integer  "priority"
    t.string   "seq"
    t.string   "name"
    t.text     "memo"
    t.integer  "facilitycat_id"
    t.datetime "updated_on"
  end

  create_table "facilitycats", :force => true do |t|
    t.integer  "priority"
    t.string   "seq"
    t.string   "name"
    t.text     "memo"
    t.datetime "updated_on"
  end

  create_table "groups", :force => true do |t|
    t.string  "name"
    t.string  "description"
    t.integer "item_id"
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.text     "memo"
    t.integer  "spot_id"
    t.text     "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "publish_level"
    t.text     "tag"
    t.integer  "group_id"
    t.integer  "category_id"
    t.integer  "structure_id"
    t.integer  "shop_id"
    t.integer  "num_val_1"
    t.integer  "num_val_2"
    t.integer  "num_val_3"
    t.integer  "num_val_4"
    t.integer  "num_val_5"
    t.integer  "num_val_6"
    t.integer  "num_val_7"
    t.integer  "num_val_8"
    t.integer  "num_val_9"
    t.integer  "num_val_a"
    t.integer  "num_val_b"
    t.integer  "num_val_c"
    t.integer  "num_val_d"
    t.integer  "num_val_e"
    t.integer  "num_val_f"
    t.integer  "num_val_g"
    t.float    "num_val_h"
    t.float    "num_val_i"
    t.float    "num_val_j"
    t.float    "num_val_k"
    t.float    "num_val_l"
    t.float    "num_val_m"
    t.integer  "num_val_n"
    t.integer  "num_val_o"
    t.integer  "num_val_p"
    t.integer  "num_val_q"
    t.integer  "num_val_r"
    t.string   "str_val_1"
    t.string   "str_val_2"
    t.string   "str_val_3"
    t.string   "str_val_4"
    t.string   "str_val_5"
    t.string   "str_val_6"
    t.string   "str_val_7"
    t.string   "str_val_8"
    t.string   "str_val_9"
    t.string   "str_val_a"
    t.string   "str_val_b"
    t.string   "str_val_c"
    t.string   "str_val_d"
    t.string   "str_val_e"
    t.string   "str_val_f"
    t.string   "str_val_g"
    t.string   "str_val_h"
    t.string   "str_val_i"
    t.string   "str_val_j"
    t.string   "str_val_k"
    t.string   "str_val_l"
    t.string   "str_val_m"
    t.string   "str_val_n"
    t.string   "str_val_o"
    t.string   "str_val_p"
    t.string   "str_val_q"
    t.string   "str_val_r"
    t.datetime "date_val_1"
    t.datetime "date_val_2"
    t.datetime "date_val_3"
    t.datetime "date_val_4"
    t.datetime "date_val_5"
    t.boolean  "check_box_00",       :default => false, :null => false
    t.boolean  "check_box_01",       :default => false, :null => false
    t.boolean  "check_box_02",       :default => false, :null => false
    t.boolean  "check_box_03",       :default => false, :null => false
    t.boolean  "check_box_04",       :default => false, :null => false
    t.boolean  "check_box_05",       :default => false, :null => false
    t.boolean  "check_box_06",       :default => false, :null => false
    t.boolean  "check_box_07",       :default => false, :null => false
    t.boolean  "check_box_08",       :default => false, :null => false
    t.boolean  "check_box_09",       :default => false, :null => false
    t.boolean  "check_box_0a",       :default => false, :null => false
    t.boolean  "facility_00",        :default => false, :null => false
    t.boolean  "facility_01",        :default => false, :null => false
    t.boolean  "facility_02",        :default => false, :null => false
    t.boolean  "facility_03",        :default => false, :null => false
    t.boolean  "facility_04",        :default => false, :null => false
    t.boolean  "facility_05",        :default => false, :null => false
    t.boolean  "facility_06",        :default => false, :null => false
    t.boolean  "facility_07",        :default => false, :null => false
    t.boolean  "facility_08",        :default => false, :null => false
    t.boolean  "facility_09",        :default => false, :null => false
    t.boolean  "facility_0a",        :default => false, :null => false
    t.boolean  "facility_0b",        :default => false, :null => false
    t.boolean  "facility_0c",        :default => false, :null => false
    t.boolean  "facility_0d",        :default => false, :null => false
    t.boolean  "facility_0e",        :default => false, :null => false
    t.boolean  "facility_0f",        :default => false, :null => false
    t.boolean  "facility_0g",        :default => false, :null => false
    t.boolean  "facility_0h",        :default => false, :null => false
    t.boolean  "facility_0i",        :default => false, :null => false
    t.boolean  "facility_0j",        :default => false, :null => false
    t.boolean  "facility_10",        :default => false, :null => false
    t.boolean  "facility_11",        :default => false, :null => false
    t.boolean  "facility_12",        :default => false, :null => false
    t.boolean  "facility_13",        :default => false, :null => false
    t.boolean  "facility_14",        :default => false, :null => false
    t.boolean  "facility_15",        :default => false, :null => false
    t.boolean  "facility_16",        :default => false, :null => false
    t.boolean  "facility_17",        :default => false, :null => false
    t.boolean  "facility_18",        :default => false, :null => false
    t.boolean  "facility_19",        :default => false, :null => false
    t.boolean  "facility_1a",        :default => false, :null => false
    t.boolean  "facility_1b",        :default => false, :null => false
    t.boolean  "facility_1c",        :default => false, :null => false
    t.boolean  "facility_1d",        :default => false, :null => false
    t.boolean  "facility_1e",        :default => false, :null => false
    t.boolean  "facility_1f",        :default => false, :null => false
    t.boolean  "facility_1g",        :default => false, :null => false
    t.boolean  "facility_1h",        :default => false, :null => false
    t.boolean  "facility_1i",        :default => false, :null => false
    t.boolean  "facility_1j",        :default => false, :null => false
    t.boolean  "facility_20",        :default => false, :null => false
    t.boolean  "facility_21",        :default => false, :null => false
    t.boolean  "facility_22",        :default => false, :null => false
    t.boolean  "facility_23",        :default => false, :null => false
    t.boolean  "facility_24",        :default => false, :null => false
    t.boolean  "facility_25",        :default => false, :null => false
    t.boolean  "facility_26",        :default => false, :null => false
    t.boolean  "facility_27",        :default => false, :null => false
    t.boolean  "facility_28",        :default => false, :null => false
    t.boolean  "facility_29",        :default => false, :null => false
    t.boolean  "facility_2a",        :default => false, :null => false
    t.boolean  "facility_2b",        :default => false, :null => false
    t.boolean  "facility_2c",        :default => false, :null => false
    t.boolean  "facility_2d",        :default => false, :null => false
    t.boolean  "facility_2e",        :default => false, :null => false
    t.boolean  "facility_2f",        :default => false, :null => false
    t.boolean  "facility_2g",        :default => false, :null => false
    t.boolean  "facility_2h",        :default => false, :null => false
    t.boolean  "facility_2i",        :default => false, :null => false
    t.boolean  "facility_2j",        :default => false, :null => false
    t.boolean  "facility_30",        :default => false, :null => false
    t.boolean  "facility_31",        :default => false, :null => false
    t.boolean  "facility_32",        :default => false, :null => false
    t.boolean  "facility_33",        :default => false, :null => false
    t.boolean  "facility_34",        :default => false, :null => false
    t.boolean  "facility_35",        :default => false, :null => false
    t.boolean  "facility_36",        :default => false, :null => false
    t.boolean  "facility_37",        :default => false, :null => false
    t.boolean  "facility_38",        :default => false, :null => false
    t.boolean  "facility_39",        :default => false, :null => false
    t.boolean  "facility_3a",        :default => false, :null => false
    t.boolean  "facility_3b",        :default => false, :null => false
    t.boolean  "facility_3c",        :default => false, :null => false
    t.boolean  "facility_3d",        :default => false, :null => false
    t.boolean  "facility_3e",        :default => false, :null => false
    t.boolean  "facility_3f",        :default => false, :null => false
    t.boolean  "facility_3g",        :default => false, :null => false
    t.boolean  "facility_3h",        :default => false, :null => false
    t.boolean  "facility_3i",        :default => false, :null => false
    t.boolean  "facility_3j",        :default => false, :null => false
    t.boolean  "facility_40",        :default => false, :null => false
    t.boolean  "facility_41",        :default => false, :null => false
    t.boolean  "facility_42",        :default => false, :null => false
    t.boolean  "facility_43",        :default => false, :null => false
    t.boolean  "facility_44",        :default => false, :null => false
    t.boolean  "facility_45",        :default => false, :null => false
    t.boolean  "facility_46",        :default => false, :null => false
    t.boolean  "facility_47",        :default => false, :null => false
    t.boolean  "facility_48",        :default => false, :null => false
    t.boolean  "facility_49",        :default => false, :null => false
    t.boolean  "facility_4a",        :default => false, :null => false
    t.boolean  "facility_4b",        :default => false, :null => false
    t.boolean  "facility_4c",        :default => false, :null => false
    t.boolean  "facility_4d",        :default => false, :null => false
    t.boolean  "facility_4e",        :default => false, :null => false
    t.boolean  "facility_4f",        :default => false, :null => false
    t.boolean  "facility_4g",        :default => false, :null => false
    t.boolean  "facility_4h",        :default => false, :null => false
    t.boolean  "facility_4i",        :default => false, :null => false
    t.boolean  "facility_4j",        :default => false, :null => false
    t.boolean  "facility_50",        :default => false, :null => false
    t.boolean  "facility_51",        :default => false, :null => false
    t.boolean  "facility_52",        :default => false, :null => false
    t.boolean  "facility_53",        :default => false, :null => false
    t.boolean  "facility_54",        :default => false, :null => false
    t.boolean  "facility_55",        :default => false, :null => false
    t.boolean  "facility_56",        :default => false, :null => false
    t.boolean  "facility_57",        :default => false, :null => false
    t.boolean  "facility_58",        :default => false, :null => false
    t.boolean  "facility_59",        :default => false, :null => false
    t.boolean  "facility_5a",        :default => false, :null => false
    t.boolean  "facility_5b",        :default => false, :null => false
    t.boolean  "facility_5c",        :default => false, :null => false
    t.boolean  "facility_5d",        :default => false, :null => false
    t.boolean  "facility_5e",        :default => false, :null => false
    t.boolean  "facility_5f",        :default => false, :null => false
    t.boolean  "facility_5g",        :default => false, :null => false
    t.boolean  "facility_5h",        :default => false, :null => false
    t.boolean  "facility_5i",        :default => false, :null => false
    t.boolean  "facility_5j",        :default => false, :null => false
    t.boolean  "facility_60",        :default => false, :null => false
    t.boolean  "facility_61",        :default => false, :null => false
    t.boolean  "facility_62",        :default => false, :null => false
    t.boolean  "facility_63",        :default => false, :null => false
    t.boolean  "facility_64",        :default => false, :null => false
    t.boolean  "facility_65",        :default => false, :null => false
    t.boolean  "facility_66",        :default => false, :null => false
    t.boolean  "facility_67",        :default => false, :null => false
    t.boolean  "facility_68",        :default => false, :null => false
    t.boolean  "facility_69",        :default => false, :null => false
    t.boolean  "facility_6a",        :default => false, :null => false
    t.boolean  "facility_6b",        :default => false, :null => false
    t.boolean  "facility_6c",        :default => false, :null => false
    t.boolean  "facility_6d",        :default => false, :null => false
    t.boolean  "facility_6e",        :default => false, :null => false
    t.boolean  "facility_6f",        :default => false, :null => false
    t.boolean  "facility_6g",        :default => false, :null => false
    t.boolean  "facility_6h",        :default => false, :null => false
    t.boolean  "facility_6i",        :default => false, :null => false
    t.boolean  "facility_6j",        :default => false, :null => false
    t.boolean  "facility_70",        :default => false, :null => false
    t.boolean  "facility_71",        :default => false, :null => false
    t.boolean  "facility_72",        :default => false, :null => false
    t.boolean  "facility_73",        :default => false, :null => false
    t.boolean  "facility_74",        :default => false, :null => false
    t.boolean  "facility_75",        :default => false, :null => false
    t.boolean  "facility_76",        :default => false, :null => false
    t.boolean  "facility_77",        :default => false, :null => false
    t.boolean  "facility_78",        :default => false, :null => false
    t.boolean  "facility_79",        :default => false, :null => false
    t.boolean  "facility_7a",        :default => false, :null => false
    t.boolean  "facility_7b",        :default => false, :null => false
    t.boolean  "facility_7c",        :default => false, :null => false
    t.boolean  "facility_7d",        :default => false, :null => false
    t.boolean  "facility_7e",        :default => false, :null => false
    t.boolean  "facility_7f",        :default => false, :null => false
    t.boolean  "facility_7g",        :default => false, :null => false
    t.boolean  "facility_7h",        :default => false, :null => false
    t.boolean  "facility_7i",        :default => false, :null => false
    t.boolean  "facility_7j",        :default => false, :null => false
    t.boolean  "facility_80",        :default => false, :null => false
    t.boolean  "facility_81",        :default => false, :null => false
    t.boolean  "facility_82",        :default => false, :null => false
    t.boolean  "facility_83",        :default => false, :null => false
    t.boolean  "facility_84",        :default => false, :null => false
    t.boolean  "facility_85",        :default => false, :null => false
    t.boolean  "facility_86",        :default => false, :null => false
    t.boolean  "facility_87",        :default => false, :null => false
    t.boolean  "facility_88",        :default => false, :null => false
    t.boolean  "facility_89",        :default => false, :null => false
    t.boolean  "facility_8a",        :default => false, :null => false
    t.boolean  "facility_8b",        :default => false, :null => false
    t.boolean  "facility_8c",        :default => false, :null => false
    t.boolean  "facility_8d",        :default => false, :null => false
    t.boolean  "facility_8e",        :default => false, :null => false
    t.boolean  "facility_8f",        :default => false, :null => false
    t.boolean  "facility_8g",        :default => false, :null => false
    t.boolean  "facility_8h",        :default => false, :null => false
    t.boolean  "facility_8i",        :default => false, :null => false
    t.boolean  "facility_8j",        :default => false, :null => false
    t.boolean  "facility_90",        :default => false, :null => false
    t.boolean  "facility_91",        :default => false, :null => false
    t.boolean  "facility_92",        :default => false, :null => false
    t.boolean  "facility_93",        :default => false, :null => false
    t.boolean  "facility_94",        :default => false, :null => false
    t.boolean  "facility_95",        :default => false, :null => false
    t.boolean  "facility_96",        :default => false, :null => false
    t.boolean  "facility_97",        :default => false, :null => false
    t.boolean  "facility_98",        :default => false, :null => false
    t.boolean  "facility_99",        :default => false, :null => false
    t.boolean  "facility_9a",        :default => false, :null => false
    t.boolean  "facility_9b",        :default => false, :null => false
    t.boolean  "facility_9c",        :default => false, :null => false
    t.boolean  "facility_9d",        :default => false, :null => false
    t.boolean  "facility_9e",        :default => false, :null => false
    t.boolean  "facility_9f",        :default => false, :null => false
    t.boolean  "facility_9g",        :default => false, :null => false
    t.boolean  "facility_9h",        :default => false, :null => false
    t.boolean  "facility_9i",        :default => false, :null => false
    t.boolean  "facility_9j",        :default => false, :null => false
    t.boolean  "facility_a0",        :default => false, :null => false
    t.boolean  "facility_a1",        :default => false, :null => false
    t.boolean  "facility_a2",        :default => false, :null => false
    t.boolean  "facility_a3",        :default => false, :null => false
    t.boolean  "facility_a4",        :default => false, :null => false
    t.boolean  "facility_a5",        :default => false, :null => false
    t.boolean  "facility_a6",        :default => false, :null => false
    t.boolean  "facility_a7",        :default => false, :null => false
    t.boolean  "facility_a8",        :default => false, :null => false
    t.boolean  "facility_a9",        :default => false, :null => false
    t.boolean  "facility_aa",        :default => false, :null => false
    t.boolean  "facility_ab",        :default => false, :null => false
    t.boolean  "facility_ac",        :default => false, :null => false
    t.boolean  "facility_ad",        :default => false, :null => false
    t.boolean  "facility_ae",        :default => false, :null => false
    t.boolean  "facility_af",        :default => false, :null => false
    t.boolean  "facility_ag",        :default => false, :null => false
    t.boolean  "facility_ah",        :default => false, :null => false
    t.boolean  "facility_ai",        :default => false, :null => false
    t.boolean  "facility_aj",        :default => false, :null => false
    t.boolean  "particular_note_00", :default => false, :null => false
    t.boolean  "particular_note_01", :default => false, :null => false
    t.boolean  "particular_note_02", :default => false, :null => false
    t.boolean  "particular_note_03", :default => false, :null => false
    t.boolean  "particular_note_04", :default => false, :null => false
    t.boolean  "particular_note_05", :default => false, :null => false
    t.boolean  "particular_note_06", :default => false, :null => false
    t.boolean  "particular_note_07", :default => false, :null => false
    t.boolean  "particular_note_08", :default => false, :null => false
    t.boolean  "particular_note_09", :default => false, :null => false
    t.boolean  "particular_note_0a", :default => false, :null => false
    t.boolean  "particular_note_0b", :default => false, :null => false
    t.boolean  "particular_note_0c", :default => false, :null => false
    t.boolean  "particular_note_0d", :default => false, :null => false
    t.boolean  "particular_note_0e", :default => false, :null => false
    t.boolean  "particular_note_0f", :default => false, :null => false
    t.boolean  "particular_note_0g", :default => false, :null => false
    t.boolean  "particular_note_0h", :default => false, :null => false
    t.boolean  "particular_note_0i", :default => false, :null => false
    t.boolean  "particular_note_0j", :default => false, :null => false
    t.boolean  "particular_note_10", :default => false, :null => false
    t.boolean  "particular_note_11", :default => false, :null => false
    t.boolean  "particular_note_12", :default => false, :null => false
    t.boolean  "particular_note_13", :default => false, :null => false
    t.boolean  "particular_note_14", :default => false, :null => false
    t.boolean  "particular_note_15", :default => false, :null => false
    t.boolean  "particular_note_16", :default => false, :null => false
    t.boolean  "particular_note_17", :default => false, :null => false
    t.boolean  "particular_note_18", :default => false, :null => false
    t.boolean  "particular_note_19", :default => false, :null => false
    t.boolean  "particular_note_1a", :default => false, :null => false
    t.boolean  "particular_note_1b", :default => false, :null => false
    t.boolean  "particular_note_1c", :default => false, :null => false
    t.boolean  "particular_note_1d", :default => false, :null => false
    t.boolean  "particular_note_1e", :default => false, :null => false
    t.boolean  "particular_note_1f", :default => false, :null => false
    t.boolean  "particular_note_1g", :default => false, :null => false
    t.boolean  "particular_note_1h", :default => false, :null => false
    t.boolean  "particular_note_1i", :default => false, :null => false
    t.boolean  "particular_note_1j", :default => false, :null => false
    t.boolean  "particular_note_20", :default => false, :null => false
    t.boolean  "particular_note_21", :default => false, :null => false
    t.boolean  "particular_note_22", :default => false, :null => false
    t.boolean  "particular_note_23", :default => false, :null => false
    t.boolean  "particular_note_24", :default => false, :null => false
    t.boolean  "particular_note_25", :default => false, :null => false
    t.boolean  "particular_note_26", :default => false, :null => false
    t.boolean  "particular_note_27", :default => false, :null => false
    t.boolean  "particular_note_28", :default => false, :null => false
    t.boolean  "particular_note_29", :default => false, :null => false
    t.boolean  "particular_note_2a", :default => false, :null => false
    t.boolean  "particular_note_2b", :default => false, :null => false
    t.boolean  "particular_note_2c", :default => false, :null => false
    t.boolean  "particular_note_2d", :default => false, :null => false
    t.boolean  "particular_note_2e", :default => false, :null => false
    t.boolean  "particular_note_2f", :default => false, :null => false
    t.boolean  "particular_note_2g", :default => false, :null => false
    t.boolean  "particular_note_2h", :default => false, :null => false
    t.boolean  "particular_note_2i", :default => false, :null => false
    t.boolean  "particular_note_2j", :default => false, :null => false
    t.boolean  "particular_note_30", :default => false, :null => false
    t.boolean  "particular_note_31", :default => false, :null => false
    t.boolean  "particular_note_32", :default => false, :null => false
    t.boolean  "particular_note_33", :default => false, :null => false
    t.boolean  "particular_note_34", :default => false, :null => false
    t.boolean  "particular_note_35", :default => false, :null => false
    t.boolean  "particular_note_36", :default => false, :null => false
    t.boolean  "particular_note_37", :default => false, :null => false
    t.boolean  "particular_note_38", :default => false, :null => false
    t.boolean  "particular_note_39", :default => false, :null => false
    t.boolean  "particular_note_3a", :default => false, :null => false
    t.boolean  "particular_note_3b", :default => false, :null => false
    t.boolean  "particular_note_3c", :default => false, :null => false
    t.boolean  "particular_note_3d", :default => false, :null => false
    t.boolean  "particular_note_3e", :default => false, :null => false
    t.boolean  "particular_note_3f", :default => false, :null => false
    t.boolean  "particular_note_3g", :default => false, :null => false
    t.boolean  "particular_note_3h", :default => false, :null => false
    t.boolean  "particular_note_3i", :default => false, :null => false
    t.boolean  "particular_note_3j", :default => false, :null => false
    t.boolean  "particular_note_40", :default => false, :null => false
    t.boolean  "particular_note_41", :default => false, :null => false
    t.boolean  "particular_note_42", :default => false, :null => false
    t.boolean  "particular_note_43", :default => false, :null => false
    t.boolean  "particular_note_44", :default => false, :null => false
    t.boolean  "particular_note_45", :default => false, :null => false
    t.boolean  "particular_note_46", :default => false, :null => false
    t.boolean  "particular_note_47", :default => false, :null => false
    t.boolean  "particular_note_48", :default => false, :null => false
    t.boolean  "particular_note_49", :default => false, :null => false
    t.boolean  "particular_note_4a", :default => false, :null => false
    t.boolean  "particular_note_4b", :default => false, :null => false
    t.boolean  "particular_note_4c", :default => false, :null => false
    t.boolean  "particular_note_4d", :default => false, :null => false
    t.boolean  "particular_note_4e", :default => false, :null => false
    t.boolean  "particular_note_4f", :default => false, :null => false
    t.boolean  "particular_note_4g", :default => false, :null => false
    t.boolean  "particular_note_4h", :default => false, :null => false
    t.boolean  "particular_note_4i", :default => false, :null => false
    t.boolean  "particular_note_4j", :default => false, :null => false
    t.boolean  "particular_note_50", :default => false, :null => false
    t.boolean  "particular_note_51", :default => false, :null => false
    t.boolean  "particular_note_52", :default => false, :null => false
    t.boolean  "particular_note_53", :default => false, :null => false
    t.boolean  "particular_note_54", :default => false, :null => false
    t.boolean  "particular_note_55", :default => false, :null => false
    t.boolean  "particular_note_56", :default => false, :null => false
    t.boolean  "particular_note_57", :default => false, :null => false
    t.boolean  "particular_note_58", :default => false, :null => false
    t.boolean  "particular_note_59", :default => false, :null => false
    t.boolean  "particular_note_5a", :default => false, :null => false
    t.boolean  "particular_note_5b", :default => false, :null => false
    t.boolean  "particular_note_5c", :default => false, :null => false
    t.boolean  "particular_note_5d", :default => false, :null => false
    t.boolean  "particular_note_5e", :default => false, :null => false
    t.boolean  "particular_note_5f", :default => false, :null => false
    t.boolean  "particular_note_5g", :default => false, :null => false
    t.boolean  "particular_note_5h", :default => false, :null => false
    t.boolean  "particular_note_5i", :default => false, :null => false
    t.boolean  "particular_note_5j", :default => false, :null => false
  end

  create_table "messages", :force => true do |t|
    t.integer  "priority"
    t.string   "title"
    t.text     "body"
    t.text     "memo"
    t.string   "org_e_mail"
    t.string   "org_url"
    t.string   "org_name"
    t.string   "source_url"
    t.string   "link_next"
    t.string   "link_prev"
    t.datetime "updated_on"
    t.integer  "level"
  end

  create_table "particularcats", :force => true do |t|
    t.integer  "priority"
    t.string   "name"
    t.text     "memo"
    t.datetime "updated_on"
  end

  create_table "particulars", :force => true do |t|
    t.integer  "priority"
    t.string   "seq"
    t.string   "name"
    t.text     "memo"
    t.integer  "particularcat_id"
    t.datetime "updated_on"
  end

  create_table "pictures", :force => true do |t|
    t.string  "title"
    t.string  "name"
    t.integer "size"
    t.string  "content_type"
    t.binary  "image",        :limit => 2147483647
    t.integer "item_id"
    t.integer "shopitem_id"
    t.integer "student_id"
    t.integer "review_id"
  end

  create_table "review_comments", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "student_id"
    t.integer  "review_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status"
  end

  create_table "reviews", :force => true do |t|
    t.integer  "shopitem_id"
    t.integer  "item_id"
    t.integer  "student_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status"
    t.string   "genre"
    t.string   "genre_wk"
    t.string   "hiro"
  end

  create_table "shopitems", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.integer  "num_val_1"
    t.text     "memo"
    t.integer  "shop_id"
    t.text     "title"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "publish_level"
    t.text     "tag"
    t.integer  "group_id"
    t.string   "author"
    t.string   "illustrator"
    t.string   "translator"
    t.string   "amazon_url"
    t.string   "genre"
    t.integer  "nr_pages"
    t.string   "hero"
    t.datetime "publish_date"
    t.string   "genre_wk"
    t.string   "name_kana"
    t.string   "author_kana"
    t.string   "illustrator_kana"
    t.string   "translator_kana"
    t.boolean  "di_flg",                 :default => false, :null => false
    t.boolean  "recommend_grade_flg_00", :default => false, :null => false
    t.boolean  "recommend_grade_flg_01", :default => false, :null => false
    t.boolean  "recommend_grade_flg_02", :default => false, :null => false
    t.boolean  "recommend_grade_flg_03", :default => false, :null => false
    t.boolean  "recommend_grade_flg_04", :default => false, :null => false
    t.boolean  "recommend_grade_flg_05", :default => false, :null => false
    t.boolean  "recommend_grade_flg_06", :default => false, :null => false
    t.boolean  "recommend_grade_flg_07", :default => false, :null => false
    t.boolean  "recommend_grade_flg_08", :default => false, :null => false
    t.boolean  "recommend_grade_flg_09", :default => false, :null => false
    t.boolean  "recommend_grade_flg_10", :default => false, :null => false
    t.string   "theme"
    t.string   "theme_wk"
    t.integer  "item_id"
    t.datetime "date_val_1"
    t.datetime "date_val_2"
    t.datetime "date_val_3"
    t.datetime "date_val_4"
    t.datetime "date_val_5"
    t.string   "str_val_1"
    t.string   "str_val_2"
    t.string   "str_val_3"
    t.string   "str_val_4"
    t.string   "str_val_5"
    t.string   "str_val_6"
    t.string   "str_val_7"
    t.string   "str_val_8"
    t.string   "str_val_9"
    t.string   "str_val_a"
    t.integer  "num_val_2"
    t.integer  "num_val_3"
    t.integer  "num_val_4"
    t.integer  "num_val_5"
    t.integer  "num_val_6"
    t.integer  "num_val_7"
    t.integer  "num_val_8"
    t.integer  "num_val_9"
    t.integer  "num_val_a"
    t.integer  "spot_id"
  end

  create_table "shops", :force => true do |t|
    t.string  "name"
    t.string  "address"
    t.string  "phone"
    t.string  "fax"
    t.text    "memo"
    t.decimal "longitude",                                  :precision => 17, :scale => 14, :default => 0.0, :null => false
    t.decimal "latitude",                                   :precision => 17, :scale => 15, :default => 0.0, :null => false
    t.string  "homepage"
    t.string  "email_1"
    t.string  "image_url"
    t.decimal "longitude_tokyo_datum_dec",                  :precision => 17, :scale => 14, :default => 0.0, :null => false
    t.decimal "latitude_tokyo_datum_dec",                   :precision => 17, :scale => 15, :default => 0.0, :null => false
    t.string  "longitude_tokyo_datum_ddmmsss"
    t.string  "latitude_tokyo_datum_ddmmsss"
    t.integer "user_id"
    t.integer "group_id"
    t.integer "publish_level"
    t.string  "address_wk1"
    t.string  "zip",                           :limit => 8
    t.string  "prefecture"
    t.string  "address1"
    t.string  "address2"
    t.string  "building"
    t.string  "text1"
    t.string  "text2"
    t.string  "text3"
    t.string  "text4"
    t.string  "text5"
    t.string  "cat_01"
    t.string  "cat_02"
    t.string  "what"
    t.string  "when"
    t.string  "where"
    t.integer "entrance_fee"
    t.integer "membership_fee_mon"
    t.integer "membership_fee_year"
    t.string  "membership_fee_remarks"
    t.integer "member_nr_m"
    t.integer "member_nr_f"
    t.integer "member_nr_all"
    t.string  "member_remarks"
    t.text    "memo_02"
    t.string  "cat_00"
    t.string  "recruitment"
    t.string  "representative"
    t.string  "officer"
    t.string  "start_date"
    t.string  "juridical_person"
    t.string  "juridical_person_start_date"
    t.string  "purpose"
    t.string  "event"
    t.string  "main_cat"
    t.string  "cat01"
    t.string  "cat02"
    t.string  "cat03"
    t.string  "cat04"
    t.string  "cat05"
    t.string  "cat06"
    t.string  "cat07"
    t.string  "cat08"
    t.string  "cat09"
    t.string  "cat10"
    t.string  "cat11"
    t.string  "cat12"
    t.string  "cat13"
    t.string  "cat14"
    t.string  "cat15"
    t.string  "cat16"
    t.string  "cat17"
  end

  create_table "spots", :force => true do |t|
    t.string  "name"
    t.string  "address"
    t.string  "phone"
    t.string  "fax"
    t.text    "memo"
    t.decimal "longitude",                                  :precision => 17, :scale => 14, :default => 0.0, :null => false
    t.decimal "latitude",                                   :precision => 17, :scale => 15, :default => 0.0, :null => false
    t.string  "homepage"
    t.string  "email_1"
    t.string  "image_url"
    t.decimal "longitude_tokyo_datum_dec",                  :precision => 17, :scale => 14, :default => 0.0, :null => false
    t.decimal "latitude_tokyo_datum_dec",                   :precision => 17, :scale => 15, :default => 0.0, :null => false
    t.string  "longitude_tokyo_datum_ddmmsss"
    t.string  "latitude_tokyo_datum_ddmmsss"
    t.integer "user_id"
    t.integer "group_id"
    t.integer "publish_level"
    t.string  "address_wk1"
    t.string  "zip",                           :limit => 8
    t.string  "prefecture"
    t.string  "address1"
    t.string  "address2"
    t.string  "building"
    t.string  "text1"
    t.string  "text2"
    t.string  "text3"
    t.string  "text4"
    t.string  "text5"
  end

  create_table "structures", :force => true do |t|
    t.integer  "priority"
    t.string   "name"
    t.text     "memo"
    t.datetime "updated_on"
  end

  create_table "students", :force => true do |t|
    t.integer  "item_id"
    t.string   "f_name"
    t.string   "m_name"
    t.string   "l_name"
    t.integer  "age"
    t.text     "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "grade"
    t.integer  "sex"
    t.datetime "birthday"
    t.string   "l_name_initial"
    t.string   "alias"
    t.integer  "user_id"
    t.string   "f_name_kana"
    t.string   "l_name_kana"
    t.string   "alias_kana"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string  "login"
    t.string  "password"
    t.string  "name"
    t.string  "email_pc"
    t.string  "email_cell"
    t.integer "group_id"
    t.integer "level"
  end

end
