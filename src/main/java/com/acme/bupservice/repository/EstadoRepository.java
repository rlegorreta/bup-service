package com.acme.bupservice.repository;

import com.acme.bupservice.model.Estado;
import com.acme.bupservice.model.Persona;
import org.springframework.data.neo4j.repository.Neo4jRepository;

import java.util.List;

public interface EstadoRepository extends Neo4jRepository<Estado, String> {
}
