/* Copyright (c) 2023, LegoSoft Soluciones, S.C.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are not permitted.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 *  AdditionalDataFetcher.java
 *
 *  Developed 2023 by LegoSoftSoluciones, S.C. www.legosoft.com.mx
 */
package com.acme.bupservice.gql.datafetcher;

import com.acme.bupservice.repository.*;
import com.fasterxml.jackson.annotation.JsonProperty;
import graphql.schema.DataFetchingEnvironment;
import org.springframework.graphql.data.method.annotation.Argument;
import org.springframework.graphql.data.method.annotation.QueryMapping;
import org.springframework.graphql.data.method.annotation.SchemaMapping;
import org.springframework.stereotype.Controller;

import java.util.Collections;
import java.util.List;
import java.util.Map;

/**
 * This is an example to has additional queries from the ones that the GraphQL give us for free
 */
@Controller
class AdditionalDataFetcher {
    private final PersonaRepository personaRepository;
    private final CompaniaRepository companiaRepository;


    AdditionalDataFetcher(CompaniaRepository companiaRepository,
                          PersonaRepository personaRepository) {
        this.companiaRepository = companiaRepository;
        this.personaRepository = personaRepository;
    }

    /**
     * Keep example alive for addition fetcher to return a String
     */
    @SchemaMapping(typeName = "Movie", field = "bar")
    public String bar() {
        return "foo";
    }

    /**
     * Keep example alive for addition fetcher to return an Object of data
     */
    @SchemaMapping(typeName = "Movie", field = "javaData")
    public List<JavaData> javaData(DataFetchingEnvironment env) {
        // no inspection unchecked
        Object title = ((Map<String, Object>) env.getSource()).get("title");
        return Collections.singletonList(new JavaData("test " + title));
    }

    @QueryMapping
    public String companiasCount(@Argument("nombre") String nombre) {
        if (nombre == null)
            return companiaRepository.count() + "";
        return companiaRepository.findCompaniaByNombreContaining(nombre).size() + "";
    }

    @QueryMapping
    public String personasCount(@Argument("apellidoPaterno") String apellidoPaterno, @Argument("activo")Boolean activo) {
        if (apellidoPaterno == null)
            if (activo == null)
                return personaRepository.count() + "";
            else
                return personaRepository.findPersonasByActivo(activo).size() + "";
        else if (activo == null)
            return personaRepository.findPersonasByApellidoPaternoContaining(apellidoPaterno).size() + "";

        return personaRepository.findPersonasByApellidoPaternoContainingAndActivo(apellidoPaterno, activo).size() + "";
    }

    public static class JavaData {
        @JsonProperty("name")
        public String name;

        public JavaData(String name) {
            this.name = name;
        }
    }
}
