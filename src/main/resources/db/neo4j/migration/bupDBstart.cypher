/* ======================================================================== */
/* This script is to initialize the BUP Neo4j database for testing purpose  */
/* All data from the start.cypher is added plus some developer data needed  */
/* for testing purposes:                                                    */
/*                                                                          */
/* Date: February 2024                                                      */
/* ======================================================================== */

MATCH (s: Sector) DETACH DELETE s;
MATCH (a: Area) DETACH DELETE a;
MATCH (p: Persona) DETACH DELETE p;
MATCH (r: Rfc) DETACH DELETE r;
MATCH (t: Telefono) DETACH DELETE t;
MATCH (e: Email) DETACH DELETE e;
MATCH (d: Direccion) DETACH DELETE d;
MATCH (co: Codigo) DETACH DELETE co;
MATCH (pa: Pais) DETACH DELETE pa;
MATCH (es: Estado) DETACH DELETE es;
MATCH (m: Municipio) DETACH DELETE m;
MATCH (cu: Cuenta) DETACH DELETE cu;


/* ======================================================================== */
/* First PASS                                                               */
/* ======================================================================== */

/* =====     S E C T O R S          ===== */
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


/* =====     A R E A S          ===== */
MERGE (area1:Area {nombre:'Direccion'})
MERGE (area2:Area {nombre:'Contabilidad'})
MERGE (area3:Area {nombre:'Sistemas'})
MERGE (area4:Area {nombre:'Manufactura'})
MERGE (area5:Area {nombre:'Call center'})
MERGE (area6:Area {nombre:'Inventario'})


/* =====     P E R S O N S          ===== */
MERGE (pers1:Persona {nombre:'Juan', apellidoPaterno:'Perez', apellidoMaterno:'Alvarez',fechaNacimiento:date(), genero:'MASCULINO', estadoCivil: 'CASADO', curp:'PEAJ8011127X3UUV', usuarioModificacion:'TEST', fechaModificacion:localdatetime(), activo:true, idPersona:500})
MERGE (pers2:Persona {nombre:'Alejandro', apellidoPaterno:'Rodriguez', apellidoMaterno:'Sains', fechaNacimiento:date(), genero:'MASCULINO', estadoCivil: 'SOLTERO', curp:'ROSA8103038X1UUV', usuarioModificacion:'TEST', fechaModificacion:localdatetime(), activo:false, idPersona:501})
MERGE (pers3:Persona {nombre:'Patricio', apellidoPaterno:'Garcia', apellidoMaterno:'Cano', fechaNacimiento:date(), genero:'MASCULINO', estadoCivil: 'CASADO', curp:'GACP8206067X6UUV', usuarioModificacion:'TEST', fechaModificacion:localdatetime(), activo:true, idPersona:502})
MERGE (pers4:Persona {nombre:'Marisa', apellidoPaterno:'Gomez', apellidoMaterno:'Lopez', fechaNacimiento:date(), genero:'FEMENINO', estadoCivil: 'CASADO',  curp:'GOLM9003039X1UUV', usuarioModificacion:'TEST', fechaModificacion:localdatetime(), activo:true, idPersona:503})
MERGE (pers5:Persona {nombre:'Roberto', apellidoPaterno:'Sanchez', apellidoMaterno:'Cortina', fechaNacimiento:date(), genero:'MASCULINO', estadoCivil: 'SOLTERO', curp:'SACR6404098X7UUV',usuarioModificacion:'TEST', fechaModificacion:localdatetime(), activo:true, idPersona:504})
MERGE (pers6:Persona {nombre:'Isabel', apellidoPaterno:'Ahumada', apellidoMaterno:'Madero', fechaNacimiento:date(), genero:'OTRO', estadoCivil: 'SOLTERO', curp:'AHMI9011128X1UUV', usuarioModificacion:'TEST', fechaModificacion:localdatetime(), activo:true, idPersona:505})
MERGE (pers7:Persona {nombre:'Diego', apellidoPaterno:'Abad', apellidoMaterno:'Atmann', fechaNacimiento:date(), genero:'MASCULINO', estadoCivil: 'VIUDO', curp:'ABAD9201089X7UUV', usuarioModificacion:'TEST', fechaModificacion:localdatetime(), activo:true, idPersona:506})
MERGE (pers8:Persona {nombre:'Ana Paula', apellidoPaterno:'Martinez', apellidoMaterno:'Torres', fechaNacimiento:date(), genero:'FEMENINO', estadoCivil: 'CASADO', curp:'MATA9003089X3UUV', usuarioModificacion:'TEST', fechaModificacion:localdatetime(), activo:true, idPersona:507})
MERGE (pers9:Persona {nombre:'Jesus', apellidoPaterno:'Torres', apellidoMaterno:'Beckmann', fechaNacimiento:date(), genero:'MASCULINO', estadoCivil: 'SOLTERO', curp:'TOBJ8808097X4UUV', usuarioModificacion:'TEST', fechaModificacion:localdatetime(), activo:true, idPersona:508})
MERGE (pers10:Persona {nombre:'Carlos', apellidoPaterno:'Sandoval', apellidoMaterno:'Vilchis', fechaNacimiento:date(), genero:'MASCULINO', estadoCivil: 'SOLTERO', curp:'SAVC8909109X1UUV', usuarioModificacion:'TEST', fechaModificacion:localdatetime(), activo:true, idPersona:509})


/* =====     P E R S O N S   W I T H  A R E A S     ===== */
/* note: can be wrong this script since we estimated the idCompania */
MATCH (pers1:Persona),(area1:Area) WHERE pers1.nombre = 'Juan' AND area1.nombre = 'Direccion' MERGE (pers1)-[:DIRIGE {idPersona:2, nombreCompania:'ACME Bodega SA de CV'}]-(area1)
MATCH (pers2:Persona),(area2:Area) WHERE pers2.nombre = 'Alejandro' AND area2.nombre = 'Contabilidad' MERGE (pers2)-[:DIRIGE {idPersona:2, nombreCompania:'ACME Bodega SA de CV'}]-(area2)
MATCH (pers7:Persona),(area3:Area) WHERE pers7.nombre = 'Diego' AND area3.nombre = 'Sistemas' MERGE (pers7)-[:DIRIGE {idPersona:2, nombreCompania:'ACME Bodega SA de CV'}]-(area3)

/* =====     P E R S O N S   W I T H  P E R S O N S     ===== */
MATCH (pers1:Persona),(pers2:Persona) WHERE pers1.nombre = 'Juan' AND pers2.nombre = 'Alejandro' MERGE (pers1)-[:RELACION{tipo:'Parentesco', nombre:'primo'}]-(pers2)
MATCH (pers9:Persona),(pers8:Persona) WHERE pers9.nombre = 'Jesus' AND pers8.nombre = 'Ana Paula' MERGE (pers9)-[:RELACION{tipo:'Parentesco', nombre:'esposo'}]-(pers8)
MATCH (pers5:Persona),(pers6:Persona) WHERE pers5.nombre = 'Roberto' AND pers6.nombre = 'Isabel' MERGE (pers5)-[:RELACION{tipo:'Parentesco', nombre:'esposo'}]-(pers6)
MATCH (pers5:Persona),(pers7:Persona) WHERE pers5.nombre = 'Roberto' AND pers7.nombre = 'Diego' MERGE (pers5)-[:RELACION{tipo:'Recomendado', nombre:'Jefe'}]-(pers7)
MATCH (pers5:Persona),(pers8:Persona) WHERE pers5.nombre = 'Roberto' AND pers8.nombre = 'Ana Paula' MERGE (pers5)-[:RELACION{tipo:'Recomendado', nombre:'Conocido'}]-(pers8)
MATCH (pers8:Persona),(pers9:Persona) WHERE pers8.nombre = 'Ana Paula' AND pers9.nombre = 'Jesus' MERGE (pers8)-[:RELACION{tipo:'Recomendado', nombre:'Conocido'}]-(pers9)
MATCH (pers9:Persona),(pers10:Persona) WHERE pers9.nombre = 'Jesus' AND pers10.nombre = 'Carlos' MERGE (pers9)-[:RELACION{tipo:'Amigo', nombre:'Muy amigo'}]-(pers10)

/* =====     R F C   ===== */
MERGE (rfc1:Rfc {rfc:'PEAJ8011127X3'})
MERGE (rfc2:Rfc {rfc:'ROSA8103038X1'})
MERGE (rfc3:Rfc {rfc:'GACP8206067X6'})
MERGE (rfc4:Rfc {rfc:'GOLM9003039X1'})
MERGE (rfc5:Rfc {rfc:'SACR6404098X7'})
MERGE (rfc6:Rfc {rfc:'AHMI9011128X1'})
MERGE (rfc7:Rfc {rfc:'ABAD9201089X7'})
MERGE (rfc8:Rfc {rfc:'MATA9003089X3'})
MERGE (rfc9:Rfc {rfc:'TOBJ8808097X4'})
MERGE (rfc10:Rfc {rfc:'SAVC8909109X1'})
MERGE (rfc11:Rfc {rfc:'LLHE6011267X2'})
MERGE (rfc12:Rfc {rfc:'LEHR6011267P2'})
MERGE (rfc13:Rfc {rfc:'JDSU6011267X2'})
MERGE (rfc14:Rfc {rfc:'RMMM6011267X2'})
MERGE (rfc15:Rfc {rfc:'LEFF6011267X2'})
MERGE (rfc16:Rfc {rfc:'RPJD951128WX2'})
MERGE (rfc17:Rfc {rfc:'RPJD9511287X2'})

/* =====    P E R S O N S   W I T H   R F C   ===== */
MATCH (pers1:Persona),(rfc1:Rfc) WHERE pers1.nombre = 'Juan' AND rfc1.rfc = 'PEAJ8011127X3' MERGE (pers1)-[:RFC]-(rfc1)
MATCH (pers2:Persona),(rfc2:Rfc) WHERE pers2.nombre = 'Alejandro' AND rfc2.rfc = 'ROSA8103038X1' MERGE (pers2)-[:RFC]-(rfc2)
MATCH (pers3:Persona),(rfc3:Rfc) WHERE pers3.nombre = 'Patricio' AND rfc3.rfc = 'GACP8206067X6' MERGE (pers3)-[:RFC]-(rfc3)
MATCH (pers4:Persona),(rfc4:Rfc) WHERE pers4.nombre = 'Marisa' AND rfc4.rfc = 'GOLM9003039X1' MERGE (pers4)-[:RFC]-(rfc4)
MATCH (pers5:Persona),(rfc5:Rfc) WHERE pers5.nombre = 'Roberto' AND rfc5.rfc = 'SACR6404098X7' MERGE (pers5)-[:RFC]-(rfc5)
MATCH (pers6:Persona),(rfc6:Rfc) WHERE pers6.nombre = 'Isabel' AND rfc6.rfc = 'AHMI9011128X1' MERGE (pers6)-[:RFC]-(rfc6)
MATCH (pers7:Persona),(rfc7:Rfc) WHERE pers7.nombre = 'Diego' AND rfc7.rfc = 'ABAD9201089X7' MERGE (pers7)-[:RFC]-(rfc7)
MATCH (pers8:Persona),(rfc8:Rfc) WHERE pers8.nombre = 'Ana Paula' AND rfc8.rfc = 'MATA9003089X3' MERGE (pers8)-[:RFC]-(rfc8)
MATCH (pers9:Persona),(rfc9:Rfc) WHERE pers9.nombre = 'Jesus' AND rfc9.rfc = 'TOBJ8808097X4' MERGE (pers9)-[:RFC]-(rfc9)
MATCH (pers10:Persona),(rfc10:Rfc) WHERE pers10.nombre = 'Carlos' AND rfc10.rfc = 'SAVC8909109X1' MERGE (pers16)-[:RFC]-(rfc10)

/* =====     T E L E P H O N E  N U M B E R S   ===== */
MERGE (tel1:Telefono {numero:'5591495001', ciudad:'CDMX', tipo:'OFICINA'})
MERGE (tel2:Telefono {numero:'5555962188', ciudad:'CDMX', tipo:'OFICINA'})
MERGE (tel3:Telefono {numero:'5555703476', ciudad:'CDMX', tipo:'OFICINA'})
MERGE (tel4:Telefono {numero:'5555681423', ciudad:'CDMX', tipo:'OFICINA'})
MERGE (tel5:Telefono {numero:'5554195422', ciudad:'CDMX', tipo:'CELULAR'})
MERGE (tel6:Telefono {numero:'5591495040', ciudad:'CDMX', tipo:'OFICINA'})
MERGE (tel7:Telefono {numero:'5591495042', ciudad:'CDMX', tipo:'OFICINA'})
MERGE (tel8:Telefono {numero:'5591495000', ciudad:'CDMX', tipo:'OFICINA'})
MERGE (tel9:Telefono {numero:'5554407981', ciudad:'CDMX', tipo:'CELULAR'})
MERGE (tel10:Telefono {numero:'6262256418', ciudad:'CHIC', tipo:'OFICINA'})
MERGE (tel11:Telefono {numero:'6262256420', ciudad:'CHIC', tipo:'OFICINA'})
MERGE (tel12:Telefono {numero:'5555366575', ciudad:'CDMX', tipo:'OFICINA'})
MERGE (tel13:Telefono {numero:'5555362188', ciudad:'CDMX', tipo:'OFICINA'})
MERGE (tel14:Telefono {numero:'5555930572', ciudad:'CDMX', tipo:'OFICINA'})
MERGE (tel15:Telefono {numero:'5555930131', ciudad:'CDMX', tipo:'OFICINA'})
MERGE (tel16:Telefono {numero:'5554195432', ciudad:'CDMX', tipo:'CELULAR'})
MERGE (tel17:Telefono {numero:'5591505040', ciudad:'CDMX', tipo:'OFICINA'})
MERGE (tel18:Telefono {numero:'5591505042', ciudad:'CDMX', tipo:'OFICINA'})
MERGE (tel19:Telefono {numero:'5591505000', ciudad:'CDMX', tipo:'CASA'})
MERGE (tel20:Telefono {numero:'5555407981', ciudad:'CDMX', tipo:'CELULAR'})
MERGE (tel21:Telefono {numero:'8212256428', ciudad:'LA', tipo:'OFICINA'})
MERGE (tel22:Telefono {numero:'8212256430', ciudad:'CHIC', tipo:'OFICINA'})

/* =====     P E R S O N S  W I T H  T E L E P H O N E S   ===== */
MATCH (pers1:Persona),(tel1:Telefono) WHERE pers1.nombre = 'Juan' AND tel1.numero = '5555966575'  MERGE (pers1)-[:TELEFONO]-(tel1)
MATCH (pers1:Persona),(tel9:Telefono) WHERE pers1.nombre = 'Juan' AND tel9.numero = '5554407981'  MERGE (pers1)-[:TELEFONO]-(tel9)
MATCH (pers2:Persona),(tel10:Telefono) WHERE pers2.nombre = 'Alejandro' AND tel10.numero = '6262256418'  MERGE (pers2)-[:TELEFONO]-(tel10)
MATCH (pers3:Persona),(tel11:Telefono) WHERE pers3.nombre = 'Patricio' AND tel11.numero = '6262256418'  MERGE (pers3)-[:TELEFONO]-(tel11)
MATCH (pers4:Persona),(tel12:Telefono) WHERE pers4.nombre = 'Marisa' AND tel12.numero = '5555366575'  MERGE (pers4)-[:TELEFONO]-(tel12)
MATCH (pers5:Persona),(tel13:Telefono) WHERE pers5.nombre = 'Roberto' AND tel13.numero = '5555362188'  MERGE (pers5)-[:TELEFONO]-(tel13)
MATCH (pers6:Persona),(tel14:Telefono) WHERE pers6.nombre = 'Isabel' AND tel14.numero = '5555930572'  MERGE (pers6)-[:TELEFONO]-(tel14)
MATCH (pers7:Persona),(tel15:Telefono) WHERE pers7.nombre = 'Diego' AND tel15.numero = '5555930131'  MERGE (pers7)-[:TELEFONO]-(tel15)
MATCH (pers7:Persona),(tel16:Telefono) WHERE pers7.nombre = 'Diego' AND tel16.numero = '5554195432'  MERGE (pers7)-[:TELEFONO]-(tel16)
MATCH (pers8:Persona),(tel17:Telefono) WHERE pers8.nombre = 'Ana Paula' AND tel17.numero = '5591505040'  MERGE (pers8)-[:TELEFONO]-(tel17)
MATCH (pers8:Persona),(tel18:Telefono) WHERE pers8.nombre = 'Ana Paula' AND tel18.numero = '5591505042'  MERGE (pers8)-[:TELEFONO]-(tel18)
MATCH (pers9:Persona),(tel19:Telefono) WHERE pers9.nombre = 'Jesus' AND tel19.numero = '5591505000'  MERGE (pers9)-[:TELEFONO]-(tel19)
MATCH (pers10:Persona),(tel20:Telefono) WHERE pers10.nombre = 'Carlos' AND tel20.numero = '5591505000'  MERGE (pers10)-[:TELEFONO]-(tel20)
MATCH (pers10:Persona),(tel21:Telefono) WHERE pers10.nombre = 'Carlos' AND tel21.numero = '8212256428'  MERGE (pers10)-[:TELEFONO]-(tel21)
MATCH (pers10:Persona),(tel22:Telefono) WHERE pers10.nombre = 'Carlos' AND tel22.numero = '8212256430'  MERGE (pers10)-[:TELEFONO]-(tel22)

/* =====     E M A I L S   ===== */
MERGE (email1:Email {uri:'acme.com.mx'})
MERGE (email2:Email {uri:'amazon.com.mx'})
MERGE (email3:Email {uri:'ixe.com.mx'})
MERGE (email4:Email {uri:'intercam.com.mx'})
MERGE (email5:Email {uri:'hotmail.com'})
MERGE (email6:Email {uri:'gmail.com'})

/* =====     P E R S O N S  W I T H  E M A I L S   ===== */
MATCH (pers1:Persona),(email1:Email) WHERE pers1.nombre = 'Juan' AND email1.uri = 'acme.com.mx'  MERGE (pers1)-[:EMAIL{email:'staff@acme.com.mx'}]-(email1)
MATCH (pers2:Persona),(email1:Email) WHERE pers2.nombre = 'Alejandro' AND email1.uri = 'acme.com.mx'  MERGE (pers2)-[:EMAIL{email:'perex@acme.com.mx'}]-(email1)
MATCH (pers3:Persona),(email1:Email) WHERE pers3.nombre = 'Patricio' AND email1.uri = 'acme.com.mx'  MERGE (pers3)-[:EMAIL{email:'perex@acme.com.mx'}]-(email1)
MATCH (pers4:Persona),(email2:Email) WHERE pers4.nombre = 'Marisa' AND email2.uri = 'amazon.com.mx'  MERGE (pers4)-[:EMAIL{email:'staff@amazon.com.mx'}]-(email2)
MATCH (pers5:Persona),(email3:Email) WHERE pers5.nombre = 'Roberto' AND email3.uri = 'ixe.com.mx'  MERGE (pers5)-[:EMAIL{email:'staff@ixe.com.mx'}]-(email3)
MATCH (pers6:Persona),(email4:Email) WHERE pers6.nombre = 'Isabel' AND email4.uri = 'intercam.com.mx'  MERGE (pers6)-[:EMAIL{email:'staff@intercam.com.mx'}]-(email4)
MATCH (pers7:Persona),(email5:Email) WHERE pers7.nombre = 'Diego' AND email5.uri = 'hotmail.com'  MERGE (pers7)-[:EMAIL{email:'mary@hotmail.com'}]-(email5)
MATCH (pers8:Persona),(email5:Email) WHERE pers8.nombre = 'Ana Paula' AND email5.uri = 'hotmail.com'  MERGE (pers8)-[:EMAIL{email:'juan@hotmail.com'}]-(email5)
MATCH (pers9:Persona),(email5:Email) WHERE pers9.nombre = 'Jesus' AND email5.uri = 'hotmail.com'  MERGE (pers9)-[:EMAIL{email:'jperez@hotmail.com'}]-(email5)
MATCH (pers10:Persona),(email6:Email) WHERE pers10.nombre = 'Carlos' AND email6.uri = 'gmail.com'  MERGE (pers10)-[:EMAIL{email:'juan@gmail.com'}]-(email6)

/* =====     A D D R E S S E S   ===== */
MERGE (adr1:Direccion {calle:'Prado Sur 240. Depto 203', delegacion:'Miguel Hidalgo', ciudad:'CDMX', tipo:'OFICIAL'})
MERGE (adr2:Direccion {calle:'Fuego 240', delegacion:'Coyoacan', ciudad:'CDMX', tipo:'FACTURAR'})
MERGE (adr3:Direccion {calle:'Puebla 1320', delegacion:'Benito Juarez', ciudad:'CDMX', tipo:'OFICIAL'})
MERGE (adr4:Direccion {calle:'Reforma 45', delegacion:'Benito Juarez', ciudad:'CDMX', tipo:'OFICIAL'})
MERGE (adr5:Direccion {calle:'Vienes 30', delegacion:'Cuajimalpa', ciudad:'CDMX', tipo:'OFICIAL'})
MERGE (adr6:Direccion {calle:'Palacio de Versalles 285', delegacion:'Cuajimalpa', ciudad:'CDMX', tipo:'OFICIAL'})
MERGE (adr7:Direccion {calle:'Castillo de Windsor 33', delegacion:'Cuauhtémoc', ciudad:'CDMX', tipo:'CASA'})
MERGE (adr8:Direccion {calle:'Virreyes 23', delegacion:'Cuauhtémoc', ciudad:'CDMX', tipo:'OFICIAL'})
MERGE (adr9:Direccion {calle:'Sierra Madre 450', delegacion:'Miguel Hidalgo', ciudad:'CDMX', tipo:'OFICIAL'})
MERGE (adr10:Direccion {calle:'Montes Eliseos 120', delegacion:'Iztacalco', ciudad:'CDMX', tipo:'CASA'})
MERGE (adr11:Direccion {calle:'Masaryk 230', delegacion:'Iztacalco', ciudad:'CDMX', tipo:'OFICIAL'})
MERGE (adr12:Direccion {calle:'Av. las Torres 200', delegacion:'Iztapalapa', ciudad:'CDMX', tipo:'OFICIAL'})
MERGE (adr13:Direccion {calle:'Torrente 84', delegacion:'Miguel Hidalgo', ciudad:'CDMX', tipo:'OFICIAL'})
MERGE (adr14:Direccion {calle:'Lope de Vega 230', delegacion:'Iztapalapa', ciudad:'CDMX', tipo:'OFICIAL'})
MERGE (adr15:Direccion {calle:'Miramar 600', delegacion:'Tláhuac', ciudad:'CDMX', tipo:'OFICIAL'})
MERGE (adr16:Direccion {calle:'Bosque de alisos 230', delegacion:'Tláhuac', ciudad:'CDMX', tipo:'CASA'})
MERGE (adr17:Direccion {calle:'La candelaria 230', delegacion:'Tlalpan', ciudad:'CDMX', tipo:'OFICIAL'})
MERGE (adr18:Direccion {calle:'Amores 200', delegacion:'Tlalpan', ciudad:'CDMX', tipo:'OFICIAL'})
MERGE (adr19:Direccion {calle:'Circunvalación 30', delegacion:'Xochimilco', ciudad:'CDMX', tipo:'TEMPORAL'})
MERGE (adr20:Direccion {calle:'Romerito 560', delegacion:'Miguel Hidalgo', ciudad:'CDMX', tipo:'OFICIAL'})
MERGE (adr21:Direccion {calle:'Chapultepec 340', delegacion:'Miguel Hidalgo', ciudad:'CDMX', tipo:'CASA'})
MERGE (adr22:Direccion {calle:'El prado 444', delegacion:'Xochimilco', ciudad:'CDMX', tipo:'OFICIAL'})
MERGE (adr23:Direccion {calle:'Circuito Novelistas 230', delegacion:'Satelite', ciudad:'EDOMEX', tipo:'OFICIAL'})

/* =====     Z I P  C O D E S   ===== */
MERGE (zip1:Codigo {cp:11000})
MERGE (zip2:Codigo {cp:11100})
MERGE (zip3:Codigo {cp:12000})
MERGE (zip4:Codigo {cp:12010})
MERGE (zip5:Codigo {cp:12020})
MERGE (zip6:Codigo {cp:13000})
MERGE (zip7:Codigo {cp:13010})
MERGE (zip8:Codigo {cp:13020})
MERGE (zip9:Codigo {cp:13030})
MERGE (zip10:Codigo {cp:13033})
MERGE (zip11:Codigo {cp:13044})
MERGE (zip12:Codigo {cp:14000})
MERGE (zip13:Codigo {cp:14001})
MERGE (zip14:Codigo {cp:14002})
MERGE (zip15:Codigo {cp:14003})
MERGE (zip16:Codigo {cp:14005})
MERGE (zip17:Codigo {cp:15300})
MERGE (zip18:Codigo {cp:16000})
MERGE (zip19:Codigo {cp:17000})

/* =====     N E I G H B O R    ===== */
MERGE (mun1:Municipio {nombre:'Lomas de Chapultec'})
MERGE (mun2:Municipio {nombre:'Roma'})
MERGE (mun3:Municipio {nombre:'Real de las Lomas'})
MERGE (mun4:Municipio {nombre:'Bosques'})
MERGE (mun5:Municipio {nombre:'Las Aguilas'})
MERGE (mun6:Municipio {nombre:'Reforma Lomas'})
MERGE (mun7:Municipio {nombre:'Palmas'})
MERGE (mun8:Municipio {nombre:'Insurgentes Sur'})
MERGE (mun9:Municipio {nombre:'Centro'})
MERGE (mun10:Municipio {nombre:'Conscripto'})
MERGE (mun11:Municipio {nombre:'Tecamachalco'})
MERGE (mun12:Municipio {nombre:'Pedregal'})

/* =====     Z I P  C O D E S  W I T H  N E I G H B O R  ===== */
MATCH (mun1:Municipio),(zip1:Codigo) WHERE mun1.nombre = 'Lomas de Chapultec' AND zip1.cp = 11000  MERGE (mun1)-[:PERTENECE]-(zip1)
MATCH (mun2:Municipio),(zip2:Codigo) WHERE mun2.nombre = 'Lomas de Chapultec' AND zip2.cp = 11100  MERGE (mun2)-[:PERTENECE]-(zip2)
MATCH (mun3:Municipio),(zip3:Codigo) WHERE mun3.nombre = 'Real de las Lomas' AND zip3.cp = 12000  MERGE (mun3)-[:PERTENECE]-(zip3)
MATCH (mun4:Municipio),(zip4:Codigo) WHERE mun4.nombre = 'Bosques' AND zip4.cp = 12010  MERGE (mun4)-[:PERTENECE]-(zip4)
MATCH (mun5:Municipio),(zip5:Codigo) WHERE mun5.nombre = 'Las Aguilas' AND zip5.cp = 12020  MERGE (mun5)-[:PERTENECE]-(zip5)
MATCH (mun6:Municipio),(zip6:Codigo) WHERE mun6.nombre = 'Reforma Lomas' AND zip6.cp = 13000  MERGE (mun6)-[:PERTENECE]-(zip6)
MATCH (mun7:Municipio),(zip7:Codigo) WHERE mun7.nombre = 'Palmas' AND zip7.cp = 13010  MERGE (mun7)-[:PERTENECE]-(zip7)
MATCH (mun8:Municipio),(zip8:Codigo) WHERE mun8.nombre = 'Insurgentes Sur' AND zip8.cp = 13020  MERGE (mun8)-[:PERTENECE]-(zip8)
MATCH (mun9:Municipio),(zip9:Codigo) WHERE mun9.nombre = 'Insurgentes Sur' AND zip9.cp = 13030  MERGE (mun9)-[:PERTENECE]-(zip9)
MATCH (mun10:Municipio),(zip10:Codigo) WHERE mun10.nombre = 'Conscripto' AND zip10.cp = 13033  MERGE (mun10)-[:PERTENECE]-(zip10)
MATCH (mun11:Municipio),(zip11:Codigo) WHERE mun11.nombre = 'Tecamachalco' AND zip11.cp = 13044  MERGE (mun11)-[:PERTENECE]-(zip11)
MATCH (mun11:Municipio),(zip12:Codigo) WHERE mun11.nombre = 'Tecamachalco' AND zip12.cp = 14000  MERGE (mun11)-[:PERTENECE]-(zip12)
MATCH (mun11:Municipio),(zip13:Codigo) WHERE mun11.nombre = 'Tecamachalco' AND zip13.cp = 14001  MERGE (mun11)-[:PERTENECE]-(zip13)
MATCH (mun11:Municipio),(zip14:Codigo) WHERE mun11.nombre = 'Tecamachalco' AND zip14.cp = 14002  MERGE (mun11)-[:PERTENECE]-(zip14)
MATCH (mun11:Municipio),(zip15:Codigo) WHERE mun11.nombre = 'Tecamachalco' AND zip15.cp = 14003  MERGE (mun11)-[:PERTENECE]-(zip15)
MATCH (mun11:Municipio),(zip16:Codigo) WHERE mun11.nombre = 'Tecamachalco' AND zip16.cp = 14005  MERGE (mun11)-[:PERTENECE]-(zip16)
MATCH (mun11:Municipio),(zip17:Codigo) WHERE mun11.nombre = 'Tecamachalco' AND zip17.cp = 15300  MERGE (mun11)-[:PERTENECE]-(zip17)
MATCH (mun11:Municipio),(zip18:Codigo) WHERE mun11.nombre = 'Tecamachalco' AND zip18.cp = 16000  MERGE (mun11)-[:PERTENECE]-(zip18)
MATCH (mun11:Municipio),(zip19:Codigo) WHERE mun11.nombre = 'Tecamachalco' AND zip19.cp = 17000  MERGE (mun11)-[:PERTENECE]-(zip19)
MATCH (mun12:Municipio),(zip13:Codigo) WHERE mun12.nombre = 'Pedregal' AND zip13.cp = 14001  MERGE (mun12)-[:PERTENECE]-(zip13)

/* =====   C O U N T R I E S  ===== */
MERGE (pais1:Pais {nombre:'México'})
MERGE (pais2:Pais {nombre:'EUA'})
MERGE (pais3:Pais {nombre:'Canada'})
MERGE (pais4:Pais {nombre:'España'})
MERGE (pais5:Pais {nombre:'Alemania'})

/* =====   S T A T E S  ===== */
MERGE (edo1:Estado {nombre:'Aguascalientes', pais:'México'})
MERGE (edo2:Estado {nombre:'Baja California', pais:'México'})
MERGE (edo3:Estado {nombre:'Baja California Sur', pais:'México'})
MERGE (edo4:Estado {nombre:'Campeche', pais:'México'})
MERGE (edo5:Estado {nombre:'Chiapas', pais:'México'})
MERGE (edo6:Estado {nombre:'Chihuaha', pais:'México'})
MERGE (edo7:Estado {nombre:'CDMX', pais:'México'})
MERGE (edo8:Estado {nombre:'Coahuila', pais:'México'})
MERGE (edo9:Estado {nombre:'Colima', pais:'México'})
MERGE (edo10:Estado {nombre:'Durango', pais:'México'})
MERGE (edo11:Estado {nombre:'Estado de México', pais:'México'})
MERGE (edo12:Estado {nombre:'Guanajuato', pais:'México'})
MERGE (edo13:Estado {nombre:'Guerrero', pais:'México'})
MERGE (edo14:Estado {nombre:'Hidalgo', pais:'México'})
MERGE (edo15:Estado {nombre:'Jalisco', pais:'México'})
MERGE (edo16:Estado {nombre:'Michoacán', pais:'México'})
MERGE (edo17:Estado {nombre:'Morelos', pais:'México'})
MERGE (edo18:Estado {nombre:'Nayarit', pais:'México'})
MERGE (edo19:Estado {nombre:'Nuevo León', pais:'México'})
MERGE (edo20:Estado {nombre:'Oaxaca', pais:'México'})
MERGE (edo21:Estado {nombre:'Puebla', pais:'México'})
MERGE (edo22:Estado {nombre:'Querétaro', pais:'México'})
MERGE (edo23:Estado {nombre:'Quintana Roo', pais:'México'})
MERGE (edo24:Estado {nombre:'San Luis Potosí', pais:'México'})
MERGE (edo25:Estado {nombre:'Sinaloa', pais:'México'})
MERGE (edo26:Estado {nombre:'Sonora', pais:'México'})
MERGE (edo27:Estado {nombre:'Tabasco', pais:'México'})
MERGE (edo28:Estado {nombre:'Tamaulipas', pais:'México'})
MERGE (edo29:Estado {nombre:'Tlaxcala', pais:'México'})
MERGE (edo30:Estado {nombre:'Veracruz', pais:'México'})
MERGE (edo31:Estado {nombre:'Yucatán', pais:'México'})
MERGE (edo32:Estado {nombre:'Zacatecas', pais:'México'})
MERGE (edo100:Estado {nombre:'Alabama', pais:'USA'})
MERGE (edo101:Estado {nombre:'Alaska', pais:'USA'})
MERGE (edo102:Estado {nombre:'Arizona', pais:'USA'})
MERGE (edo103:Estado {nombre:'Arkansas', pais:'USA'})
MERGE (edo104:Estado {nombre:'California', pais:'USA'})
MERGE (edo105:Estado {nombre:'Colorado', pais:'USA'})
MERGE (edo106:Estado {nombre:'Connecticut', pais:'USA'})
MERGE (edo107:Estado {nombre:'Delaware', pais:'USA'})
MERGE (edo108:Estado {nombre:'Florida', pais:'USA'})
MERGE (edo109:Estado {nombre:'Georgia', pais:'USA'})
MERGE (edo110:Estado {nombre:'Hawai', pais:'USA'})
MERGE (edo111:Estado {nombre:'Idaho', pais:'USA'})
MERGE (edo112:Estado {nombre:'Illinois', pais:'USA'})
MERGE (edo113:Estado {nombre:'Indiana', pais:'USA'})
MERGE (edo114:Estado {nombre:'Iowa', pais:'USA'})
MERGE (edo115:Estado {nombre:'Kansas', pais:'USA'})
MERGE (edo116:Estado {nombre:'Kentucky', pais:'USA'})
MERGE (edo117:Estado {nombre:'Louisiana', pais:'USA'})
MERGE (edo118:Estado {nombre:'Maine', pais:'USA'})
MERGE (edo119:Estado {nombre:'Maryland', pais:'USA'})
MERGE (edo120:Estado {nombre:'Massachusetts', pais:'USA'})
MERGE (edo121:Estado {nombre:'Michigan', pais:'USA'})
MERGE (edo122:Estado {nombre:'Minnesota', pais:'USA'})
MERGE (edo123:Estado {nombre:'Mississippi', pais:'USA'})
MERGE (edo124:Estado {nombre:'Missouri', pais:'USA'})
MERGE (edo125:Estado {nombre:'Montana', pais:'USA'})
MERGE (edo126:Estado {nombre:'Nebraska', pais:'USA'})
MERGE (edo127:Estado {nombre:'Nevada', pais:'USA'})
MERGE (edo128:Estado {nombre:'New Hampshire', pais:'USA'})
MERGE (edo129:Estado {nombre:'New Jersey', pais:'USA'})
MERGE (edo130:Estado {nombre:'New Mexico', pais:'USA'})
MERGE (edo131:Estado {nombre:'New York', pais:'USA'})
MERGE (edo132:Estado {nombre:'North Carolina', pais:'USA'})
MERGE (edo133:Estado {nombre:'Month Dakota', pais:'USA'})
MERGE (edo134:Estado {nombre:'Ohio', pais:'USA'})
MERGE (edo135:Estado {nombre:'Oklahoma', pais:'USA'})
MERGE (edo136:Estado {nombre:'Oregon', pais:'USA'})
MERGE (edo137:Estado {nombre:'Pennsylvania', pais:'USA'})
MERGE (edo138:Estado {nombre:'Rhode Island', pais:'USA'})
MERGE (edo139:Estado {nombre:'South Carolina', pais:'USA'})
MERGE (edo140:Estado {nombre:'South Dakota', pais:'USA'})
MERGE (edo141:Estado {nombre:'Tennessee', pais:'USA'})
MERGE (edo142:Estado {nombre:'Texas', pais:'USA'})
MERGE (edo143:Estado {nombre:'Utah', pais:'USA'})
MERGE (edo144:Estado {nombre:'Vermont', pais:'USA'})
MERGE (edo145:Estado {nombre:'Virginia', pais:'USA'})
MERGE (edo146:Estado {nombre:'Washington', pais:'USA'})
MERGE (edo147:Estado {nombre:'West Virginia', pais:'USA'})
MERGE (edo148:Estado {nombre:'Wisconsin', pais:'USA'})
MERGE (edo149:Estado {nombre:'Wyoming', pais:'USA'})

/* =====     Z I P  C O D E S  W I T H  S T A T E S  ===== */
MATCH (zip1:Codigo),(edo1:Estado) WHERE zip1.cp = 11000 AND edo1.nombre = 'Estado de Mexico' MERGE (zip1)-[:PERTENECE]-(edo1)
MATCH (zip2:Codigo),(edo1:Estado) WHERE zip2.cp = 11100 AND edo1.nombre = 'Estado de Mexico' MERGE (zip2)-[:PERTENECE]-(edo1)
MATCH (zip3:Codigo),(edo2:Estado) WHERE zip3.cp = 12000 AND edo2.nombre = 'CDMX' MERGE (zip3)-[:PERTENECE]-(edo2)
MATCH (zip4:Codigo),(edo2:Estado) WHERE zip4.cp = 12010 AND edo2.nombre = 'CDMX' MERGE (zip4)-[:PERTENECE]-(edo2)
MATCH (zip5:Codigo),(edo2:Estado) WHERE zip5.cp = 12020 AND edo2.nombre = 'CDMX' MERGE (zip5)-[:PERTENECE]-(edo2)
MATCH (zip6:Codigo),(edo2:Estado) WHERE zip6.cp = 13000 AND edo2.nombre = 'CDMX' MERGE (zip6)-[:PERTENECE]-(edo2)
MATCH (zip7:Codigo),(edo2:Estado) WHERE zip7.cp = 13010 AND edo2.nombre = 'CDMX' MERGE (zip7)-[:PERTENECE]-(edo2)
MATCH (zip8:Codigo),(edo2:Estado) WHERE zip8.cp = 13020 AND edo2.nombre = 'CDMX' MERGE (zip8)-[:PERTENECE]-(edo2)
MATCH (zip9:Codigo),(edo3:Estado) WHERE zip9.cp = 13030 AND edo3.nombre = 'Morelos' MERGE (zip9)-[:PERTENECE]-(edo3)
MATCH (zip10:Codigo),(edo3:Estado) WHERE zip10.cp = 13033 AND edo3.nombre = 'Morelos' MERGE (zip10)-[:PERTENECE]-(edo3)
MATCH (zip11:Codigo),(edo4:Estado) WHERE zip11.cp = 13044 AND edo4.nombre = 'Guerrero' MERGE (zip11)-[:PERTENECE]-(edo4)
MATCH (zip12:Codigo),(edo4:Estado) WHERE zip12.cp = 14000 AND edo4.nombre = 'Guerrero' MERGE (zip12)-[:PERTENECE]-(edo4)
MATCH (zip13:Codigo),(edo4:Estado) WHERE zip13.cp = 14001 AND edo4.nombre = 'Guerrero' MERGE (zip13)-[:PERTENECE]-(ededo4o1)
MATCH (zip14:Codigo),(edo2:Estado) WHERE zip14.cp = 14002 AND edo2.nombre = 'CDMX' MERGE (zip14)-[:PERTENECE]-(edo2)
MATCH (zip15:Codigo),(edo2:Estado) WHERE zip15.cp = 14003 AND edo2.nombre = 'CDMX' MERGE (zip15)-[:PERTENECE]-(edo2)
MATCH (zip16:Codigo),(edo2:Estado) WHERE zip16.cp = 14005 AND edo2.nombre = 'CDMX' MERGE (zip16)-[:PERTENECE]-(edo2)
MATCH (zip17:Codigo),(edo6:Estado) WHERE zip17.cp = 15300 AND edo6.nombre = 'Texas' MERGE (zip17)-[:PERTENECE]-(edo6)
MATCH (zip18:Codigo),(edo6:Estado) WHERE zip18.cp = 16000 AND edo6.nombre = 'Texas' MERGE (zip18)-[:PERTENECE]-(edo6)
MATCH (zip19:Codigo),(edo6:Estado) WHERE zip19.cp = 17000 AND edo6.nombre = 'Texas' MERGE (zip19)-[:PERTENECE]-(edo6)

/* =====     A D D R E S S  W I T H  Z I P  C O D E S  ===== */
MATCH (adr1:Direccion),(zip1:Codigo) WHERE adr1.calle = 'Prado Sur 240. Depto 203' AND zip1.cp = 11000 MERGE (adr1)-[:CODIGO]-(zip1)
MATCH (adr2:Direccion),(zip2:Codigo) WHERE adr2.calle = 'Fuego 240' AND zip2.cp = 11100 MERGE (adr2)-[:CODIGO]-(zip2)
MATCH (adr3:Direccion),(zip3:Codigo) WHERE adr3.calle = 'Puebla 1320' AND zip3.cp = 12000 MERGE (adr3)-[:CODIGO]-(zip3)
MATCH (adr4:Direccion),(zip4:Codigo) WHERE adr4.calle = 'Reforma 45' AND zip4.cp = 12010 MERGE (adr4)-[:CODIGO]-(zip4)
MATCH (adr5:Direccion),(zip5:Codigo) WHERE adr5.calle = 'Vienes 30' AND zip5.cp = 12020 MERGE (adr5)-[:CODIGO]-(zip5)
MATCH (adr6:Direccion),(zip6:Codigo) WHERE adr6.calle = 'Palacio de Versalles 285' AND zip6.cp = 13000 MERGE (adr6)-[:CODIGO]-(zip6)
MATCH (adr7:Direccion),(zip7:Codigo) WHERE adr7.calle = 'Castillo de Windsor 33' AND zip7.cp = 13010 MERGE (adr7)-[:CODIGO]-(zip7)
MATCH (adr8:Direccion),(zip8:Codigo) WHERE adr8.calle = 'Virreyes 23' AND zip8.cp = 13020 MERGE (adr8)-[:CODIGO]-(zip8)
MATCH (adr9:Direccion),(zip9:Codigo) WHERE adr9.calle = 'Sierra Madre 450' AND zip9.cp = 13030 MERGE (adr9)-[:CODIGO]-(zip9)
MATCH (adr10:Direccion),(zip10:Codigo) WHERE adr10.calle = 'Montes Eliseos 120' AND zip10.cp = 13033 MERGE (adr10)-[:CODIGO]-(zip10)
MATCH (adr11:Direccion),(zip10:Codigo) WHERE adr11.calle = 'Masaryk 230' AND zip10.cp = 13033 MERGE (adr11)-[:CODIGO]-(zip10)
MATCH (adr12:Direccion),(zip11:Codigo) WHERE adr12.calle = 'Av. las Torres 200' AND zip11.cp = 13044 MERGE (adr12)-[:CODIGO]-(zip11)
MATCH (adr13:Direccion),(zip12:Codigo) WHERE adr13.calle = 'Torrente 84' AND zip12.cp = 14000 MERGE (adr13)-[:CODIGO]-(zip12)
MATCH (adr14:Direccion),(zip12:Codigo) WHERE adr14.calle = 'Lope de Vega 230' AND zip12.cp = 14000 MERGE (adr14)-[:CODIGO]-(zip12)
MATCH (adr15:Direccion),(zip13:Codigo) WHERE adr15.calle = 'Miramar 600' AND zip13.cp = 14001 MERGE (adr15)-[:CODIGO]-(zip13)
MATCH (adr16:Direccion),(zip14:Codigo) WHERE adr16.calle = 'Bosque de alisos 230' AND zip14.cp = 14002 MERGE (adr16)-[:CODIGO]-(zip14)
MATCH (adr17:Direccion),(zip14:Codigo) WHERE adr17.calle = 'La candelaria 230' AND zip14.cp = 14002 MERGE (adr17)-[:CODIGO]-(zip14)
MATCH (adr18:Direccion),(zip15:Codigo) WHERE adr18.calle = 'Amores 200' AND zip15.cp = 14003 MERGE (adr18)-[:CODIGO]-(zip15)
MATCH (adr19:Direccion),(zip16:Codigo) WHERE adr19.calle = 'Circunvalación 30' AND zip16.cp = 14005 MERGE (adr19)-[:CODIGO]-(zip16)
MATCH (adr20:Direccion),(zip17:Codigo) WHERE adr20.calle = 'Romerito 560' AND zip17.cp = 15300 MERGE (adr20)-[:CODIGO]-(zip17)
MATCH (adr21:Direccion),(zip18:Codigo) WHERE adr21.calle = 'Chapultepec 340' AND zip18.cp = 16000 MERGE (adr21)-[:CODIGO]-(zip18)
MATCH (adr22:Direccion),(zip19:Codigo) WHERE adr22.calle = 'El prado 444' AND zip19.cp = 17000 MERGE (adr22)-[:CODIGO]-(zip19)
MATCH (adr23:Direccion),(zip19:Codigo) WHERE adr23.calle = 'Circuito Novelistas 230' AND zip19.cp = 17000 MERGE (adr23)-[:CODIGO]-(zip19)

/* =====     A D D R E S S  W I T H  M U N I C I P I O S  ===== */
MATCH (adr1:Direccion),(mun1:Municipio) WHERE adr1.calle = 'Prado Sur 240. Depto 203' AND mun1.nombre = 'Lomas de Chapultec' MERGE (adr1)-[:SE_ENCUENTRA]-(mun1)
MATCH (adr2:Direccion),(mun2:Municipio) WHERE adr2.calle = 'Fuego 240' AND mun2.nombre= 'Roma' MERGE (adr2)-[:SE_ENCUENTRA]-(mun2)
MATCH (adr3:Direccion),(mun3:Municipio) WHERE adr3.calle = 'Puebla 1320' AND mun3.nombre = 'Real de las Lomas' MERGE (adr3)-[:SE_ENCUENTRA]-(mun3)
MATCH (adr4:Direccion),(mun4:Municipio) WHERE adr4.calle = 'Reforma 45' AND mun4.nombre = 'Bosques' MERGE (adr4)-[:SE_ENCUENTRA]-(mun4)
MATCH (adr5:Direccion),(mun5:Municipio) WHERE adr5.calle = 'Vienes 30' AND mun5.nombre = 'Las Aguilas' MERGE (adr5)-[:SE_ENCUENTRA]-(mun5)
MATCH (adr6:Direccion),(mun6:Municipio) WHERE adr6.calle = 'Palacio de Versalles 285' AND mun6.nombre = 'Reforma Lomas' MERGE (adr6)-[:SE_ENCUENTRA]-(mun6)
MATCH (adr7:Direccion),(mun7:Municipio) WHERE adr7.calle = 'Castillo de Windsor 33' AND mun7.nombre = 'Palmas' MERGE (adr7)-[:SE_ENCUENTRA]-(mun7)
MATCH (adr8:Direccion),(mun8:Municipio) WHERE adr8.calle = 'Virreyes 23' AND mun8.nombre = 'Insurgentes Sur' MERGE (adr8)-[:SE_ENCUENTRA]-(mun8)
MATCH (adr9:Direccion),(mun9:Municipio) WHERE adr9.calle = 'Sierra Madre 450' AND mun9.nombre = 'Centro' MERGE (adr9)-[:SE_ENCUENTRA]-(mun9)
MATCH (adr10:Direccion),(mun10:Municipio) WHERE adr10.calle = 'Montes Eliseos 120' AND mun10.nombre = 'Conscripto' MERGE (adr10)-[:SE_ENCUENTRA]-(mun10)
MATCH (adr11:Direccion),(mun10:Municipio) WHERE adr11.calle = 'Masaryk 230' AND mun10.nombre = 'Conscripto' MERGE (adr11)-[:SE_ENCUENTRA]-(mun10)
MATCH (adr12:Direccion),(mun11:Municipio) WHERE adr12.calle = 'Av. las Torres 200' AND mun11.nombre = 'Tecamachalco' MERGE (adr12)-[:SE_ENCUENTRA]-(mun11)
MATCH (adr13:Direccion),(mun9:Municipio) WHERE adr13.calle = 'Torrente 84' AND mun9.nombre = 'Centro' MERGE (adr13)-[:SE_ENCUENTRA]-(mun9)
MATCH (adr14:Direccion),(mun8:Municipio) WHERE adr14.calle = 'Lope de Vega 230' AND mun8.nombre = 'Insurgentes Sur' MERGE (adr14)-[:SE_ENCUENTRA]-(mun8)
MATCH (adr15:Direccion),(mun7:Municipio) WHERE adr15.calle = 'Miramar 600' AND mun7.nombre = 'Palmas' MERGE (adr15)-[:SE_ENCUENTRA]-(mun7)
MATCH (adr16:Direccion),(mun6:Municipio) WHERE adr16.calle = 'Bosque de alisos 230' AND mun6.nombre = 'Reforma Lomas' MERGE (adr16)-[:SE_ENCUENTRA]-(mun6)
MATCH (adr17:Direccion),(mun5:Municipio) WHERE adr17.calle = 'La candelaria 230' AND mun5.nombre = 14002 MERGE (adr17)-[:CODISE_ENCUENTRAGO]-(mun5)
MATCH (adr18:Direccion),(mun5:Municipio) WHERE adr18.calle = 'Amores 200' AND mun5.nombre = 'Las Aguilas' MERGE (adr18)-[:SE_ENCUENTRA]-(mun5)
MATCH (adr19:Direccion),(mun4:Municipio) WHERE adr19.calle = 'Circunvalación 30' AND mun4.nombre = 'Bosques' MERGE (adr19)-[:SE_ENCUENTRA]-(mun4)
MATCH (adr20:Direccion),(mun3:Municipio) WHERE adr20.calle = 'Romerito 560' AND mun3.nombre = 'Real de las Lomas' MERGE (adr20)-[:SE_ENCUENTRA]-(mun3)
MATCH (adr21:Direccion),(mun1:Municipio) WHERE adr21.calle = 'Chapultepec 340' AND mun1.nombre = 'Roma' MERGE (adr21)-[:SE_ENCUENTRA]-(mun1)
MATCH (adr22:Direccion),(mun1:Municipio) WHERE adr22.calle = 'El prado 444' AND mun1.nombre = 'Lomas de Chapultec' MERGE (adr22)-[:SE_ENCUENTRA]-(mun1)
MATCH (adr23:Direccion),(mun1:Municipio) WHERE adr23.calle = 'Circuito Novelistas 230' AND mun1.nombre = 'Lomas de Chapultec' MERGE (adr23)-[:SE_ENCUENTRA]-(mun1)

/* =====     P E R S O N S  W I T H  A D D R E S S   ===== */
MATCH (pers1:Persona),(adr1:Direccion) WHERE pers1.nombre = 'Juan' AND adr1.calle = 'Prado Sur 240. Depto 203' MERGE (pers7)-[:DIRECCION]-(adr1)
MATCH (pers1:Persona),(adr2:Direccion) WHERE pers1.nombre = 'Juan' AND adr2.calle = 'Fuego 240' MERGE (pers1)-[:DIRECCION]-(adr2)
MATCH (pers2:Persona),(adr3:Direccion) WHERE pers2.nombre = 'Alejandro' AND adr3.calle = 'Puebla 1320' MERGE (pers2)-[:DIRECCION]-(adr3)
MATCH (pers3:Persona),(adr4:Direccion) WHERE pers3.nombre = 'Patricio' AND adr4.calle = 'Reforma 45' MERGE (pers3)-[:DIRECCION]-(adr4)
MATCH (pers4:Persona),(adr5:Direccion) WHERE pers4.nombre = 'Marisa' AND adr5.calle = 'Vienes 30' MERGE (pers4)-[:DIRECCION]-(adr5)
MATCH (pers5:Persona),(adr6:Direccion) WHERE pers5.nombre = 'Roberto' AND adr6.calle = 'Palacio de Versalles 285' MERGE (pers5)-[:DIRECCION]-(adr6)
MATCH (pers6:Persona),(adr7:Direccion) WHERE pers6.nombre = 'Isabel' AND adr7.calle = 'Castillo de Windsor 33' MERGE (pers6)-[:DIRECCION]-(adr7)
MATCH (pers7:Persona),(adr8:Direccion) WHERE pers7.nombre = 'Diego' AND adr8.calle = 'Virreyes 23' MERGE (pers7)-[:DIRECCION]-(adr8)
MATCH (pers7:Persona),(adr9:Direccion) WHERE pers7.nombre = 'Diego' AND adr9.calle = 'Sierra Madre 450' MERGE (pers7)-[:DIRECCION]-(adr9)
MATCH (pers8:Persona),(adr10:Direccion) WHERE pers8.nombre = 'Ana Paula' AND adr10.calle = 'Montes Eliseos 120' MERGE (pers8)-[:DIRECCION]-(adr10)
MATCH (pers8:Persona),(adr11:Direccion) WHERE pers8.nombre = 'Ana Paula' AND adr11.calle = 'Masaryk 230' MERGE (pers8)-[:DIRECCION]-(adr11)
MATCH (pers9:Persona),(adr12:Direccion) WHERE pers9.nombre = 'Jesus' AND adr12.calle = 'Av. las Torres 200' MERGE (pers9)-[:DIRECCION]-(adr12)
MATCH (pers10:Persona),(adr13:Direccion) WHERE pers10.nombre = 'Carlos' AND adr13.calle = 'Torrente 84' MERGE (pers10)-[:DIRECCION]-(adr13)
MATCH (pers10:Persona),(adr14:Direccion) WHERE pers10.nombre = 'Carlos' AND adr14.calle = 'Lope de Vega 230' MERGE (pers10)-[:DIRECCION]-(adr14)
MATCH (pers10:Persona),(adr15:Direccion) WHERE pers10.nombre = 'Carlos' AND adr15.calle = 'Miramar 600' MERGE (pers10)-[:DIRECCION]-(adr15)

/* =====     A C C O U N T S   ===== */
MERGE (act1:Cuenta {clabe:'0123456789012345678', banco:'BBVA', moneda:'MXN', saldo:130000})
MERGE (act2:Cuenta {clabe:'0134545584500000676', banco:'BBVA', moneda:'MXN', saldo:230000})
MERGE (act3:Cuenta {clabe:'4849300000899393390', banco:'Banamex', moneda:'MXN', saldo:140000})
MERGE (act4:Cuenta {clabe:'0004455858575959855', banco:'Banorte', moneda:'MXN', saldo:900000})
MERGE (act5:Cuenta {clabe:'4474837383748474780', banco:'Banorte', moneda:'USD', saldo:10000})
MERGE (act6:Cuenta {clabe:'0003933839338383734', banco:'BX+', moneda:'MXN', saldo:110000})
MERGE (act7:Cuenta {clabe:'4849448494800008933', banco:'HSBC', moneda:'MXN', saldo:345})
MERGE (act8:Cuenta {clabe:'3483738373700000345', banco:'Santander', moneda:'MXN', saldo:112200})
MERGE (act9:Cuenta {clabe:'4647484480000089378', banco:'Santander', moneda:'MXN', saldo:110000})
MERGE (act10:Cuenta {clabe:'2929283938800000383', banco:'Scotiabank', moneda:'MXN', saldo:10000})
MERGE (act11:Cuenta {clabe:'3333333330930830393', banco:'BBVA', moneda:'MXN', saldo:83000})
MERGE (act12:Cuenta {clabe:'0003833738937393789', banco:'Scotiabank', moneda:'USD', saldo:120000})
MERGE (act13:Cuenta {clabe:'3938393839383938933', banco:'Banorte', moneda:'MXN', saldo:14500})
MERGE (act14:Cuenta {clabe:'3837837937300003839', banco:'Banorte', moneda:'MXN', saldo:120000})
MERGE (act15:Cuenta {clabe:'3839387398378393893', banco:'CIBanco', moneda:'MXN', saldo:11200})

/* =====    P E R S O N S  W I T H   A C C O U N T S   ===== */
MATCH (pers1:Persona),(act1:Cuenta) WHERE pers1.nombre = 'Juan' AND act1.clabe = '0123456789012345678' MERGE (pers1)-[:CUENTA]-(act1)
MATCH (pers2:Persona),(act2:Cuenta) WHERE pers2.nombre = 'Alejandro' AND act2.clabe = '0134545584500000676' MERGE (pers2)-[:CUENTA]-(act2)
MATCH (pers3:Persona),(act3:Cuenta) WHERE pers3.nombre = 'Patricio' AND act3.clabe = '4849300000899393390' MERGE (pers3)-[:CUENTA]-(act3)
MATCH (pers4:Persona),(act4:Cuenta) WHERE pers4.nombre = 'Marisa' AND act4.clabe = '0004455858575959855' MERGE (pers4)-[:CUENTA]-(act4)
MATCH (pers5:Persona),(act5:Cuenta) WHERE pers5.nombre = 'Roberto' AND act5.clabe = '4474837383748474780' MERGE (pers5)-[:CUENTA]-(act5)
MATCH (pers6:Persona),(act6:Cuenta) WHERE pers6.nombre = 'Isabel' AND act6.clabe = '0003933839338383734' MERGE (pers6)-[:CUENTA]-(act6)
MATCH (pers7:Persona),(act7:Cuenta) WHERE pers7.nombre = 'Diego' AND act7.clabe = '4849448494800008933' MERGE (pers7)-[:CUENTA]-(act7)
MATCH (pers8:Persona),(act8:Cuenta) WHERE pers8.nombre = 'Ana Paula' AND act8.clabe = '3483738373700000345' MERGE (pers8)-[:CUENTA]-(act8)
MATCH (pers9:Persona),(act9:Cuenta) WHERE pers9.nombre = 'Jesus' AND act9.clabe = '4647484480000089378' MERGE (pers9)-[:CUENTA]-(act9)
MATCH (pers10:Persona),(act10:Cuenta) WHERE pers10.nombre = 'Carlos' AND act10.clabe = '2929283938800000383' MERGE (pers1)-[:CUENTA]-(act10)


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
MATCH (pers3:Persona {nombre:'Patricio'}), (acme:Compania {nombre:'ACME SA de CV'}) MERGE (pers3)-[r:TRABAJA{puesto:'director'}]-(acme) RETURN r;
MATCH (pers4:Persona {nombre:'Marisa'}), (ixe:Compania {nombre:'IXE BANCO'}) MERGE (pers4)-[r:TRABAJA{puesto:'director'}]-(ixe) RETURN r;
MATCH (pers5:Persona {nombre:'Roberto'}), (intercam:Compania {nombre:'INTERCAM BANCO'}) MERGE (pers5)-[r:TRABAJA{puesto:'representante'}]-(intercam) RETURN r;
MATCH (pers6:Persona {nombre:'Isabel'}), (intercam:Compania {nombre:'INTERCAM BANCO'}) MERGE (pers6)-[r:TRABAJA{puesto:'contador'}]-(intercam) RETURN r;
MATCH (pers7:Persona {nombre:'Diego'}), (intercam:Compania {nombre:'INTERCAM BANCO'}) MERGE (pers7)-[r:TRABAJA{puesto:'promotor'}]-(intercam) RETURN r;

/* =====    C O M P A N I E S  W I T H   R F C   ===== */
MATCH (acme:Compania {nombre:'ACME SA de CV'}), (rfc11:Rfc {rfc:'LLHE6011267X2'}) MERGE (acme)-[r:RFC]-(rfc11) RETURN r;
MATCH (acmeB:Compania {nombre:'ACME Bodega SA de CV'}), (rfc12:Rfc {rfc:'LEHR6011267P2'}) MERGE (acmeb)-[r:RFC]-(rfc12) RETURN r;
MATCH (acmeT:Compania {nombre:'ACME Tienda SA de CV'}), (rfc13:Rfc {rfc:'JDSU6011267X2'}) MERGE (acmet)-[r:RFC]-(rfc13) RETURN r;
MATCH (prov1:Compania {nombre:'AMAZON SA DE CV'}), (rfc14:Rfc {rfc:'RMMM6011267X2'}) MERGE (prov1)-[r:RFC]-(rfc14) RETURN r;
MATCH (prov2:Compania {nombre:'ABOGADOS SC'}), (rfc15:Rfc {rfc:'LEFF6011267X2'}) MERGE (prov2)-[r:RFC]-(rfc15) RETURN r;
MATCH (ixe:Compania {nombre:'IXE BANCO'}), (rfc16:Rfc {rfc:'RPJD951128WX2'}) MERGE (ixe)-[r:RFC]-(rfc16) RETURN r;
MATCH (intercam:Compania {nombre:'INTERCAM BANCO'}), (rfc17:Rfc {rfc:'RPJD9511287X2'}) MERGE (intercam)-[r:RFC]-(rfc17) RETURN r;

/* =====     C O M P A N I E S  W I T H  T E L E P H O N E S   ===== */
MATCH (acme:Compania {nombre:'ACME SA de CV'}), (tel1:Telefono {numero:'5555966575'}) MERGE (acme)-[r:TELEFONO]-(tel1) RETURN r;
MATCH (acme:Compania {nombre:'ACME SA de CV'}), (tel2:Telefono {numero:'5555962188'}) MERGE (acme)-[r:TELEFONO]-(tel2) RETURN r;
MATCH (acmeT:Compania {nombre:'ACME Tienda SA de CV'}), (tel3:Telefono {numero:'5555703476'}) MERGE (acmet)-[r:TELEFONO]-(tel3) RETURN r;
MATCH (acmeB:Compania {nombre:'ACME Bodega SA de CV'}), (tel1:Telefono {numero:'5555966575'}) MERGE (acmeb)-[r:TELEFONO]-(tel1) RETURN r;
MATCH (prov1:Compania {nombre:'AMAZON SA DE CV'}), (tel4:Telefono {numero:'5555681423'}) MERGE (prov1)-[r:TELEFONO]-(tel4) RETURN r;
MATCH (prov2:Compania {nombre:'ABOGADOS SC'}), (tel5:Telefono {numero:'5554195422'}) MERGE (prov2)-[r:TELEFONO]-(tel5) RETURN r;
MATCH (ixe:Compania {nombre:'IXE BANCO'}), (tel6:Telefono {numero:'5591495040'}) MERGE (ixe)-[r:TELEFONO]-(tel6) RETURN r;
MATCH (intercam:Compania {nombre:'INTERCAM BANCO'}), (tel7:Telefono {numero:'5591495042'}) MERGE (intercam)-[r:TELEFONO]-(tel7) RETURN r;
MATCH (intercam:Compania {nombre:'INTERCAM BANCO'}), (tel8:Telefono {numero:'5591495000'}) MERGE (intercam)-[r:TELEFONO]-(tel8) RETURN r;

/* =====     C O M P A N I E S  W I T H  A D D R E S S   ===== */
MATCH (acme:Compania {nombre:'ACME SA de CV'}), (adr16:Direccion {calle:'Bosque de alisos 230'}) MERGE (acme)-[r:DIRECCION]-(adr16) RETURN r;
MATCH (acme:Compania {nombre:'ACME SA de CV'}), (adr17:Direccion {calle:'La candelaria 230'}) MERGE (acme)-[r:DIRECCION]-(adr17) RETURN r;
MATCH (acmet:Compania {nombre:'ACME Tienda SA de CV'}), (adr18:Direccion {calle:'Amores 200'}) MERGE (acmet)-[r:DIRECCION]-(adr18) RETURN r;
MATCH (acmeB:Compania {nombre:'ACME Bodega SA de CV'}), (adr19:Direccion {calle:'Circunvalación 30'}) MERGE (acmeb)-[r:DIRECCION]-(adr119) RETURN r;
MATCH (prov1:Compania {nombre:'AMAZON SA DE CV'}), (adr20:Direccion {calle:'Romerito 560'}) MERGE (prov1)-[r:DIRECCION]-(adr20) RETURN r;
MATCH (prov2:Compania {nombre:'ABOGADOS SC'}), (adr21:Direccion {calle:'Chapultepec 340'}) MERGE (prov2)-[r:DIRECCION]-(adr21) RETURN r;
MATCH (ixe:Compania {nombre:'IXE BANCO'}), (adr22:Direccion {calle:'El prado 444'}) MERGE (ixe)-[r:DIRECCION]-(adr22) RETURN r;
MATCH (intercam:Compania {nombre:'INTERCAM BANCO'}), (adr23:Direccion {calle:'Circuito Novelistas 230'}) MERGE (intercam)-[r:DIRECCION]-(adr23) RETURN r;

/* =====    C O M P A N I E S  W I T H   A C C O U N T S   ===== */
MATCH (acme:Compania {nombre:'ACME SA de CV'}), (act11:Cuenta {clabe:'3333333330930830393'}) MERGE (acme)-[r:CUENTA]-(act11) RETURN r;
MATCH (acmet:Compania {nombre:'ACME Tienda SA de CV'}), (act12:Cuenta {clabe:'0003833738937393789'}) MERGE (acmet)-[r:CUENTA]-(act12) RETURN r;
MATCH (acmeB:Compania {nombre:'ACME Bodega SA de CV'}), (act13:Cuenta {clabe:'3938393839383938933'}) MERGE (acmeb)-[r:CUENTA]-(act13) RETURN r;
MATCH (ixe:Compania {nombre:'IXE BANCO'}), (act14:Cuenta {clabe:'3837837937300003839'}) MERGE (ixe)-[r:CUENTA]-(act14) RETURN r;
MATCH (intercam:Compania {nombre:'INTERCAM BANCO'}), (act15:Cuenta {clabe:'3839387398378393893'}) MERGE (intercam)-[r:CUENTA]-(act15) RETURN r;


/* ========================================================================= */
/*                 C O N S T R A I N T S                                     */

SHOW INDEXES

DROP CONSTRAINT unique_persona IF EXISTS;
CREATE CONSTRAINT unique_persona FOR (persona:Persona) REQUIRE persona.idPersona IS UNIQUE

DROP CONSTRAINT unique_compania IF EXISTS;
CREATE CONSTRAINT unique_compania FOR (compania:Compania) REQUIRE compania.idPersona IS UNIQUE

DROP CONSTRAINT unique_sector IF EXISTS;
CREATE CONSTRAINT unique_sector FOR (sector:Sector) REQUIRE sector.nombre IS UNIQUE

DROP CONSTRAINT unique_area IF EXISTS;
CREATE CONSTRAINT unique_area FOR (area:Area) REQUIRE area.nombre IS UNIQUE

DROP CONSTRAINT unique_telefono IF EXISTS;
CREATE CONSTRAINT unique_telefono FOR (telefono:Telefono) REQUIRE telefono.numero IS UNIQUE

DROP CONSTRAINT unique_pais IF EXISTS;
CREATE CONSTRAINT unique_pais FOR (pais:Pais) REQUIRE pais.nombre IS UNIQUE

DROP CONSTRAINT unique_codigo IF EXISTS;
CREATE CONSTRAINT unique_codigo FOR (codigo:Codigo) REQUIRE codigo.cp IS UNIQUE

DROP CONSTRAINT unique_email IF EXISTS;
CREATE CONSTRAINT unique_email FOR (email:Email) REQUIRE email.uri IS UNIQUE

DROP CONSTRAINT unique_rfc IF EXISTS;
CREATE CONSTRAINT unique_rfc FOR (rfc:Rfc) REQUIRE rfc.rfc IS UNIQUE

/* ========================================================================= */
/* =====       E N D  O F  M I N I M U M  D A T A  R E Q U I R E D     ===== */
/* ========================================================================= */
/* End */