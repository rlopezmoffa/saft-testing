# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end

ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.plural /^(ox)$/i, '\1en'   
  inflect.singular /^(ox)en/i, '\1'
  inflect.irregular 'empresa', 'empresas'
  inflect.irregular 'vehiculo', 'vehiculos'
  inflect.irregular 'gestoria', 'gestorias'
  inflect.irregular 'tramite', 'tramites'
  inflect.irregular 'licencia', 'licencias'
  inflect.irregular 'tarifa', 'tarifas'
  inflect.irregular 'chofer', 'choferes'
  inflect.irregular 'matricula', 'matriculas'
  inflect.irregular 'matricula_log', 'matriculas_log'
  inflect.irregular 'periodo', 'periodos'
  inflect.irregular 'licencia', 'licencias'
  inflect.irregular 'proveedor', 'proveedores'
  inflect.irregular 'combustible', 'combustibles'
  inflect.irregular 'rubro_mantenimiento', 'rubros_mantenimiento'
  inflect.irregular 'categoria_mantenimiento', 'categorias_mantenimiento'
  inflect.irregular 'operacion_mantenimiento', 'operaciones_mantenimiento'
  inflect.irregular 'servicio_realizado', 'servicios_realizados' 
  inflect.irregular 'liquidacion_de_viajes', 'liquidaciones_de_viajes'
  inflect.irregular 'gasto_adicional', 'gastos_adicionales' 
  inflect.irregular 'parametros', 'parametros' 
  inflect.uncountable %w( fish sheep )
end
