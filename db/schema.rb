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

ActiveRecord::Schema.define(version: 20150224005801) do

  create_table "alerta", force: true do |t|
    t.string   "texto"
    t.integer  "producto_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "alerta", ["producto_id"], name: "index_alerta_on_producto_id"

  create_table "articulos", force: true do |t|
    t.integer  "cantidad"
    t.integer  "producto_id"
    t.integer  "ventum_id"
    t.integer  "total"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articulos", ["producto_id"], name: "index_articulos_on_producto_id"
  add_index "articulos", ["ventum_id"], name: "index_articulos_on_ventum_id"

  create_table "clientes", force: true do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.integer  "rut"
    t.boolean  "credito"
    t.string   "direccion"
    t.integer  "telefono"
    t.string   "nombre_aval"
    t.string   "apellido_aval"
    t.integer  "rut_aval"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "productos", force: true do |t|
    t.string   "codigo"
    t.string   "nombre"
    t.integer  "valor"
    t.integer  "tipo_producto_id"
    t.integer  "stock"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "productos", ["tipo_producto_id"], name: "index_productos_on_tipo_producto_id"

  create_table "tipo_productos", force: true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usuarios", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "nombre"
    t.string   "apellido"
    t.integer  "tipo_usuario"
    t.boolean  "aprovado",               default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true

  create_table "venta", force: true do |t|
    t.integer  "usuario_id"
    t.integer  "total"
    t.boolean  "terminada",  default: false, null: false
    t.date     "fecha"
    t.integer  "cliente_id"
    t.integer  "cuota"
    t.integer  "pagado",     default: 0,     null: false
    t.integer  "abono",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venta", ["usuario_id"], name: "index_venta_on_usuario_id"

end
