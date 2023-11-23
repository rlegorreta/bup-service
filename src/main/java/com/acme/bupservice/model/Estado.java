package com.acme.bupservice.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.data.neo4j.core.schema.GeneratedValue;
import org.springframework.data.neo4j.core.schema.Id;
import org.springframework.data.neo4j.core.schema.Node;
import org.springframework.data.neo4j.core.schema.Property;

@Node("Estado")
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Estado {
    @Id
    @GeneratedValue
    String id;

    @Property(name = "nombre")
    public String nombre;

    @Property(name = "pais")
    public String pais;
}