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
 *  BupServiceApplication.kt
 *
 *  Developed 2023 by LegoSoftSoluciones, S.C. www.legosoft.com.mx
 */
package com.acme.bupservice

import com.acme.bupservice.config.ServiceConfig
import com.acme.bupservice.repository.PersonaRepository
import com.ailegorreta.commons.utils.HasLogger
import com.fasterxml.jackson.annotation.JsonInclude
import com.fasterxml.jackson.databind.SerializationFeature
import com.fasterxml.jackson.datatype.jdk8.Jdk8Module
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule
import com.fasterxml.jackson.module.kotlin.KotlinModule
import org.neo4j.driver.Driver
import org.springframework.boot.ApplicationArguments
import org.springframework.boot.ApplicationRunner
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.cloud.client.discovery.EnableDiscoveryClient
import org.springframework.cloud.context.config.annotation.RefreshScope
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.ComponentScan
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer
import org.springframework.http.converter.json.Jackson2ObjectMapperBuilder
import org.springframework.stereotype.Component
import java.io.BufferedReader
import java.io.InputStreamReader

/**
 * BUP service repository.
 *
 * This server repo maintains all BUP Person & Companies data. Three main functions:
 *
 * - All Persons data
 * - All Companies data
 * - Relationships between Persons & data
 *
 * @author rlh
 * @project : bup-service
 * @date November 2023
 *
 */
@SpringBootApplication
@EnableDiscoveryClient
@RefreshScope               // This is we need to refresh the config server scope
@ComponentScan(basePackages = ["com.acme.bupservice", "com.ailegorreta.resourceserver"])
class BupServiceApplication {

	@Bean
	fun kotlinPropertyConfigurer(): PropertySourcesPlaceholderConfigurer {
		val propertyConfigurer = PropertySourcesPlaceholderConfigurer()

		propertyConfigurer.setPlaceholderPrefix("@{")
		propertyConfigurer.setPlaceholderSuffix("}")
		propertyConfigurer.setIgnoreUnresolvablePlaceholders(true)

		return propertyConfigurer
	}

	@Bean
	fun defaultPropertyConfigurer() = PropertySourcesPlaceholderConfigurer()

	@Bean
	fun mapperConfigurer() = Jackson2ObjectMapperBuilder().apply {
		serializationInclusion(JsonInclude.Include.NON_NULL)
		failOnUnknownProperties(true)
		featuresToDisable(*arrayOf(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS))
		indentOutput(true)
		modules(listOf(KotlinModule.Builder().build(), JavaTimeModule(), Jdk8Module()))
	}

	@Component
	class DataInitializer(private val personaRepository: PersonaRepository,
						  private val driver: Driver,
						  private val serviceConfig: ServiceConfig): ApplicationRunner, HasLogger {
		override fun run(args: ApplicationArguments?) {
			if (personaRepository.count() == 0L) {
				logger.info("The ACME Noe4j database is empty... We fill it with minimum data for testing purpose")

				driver.session().use { session ->
					BufferedReader(InputStreamReader(this.javaClass.getResourceAsStream("${serviceConfig.neo4jFlywayLocations}/bupDBstartSync.cypher"))).use { testReader ->
						logger.info("Start process ${serviceConfig.neo4jFlywayLocations}/bupDBstartSynch.cypher")
						// NOTE: This command will erase ALL database data. Comment if we don´t want to
						//       delete all data since the test.cypher utilizes MERGE instead of CREATE
						session.run("MATCH (n) DETACH DELETE n")

						do {
							val cypher: String? = testReader.readLine()

							if (!cypher.isNullOrBlank() && !cypher.startsWith("/"))
								session.run(cypher)
									.consume()
						} while (cypher != "/* End */")
						logger.info("The synchronization (iamDB) data has been initialized...")
					}
					BufferedReader(InputStreamReader(this.javaClass.getResourceAsStream("${serviceConfig.neo4jFlywayLocations}/bupDBstart.cypher"))).use { testReader ->
						logger.info("Start process ${serviceConfig.neo4jFlywayLocations}/bupDBstart.cypher")
						do {
							val cypher: String? = testReader.readLine()

							if (!cypher.isNullOrBlank() && !cypher.startsWith("/"))
								session.run(cypher)
									.consume()
						} while (cypher != "/* End */")
					}
					session.close()
				}
				logger.info("The database ACME Neo4j has been initialized...")
				logger.info("Number of persons created..." + personaRepository.count())
				logger.info("Check that the constraints exists:")
				logger.info("  CREATE CONSTRAINT unique_compania FOR (compania:Compania) REQUIRE compania.nombre IS UNIQUE")
				logger.info("  CREATE CONSTRAINT unique_usuario FOR (usuario:Usuario) REQUIRE usuario.idUsuario IS UNIQUE")
				logger.info("  CREATE CONSTRAINT unique_usuario2 FOR (usuario:Usuario) REQUIRE usuario.nombreUsuario IS UNIQUE")
				logger.info("  CREATE CONSTRAINT unique_area FOR (area:Area) REQUIRE area.isArea IS UNIQUE")
				logger.info("  CREATE CONSTRAINT unique_grupo FOR (grupo:Grupo) REQUIRE grupo.nombre IS UNIQUE")
			} else
				logger.debug("The database ACME Neo4j has already data...")
		}
	}
}


fun main(args: Array<String>) {
	runApplication<BupServiceApplication>(*args)
}