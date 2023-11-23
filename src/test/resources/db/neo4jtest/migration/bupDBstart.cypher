/* ======================================================================== */
/* This script is to initialize the BUP Neo4j database for testing purpose  */
/* All data from the start.cypher is added plus some developer data needed  */
/* for testing purposes:                                                    */
/*                                                                          */
/* Date: November 2023                                                      */
/* ======================================================================== */

MERGE (sect1:Sector {nombre:'Industrial', usuarioModificacion:'TEST', fechaModificacion:localdatetime()})
MERGE (sect2:Sector {nombre:'Financiero', usuarioModificacion:'TEST', fechaModificacion:localdatetime()})
MERGE (sect3:Sector {nombre:'Textil', usuarioModificacion:'TEST', fechaModificacion:localdatetime()})
MERGE (sect4:Sector {nombre:'Telecomunicaciones', usuarioModificacion:'TEST', fechaModificacion:localdatetime()})
MERGE (sect5:Sector {nombre:'Gobierno', usuarioModificacion:'TEST', fechaModificacion:localdatetime()})
MERGE (sect6:Sector {nombre:'Educación', usuarioModificacion:'TEST', fechaModificacion:localdatetime()})
MERGE (sect7:Sector {nombre:'Tecnologia', usuarioModificacion:'TEST', fechaModificacion:localdatetime()})
MERGE (sect8:Sector {nombre:'Sin lucro', usuarioModificacion:'TEST', fechaModificacion:localdatetime()})
MERGE (sect9:Sector {nombre:'Comercial', usuarioModificacion:'TEST', fechaModificacion:localdatetime()})
MERGE (sect10:Sector {nombre:'Bienes raices', usuarioModificacion:'TEST', fechaModificacion:localdatetime()})

MERGE (area1:Area {nombre:'Direccion'})
MERGE (area2:Area {nombre:'Contabilidad'})
MERGE (area3:Area {nombre:'Sistemas'})
MERGE (area4:Area {nombre:'Manufactura'})
MERGE (area5:Area {nombre:'Call center'})
MERGE (area6:Area {nombre:'Inventario'})


/* =====     P E R S O N S          ===== */
MERGE (pers1:Persona {nombre:'Juan', apellidoPaterno:'Perez', apellidoMaterno:'Hernández',fechaNacimiento:date(), genero:'MASCULINO', estadoCivil: 'CASADO', usuarioModificacion:'TEST', fechaModificacion:localdatetime(), activo:true, idPersona:1000})
MERGE (pers2:Persona {nombre:'Alejandro', apellidoPaterno:'Rodriguez', apellidoMaterno:'Sains', fechaNacimiento:date(), genero:'MASCULINO', estadoCivil: 'SOLTERO', usuarioModificacion:'TEST', fechaModificacion:localdatetime(), activo:false, idPersona:1001})

/* =====     P E R S O N S   W I T H  A R E A S     ===== */
/* note: can be wrong this script since we estimated the idCompania */
MATCH (pers1:Persona),(area1:Area) WHERE pers1.nombre = 'Juan' AND area1.nombre = 'Direccion' MERGE (pers1)-[:DIRIGE {idCompania:2, nombreCompania:'ACME Bodega SA de CV'}]-(area1)
MATCH (pers2:Persona),(area2:Area) WHERE pers2.nombre = 'Alejandro' AND area2.nombre = 'Contabilidad' MERGE (pers2)-[:DIRIGE {idCompania:2, nombreCompania:'ACME Bodega SA de CV'}]-(area2)

/* =====     P E R S O N S   W I T H  P E R S O N S     ===== */
MATCH (pers1:Persona),(pers2:Persona) WHERE pers1.nombre = 'Juan' AND pers2.nombre = 'Alejandro' MERGE (pers1)-[:RELACION{tipo:'Parentesco', nombre:'primo'}]-(pers2)

/* =====     R F C   ===== */
MERGE (rfc1:Rfc {rfc:'PROVW6011267X2', curp:'PROVW6011267X2UV', usuarioModificacion:'TEST', fechaModificacion:localdatetime()})
MERGE (rfc2:Rfc {rfc:'ABOGX6011267X2', curp:'ABOGX6011267X2UV', usuarioModificacion:'TEST', fechaModificacion:localdatetime()})
MERGE (rfc3:Rfc {rfc:'IXEGG8011267X2', curp:'IXEGG8011267X2UV', usuarioModificacion:'TEST', fechaModificacion:localdatetime()})
MERGE (rfc4:Rfc {rfc:'INTER6011267X2', curp:'INTER6011267X2UV', usuarioModificacion:'TEST', fechaModificacion:localdatetime()})
MERGE (rfc5:Rfc {rfc:'ACME651130UVX', curp:'ACME651130UVXUV', usuarioModificacion:'TEST', fechaModificacion:localdatetime()})

/* =====    P E R S O N S   W I T H   R F C   ===== */
MATCH (pers1:Persona),(rfc8:Rfc) WHERE pers1.nombre = 'Juan' AND rfc8.rfc = 'PROVW6011267X2' MERGE (pers1)-[:RFC]-(rfc8)
MATCH (pers2:Persona),(rfc9:Rfc) WHERE pers2.nombre = 'Alejandro' AND rfc9.rfc = 'MIAS6211267X2' MERGE (pers2)-[:RFC]-(rfc9)

/* =====     T E L E P H O N E  N U M B E R S   ===== */
MERGE (tel1:Telefono {numero:'5555966575', ciudad:'CDMX', tipo:'OFICINA'})
MERGE (tel2:Telefono {numero:'5555962188', ciudad:'CDMX', tipo:'OFICINA'})
MERGE (tel3:Telefono {numero:'5555703476', ciudad:'CDMX', tipo:'OFICINA'})
MERGE (tel4:Telefono {numero:'5555681423', ciudad:'CDMX', tipo:'OFICINA'})
MERGE (tel5:Telefono {numero:'5554195422', ciudad:'CDMX', tipo:'CELULAR'})
MERGE (tel6:Telefono {numero:'5591495040', ciudad:'CDMX', tipo:'OFICINA'})

/* =====     P E R S O N S  W I T H  T E L E P H O N E S   ===== */
MATCH (pers1:Persona),(tel1:Telefono) WHERE pers1.nombre = 'Juan' AND tel1.numero = '5555966575'  MERGE (pers1)-[:TELEFONO]-(tel1)
MATCH (pers1:Persona),(tel6:Telefono) WHERE pers1.nombre = 'Juan' AND tel6.numero = '5591495040'  MERGE (pers1)-[:TELEFONO]-(tel6)
MATCH (pers2:Persona),(tel10:Telefono) WHERE pers2.nombre = 'Alejandro' AND tel10.numero = '6262256418'  MERGE (pers2)-[:TELEFONO]-(tel10)

/* =====     E M A I L S   ===== */
MERGE (email1:Email {uri:'acme.com.mx'})

/* =====     P E R S O N S  W I T H  E M A I L S   ===== */
MATCH (pers1:Persona),(email1:Email) WHERE pers1.nombre = 'Juan' AND email1.uri = 'acme.com.mx'  MERGE (pers1)-[:EMAIL{email:'staff@acme.com.mx'}]-(email1)
MATCH (pers2:Persona),(email1:Email) WHERE pers2.nombre = 'Alejandro' AND email1.uri = 'acme.com.mx'  MERGE (pers2)-[:EMAIL{email:'perex@acme.com.mx'}]-(email1)

/* =====     A D D R E S S E S   ===== */
MERGE (adr1:Direccion {calle:'Prado Sur 240. Depto 203', delegacion:'Miguel Hidalgo', ciudad:'CDMX', tipo:'OFICIAL'})
MERGE (adr2:Direccion {calle:'Fuego 240', delegacion:'Coyoacan', ciudad:'CDMX', tipo:'FACTURAR'})
MERGE (adr3:Direccion {calle:'Puebla 1320', delegacion:'Benito Juarez', ciudad:'CDMX', tipo:'OFICIAL'})
MERGE (adr4:Direccion {calle:'Reforma 45', delegacion:'Benito Juarez', ciudad:'CDMX', tipo:'OFICIAL'})

/* =====     Z I P  C O D E S   ===== */
MERGE (zip1:Codigo {cp:11000})
MERGE (zip2:Codigo {cp:11100})
MERGE (zip3:Codigo {cp:12000})
MERGE (zip4:Codigo {cp:12010})

/* =====     N E I G H B O R    ===== */
MERGE (mun1:Municipio {nombre:'Lomas de Chapultec'})
MERGE (mun2:Municipio {nombre:'Roma'})
MERGE (mun3:Municipio {nombre:'Real de las Lomas'})
MERGE (mun4:Municipio {nombre:'Bosques'})

/* =====     Z I P  C O D E S  W I T H  N E I G H B O R  ===== */
MATCH (mun1:Municipio),(zip1:Codigo) WHERE mun1.nombre = 'Lomas de Chapultec' AND zip1.cp = 11000  MERGE (mun1)-[:PERTENECE]-(zip1)
MATCH (mun2:Municipio),(zip2:Codigo) WHERE mun2.nombre = 'Lomas de Chapultec' AND zip2.cp = 11100  MERGE (mun2)-[:PERTENECE]-(zip2)
MATCH (mun3:Municipio),(zip3:Codigo) WHERE mun3.nombre = 'Real de las Lomas' AND zip3.cp = 12000  MERGE (mun3)-[:PERTENECE]-(zip3)
MATCH (mun4:Municipio),(zip4:Codigo) WHERE mun4.nombre = 'Bosques' AND zip4.cp = 12010  MERGE (mun4)-[:PERTENECE]-(zip4)

/* =====   C O U N T R I E S  ===== */
MERGE (pais1:Pais {nombre:'México'})
MERGE (pais2:Pais {nombre:'EUA'})

/* =====   S T A T E S  ===== */
MERGE (edo1:Estado {nombre:'Estado de Mexico', pais:'México'})
MERGE (edo2:Estado {nombre:'CDMX', pais:'México'})
MERGE (edo3:Estado {nombre:'Morelos', pais:'México'})
MERGE (edo4:Estado {nombre:'Guerrero', pais:'México'})
MERGE (edo5:Estado {nombre:'Nuevo Leon', pais:'México'})
MERGE (edo6:Estado {nombre:'Texas', pais:'USA'})

/* =====     Z I P  C O D E S  W I T H  S T A T E S  ===== */
MATCH (zip1:Codigo),(edo1:Estado) WHERE zip1.cp = 11000 AND edo1.nombre = 'Estado de Mexico' MERGE (zip1)-[:PERTENECE]-(edo1)
MATCH (zip2:Codigo),(edo1:Estado) WHERE zip2.cp = 11100 AND edo1.nombre = 'Estado de Mexico' MERGE (zip2)-[:PERTENECE]-(edo1)
MATCH (zip3:Codigo),(edo2:Estado) WHERE zip3.cp = 12000 AND edo2.nombre = 'CDMX' MERGE (zip3)-[:PERTENECE]-(edo2)
MATCH (zip4:Codigo),(edo2:Estado) WHERE zip4.cp = 12010 AND edo2.nombre = 'CDMX' MERGE (zip4)-[:PERTENECE]-(edo2)

/* =====     A D D R E S S  W I T H  Z I P  C O D E S  ===== */
MATCH (adr1:Direccion),(zip1:Codigo) WHERE adr1.calle = 'Prado Sur 240. Depto 203' AND zip1.cp = 11000 MERGE (adr1)-[:CODIGO]-(zip1)
MATCH (adr2:Direccion),(zip2:Codigo) WHERE adr2.calle = 'Fuego 240' AND zip2.cp = 11100 MERGE (adr2)-[:CODIGO]-(zip2)
MATCH (adr3:Direccion),(zip3:Codigo) WHERE adr3.calle = 'Puebla 1320' AND zip3.cp = 12000 MERGE (adr3)-[:CODIGO]-(zip3)
MATCH (adr4:Direccion),(zip4:Codigo) WHERE adr4.calle = 'Reforma 45' AND zip4.cp = 12010 MERGE (adr4)-[:CODIGO]-(zip4)

/* =====     A D D R E S S  W I T H  M U N I C I P I O S  ===== */
MATCH (adr1:Direccion),(mun1:Municipio) WHERE adr1.calle = 'Prado Sur 240. Depto 203' AND mun1.nombre = 'Lomas de Chapultec' MERGE (adr1)-[:SE_ENCUENTRA]-(mun1)
MATCH (adr2:Direccion),(mun2:Municipio) WHERE adr2.calle = 'Fuego 240' AND mun2.nombre= 'Roma' MERGE (adr2)-[:SE_ENCUENTRA]-(mun2)
MATCH (adr3:Direccion),(mun3:Municipio) WHERE adr3.calle = 'Puebla 1320' AND mun3.nombre = 'Real de las Lomas' MERGE (adr3)-[:SE_ENCUENTRA]-(mun3)
MATCH (adr4:Direccion),(mun4:Municipio) WHERE adr4.calle = 'Reforma 45' AND mun4.nombre = 'Bosques' MERGE (adr4)-[:SE_ENCUENTRA]-(mun4)

/* =====     P E R S O N S  W I T H  A D D R E S S   ===== */
MATCH (pers1:Persona),(adr1:Direccion) WHERE pers1.nombre = 'Juan' AND adr1.calle = 'Prado Sur 240. Depto 203' MERGE (pers7)-[:DIRECCION]-(adr1)
MATCH (pers1:Persona),(adr2:Direccion) WHERE pers1.nombre = 'Juan' AND adr2.calle = 'Fuego 240' MERGE (pers1)-[:DIRECCION]-(adr2)
MATCH (pers2:Persona),(adr3:Direccion) WHERE pers2.nombre = 'Alejandro' AND adr3.calle = 'Puebla 1320' MERGE (pers2)-[:DIRECCION]-(adr3)

/* =====     A C C O U N T S   ===== */
MERGE (act1:Cuenta {clabe:'0123456789012345678', banco:'BBVA', moneda:'MXN', saldo:130000})
MERGE (act2:Cuenta {clabe:'0134545584500000676', banco:'BBVA', moneda:'MXN', saldo:230000})

/* =====    P E R S O N S  W I T H   A C C O U N T S   ===== */
MATCH (pers1:Persona),(act1:Cuenta) WHERE pers1.nombre = 'Juan' AND act1.clabe = '0123456789012345678' MERGE (pers1)-[:CUENTA]-(act1)
MATCH (pers2:Persona),(act2:Cuenta) WHERE pers2.nombre = 'Alejandro' AND act2.clabe = '0134545584500000676' MERGE (pers2)-[:CUENTA]-(act2)

/* ======================================================================== */
/* Second PASS                                                              */
/* note: Companies are redundant to IAMDb and by the Kafka event messages   */
/*       these are synchronized by the 'iam-service' micro service. So we   */
/*       use the same script for companies inside the iamDB but just the    */
/*       relevant data that is needed for GraphQL.                          */
/* ======================================================================== */

/* =====     S U P P L I E R S    ===== */
MATCH(prov1:Compania {nombre:'AMAZON SA DE CV'}), (acme:Compania {nombre:'ACME SA de CV'}) MERGE (prov1)-[r:PROVEEDOR{tipo:'entrega'}]-(acme) RETURN r;
MATCH(prov1:Compania {nombre:'AMAZON SA DE CV'}), (acmet:Compania {nombre:'ACME Tienda SA de CV'}) MERGE (prov1)-[r:PROVEEDOR{tipo:'entrega'}]-(acmet) RETURN r;
MATCH(prov1:Compania {nombre:'AMAZON SA DE CV'}), (acmet:Compania {nombre:'ACME Bodega SA de CV'}) MERGE (prov1)-[r:PROVEEDOR{tipo:'entrega'}]-(acmet) RETURN r;
MATCH(prov2:Compania {nombre:'ABOGADOS SC'}), (acmeb:Compania {nombre:'ACME Bodega SA de CV'}) MERGE (prov2)-[r:PROVEEDOR{tipo:'asesor'}]-(acmeb) RETURN r;
MATCH (prov2:Compania {nombre:'ABOGADOS SC'}), (ixe:Compania {nombre:'IXE BANCO'}) MERGE (prov2)-[r:PROVEEDOR{tipo:'asesor'}]-(ixe) RETURN r;
MATCH (prov2:Compania {nombre:'ABOGADOS SC'}), (intercam:Compania {nombre:'INTERCAM BANCO'}) MERGE (prov2)-[r:PROVEEDOR{tipo:'asesor'}]-(intercam) RETURN r;

/* =====     C O M P A N I E S  B E L O N G  T O  S E C T O R S          ===== */
MATCH(acme:Compania {nombre:'ACME SA de CV'}), (sect1:Sector {nombre:'Industrial'}) MERGE (acme)-[r:PERTENECE{clasificacion:'SAT'}]-(sect1) RETURN r;
MATCH(acmeB:Compania {nombre:'ACME Bodega SA de CV'}), (sect1:Sector {nombre:'Industrial'}) MERGE (acmeB)-[r:PERTENECE{clasificacion:'SAT'}]-(sect1) RETURN r;
MATCH(acmeT:Compania {nombre:'ACME Tienda SA de CV'}), (sect1:Sector {nombre:'Industrial'}) MERGE (acmeT)-[r:PERTENECE{clasificacion:'SAT'}]-(sect1) RETURN r;
MATCH(prov1:Compania {nombre:'AMAZON SA DE CV'}), (sect9:Sector {nombre:'Comercial'}) MERGE (prov1)-[r:PERTENECE{clasificacion:'SAT'}]-(sect9) RETURN r;
MATCH(prov2:Compania {nombre:'ABOGADOS SC'}), (sect9:Sector {nombre:'Comercial'}) MERGE (prov2)-[r:PERTENECE{clasificacion:'SAT'}]-(sect9) RETURN r;
MATCH (ixe:Compania {nombre:'IXE BANCO'}), (sect2:Sector {nombre:'Financiero'}) MERGE (ixe)-[r:PERTENECE{clasificacion:'SAT'}]-(sect2) RETURN r;
MATCH (intercam:Compania {nombre:'INTERCAM BANCO'}), (sect2:Sector {nombre:'Financiero'}) MERGE (intercam)-[r:PERTENECE{clasificacion:'SAT'}]-(sect2) RETURN r;
MATCH(acme:Compania {nombre:'ACME SA de CV'}), (sect9:Sector {nombre:'Comercial'}) MERGE (acme)-[r:PERTENECE{clasificacion:'CNVB'}]-(sect9) RETURN r;
MATCH(acmeB:Compania {nombre:'ACME Bodega SA de CV'}), (sect9:Sector {nombre:'Comercial'}) MERGE (acmeB)-[r:PERTENECE{clasificacion:'CNVB'}]-(sect9) RETURN r;
MATCH(acmeT:Compania {nombre:'ACME Tienda SA de CV'}), (sect9:Sector {nombre:'Comercial'}) MERGE (acmeT)-[r:PERTENECE{clasificacion:'CNVB'}]-(sect9) RETURN r;
MATCH (prov1:Compania {nombre:'AMAZON SA DE CV'}), (sect5:Sector {nombre:'Gobierno'}) MERGE (prov1)-[r:PERTENECE{clasificacion:'CNVB'}]-(sect5) RETURN r;
MATCH(prov2:Compania {nombre:'ABOGADOS SC'}), (sect4:Sector {nombre:'Telecomunicaciones'}) MERGE (prov2)-[r:PERTENECE{clasificacion:'CNVB'}]-(sect4) RETURN r;
MATCH (ixe:Compania {nombre:'IXE BANCO'}), (sect2:Sector {nombre:'Financiero'}) MERGE (ixe)-[r:PERTENECE{clasificacion:'CNVB'}]-(sect2) RETURN r;
MATCH (intercam:Compania {nombre:'INTERCAM BANCO'}), (sect2:Sector {nombre:'Financiero'}) MERGE (intercam)-[r:PERTENECE{clasificacion:'CNVB'}]-(sect2) RETURN r;

/* =====     C O M P A N I E S  W I T H  A R E A S         ===== */
MATCH(acme:Compania {nombre:'ACME SA de CV'}), (area1:Area {nombre:'Direccion'}) MERGE (acme)-[r:CONTIENE]-(area1) RETURN r;
MATCH(acme:Compania {nombre:'ACME SA de CV'}), (area2:Area {nombre:'Contabilidad'}) MERGE (acme)-[r:CONTIENE]-(area2) RETURN r;
MATCH(acmeT:Compania {nombre:'ACME Tienda SA de CV'}), (area2:Area {nombre:'Contabilidad'}) MERGE (acmet)-[r:CONTIENE]-(area2) RETURN r;
MATCH (acmeT:Compania {nombre:'ACME Tienda SA de CV'}), (area3:Area {nombre:'Sistemas'}) MERGE (acmet)-[r:CONTIENE]-(area3) RETURN r;
MATCH (acmeB:Compania {nombre:'ACME Bodega SA de CV'}), (area6:Area {nombre:'Inventario'}) MERGE (acmeb)-[r:CONTIENE]-(area6) RETURN r;
MATCH (ixe:Compania {nombre:'IXE BANCO'}), (area1:Area {nombre:'Direccion'}) MERGE (ixe)-[r:CONTIENE]-(area1) RETURN r;
MATCH (ixe:Compania {nombre:'IXE BANCO'}), (area2:Area {nombre:'Contabilidad'}) MERGE (ixe)-[r:CONTIENE]-(area2) RETURN r;
MATCH (ixe:Compania {nombre:'IXE BANCO'}), (area3:Area {nombre:'Sistemas'}) MERGE (ixe)-[r:CONTIENE]-(area3) RETURN r;
MATCH (ixe:Compania {nombre:'IXE BANCO'}), (area5:Area {nombre:'Call center'}) MERGE (ixe)-[r:CONTIENE]-(area5) RETURN r;
MATCH (intercam:Compania {nombre:'INTERCAM BANCO'}), (area1:Area {nombre:'Direccion'}) MERGE (intercam)-[r:CONTIENE]-(area1) RETURN r;
MATCH (intercam:Compania {nombre:'INTERCAM BANCO'}), (area2:Area {nombre:'Contabilidad'}) MERGE (intercam)-[r:CONTIENE]-(area2) RETURN r;
MATCH (intercam:Compania {nombre:'INTERCAM BANCO'}), (area3:Area {nombre:'Sistemas'}) MERGE (intercam)-[r:CONTIENE]-(area3) RETURN r;
MATCH (intercam:Compania {nombre:'INTERCAM BANCO'}), (area5:Area {nombre:'Call center'}) MERGE (intercam)-[r:CONTIENE]-(area5) RETURN r;

/* =====     P E R S O N S   W I T H  C O M P A N I E S      ===== */
MATCH (pers1:Persona {nombre:'Juan'}), (acme:Compania {nombre:'ACME SA de CV'}) MERGE (pers1)-[r:TRABAJA{puesto:'contador'}]-(acme) RETURN r;
MATCH (pers2:Persona {nombre:'Alejandro'}), (acme:Compania {nombre:'ACME SA de CV'}) MERGE (pers2)-[r:TRABAJA{puesto:'supervisor'}]-(acme) RETURN r;

/* =====    C O M P A N I E S  W I T H   R F C   ===== */
MATCH (acme:Compania {nombre:'ACME SA de CV'}), (rfc5:Rfc {rfc:'ACME651130UVX'}) MERGE (acme)-[r:RFC]-(rfc5) RETURN r;
MATCH (acmeB:Compania {nombre:'ACME Bodega SA de CV'}), (rfc6:Rfc {rfc:'ACME701130UVX'}) MERGE (acmeb)-[r:RFC]-(rfc6) RETURN r;
MATCH (acmeT:Compania {nombre:'ACME Tienda SA de CV'}), (rfc5:Rfc {rfc:'ACME651130UVXUV'}) MERGE (acmet)-[r:RFC]-(rfc5) RETURN r;
MATCH (prov1:Compania {nombre:'AMAZON SA DE CV'}), (rfc1:Rfc {rfc:'PROVW6011267X2'}) MERGE (prov1)-[r:RFC]-(rfc1) RETURN r;
MATCH (prov2:Compania {nombre:'ABOGADOS SC'}), (rfc2:Rfc {rfc:'ABOGX6011267X2'}) MERGE (prov2)-[r:RFC]-(rfc2) RETURN r;
MATCH (ixe:Compania {nombre:'IXE BANCO'}), (rfc3:Rfc {rfc:'IXEGG8011267X2'}) MERGE (ixe)-[r:RFC]-(rfc3) RETURN r;
MATCH (intercam:Compania {nombre:'INTERCAM BANCO'}), (rfc4:Rfc {rfc:'INTER6011267X2'}) MERGE (intercam)-[r:RFC]-(rfc4) RETURN r;

/* =====     C O M P A N I E S  W I T H  T E L E P H O N E S   ===== */
MATCH (acme:Compania {nombre:'ACME SA de CV'}), (tel1:Telefono {numero:'5555966575'}) MERGE (acme)-[r:TELEFONO]-(tel1) RETURN r;
MATCH (acme:Compania {nombre:'ACME SA de CV'}), (tel2:Telefono {numero:'5555962188'}) MERGE (acme)-[r:TELEFONO]-(tel2) RETURN r;
MATCH (acmeT:Compania {nombre:'ACME Tienda SA de CV'}), (tel3:Telefono {numero:'5555703476'}) MERGE (acmet)-[r:TELEFONO]-(tel3) RETURN r;
MATCH (acmeB:Compania {nombre:'ACME Bodega SA de CV'}), (tel1:Telefono {numero:'5555966575'}) MERGE (acmeb)-[r:TELEFONO]-(tel1) RETURN r;
MATCH (prov1:Compania {nombre:'AMAZON SA DE CV'}), (tel4:Telefono {numero:'5555681423'}) MERGE (prov1)-[r:TELEFONO]-(tel4) RETURN r;
MATCH (prov2:Compania {nombre:'ABOGADOS SC'}), (tel5:Telefono {numero:'5554195422'}) MERGE (prov2)-[r:TELEFONO]-(tel5) RETURN r;
MATCH (ixe:Compania {nombre:'IXE BANCO'}), (tel6:Telefono {numero:'5591495040'}) MERGE (ixe)-[r:TELEFONO]-(tel6) RETURN r;
MATCH (intercam:Compania {nombre:'INTERCAM BANCO'}), (tel5:Telefono {numero:'5554195422'}) MERGE (intercam)-[r:TELEFONO]-(tel5) RETURN r;
MATCH (intercam:Compania {nombre:'INTERCAM BANCO'}), (tel5:Telefono {numero:'5554195422'}) MERGE (intercam)-[r:TELEFONO]-(tel5) RETURN r;

/* =====     C O M P A N I E S  W I T H  A D D R E S S   ===== */
MATCH (acme:Compania {nombre:'ACME SA de CV'}), (adr16:Direccion {calle:'Prado Sur 240. Depto 203'}) MERGE (acme)-[r:DIRECCION]-(adr16) RETURN r;
MATCH (acme:Compania {nombre:'ACME SA de CV'}), (adr17:Direccion {calle:'Prado Sur 240. Depto 203'}) MERGE (acme)-[r:DIRECCION]-(adr17) RETURN r;
MATCH (acmet:Compania {nombre:'ACME Tienda SA de CV'}), (adr18:Direccion {calle:'Prado Sur 240. Depto 203'}) MERGE (acmet)-[r:DIRECCION]-(adr18) RETURN r;
MATCH (acmeB:Compania {nombre:'ACME Bodega SA de CV'}), (adr19:Direccion {calle:'Prado Sur 240. Depto 203'}) MERGE (acmeb)-[r:DIRECCION]-(adr119) RETURN r;
MATCH (prov1:Compania {nombre:'AMAZON SA DE CV'}), (adr20:Direccion {calle:'Fuego 240'}) MERGE (prov1)-[r:DIRECCION]-(adr20) RETURN r;
MATCH (prov2:Compania {nombre:'ABOGADOS SC'}), (adr21:Direccion {calle:'Fuego 240'}) MERGE (prov2)-[r:DIRECCION]-(adr21) RETURN r;
MATCH (ixe:Compania {nombre:'IXE BANCO'}), (adr22:Direccion {calle:'Fuego 240'}) MERGE (ixe)-[r:DIRECCION]-(adr22) RETURN r;
MATCH (intercam:Compania {nombre:'INTERCAM BANCO'}), (adr23:Direccion {calle:'Fuego 240'}) MERGE (intercam)-[r:DIRECCION]-(adr23) RETURN r;


/* =====    C O M P A N I E S  W I T H   A C C O U N T S   ===== */
MATCH (acme:Compania {nombre:'ACME SA de CV'}), (act2:Cuenta {clabe:'0134545584500000676'}) MERGE (acme)-[r:CUENTA]-(act2) RETURN r;
MATCH (acmet:Compania {nombre:'ACME Tienda SA de CV'}), (act2:Cuenta {clabe:'0134545584500000676'}) MERGE (acmet)-[r:CUENTA]-(act2) RETURN r;
MATCH (acmeB:Compania {nombre:'ACME Bodega SA de CV'}), (act2:Cuenta {clabe:'0134545584500000676'}) MERGE (acmeb)-[r:CUENTA]-(act2) RETURN r;
MATCH (ixe:Compania {nombre:'IXE BANCO'}), (act2:Cuenta {clabe:'0134545584500000676'}) MERGE (ixe)-[r:CUENTA]-(act2) RETURN r;
MATCH (intercam:Compania {nombre:'INTERCAM BANCO'}), (act2:Cuenta {clabe:'0134545584500000676'}) MERGE (intercam)-[r:CUENTA]-(act2) RETURN r;
/* End */