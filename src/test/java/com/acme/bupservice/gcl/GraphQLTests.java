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
 *  GraphQlTests.java
 *
 *  Developed 2023 by LegoSoftSoluciones, S.C. www.legosoft.com.mx
 */
package com.acme.bupservice.gcl;

import com.acme.bupservice.EnableTestContainers;
import com.acme.bupservice.model.Compania;
import com.acme.bupservice.model.Estado;
import com.acme.bupservice.repository.EstadoRepository;
import com.acme.bupservice.repository.PersonaRepository;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.graphql.tester.AutoConfigureGraphQlTester;
import org.springframework.graphql.test.tester.ExecutionGraphQlServiceTester;
import org.springframework.graphql.ExecutionGraphQlService;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.cloud.stream.function.StreamBridge;
import org.springframework.graphql.test.tester.GraphQlTester;
import org.springframework.security.oauth2.jwt.ReactiveJwtDecoder;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.context.ActiveProfiles;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

/**
 *
 *  For GraphQL tester see:
 *  https://piotrminkowski.com/2023/01/18/an-advanced-graphql-with-spring-boot/
 *
 *  - How graphQlTester is created (imperative):
 *  WebTestClient client = MockMvcWebTestClient.bindToApplicationContext(context)
 *                 .configureClient()
 *                 .baseUrl("/graphql")
 *                 .build();
 *
 * WebGraphQlTester tester = WebGraphQlTester.builder(client).build();
 *
 * - For WebFlux:
 * WebTestClient client = WebTestClient.bindToApplicationContext(context)
 *                 .configureClient()
 *                 .baseUrl("/graphql")
 *                 .build();
 *
 *  WebGraphQlTester tester = WebGraphQlTester.builder(client).build();
 *
 * - And last against a running remote server:
 * WebTestClient client =WebTestClient.bindToServer()
 *                 .baseUrl("http://localhost:8080/graphql")
 *                 .build();
 *
 * WebGraphQlTester tester = WebGraphQlTester.builder(client).build();
 *
 * note: Use always GraphQLTester and not WebMvc because GraphQL does not support WebMvc tester.
 *
 * @project bup-service
 * @autho: rlh
 * @date: November 2023
 */
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.NONE)
@EnableTestContainers
@ExtendWith(MockitoExtension.class)
@ActiveProfiles("integration-tests")
@DirtiesContext                /* will make sure this context is cleaned and reset between different tests */
@AutoConfigureGraphQlTester
public class GraphQLTests {

    @MockBean
    private StreamBridge streamBridge;
    @MockBean
    private ReactiveJwtDecoder reactiveJwtDecoder;			// Mocked the security JWT

    @Autowired
    private GraphQlTester graphQlTester;

    /*
    private final GraphQlTester graphQlTester;

    @Autowired
    public GraphQLTests(ExecutionGraphQlService graphQlService) {
        this.graphQlTester = ExecutionGraphQlServiceTester.builder(graphQlService).build();
    }

     */

    /**
     * Validates database initialization.
     */
    @Test
    void finAll(@Autowired EstadoRepository estadoRepository) {
        /* Companies count */
        /*
        String queryCompanyCount = """
                    query {
                        companiasCount(nombre:"ACME SA de CV")
                    }
                """;
        var companiesCount = graphQlTester.document(queryCompanyCount)
                .execute()
                .path("data.companiasCount[*]")
                .matchesJson(""" 
                        [
                        ]
                        """);

        //assertThat(companiesCount.size()).isEqualTo(3);
        /* */
        /* Query all companies */
        /*
        String queryCompanies = """
                query {
                  companias(nombre_not_contains:"ACME")  {
                    nombre
                  }
                }
                """;
        var companies = graphQlTester.document(queryCompanies)
                .execute()
                .path("data.companias[*]")
                .entityList(Compania.class)
                .get();
                //.matchesJson("""
                //        [
                  //      ]
                  //      """);
        System.out.println(">>>>> FIN de pruebas:" + companies.size());
        /* Query all estados */
        String addQuery = """
                mutation {
                    createEstado (nombre: "CDMX2", pais:"MX") {
                      nombre
                      pais
                    }
                }
                """;

        System.out.println(">>>>>> Estados:" + estadoRepository.count());
        graphQlTester.document(addQuery)
                .execute()
                .path("");
                //   .hasValue()
                //   .entity(Estado.class)
                //   .get();
                //.matchesJson("""
                //       { "nombre" : "CDMX2",
                //         "pais": "MX"
                //       }
                //   """);

        System.out.println(">>>>>> Estados:" + estadoRepository.count());
        String queryEstados = """
                query {
                  estadoes(nombre:"CDMX")  {
                    nombre                  
                  }
                }
                """;
        graphQlTester.document(queryEstados)
                     .execute()
                     .path("estadoes")
                  //   .hasValue()
             //   .entityList(Estado.class)
             //   .get();
                    .matchesJson("""
                       [ 
                       { "nombre" : "CDMX" }
                       ]
                    """);

        // assertThat(companies.size()).isEqualTo(7);
    }

    /**
     * Validates the cache-service that reads a single rate
     *
    @Test
    void findByName() {
        /* System rate by its name * /
        String querySystemRate = """
                    query getSysRate {
                      systemRate(name: "MXN-DLR") {
                           name
                           rate
                      }
                    }
                """;
        SystemRate systemRate = graphQlTester.document(querySystemRate)
                .execute()
                .path("data.systemRate")
                .entity(SystemRate.class)
                .get();

        assertThat(systemRate).isNotNull();
    }

    /**
     * Adds a new system date from system-ui
     *
     * Examples of json for LocalDate, TimeZone and Timestamp:
     * - { date: "1996-03-15" }
     * - objects: [{ time: "17:30:15+05:30" }]
     * - objects: [{ created_at: "2016-07-20T17:30:15+05:30" }]
     *
    @Test
    void addSystemDate() {
        String mutationSystemDate = """
                    mutation addSysDate {
                      addSystemDate(systemDateInput: { name: FESTIVO day: "2023-08-08" userModify: "TEST" } ) {
                            id
                            name
                            day
                        }
                    }
                """;
        SystemDate systemDate = graphQlTester.document(mutationSystemDate)
                .execute()
                .path("data.addSystemDate")
                .entity(SystemDate.class)
                .get();

        assertThat(systemDate).isNotNull();
        assertThat(systemDate.getId()).isNotNull();
    }

    /**
     * Adds a new system rate from system-ui
     *
     * Examples of json for BigDecimal
     * - objects: [{ total: 200 }]
     * - objects: [{ amount: 30.45 }]
     *
    @Test
    void addSystemRate() {
        String mutationSystemRate = """
                    mutation addSysRate {
                      addSystemRate(systemRateInput: { name: "MXN-EUR" rate: 20.45 userModify: "TEST"} ) {
                            id
                            name
                            rate
                        }
                    }
                """;
        SystemRate systemRate = graphQlTester.document(mutationSystemRate)
                .execute()
                .path("data.addSystemRate")
                .entity(SystemRate.class)
                .get();

        assertThat(systemRate).isNotNull();
        assertThat(systemRate.getId()).isNotNull();
    }

    /**
     * Updates a document Type
     *
     *
    @Test
    void updateDocumentType() {
        DocumentType documentType = documentTypeRepository.findDocumentTypeByName("Visa");

        assertThat(documentType).isNotNull();

        String mutationDocumentType = """
                    mutation updDocType {
                      updateDocumentType(documentTypeInput: { id:
               """ + "\"" + documentType.getId() + "\"" + """
                    name: "Visa" expiration: "2m" userModify: "TEST"} ) {
                            id
                            name
                            expiration
                        }
                    }
                """;
        DocumentType mutatedDocumentType = graphQlTester.document(mutationDocumentType)
                .execute()
                .path("data.updateDocumentType")
                .entity(DocumentType.class)
                .get();

        assertThat(mutatedDocumentType).isNotNull();
        assertThat(mutatedDocumentType.getId()).isNotNull();
        assertThat(mutatedDocumentType.getExpiration()).isEqualTo("2m");
    }
    */

}