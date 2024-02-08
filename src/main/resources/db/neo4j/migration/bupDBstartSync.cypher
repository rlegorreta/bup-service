/* =========================================================================== */
/* This script is to initialize the BUP Neo4j database that is in synchronized */
/* using the Kafka events produced by 'acme-ui' and 'bup-batch-service' and    */
/* listened by 'iam-service' with the iamDB.                                   */
/* For testing purpose we use the Company script from iamDB but with just the  */
/* relevan data that is needed in the bupDB (i.e., no relationships) for       */
/* iam DB entities.                                                            */
/*                                                                             */
/* Date: November 2023                                                         */
/* =========================================================================== */

/* ======================================================= */
/* =====     C O M P A N I E S  LMASS & ACME         ===== */
/* ======================================================= */
MERGE (lmass:Compania {nombre:'LMASS Desarrolladores SA de CV', padre:true, negocio:'NA', usuarioModificacion:'START', fechaModificacion:localdatetime(), activo:true, idPersona:0})
MERGE (aiml:Compania {nombre:'AI/ML SA de CV', padre:false, negocio:'NA', usuarioModificacion:'START', fechaModificacion:localdatetime(), activo:true, idPersona:1})
MERGE (acme:Compania {nombre:'ACME SA de CV', padre:true, negocio:'INDUSTRIAL', usuarioModificacion:'START', fechaModificacion:localdatetime(), activo:true, idPersona:2})
MERGE (acmet:Compania {nombre:'ACME Tienda SA de CV', padre:false, negocio:'INDUSTRIAL', usuarioModificacion:'START', fechaModificacion:localdatetime(), activo:true, idPersona:3})
MERGE (acmeb:Compania {nombre:'ACME Bodega SA de CV', padre:false, negocio:'INDUSTRIAL', usuarioModificacion:'START', fechaModificacion:localdatetime(), activo:true, idPersona:4})
MERGE (prov1:Compania {nombre:'AMAZON SA DE CV', padre:true, negocio:'INDUSTRIAL', usuarioModificacion:'START', fechaModificacion:localdatetime(), activo:true, idPersona:5})
MERGE (prov2:Compania {nombre:'ABOGADOS SC', padre:true, negocio:'PARTICULAR', usuarioModificacion:'START', fechaModificacion:localdatetime(), activo:true, idPersona:6})
MERGE (ixe:Compania {nombre:'IXE BANCO', padre:true, negocio:'FINANCIERA', usuarioModificacion:'START', fechaModificacion:localdatetime(), activo:true, idPersona:7})
MERGE (intercam:Compania {nombre:'INTERCAM BANCO', padre:true, negocio:'FINANCIERA', usuarioModificacion:'START', fechaModificacion:localdatetime(), activo:true, idPersona:8})

/* =====     S U B S I D I A R Y E S    ===== */
MATCH (aiml:Compania {nombre:'AI/ML SA de CV'}), (lmass:Compania {nombre:'LMASS Desarrolladores SA de CV'}) MERGE (aiml)-[:SUBSIDIARIA]->(lmass);
MATCH (acmet:Compania {nombre:'ACME Tienda SA de CV'}), (acme:Compania {nombre:'ACME SA de CV'}) MERGE (acmet)-[:SUBSIDIARIA]->(acme);
MATCH (acmeb:Compania {nombre:'ACME Bodega SA de CV'}), (acme:Compania {nombre:'ACME SA de CV'}) MERGE (acmeb)-[:SUBSIDIARIA]->(acme);

MERGE (aiml)-[:SUBSIDIARIA]->(lmass)
MERGE (acmet)-[:SUBSIDIARIA]->(acme)
MERGE (acmeb)-[:SUBSIDIARIA]->(acme)
/* End */