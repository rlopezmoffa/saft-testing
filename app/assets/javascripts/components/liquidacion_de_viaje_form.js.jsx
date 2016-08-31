class LiquidacionDeViajeForm extends React.Component {
  constructor(props) {
    super(props);

    this.initState();

    this.handleChange = this.handleChange.bind(this);
    this.onMatriculaBlur = this.onMatriculaBlur.bind(this);
    this.onCedulaBlur = this.onCedulaBlur.bind(this);
  }

  handleChange(event) {
    this.setState({
      [event.target.name]:  event.target.value
    });
  }

  onMatriculaBlur(event) {
    const { matricula } = this.state;

    if (matricula.length > 0) {
      const target = event.target;

      $.getJSON(`/matriculas/search.json?codigo=${matricula}`)
        .done((json) => {
          this.setState({empresa: json.empresa});
        })
        .fail(() => {
          this.setState({empresa: null});
          target.focus();
        });
    }
  }

  onCedulaBlur(event) {
    const { cedula, empresa } = this.state;

    if (empresa && cedula.length > 0) {
      const target = event.target;

      $.getJSON(`/empresa_choferes/search.json?id_empresa=${empresa.id}&cedula=${cedula}`)
        .done((json) => {
          this.setState({empresa_chofer: json});
        })
        .fail(() => {
          this.setState({empresa_chofer: null});
          target.focus();
        });
    }
  }

  getDifference(entry, exit) {
    const parsedEntry = parseInt(entry);
    const parsedExit = parseInt(exit);
    return isNaN(parsedEntry) || isNaN(parsedExit) ? '' : parsedExit - parsedEntry;
  }

  getTotalKmt() {
    const { veKmEnt, veKmSal } = this.state;
    return this.getDifference(veKmEnt, veKmSal);
  }

  getTotalBaDiu() {
    const { baDiuEnt, baDiuSal } = this.state;
    return this.getDifference(baDiuEnt, baDiuSal);
  }

  getTotalFiDiu() {
    const { fiDiuEnt, fiDiuSal } = this.state;
    return this.getDifference(fiDiuEnt, fiDiuSal);
  }

  getTotalBaNoc() {
    const { baNocEnt, baNocSal } = this.state;
    return this.getDifference(baNocEnt, baNocSal);
  }

  getTotalFiNoc() {
    const { fiNocEnt, fiNocSal } = this.state;
    return this.getDifference(fiNocEnt, fiNocSal);
  }

  getRecBaDiu() {
    const { baDiuDes } = this.state;
    const { tarifa } = this.props;
    const parsedDes = Number(baDiuDes);
    const total = this.getTotalBaDiu();

    return total ? (total - parsedDes) * tarifa.valor_ba_diu : '';
  }

  getRecFiDiu() {
    const { fiDiuDes } = this.state;
    const { tarifa } = this.props;
    const parsedDes = Number(fiDiuDes);
    const total = this.getTotalFiDiu();

    return total ? (total - parsedDes) * tarifa.valor_fi_diu : '';
  }

  getRecBaNoc() {
    const { baNocDes } = this.state;
    const { tarifa } = this.props;
    const total = this.getTotalBaNoc();
    const parsedDes = Number(baNocDes);

    return total ? (total - parsedDes) * tarifa.valor_ba_noc : '';
  }

  getRecFiNoc() {
    const { fiNocDes } = this.state;
    const { tarifa } = this.props;
    const parsedDes = Number(fiNocDes);
    const total = this.getTotalFiNoc();

    return total ? (total - parsedDes) * tarifa.valor_fi_noc : '';
  }

  getValorKmt() {
    const recaudado = this.getRecaudado();
    const totalKmt = this.getTotalKmt();

    if (recaudado && totalKmt) {
      return recaudado / totalKmt;
    } else {
      return '';
    }
  }

  getRecaudado() {
    const { reOtrosMas, reOtrosMenos } = this.state;
    const parsedReOtrosMas = parseInt(reOtrosMas);
    const parsedReOtrosMenos = parseInt(reOtrosMenos);
    const recBaDiu = this.getRecBaDiu();
    const recFiDiu = this.getRecFiDiu();
    const recBaNoc = this.getRecBaNoc();
    const recFiNoc = this.getRecFiNoc();
    if (!isNaN(parsedReOtrosMas) && !isNaN(parsedReOtrosMenos) && recBaDiu && recFiDiu && recBaNoc && recFiNoc) {
      return recBaDiu + recFiDiu + recBaNoc + recFiNoc + parsedReOtrosMas - parsedReOtrosMenos;
    } else {
      return '';
    }
  }

  getSalario() {
    const { empresa_chofer } = this.state;
    const recaudado = this.getRecaudado();
    if (recaudado && empresa_chofer) {
      const comision = empresa_chofer.porc_comision;
      return recaudado * comision / 100;
    } else {
      return '';
    }
  }

  getGastos() {
    const { gaComplemento, gaGasoil, gaAceite, gaGomeria, gaLavado, gaOtros1Valor, gaOtros2Valor } = this.state;
    const gastos = [this.getSalario(), gaComplemento, gaGasoil, gaAceite, gaGomeria, gaLavado, gaOtros1Valor, gaOtros2Valor];
    return gastos.map((x) => parseInt(x)).filter((x) => !isNaN(x)).reduce((x, r) => x + r, 0);
  }

  getLiquido() {
    const recaudado = this.getRecaudado();
    const gastos = this.getGastos();
    if (recaudado && gastos) {
      return recaudado - gastos;
    } else {
      return '';
    }
  }

  getSubtotal() {
    const liquido = this.getLiquido();
    const { aportes } = this.state;
    const parsedAportes = parseInt(aportes);
    if (!isNaN(parsedAportes) && liquido) {
      return parsedAportes + liquido;
    } else {
      return '';
    }
  }

  getTotal() {
    const subtotal = this.getSubtotal();
    const { varios } = this.state;
    const parsedVarios = parseInt(varios);
    if (!isNaN(parsedVarios) && subtotal) {
      return subtotal + parsedVarios;
    } else {
      return '';
    }
  }

  save() {
    let url, method;
    const state = this.state;
    const current = this.props.liquidacion_de_viaje;

    if (current) {
      url = `/liquidacion_de_viajes/${current.id}.json`;
      method = 'PUT';
    } else {
      url = '/liquidacion_de_viajes.json'
      method = 'POST';
    }

    const data = {
      matricula: state.matricula,
      fecha_registro: state.fechaRegistro,
      id_empresa: state.empresa ? state.empresa.id : null,
      ch_choferes_id: state.empresa_chofer ? state.empresa_chofer.chofer.id : null,
      ch_turnos_id: state.chTurnosId,
      ve_km_ent: state.veKmEnt,
      ve_km_sal: state.veKmSal,
      ba_diu_ent: state.baDiuEnt,
      ba_diu_sal: state.baDiuSal,
      fi_diu_ent: state.fiDiuEnt,
      fi_diu_sal: state.fiDiuSal,
      ba_noc_ent: state.baNocEnt,
      ba_noc_sal: state.baNocSal,
      fi_noc_ent: state.fiNocEnt,
      fi_noc_sal: state.fiNocSal,
      ba_diu_des: state.baDiuDes,
      fi_diu_des: state.fiDiuDes,
      ba_noc_des: state.baNocDes,
      fi_noc_des: state.fiNocDes,
      ga_salario_otros: state.gaComplemento,
      ga_gasoil: state.gaGasoil,
      ga_aceite: state.gaAceite,
      ga_gomeria: state.gaGomeria,
      ga_lavado: state.gaLavado,
      ga_otros1_valor: state.gaOtros1Valor,
      ga_otros1_detalle: state.gaOtros1Detalle,
      ga_otros2_valor: state.gaOtros2Valor,
      ga_otros2_detalle: state.gaOtros2Detalle,
      re_otros_mas: state.reOtrosMas,
      re_otros_menos: state.reOtrosMenos,
      tot_aportes: state.aportes,
      tot_varios: state.varios,
      recaudacion_digitada: state.recaudacionDigitada,
      observ: state.observaciones
    };

    $.ajax(url, {
      method: method,
      data: {liquidacion_de_viaje: data}
    }).done((data, status, xhr) => {
      window.location = xhr.getResponseHeader('Location');
    }).fail((error) => {
      alert('Error: no se pudo guardar');
    });
  }

  initState() {
    const state = {};
    const { liquidacion_de_viaje, empresa, chofer, empresa_chofer } = this.props;

    if (liquidacion_de_viaje) {
      state.matricula = liquidacion_de_viaje.matricula;
      state.fechaRegistro = liquidacion_de_viaje.fecha_registro_as_json;
      state.chTurnosId = liquidacion_de_viaje.ch_turnos_id;
      state.veKmEnt = liquidacion_de_viaje.ve_km_ent;
      state.veKmSal = liquidacion_de_viaje.ve_km_sal;
      state.baDiuEnt = liquidacion_de_viaje.ba_diu_ent;
      state.baDiuSal = liquidacion_de_viaje.ba_diu_sal;
      state.fiDiuEnt = liquidacion_de_viaje.fi_diu_ent;
      state.fiDiuSal = liquidacion_de_viaje.fi_diu_sal;
      state.baNocEnt = liquidacion_de_viaje.ba_noc_ent;
      state.baNocSal = liquidacion_de_viaje.ba_noc_sal;
      state.fiNocEnt = liquidacion_de_viaje.fi_noc_ent;
      state.fiNocSal = liquidacion_de_viaje.fi_noc_sal;
      state.baDiuDes = liquidacion_de_viaje.ba_diu_des;
      state.fiDiuDes = liquidacion_de_viaje.fi_diu_des;
      state.baNocDes = liquidacion_de_viaje.ba_noc_des;
      state.fiNocDes = liquidacion_de_viaje.fi_noc_des;
      state.gaComplemento = liquidacion_de_viaje.ga_salario_otros;
      state.gaGasoil = liquidacion_de_viaje.ga_gasoil;
      state.gaAceite = liquidacion_de_viaje.ga_aceite;
      state.gaGomeria = liquidacion_de_viaje.ga_gomeria;
      state.gaLavado = liquidacion_de_viaje.ga_lavado;
      state.gaOtros1Valor = liquidacion_de_viaje.ga_otros1_valor;
      state.gaOtros1Detalle = liquidacion_de_viaje.ga_otros1_detalle;
      state.gaOtros2Valor = liquidacion_de_viaje.ga_otros2_valor;
      state.gaOtros2Detalle = liquidacion_de_viaje.ga_otros2_detalle;
      state.reOtrosMas = liquidacion_de_viaje.re_otros_mas;
      state.reOtrosMenos = liquidacion_de_viaje.re_otros_menos;
      state.aportes = liquidacion_de_viaje.tot_aportes;
      state.varios = liquidacion_de_viaje.tot_varios;
      state.recaudacionDigitada = liquidacion_de_viaje.recaudacion_digitada;
      state.observaciones = liquidacion_de_viaje.observ;
    }

    if (empresa_chofer) {
      empresa_chofer.chofer = chofer;
      state.empresa_chofer = empresa_chofer;
      state.cedula = chofer.ci_numero;
    }

    state.empresa = empresa;

    this.state = state;
  }

  render() {
    const { tarifa } = this.props;
    const { empresa, empresa_chofer } = this.state;

    const chofer = empresa_chofer ? empresa_chofer.chofer : null;
    const razonSocial = empresa ? empresa.razon_social : '';
    const choferName = chofer ? `${chofer.nombres} ${chofer.apellidos}` : '';
    const comision = empresa_chofer ? empresa_chofer.porc_comision : '';

    return (
      <form className="">
        <div className="row">
          <div className="col-md-6">
            <div className="row">
              <div className="col-sm-6 form-group">
                <label>Matricula</label>
                <input type="text" name="matricula" value={this.state.matricula} onChange={this.handleChange} onKeyPress={this.onMatriculaKeyPress} onBlur={this.onMatriculaBlur} className="form-control" />
              </div>
              <div className="col-sm-6 form-group">
                <label>Fecha</label>
                <input type="date" name="fechaRegistro" value={this.state.fechaRegistro} className="form-control" onChange={this.handleChange} />
              </div>
            </div>
            <div className="row">
              <div className="col-sm-6 form-group">
                <label>Razon Social</label>
                <input type="text" value={razonSocial} disabled={true} className="form-control" />
              </div>
            </div>
          </div>
          <div className="col-md-6">
            <div className="form-group">
              <label>Cedula</label>
              <div className="row">
                <div className="col-xs-5">
                  <input type="text" name="cedula" value={this.state.cedula}  onChange={this.handleChange} onBlur={this.onCedulaBlur} className="form-control" />
                </div>
                <div className="col-xs-7">
                  <input type="text" value={choferName} disabled={true} className="form-control" />
                </div>
              </div>
            </div>
            <div className="row">
              <div className="col-xs-6">
                <div className="form-group">
                  <label>Turno</label>
                  <div className="form-group">
                    <label className="radio-inline">
                      <input type="radio" name="chTurnosId" onChange={this.handleChange} checked={this.state.chTurnosId == '1'} className="form-control" value="1"/> Diurno
                    </label>
                    <label className="radio-inline">
                      <input type="radio" name="chTurnosId" onChange={this.handleChange} checked={this.state.chTurnosId == '2'} className="form-control" value="2"/> Nocturno
                    </label>
                  </div>
                </div>
              </div>
              <div className="col-xs-6">
                <div className="form-group">
                  <label>Comision</label>
                  <input type="text" disabled={true} value={comision} className="form-control" />
                </div>
              </div>
            </div>
          </div>
        </div>
        <table className="table">
          <thead></thead>
          <tbody>
            <tr>
              <th colSpan="6">Kmts. / Banderas / Fichas</th>
              <th>Valor Kmt</th>
            </tr>
            <tr>
              <th></th>
              <th>Vehiculo</th>
              <th colSpan="2">Diurno</th>
              <th colSpan="2">Nocturno</th>
              <th></th>
            </tr>
            <tr>
              <th></th>
              <th>Kmts.</th>
              <th>Banderas</th>
              <th>Fichas</th>
              <th>Banderas</th>
              <th>Fichas</th>
              <th></th>
            </tr>
            <tr>
              <th>Salida</th>
              <td><input type="number" name="veKmSal" value={this.state.veKmSal} onChange={this.handleChange} className="form-control"/></td>
              <td><input type="number" name="baDiuSal" value={this.state.baDiuSal} onChange={this.handleChange} className="form-control"/></td>
              <td><input type="number" name="fiDiuSal" value={this.state.fiDiuSal} onChange={this.handleChange} className="form-control"/></td>
              <td><input type="number" name="baNocSal" value={this.state.baNocSal} onChange={this.handleChange} className="form-control"/></td>
              <td><input type="number" name="fiNocSal" value={this.state.fiNocSal} onChange={this.handleChange} className="form-control"/></td>
              <td></td>
            </tr>
            <tr>
              <th>Entrada</th>
              <td><input type="number" name="veKmEnt" value={this.state.veKmEnt} onChange={this.handleChange} className="form-control"/></td>
              <td><input type="number" name="baDiuEnt" value={this.state.baDiuEnt} onChange={this.handleChange} className="form-control"/></td>
              <td><input type="number" name="fiDiuEnt" value={this.state.fiDiuEnt} onChange={this.handleChange} className="form-control"/></td>
              <td><input type="number" name="baNocEnt" value={this.state.baNocEnt} onChange={this.handleChange} className="form-control"/></td>
              <td><input type="number" name="fiNocEnt" value={this.state.fiNocEnt} onChange={this.handleChange} className="form-control"/></td>
              <td><input type="text" value={this.getValorKmt()}className="form-control" disabled={true}/></td>
            </tr>
            <tr>
              <th>Total</th>
              <td><DifField entry={this.state.veKmEnt} exit={this.state.veKmSal}/></td>
              <td><DifField entry={this.state.baDiuEnt} exit={this.state.baDiuSal}/></td>
              <td><DifField entry={this.state.fiDiuEnt} exit={this.state.fiDiuSal}/></td>
              <td><DifField entry={this.state.baNocEnt} exit={this.state.baNocSal}/></td>
              <td><DifField entry={this.state.fiNocEnt} exit={this.state.fiNocSal}/></td>
              <td></td>
            </tr>
            <tr>
              <th colSpan="2">Descuento</th>
              <td><input type="number" name="baDiuDes" value={this.state.baDiuDes} onChange={this.handleChange} className="form-control"/></td>
              <td><input type="number" name="fiDiuDes" value={this.state.fiDiuDes} onChange={this.handleChange} className="form-control"/></td>
              <td><input type="number" name="baNocDes" value={this.state.baNocDes} onChange={this.handleChange} className="form-control"/></td>
              <td><input type="number" name="fiNocDes" value={this.state.fiNocDes} onChange={this.handleChange} className="form-control"/></td>
              <td></td>
            </tr>
          </tbody>
        </table>
        <div className="row form-horizontal">
          <div className="col-md-6">
            <h5>Gastos</h5>
            <div className="form-group">
              <label className="col-sm-3 control-label">Salario</label>
              <div className="col-sm-3">
                <input type="text" className="form-control" value={this.getSalario()} disabled={true}/>
              </div>
            </div>
            <div className="form-group">
              <label className="col-sm-3 control-label">Complemento</label>
              <div className="col-sm-3">
                <input type="number" name="gaComplemento" value={this.state.gaComplemento} onChange={this.handleChange} className="form-control"/>
              </div>
            </div>
            <div className="form-group">
              <label className="col-sm-3 control-label">Gas Oil</label>
              <div className="col-sm-3">
                <input type="number" name="gaGasoil" value={this.state.gaGasoil} onChange={this.handleChange} className="form-control"/>
              </div>
            </div>
            <div className="form-group">
              <label className="col-sm-3 control-label">Aceite</label>
              <div className="col-sm-3">
                <input type="number" name="gaAceite" value={this.state.gaAceite} onChange={this.handleChange} className="form-control"/>
              </div>
            </div>
            <div className="form-group">
              <label className="col-sm-3 control-label">Gomeria</label>
              <div className="col-sm-3">
                <input type="number" name="gaGomeria" value={this.state.gaGomeria} onChange={this.handleChange} className="form-control"/>
              </div>
            </div>
            <div className="form-group">
              <label className="col-sm-3 control-label">Lavado</label>
              <div className="col-sm-3">
                <input type="number" name="gaLavado" value={this.state.gaLavado} onChange={this.handleChange} className="form-control"/>
              </div>
            </div>
            <div className="form-group">
              <label className="col-sm-3 control-label">Otros (1)</label>
              <div className="col-sm-3">
                <input type="number" name="gaOtros1Valor" value={this.state.gaOtros1Valor} onChange={this.handleChange} className="form-control"/>
              </div>
              <div className="col-sm-6">
                <input type="text" name="gaOtros1Detalle" value={this.state.gaOtros1Detalle} onChange={this.handleChange} className="form-control"/>
              </div>
            </div>
            <div className="form-group">
              <label className="col-sm-3 control-label">Otros (2)</label>
              <div className="col-sm-3">
                <input type="number" name="gaOtros2Valor" value={this.state.gaOtros2Valor} onChange={this.handleChange} className="form-control"/>
              </div>
              <div className="col-sm-6">
                <input type="text" name="gaOtros2Detalle" value={this.state.gaOtros2Detalle} onChange={this.handleChange} className="form-control"/>
              </div>
            </div>
          </div>
          <div className="col-md-3">
            <h5>Recaudacion</h5>
            <div>
              <label>Diurno</label>
              <div className="form-group">
                <label className="col-sm-4 control-label">Banderas</label>
                <div className="col-sm-8">
                  <input type="text" value={this.getRecBaDiu()} className="form-control" disabled={true} />
                </div>
              </div>
              <div className="form-group">
                <label className="col-sm-4 control-label">Ficha</label>
                <div className="col-sm-8">
                  <input type="text" value={this.getRecFiDiu()} className="form-control" disabled={true} />
                </div>
              </div>
            </div>
            <div>
              <label>Nocturno</label>
              <div className="form-group">
                <label className="col-sm-4 control-label">Banderas</label>
                <div className="col-sm-8">
                  <input type="text" value={this.getRecBaNoc()} className="form-control" disabled={true} />
                </div>
              </div>
              <div className="form-group">
                <label className="col-sm-4 control-label">Ficha</label>
                <div className="col-sm-8">
                  <input type="text" value={this.getRecFiNoc()} className="form-control" disabled={true} />
                </div>
              </div>
            </div>
            <div>
              <div className="form-group">
                <label className="col-sm-4 control-label">Otros (+)</label>
                <div className="col-sm-8">
                  <input type="text" name="reOtrosMas" value={this.state.reOtrosMas} onChange={this.handleChange} className="form-control"/>
                </div>
              </div>
              <div className="form-group">
                <label className="col-sm-4 control-label">Otros (-)</label>
                <div className="col-sm-8">
                  <input type="text" name="reOtrosMenos" value={this.state.reOtrosMenos} onChange={this.handleChange} className="form-control"/>
                </div>
              </div>
            </div>
          </div>
          <div className="col-md-3">
            <h5>Totales</h5>
            <div className="form-group">
              <label className="col-sm-4 control-label">Recaudado</label>
              <div className="col-sm-8">
                <input type="text" value={this.getRecaudado()} className="form-control" disabled={true}/>
              </div>
            </div>
            <div className="form-group">
              <label className="col-sm-4 control-label">Gastos</label>
              <div className="col-sm-8">
                <input type="text" value={this.getGastos()} className="form-control" disabled={true}/>
              </div>
            </div>
            <div className="form-group">
              <label className="col-sm-4 control-label">Liquido</label>
              <div className="col-sm-8">
                <input type="text" value={this.getLiquido()} className="form-control" disabled={true}/>
              </div>
            </div>
            <div className="form-group">
              <label className="col-sm-4 control-label">Aportes</label>
              <div className="col-sm-8">
                <input type="text" name="aportes" value={this.state.aportes} onChange={this.handleChange} className="form-control"/>
              </div>
            </div>
            <div className="form-group">
              <label className="col-sm-4 control-label">Subtotal</label>
              <div className="col-sm-8">
                <input type="text" value={this.getSubtotal()} className="form-control" disabled={true}/>
              </div>
            </div>
            <div className="form-group">
              <label className="col-sm-4 control-label">Varios</label>
              <div className="col-sm-8">
                <input type="text" name="varios" value={this.state.varios} onChange={this.handleChange} className="form-control" />
              </div>
            </div>
            <div className="form-group">
              <label className="col-sm-4 control-label">Total</label>
              <div className="col-sm-8">
                <input type="text" value={this.getTotal()} className="form-control" disabled={true}/>
              </div>
            </div>
            <div className="form-group">
              <label className="col-sm-4 control-label">Rec. Boleta</label>
              <div className="col-sm-8">
                <input type="text" name="recaudacionDigitada" value={this.state.recaudacionDigitada} onChange={this.handleChange} className="form-control"/>
              </div>
            </div>
          </div>
        </div>
        <div className="row">
          <div className="col-md-12">
            <div className="form-group">
              <label className="control-label">Observaciones</label>
              <input type="text" name="observaciones" value={this.state.observaciones} onChange={this.handleChange} className="form-control"/>
            </div>
          </div>
        </div>
        <div className="row">
          <div className="col-md-12">
            <button className="btn btn-primary pull-right" type="button" onClick={() => this.save()}>Confirmar</button>
          </div>
        </div>
      </form>
    );
  }
}
