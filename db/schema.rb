# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180207152850) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"

  create_table "albums", force: :cascade do |t|
    t.string   "name"
    t.date     "date"
    t.text     "description"
    t.string   "image"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "attendances", force: :cascade do |t|
    t.integer  "attendable_id"
    t.string   "attendable_type"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "attendances", ["attendable_type", "attendable_id"], name: "index_attendances_on_attendable_type_and_attendable_id"
  add_index "attendances", ["user_id"], name: "index_attendances_on_user_id"

  create_table "average_caches", force: :cascade do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "avg",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blogs", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.string   "image"
    t.integer  "user_id"
    t.integer  "category_blog_id"
    t.string   "video_link"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "user_image_link"
    t.string   "user_link"
    t.string   "blog_image_link"
    t.string   "twitter_link"
    t.string   "slug"
    t.string   "blogger_name"
    t.boolean  "publish"
    t.date     "publishdate"
    t.string   "subtitle"
    t.string   "blogimg_one"
    t.string   "blogimg_two"
    t.string   "blogimg_three"
    t.string   "blogimgtxt_one"
    t.string   "blogimgtxt_two"
    t.string   "blogimgtxt_three"
  end

  add_index "blogs", ["slug"], name: "index_blogs_on_slug", unique: true

  create_table "cards", force: :cascade do |t|
    t.string   "title"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  add_index "cards", ["slug"], name: "index_cards_on_slug", unique: true

  create_table "category_ages", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_blogs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_contactclients", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_countries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_enquiries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_genders", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_idealbodytypes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_idealbodytypes_preferences", id: false, force: :cascade do |t|
    t.integer "preference_id",             null: false
    t.integer "category_idealbodytype_id", null: false
  end

  create_table "category_idealeducations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_idealeducations_preferences", id: false, force: :cascade do |t|
    t.integer "preference_id",              null: false
    t.integer "category_idealeducation_id", null: false
  end

  create_table "category_idealethnicities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_idealethnicities_preferences", id: false, force: :cascade do |t|
    t.integer "preference_id",              null: false
    t.integer "category_idealethnicity_id", null: false
  end

  create_table "category_idealheights", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_idealheights_preferences", id: false, force: :cascade do |t|
    t.integer "preference_id",           null: false
    t.integer "category_idealheight_id", null: false
  end

  create_table "category_idealkids", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_idealparents", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_idealrelationships", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_idealreligions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_idealreligions_preferences", id: false, force: :cascade do |t|
    t.integer "preference_id",             null: false
    t.integer "category_idealreligion_id", null: false
  end

  create_table "category_idealsmokes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_idealsmokes_preferences", id: false, force: :cascade do |t|
    t.integer "preference_id",          null: false
    t.integer "category_idealsmoke_id", null: false
  end

  create_table "category_idealstatuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_idealstatuses_preferences", id: false, force: :cascade do |t|
    t.integer "preference_id",           null: false
    t.integer "category_idealstatus_id", null: false
  end

  create_table "category_inviteoptions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_invites", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_managementgroups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_matchbodytypes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_matcheducations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_matchethnicities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_matchheights", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_matchkids", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_matchparents", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_matchrelationships", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_matchreligions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_matchseekings", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_matchsmokes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_matchstatuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_quantitygenders", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_quantitygendersocials", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_reports", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_topics", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string   "title",            limit: 50, default: ""
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.string   "role",                        default: "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "social_id"
    t.text     "content"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "contacts", force: :cascade do |t|
    t.string   "email"
    t.text     "message"
    t.integer  "category_enquiry_id"
    t.string   "tel"
    t.string   "status"
    t.string   "reference"
    t.integer  "category_contactclient_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "lastname"
    t.string   "companyname"
    t.string   "firstname"
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "address"
    t.string   "postcode"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "user_id"
    t.integer  "category_topic_id"
    t.string   "image"
    t.date     "date"
    t.time     "time"
    t.string   "city"
    t.integer  "quantity"
    t.integer  "category_age_id"
    t.integer  "category_country_id"
    t.integer  "quantity_men"
    t.integer  "quantity_women"
    t.integer  "category_quantitygender_id"
    t.string   "venuename"
    t.decimal  "price"
    t.time     "time_end"
    t.text     "maplink"
    t.boolean  "close"
    t.string   "reference"
    t.string   "slug"
    t.boolean  "display_match"
    t.integer  "event_score_access"
    t.boolean  "upcoming_event"
    t.string   "agerange_info"
    t.boolean  "agerange"
    t.string   "imgvenue_one"
    t.string   "imgvenue_two"
    t.string   "imgvenue_three"
    t.string   "imgevent_one"
    t.string   "imgevent_two"
    t.string   "imgevent_three"
    t.string   "imgevent_four"
    t.string   "imgevent_five"
    t.string   "imgevent_six"
    t.boolean  "external_event"
    t.text     "external_eventlink"
    t.boolean  "soldout"
    t.boolean  "soldout_men"
    t.boolean  "soldout_women"
    t.string   "event_image_link"
  end

  add_index "events", ["slug"], name: "index_events_on_slug", unique: true

  create_table "externalattendinglists", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "reference"
  end

  create_table "externalattendinglists_users", id: false, force: :cascade do |t|
    t.integer "externalattendinglist_id", null: false
    t.integer "user_id",                  null: false
  end

  create_table "favourites", force: :cascade do |t|
    t.integer  "favourited_id"
    t.string   "favourited_type"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "favourites", ["favourited_type", "favourited_id"], name: "index_favourites_on_favourited_type_and_favourited_id"
  add_index "favourites", ["user_id"], name: "index_favourites_on_user_id"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "friendships", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.integer  "friend_id"
    t.string   "status"
    t.datetime "accepted_at"
  end

  create_table "hosts", force: :cascade do |t|
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hosts_users", id: false, force: :cascade do |t|
    t.integer "host_id", null: false
    t.integer "user_id", null: false
  end

  create_table "impressions", force: :cascade do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.text     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id"

  create_table "invite_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "inviter_id"
    t.integer  "social_id"
    t.integer  "event_id"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "invites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "invitee_id"
    t.integer  "social_id"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "status"
  end

  create_table "invites_users", id: false, force: :cascade do |t|
    t.integer "invite_id", null: false
    t.integer "user_id",   null: false
  end

  create_table "mailboxer_conversation_opt_outs", force: :cascade do |t|
    t.integer "unsubscriber_id"
    t.string  "unsubscriber_type"
    t.integer "conversation_id"
  end

  add_index "mailboxer_conversation_opt_outs", ["conversation_id"], name: "index_mailboxer_conversation_opt_outs_on_conversation_id"
  add_index "mailboxer_conversation_opt_outs", ["unsubscriber_id", "unsubscriber_type"], name: "index_mailboxer_conversation_opt_outs_on_unsubscriber_id_type"

  create_table "mailboxer_conversations", force: :cascade do |t|
    t.string   "subject",    default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "mailboxer_notifications", force: :cascade do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              default: ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                default: false
    t.string   "notification_code"
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "attachment"
    t.datetime "updated_at",                           null: false
    t.datetime "created_at",                           null: false
    t.boolean  "global",               default: false
    t.datetime "expires"
  end

  add_index "mailboxer_notifications", ["conversation_id"], name: "index_mailboxer_notifications_on_conversation_id"
  add_index "mailboxer_notifications", ["notified_object_id", "notified_object_type"], name: "index_mailboxer_notifications_on_notified_object_id_and_type"
  add_index "mailboxer_notifications", ["sender_id", "sender_type"], name: "index_mailboxer_notifications_on_sender_id_and_sender_type"
  add_index "mailboxer_notifications", ["type"], name: "index_mailboxer_notifications_on_type"

  create_table "mailboxer_receipts", force: :cascade do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                            null: false
    t.boolean  "is_read",                    default: false
    t.boolean  "trashed",                    default: false
    t.boolean  "deleted",                    default: false
    t.string   "mailbox_type",    limit: 25
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.boolean  "is_delivered",               default: false
    t.string   "delivery_method"
    t.string   "message_id"
  end

  add_index "mailboxer_receipts", ["notification_id"], name: "index_mailboxer_receipts_on_notification_id"
  add_index "mailboxer_receipts", ["receiver_id", "receiver_type"], name: "index_mailboxer_receipts_on_receiver_id_and_receiver_type"

  create_table "managements", force: :cascade do |t|
    t.decimal  "venuecost"
    t.decimal  "hostcost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date     "date"
    t.integer  "event_id"
    t.string   "monthyear"
    t.string   "week"
  end

  create_table "overall_averages", force: :cascade do |t|
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "overall_avg",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", force: :cascade do |t|
    t.string   "email"
    t.integer  "user_id"
    t.integer  "subscription_id"
    t.string   "reference"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "event_id"
    t.string   "stripe_customer_id"
    t.string   "stripe_subscription_id"
    t.string   "stripe_payment_id"
    t.datetime "subscription_payment_date"
    t.datetime "event_payment_date"
    t.string   "user_card_type"
    t.string   "user_card_last4"
    t.integer  "user_card_exp_month"
    t.integer  "user_card_exp_year"
    t.string   "status"
    t.string   "event_payment_date_status"
    t.string   "subscription_payment_date_status"
  end

  create_table "preferences", force: :cascade do |t|
    t.string   "town"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "user_id"
    t.string   "name"
    t.string   "slug"
    t.string   "idealage_start"
    t.string   "idealage_end"
    t.integer  "category_matchseeking_id"
    t.integer  "category_matchrelationship_id"
    t.integer  "category_matchstatus_id"
    t.integer  "category_matchparent_id"
    t.integer  "category_matchkid_id"
    t.integer  "category_matcheducation_id"
    t.integer  "category_matchheight_id"
    t.integer  "category_matchbodytype_id"
    t.integer  "category_matchethnicity_id"
    t.integer  "category_matchreligion_id"
    t.integer  "category_matchsmoke_id"
    t.integer  "category_idealrelationship_id"
    t.integer  "category_idealstatus_id"
    t.integer  "category_idealparent_id"
    t.integer  "category_idealkid_id"
    t.integer  "category_idealeducation_id"
    t.integer  "category_idealheight_id"
    t.integer  "category_idealbodytype_id"
    t.integer  "category_idealethnicity_id"
    t.integer  "category_idealreligion_id"
    t.integer  "category_idealsmoke_id"
  end

  add_index "preferences", ["slug"], name: "index_preferences_on_slug", unique: true

  create_table "rates", force: :cascade do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "stars",         null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type"
  add_index "rates", ["rater_id"], name: "index_rates_on_rater_id"

  create_table "rating_caches", force: :cascade do |t|
    t.integer  "cacheable_id"
    t.string   "cacheable_type"
    t.float    "avg",            null: false
    t.integer  "qty",            null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type"

  create_table "read_marks", force: :cascade do |t|
    t.integer  "readable_id"
    t.string   "readable_type", limit: 255, null: false
    t.integer  "reader_id"
    t.string   "reader_type",               null: false
    t.datetime "timestamp"
  end

  add_index "read_marks", ["reader_id", "reader_type", "readable_type", "readable_id"], name: "read_marks_reader_readable_index", unique: true

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "reports", force: :cascade do |t|
    t.text     "content"
    t.integer  "category_report_id"
    t.integer  "event_id"
    t.integer  "social_id"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "reference"
    t.integer  "reporter_id"
  end

  create_table "signups", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "socials", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "address"
    t.string   "postcode"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "user_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "category_topic_id"
    t.string   "image"
    t.date     "date"
    t.time     "time"
    t.string   "city"
    t.integer  "quantity"
    t.integer  "category_age_id"
    t.string   "companyname"
    t.integer  "category_country_id"
    t.integer  "category_invite_id"
    t.string   "speakername"
    t.text     "speakerlinkedin"
    t.string   "venuename"
    t.text     "maplink"
    t.boolean  "close"
    t.string   "reference"
    t.string   "slug"
    t.integer  "category_quantitygendersocial_id"
    t.boolean  "upcoming_social"
    t.boolean  "company_image"
    t.boolean  "eventbrite"
    t.text     "eventbrite_url"
    t.string   "social_image_link"
  end

  add_index "socials", ["slug"], name: "index_socials_on_slug", unique: true

  create_table "subscriptions", force: :cascade do |t|
    t.string   "title"
    t.decimal  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "reference"
    t.string   "slug"
  end

  add_index "subscriptions", ["slug"], name: "index_subscriptions_on_slug", unique: true

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["context"], name: "index_taggings_on_context"
  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
  add_index "taggings", ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
  add_index "taggings", ["taggable_id"], name: "index_taggings_on_taggable_id"
  add_index "taggings", ["taggable_type"], name: "index_taggings_on_taggable_type"
  add_index "taggings", ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
  add_index "taggings", ["tagger_id"], name: "index_taggings_on_tagger_id"

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "email",                           default: "", null: false
    t.string   "encrypted_password",              default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "firstname"
    t.string   "lastname"
    t.date     "birthdate"
    t.integer  "category_gender_id"
    t.text     "description"
    t.string   "profession"
    t.string   "image"
    t.integer  "category_role_id"
    t.integer  "category_managementgroup_id"
    t.string   "stripe_id"
    t.string   "stripe_subscription_pymt_id"
    t.string   "card_last4"
    t.integer  "card_exp_month"
    t.integer  "card_exp_year"
    t.string   "card_type"
    t.datetime "recent_subscription_pymt_date"
    t.string   "stripe_event_pymt_id"
    t.datetime "recent_event_pymt_date"
    t.string   "reference"
    t.text     "host_description"
    t.string   "slug"
    t.integer  "category_inviteoption_id"
    t.string   "link_fb"
    t.string   "link_twitter"
    t.integer  "category_country_id"
    t.string   "city"
    t.datetime "recent_subscription_cancel_date"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true

  create_table "venues", force: :cascade do |t|
    t.string   "venuename"
    t.string   "address"
    t.string   "postcode"
    t.text     "maplink"
    t.string   "station"
    t.decimal  "price"
    t.string   "min_capacity"
    t.string   "eventmanager"
    t.string   "contact"
    t.string   "image"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "website"
    t.integer  "category_country_id"
    t.string   "city"
    t.text     "note"
    t.string   "slug"
    t.string   "email"
    t.boolean  "favourite"
  end

  add_index "venues", ["slug"], name: "index_venues_on_slug", unique: true

end
