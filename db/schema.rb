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

ActiveRecord::Schema.define(version: 20120402151524) do

  create_table "ajustes_cuentas_vehiculos", force: :cascade do |t|
    t.datetime "fecha_desde"
    t.datetime "fecha_hasta"
    t.decimal  "valor",       precision: 18
  end

  create_table "baj_liq_viajes", force: :cascade do |t|
    t.integer  "co_numero",         limit: 4
    t.datetime "co_fecha"
    t.integer  "ve_vehiculos_id",   limit: 4
    t.string   "ve_matricula",      limit: 15
    t.integer  "ve_km_ent",         limit: 4
    t.integer  "ve_km_sal",         limit: 4
    t.float    "ve_km_valor",       limit: 53
    t.integer  "ch_choferes_id",    limit: 4
    t.integer  "ch_turnos_id",      limit: 4
    t.string   "ch_hora_ent",       limit: 5
    t.string   "ch_hora_sal",       limit: 5
    t.float    "ch_porc_comis",     limit: 53
    t.integer  "ap_tot_km_ent",     limit: 4
    t.integer  "ap_tot_km_sal",     limit: 4
    t.integer  "ap_alq_km_ent",     limit: 4
    t.integer  "ap_alq_km_sal",     limit: 4
    t.integer  "ap_ticket_num",     limit: 4
    t.integer  "ba_diu_ent",        limit: 4
    t.integer  "ba_diu_sal",        limit: 4
    t.integer  "ba_diu_des",        limit: 4
    t.float    "ba_diu_valor",      limit: 53
    t.integer  "ba_noc_ent",        limit: 4
    t.integer  "ba_noc_sal",        limit: 4
    t.integer  "ba_noc_des",        limit: 4
    t.float    "ba_noc_valor",      limit: 53
    t.integer  "fi_diu_ent",        limit: 4
    t.integer  "fi_diu_sal",        limit: 4
    t.integer  "fi_diu_des",        limit: 4
    t.float    "fi_diu_valor",      limit: 53
    t.integer  "fi_noc_ent",        limit: 4
    t.integer  "fi_noc_sal",        limit: 4
    t.integer  "fi_noc_des",        limit: 4
    t.float    "fi_noc_valor",      limit: 53
    t.float    "re_diu_banderas",   limit: 53
    t.float    "re_diu_fichas",     limit: 53
    t.float    "re_noc_banderas",   limit: 53
    t.float    "re_noc_fichas",     limit: 53
    t.float    "re_otros_mas",      limit: 53
    t.float    "re_otros_menos",    limit: 53
    t.float    "ga_salario_comis",  limit: 53
    t.float    "ga_salario_otros",  limit: 53
    t.float    "ga_gasoil",         limit: 53
    t.float    "ga_aceite",         limit: 53
    t.float    "ga_gomeria",        limit: 53
    t.float    "ga_lavado",         limit: 53
    t.float    "ga_otros1_valor",   limit: 53
    t.string   "ga_otros1_detalle", limit: 50
    t.float    "ga_otros2_valor",   limit: 53
    t.string   "ga_otros2_detalle", limit: 50
    t.float    "tot_recaudado",     limit: 53
    t.float    "tot_gastos",        limit: 53
    t.float    "tot_liquido",       limit: 53
    t.float    "tot_aportes",       limit: 53
    t.float    "tot_subtotal",      limit: 53
    t.float    "tot_varios",        limit: 53
    t.float    "tot_total",         limit: 53
    t.string   "observ",            limit: 256
    t.datetime "ro_fecha_registro"
    t.integer  "ro_usuarios_id",    limit: 4
    t.datetime "fecha_registro"
    t.integer  "usuarios_id",       limit: 4
  end

  create_table "cajas", force: :cascade do |t|
    t.date     "fecha"
    t.integer  "rubro_id",   limit: 4
    t.string   "boleta",     limit: 255
    t.string   "concepto",   limit: 255
    t.decimal  "importe",                precision: 10
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    limit: 4
  end

  create_table "categorias_mantenimiento", force: :cascade do |t|
    t.string "denominacion", limit: 45
  end

  add_index "categorias_mantenimiento", ["denominacion"], name: "denominacion_UNIQUE", unique: true

  create_table "choferes", force: :cascade do |t|
    t.string   "nombres",        limit: 50
    t.string   "apellidos",      limit: 50
    t.string   "apodo",          limit: 50
    t.string   "ci_numero",      limit: 15
    t.datetime "ci_vencim"
    t.string   "cc_numero",      limit: 15
    t.string   "lc_numero",      limit: 15
    t.datetime "lc_vencim"
    t.string   "cs_numero",      limit: 15
    t.datetime "cs_vencim"
    t.string   "bps_numero",     limit: 15
    t.datetime "bps_ingreso"
    t.string   "seg_numero",     limit: 15
    t.datetime "fe_nacim"
    t.datetime "fe_ingreso"
    t.string   "direccion",      limit: 50
    t.string   "tel_domic",      limit: 15
    t.string   "tel_celular",    limit: 15
    t.string   "tel_contacto",   limit: 15
    t.string   "mutualista",     limit: 50
    t.string   "emergencia",     limit: 50
    t.integer  "empresas_id",    limit: 4
    t.float    "comision",       limit: 53
    t.text     "observ",         limit: 65535
    t.integer  "estados_id",     limit: 4
    t.integer  "flag_bps",       limit: 4
    t.integer  "flag_efectivo",  limit: 4
    t.integer  "is_activo",      limit: 1
    t.datetime "fecha_registro"
  end

  create_table "combustibles", force: :cascade do |t|
    t.string "denominacion", limit: 50
  end

  create_table "control_boletas", force: :cascade do |t|
    t.datetime "fecha_caja"
    t.datetime "fecha_boleta"
    t.string   "matricula",     limit: 15
    t.integer  "turno",         limit: 4
    t.integer  "kmts",          limit: 4
    t.float    "recaudado",     limit: 53
    t.float    "h13",           limit: 53
    t.float    "liquido",       limit: 53
    t.integer  "id_recaudador", limit: 4,  default: 0, null: false
    t.integer  "id_chofer",     limit: 4
  end

  create_table "control_recaudacion", force: :cascade do |t|
    t.datetime "fecha_caja"
    t.datetime "fecha_boleta"
    t.string   "matricula",    limit: 15
    t.integer  "turno",        limit: 4
    t.decimal  "recaudado",               precision: 18
  end

  create_table "empresa_chofer", force: :cascade do |t|
    t.integer  "id_empresa",      limit: 4
    t.integer  "id_chofer",       limit: 4
    t.integer  "estado",          limit: 4
    t.datetime "fecha_alta"
    t.datetime "fecha_baja"
    t.integer  "turno",           limit: 4
    t.string   "hora_entrada",    limit: 5
    t.string   "hora_salida",     limit: 5
    t.integer  "descanso",        limit: 4
    t.datetime "fecha_alta_bps"
    t.integer  "charla_seguro",   limit: 1
    t.integer  "carne_seguro",    limit: 1
    t.float    "porc_comision",   limit: 53
    t.float    "porc_aporte",     limit: 53
    t.float    "fijo_aporte",     limit: 53
    t.string   "observaciones",   limit: 200
    t.integer  "mark_for_delete", limit: 1
  end

  create_table "empresas", force: :cascade do |t|
    t.string   "razon_social",  limit: 50
    t.string   "direccion",     limit: 100
    t.string   "telefonos",     limit: 50
    t.string   "contacto",      limit: 50
    t.datetime "fecha_ingreso"
    t.string   "bps_numero",    limit: 15
    t.integer  "bps_digito",    limit: 4
    t.string   "pat_socio",     limit: 15
    t.string   "rubros",        limit: 100
    t.integer  "estados_id",    limit: 4
    t.decimal  "porc_comision",             precision: 18, default: 0
  end

  create_table "gastos_adicionales", force: :cascade do |t|
    t.string   "matricula",        limit: 255
    t.string   "periodo",          limit: 255
    t.integer  "dia",              limit: 4
    t.decimal  "rep_mec_valor",                precision: 10
    t.string   "rep_mec_concepto", limit: 255
    t.decimal  "fijos_valor",                  precision: 10
    t.string   "fijos_concepto",   limit: 255
    t.decimal  "aceite_valor",                 precision: 10
    t.string   "aceite_concepto",  limit: 255
    t.decimal  "ajuste",                       precision: 10
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "gestorias", force: :cascade do |t|
    t.string "gestoria", limit: 50
  end

  create_table "grupos", force: :cascade do |t|
    t.string "grupo", limit: 50
  end

  create_table "historias_choferes", force: :cascade do |t|
    t.integer "id_chofer", limit: 4
  end

  create_table "licencias", force: :cascade do |t|
    t.integer  "id_empresa",         limit: 4
    t.integer  "id_chofer",          limit: 4
    t.string   "cedula",             limit: 15
    t.integer  "motivo",             limit: 4
    t.datetime "fecha_desde"
    t.datetime "fecha_hasta"
    t.decimal  "importe",                       precision: 18
    t.decimal  "salario_vacacional",            precision: 18
  end

  create_table "lineas_historias_choferes", force: :cascade do |t|
    t.datetime "fecha"
    t.string   "detalle",            limit: 200
    t.integer  "id_historia_chofer", limit: 4
  end

  create_table "lineas_operaciones_mantenimiento", force: :cascade do |t|
    t.datetime "fecha"
    t.integer  "kmts",                       limit: 4
    t.string   "articulo",                   limit: 100
    t.integer  "cantidad",                   limit: 4
    t.string   "proveedor",                  limit: 100
    t.string   "mano_de_obra",               limit: 100
    t.integer  "id_operacion_mantenimiento", limit: 4
  end

  create_table "liq_choferes", force: :cascade do |t|
    t.string "cedula",   limit: 15
    t.string "feriados", limit: 15
    t.string "taller",   limit: 15
  end

  create_table "liq_vehiculos", force: :cascade do |t|
    t.string  "matricula",        limit: 15
    t.string  "periodo",          limit: 15
    t.integer "dia",              limit: 4
    t.float   "rep_mec_valor",    limit: 53
    t.string  "rep_mec_concepto", limit: 50
    t.float   "fijos_valor",      limit: 53
    t.string  "fijos_concepto",   limit: 50
    t.float   "aceite_valor",     limit: 53
    t.string  "aceite_concepto",  limit: 50
    t.decimal "ajuste",                      precision: 18, default: 0, null: false
  end

  create_table "liq_vehiculos_textos", force: :cascade do |t|
    t.string "matricula", limit: 15
    t.string "periodo",   limit: 15
    t.text   "texto",     limit: 65535
  end

  create_table "liquidaciones_de_viajes", id: false, force: :cascade do |t|
    t.integer  "co_numero",            limit: 4
    t.datetime "co_fecha"
    t.integer  "ve_vehiculos_id",      limit: 4
    t.string   "matricula",            limit: 15
    t.integer  "ve_km_ent",            limit: 4
    t.integer  "ve_km_sal",            limit: 4
    t.float    "ve_km_valor",          limit: 53
    t.integer  "ch_choferes_id",       limit: 4
    t.integer  "ch_turnos_id",         limit: 4
    t.string   "ch_hora_ent",          limit: 5
    t.string   "ch_hora_sal",          limit: 5
    t.float    "ch_porc_comis",        limit: 53
    t.integer  "ap_tot_km_ent",        limit: 4
    t.integer  "ap_tot_km_sal",        limit: 4
    t.integer  "ap_alq_km_ent",        limit: 4
    t.integer  "ap_alq_km_sal",        limit: 4
    t.integer  "ap_ticket_num",        limit: 4
    t.integer  "ba_diu_ent",           limit: 4
    t.integer  "ba_diu_sal",           limit: 4
    t.integer  "ba_diu_des",           limit: 4
    t.float    "ba_diu_valor",         limit: 53
    t.integer  "ba_noc_ent",           limit: 4
    t.integer  "ba_noc_sal",           limit: 4
    t.integer  "ba_noc_des",           limit: 4
    t.float    "ba_noc_valor",         limit: 53
    t.integer  "fi_diu_ent",           limit: 4
    t.integer  "fi_diu_sal",           limit: 4
    t.integer  "fi_diu_des",           limit: 4
    t.float    "fi_diu_valor",         limit: 53
    t.integer  "fi_noc_ent",           limit: 4
    t.integer  "fi_noc_sal",           limit: 4
    t.integer  "fi_noc_des",           limit: 4
    t.float    "fi_noc_valor",         limit: 53
    t.float    "re_diu_banderas",      limit: 53
    t.float    "re_diu_fichas",        limit: 53
    t.float    "re_noc_banderas",      limit: 53
    t.float    "re_noc_fichas",        limit: 53
    t.float    "re_otros_mas",         limit: 53
    t.float    "re_otros_menos",       limit: 53
    t.float    "ga_salario_comis",     limit: 53
    t.float    "ga_salario_otros",     limit: 53
    t.float    "ga_gasoil",            limit: 53
    t.float    "ga_aceite",            limit: 53
    t.float    "ga_gomeria",           limit: 53
    t.float    "ga_lavado",            limit: 53
    t.float    "ga_otros1_valor",      limit: 53
    t.string   "ga_otros1_detalle",    limit: 50
    t.float    "ga_otros2_valor",      limit: 53
    t.string   "ga_otros2_detalle",    limit: 50
    t.float    "tot_recaudado",        limit: 53
    t.float    "tot_gastos",           limit: 53
    t.float    "tot_liquido",          limit: 53
    t.float    "tot_aportes",          limit: 53
    t.float    "tot_subtotal",         limit: 53
    t.float    "tot_varios",           limit: 53
    t.float    "tot_total",            limit: 53
    t.string   "observ",               limit: 256
    t.datetime "fecha_registro"
    t.integer  "usuarios_id",          limit: 4
    t.integer  "id",                   limit: 4,                               null: false
    t.integer  "id_empresa",           limit: 4,                  default: 55, null: false
    t.integer  "id_totales",           limit: 4,                  default: 0,  null: false
    t.decimal  "recaudacion_digitada",             precision: 18, default: 0,  null: false
    t.string   "return_to",            limit: 15
  end

  create_table "liquidaciones_de_viajes-old", force: :cascade do |t|
    t.integer  "co_numero",            limit: 4
    t.datetime "co_fecha"
    t.integer  "ve_vehiculos_id",      limit: 4
    t.string   "matricula",            limit: 15
    t.integer  "ve_km_ent",            limit: 4
    t.integer  "ve_km_sal",            limit: 4
    t.float    "ve_km_valor",          limit: 53
    t.integer  "ch_choferes_id",       limit: 4
    t.integer  "ch_turnos_id",         limit: 4
    t.string   "ch_hora_ent",          limit: 5
    t.string   "ch_hora_sal",          limit: 5
    t.float    "ch_porc_comis",        limit: 53
    t.integer  "ap_tot_km_ent",        limit: 4
    t.integer  "ap_tot_km_sal",        limit: 4
    t.integer  "ap_alq_km_ent",        limit: 4
    t.integer  "ap_alq_km_sal",        limit: 4
    t.integer  "ap_ticket_num",        limit: 4
    t.integer  "ba_diu_ent",           limit: 4
    t.integer  "ba_diu_sal",           limit: 4
    t.integer  "ba_diu_des",           limit: 4
    t.float    "ba_diu_valor",         limit: 53
    t.integer  "ba_noc_ent",           limit: 4
    t.integer  "ba_noc_sal",           limit: 4
    t.integer  "ba_noc_des",           limit: 4
    t.float    "ba_noc_valor",         limit: 53
    t.integer  "fi_diu_ent",           limit: 4
    t.integer  "fi_diu_sal",           limit: 4
    t.integer  "fi_diu_des",           limit: 4
    t.float    "fi_diu_valor",         limit: 53
    t.integer  "fi_noc_ent",           limit: 4
    t.integer  "fi_noc_sal",           limit: 4
    t.integer  "fi_noc_des",           limit: 4
    t.float    "fi_noc_valor",         limit: 53
    t.float    "re_diu_banderas",      limit: 53
    t.float    "re_diu_fichas",        limit: 53
    t.float    "re_noc_banderas",      limit: 53
    t.float    "re_noc_fichas",        limit: 53
    t.float    "re_otros_mas",         limit: 53
    t.float    "re_otros_menos",       limit: 53
    t.float    "ga_salario_comis",     limit: 53
    t.float    "ga_salario_otros",     limit: 53
    t.float    "ga_gasoil",            limit: 53
    t.float    "ga_aceite",            limit: 53
    t.float    "ga_gomeria",           limit: 53
    t.float    "ga_lavado",            limit: 53
    t.float    "ga_otros1_valor",      limit: 53
    t.string   "ga_otros1_detalle",    limit: 50
    t.float    "ga_otros2_valor",      limit: 53
    t.string   "ga_otros2_detalle",    limit: 50
    t.float    "tot_recaudado",        limit: 53
    t.float    "tot_gastos",           limit: 53
    t.float    "tot_liquido",          limit: 53
    t.float    "tot_aportes",          limit: 53
    t.float    "tot_subtotal",         limit: 53
    t.float    "tot_varios",           limit: 53
    t.float    "tot_total",            limit: 53
    t.string   "observ",               limit: 256
    t.datetime "fecha_registro"
    t.integer  "usuarios_id",          limit: 4
    t.integer  "id_empresa",           limit: 4,                  default: 55, null: false
    t.integer  "id_totales",           limit: 4
    t.decimal  "recaudacion_digitada",             precision: 18, default: 0,  null: false
    t.string   "return_to",            limit: 255
  end

  create_table "matriculas", force: :cascade do |t|
    t.string  "codigo",     limit: 15
    t.integer "empresa_id", limit: 4
  end

  create_table "matriculas_log", force: :cascade do |t|
    t.integer  "matricula_id", limit: 4
    t.integer  "vehiculo_id",  limit: 4
    t.integer  "empresa_id",   limit: 4
    t.datetime "fecha"
    t.integer  "evento",       limit: 4
  end

  create_table "parametros", force: :cascade do |t|
    t.integer  "mes",        limit: 4
    t.integer  "anio",       limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "periodos", force: :cascade do |t|
    t.datetime "fecha_desde"
    t.datetime "fecha_hasta"
    t.string   "descripcion", limit: 50
    t.integer  "status",      limit: 1
  end

  create_table "precios_gasoil", force: :cascade do |t|
    t.datetime "fecha_desde"
    t.datetime "fecha_hasta"
    t.float    "precio",         limit: 53
    t.integer  "id_combustible", limit: 4
  end

  create_table "proveedores", force: :cascade do |t|
    t.string "nombre", limit: 100
  end

  add_index "proveedores", ["nombre"], name: "UQ__proveedores__6D6238AF", unique: true

  create_table "recaudadores", force: :cascade do |t|
    t.string "nombre", limit: 50
  end

  create_table "rubros", force: :cascade do |t|
    t.string   "denominacion",      limit: 255
    t.integer  "secuencia",         limit: 4
    t.string   "tipo",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",           limit: 4
    t.integer  "secuencia_reporte", limit: 4
  end

  create_table "rubros_mantenimiento", force: :cascade do |t|
    t.string  "descripcion",            limit: 100
    t.integer "frecuencia_meses",       limit: 4
    t.integer "frecuencia_kmts",        limit: 4
    t.integer "categoria_id",           limit: 4,   default: 0
    t.integer "es_correa_distribucion", limit: 1
  end

  add_index "rubros_mantenimiento", ["descripcion"], name: "UQ__servicios__703EA55A", unique: true

  create_table "servicios_realizados", force: :cascade do |t|
    t.datetime "fecha"
    t.integer  "kmts_vehiculo", limit: 4
    t.datetime "fecha_proximo"
    t.integer  "kmts_proximo",  limit: 4
    t.text     "materiales",    limit: 65535
    t.text     "mano_de_obra",  limit: 65535
    t.integer  "id_servicio",   limit: 4
    t.integer  "id_proveedor",  limit: 4
    t.integer  "id_vehiculo",   limit: 4
    t.integer  "cantidad",      limit: 4,     default: 0
    t.string   "matricula",     limit: 10
  end

  create_table "tarifas", force: :cascade do |t|
    t.datetime "fecha"
    t.float    "valor_ba_diu", limit: 53
    t.float    "valor_ba_noc", limit: 53
    t.float    "valor_fi_diu", limit: 53
    t.float    "valor_fi_noc", limit: 53
  end

  create_table "tramites", force: :cascade do |t|
    t.integer "empresas_id",  limit: 4
    t.integer "gestorias_id", limit: 4
    t.string  "tramite",      limit: 50
  end

  create_table "users", force: :cascade do |t|
    t.string "username", limit: 60
    t.string "password", limit: 60
  end

  create_table "usuarios", force: :cascade do |t|
    t.string  "usuario",   limit: 15
    t.string  "nombre",    limit: 50
    t.integer "grupos_id", limit: 4
    t.string  "password",  limit: 100
  end

  create_table "vehiculos", force: :cascade do |t|
    t.string  "matricula",                 limit: 15
    t.string  "marca",                     limit: 50
    t.string  "seguro",                    limit: 15
    t.string  "padron",                    limit: 15
    t.string  "motor",                     limit: 15
    t.integer "empresas_id",               limit: 4
    t.integer "estados_id",                limit: 4
    t.integer "id_combustible",            limit: 4
    t.integer "id_ultimo_viaje_realizado", limit: 4
  end

end
