# <img height="25" src="./images/AILLogoSmall.png" width="40"/> BUP-service

<a href="https://www.legosoft.com.mx"><img height="150px" src="./images/Icon.png" alt="AI Legorreta" align="left"/></a>
Microservice that acts as the graph repository for all persons (clients, suppliers, employees, etc) that has some
relationship with the ACME company.

The `acme-ui` is the microservice that utilizes most the `bup-service`. Others microservice utilizes this 
microservice when they need any access to any person releated to the ACME company.


## Introduction

The `bup-service` repository microservice is in charge to do all operations for the BUP database. Is has
many REST GET, POST and DELETE  REST service.

It stores all BUP (Persons & Companies) information.

We can summarize the operations as follows:

- Persons: customers, contacts, employees, etc.
- With each person include:
  - Addresses.
  - emails.
  - RFC
  - Telephones
  - Bank accounts
  - other
- Companies: customers, suppliers, consultans, etc.
- With each Company include:
  - Areas
  - Sector.
  - Addresses.
  - emails.
  - RFC
  - Telephones
  - Bank accounts
  - other
- All possible relationships:
  - Between Companies:
    - Subsidiaries
    - Suppliers
    - Consultants.
    - Other.
  - Between Company and Persona:
    - Employees
    - Administrator
    - CEO
    - CFO
  - Between Personas and Personas
    - Friends
    - Family
    - Any type of relationship.


Future versions of this microservice will include many other CRM and BUP functionality. This is just an initial 
POC version for the ACME company.

For LLM AI functionality, please se the `chat-gpt` microservice in the GenAI section.

note: `bup-service` microservice is a protected resource so all REST services need a valid JWT produced
token by Oauth2  microservice. For develop purpose the developer can eliminate this restriction 
commenting the  @EnableResourceServer annotation in the main application.

## Use it with cache

Since the microservices queries the parameters many times during te day and optimize the database access; this microservice
works in conjunction with the `cache-service` to keep them in memory.

To solve the problem to keep in sync the values stored in the database versus the values in memory in the 
`cache-service` i.e, be the same values in the memory Redis cache parameters and the values stored
In Neo4j DB, every time a cache value is changed this microservice (BUP) sends an event to be listened by the 
`cache-service` in order to invalidate the memory value in Redis and the next time it is queried the value is re-read 
from the database.

## BUP database

The Neo4j database called bupDB is declared and created (if not exists) by the third party docker-compose.
Also, when the database bupDB is created the micro.services runs a script `start.cypher` to run minimal
data needed. The `dev.cypher` is a more complete example for the database and it

### Database queries

`bup-service` utilizes Neo4jDB to store the BUP data, GraphQL as an API to query parameters and Spring 
GraphQL and Neo4j GraphQL Java library.

note: NOT use Spring Data and Spring Neo4j Data libraries (i.e., repositories). All is done in GraphQL 
which we believe is much better solution for these type of queries.

For more information see example:

graphql-spring-boot or visit link:

https://github.com/neo4j-graphql/neo4j-graphql-java/tree/master/examples/graphql-spring-boot

Or the official repository (see examples) for Spring for GraphQL

https://github.com/spring-projects/spring-graphql

### bupDB version

For Gen AI we also can use AI LLM queries, que prefer to use the newest NEO4j version
(i.e. 5.X) so we create another image from `iam-service` Neo4j database and therefor keep the upgrades
separate.

### bupDB ports

By default `bupDB` is configured to use the 7688 port to be accessed externally.

Other ports are port 7475, 74743 for :bolt driver

note: i.e., all ports are the `default` Neo4j ports + 1.

### Schema

For developers, we can generate at compile time the schema augmentation for debug purpose. This is done with the
`neo4j-graphql-augmented-schema-generator-maven-plugin`. Since there is not Gradle plugin you can do the following 
process:

(a) In Gradle use the `maven-publish` plugin with the `publish` task goal. When you run:

```
./gradlew publish
```

A pom file is created in the directory ./build/publications with the name `pom-default.xml`.

(b) The file was copied in the project directory and modified to include the `neo4j-graphql-augmented-schema-generator-maven-plugin`
and comment some dependencies from the maven local repository (i.e., ailegorreta-kit)

(c) The run the goal 
```
mvn -f pom-default.xml compile
```

To create tha augmented schema in the directory `/target/augmented-schem/neo4j.graphql`.

note: This process has to be done every time the schema is modified.


### Compilation (to be checked for Neo4j 5.X)

When this microservice is compiled it sends the following warning:

```
The entity XXXXXXX is using a Long value for storing internally generated Neo4j ids. The Neo4j internal Long Ids are deprecated, please consider using an external ID generator.
```

As for documentation in SDN Neo4j it still utilizes Long es generated value and in :

```
https://community.neo4j.com/t5/drivers-stacks/list-of-relationshipproperties/m-p/61214
```

It says Please ignore this warning for now because we are still not sure if we will just stick with the
old `id` format and dismiss this warning in the GA version.

This maybe change for Neo4j 5 and SDN 7


### TODO Events generated

All events generated to `kafka` came with a field "notificaFacultad" where indicates that notification must be sent 
to all user with this permit.

This is the event generated by this micro.servico to the Even-logger

- Event name: ALTA_...
  Action: new a permit.
  Data: FacultadDTO
- Event name: ACTUALIZA_...
  Action: update a permit.
  Data: FacultadDTO


### TODO:Events listener

These are the event  that this microservice is a listener. Mainly are to keep in sync the `chache-service`,
`iam-service` with security.

- Event name: CreaParticipante
    - Producer: Participantes
    - Action: Insert a new Operadora/Afore, Group and its Administrator
    - Data: NewCorporativoDTO
    - note: No activation for Participante is done (i.e., activo = false).

- Event name: AutorizacionParticipante
    - Producer: Participantes
    - Action: Activate new Operadora/Afore, Group or a Fund (i.e., set the flag activo = true)

- Event name: CreaFondo
    - Producer: Particiantes
    - Action: Insert e new Fondo/Siefore  and link OPERADO_POR an existing Operadora/Afore
    - Data: NewFondoDTO
    - note: No activation is done.

- Event name: CreaSiefore
    - Producer: Particiantes
    - Action: Insert e new Fondo/Siefore  and link OPERADO_POR an existing Operadora/Afore
    - Data: NewFondoDTO
    - note: No activation is done.

- Event name: CreaFondoAseguradora
    - Producer: Particiantes
    - Action: Insert e new Fondo/Siefore  and link OPERADO_POR an existing Operadora/Afore
    - Data: NewFondoDTO
    - note: No activation is done.

- Event name: CreaFondoPrivado
    - Producer: Particiantes
    - Action: Insert e new Fondo/Siefore  and link OPERADO_POR an existing Operadora/Afore
    - Data: NewFondoDTO
    - note: No activation is done.
  
## Running on Docker Desktop

For docker-compose the `bupDB` is configured to be stored as a separate volume in order to protect data
in the /var/bupDB directory.

The directory following directory must exist inside the docker and have +rwx permission:

volumes:
- /var/neo4jDB/data:/data
- /var/neo4jDB/logs:/logs
- /var/neo4jDB/import:/var/lib/neo4j/import
- /var/neo4jDB/plugins:/plugins


### Create the image manually

```bash
./gradlew bootBuildImage
```

### Publish the image to GitHub manually

```
./gradlew bootBuildImage \
   --imageName ghcr.io/rlegorreta/bup-service \
   --publishImage \
   -PregistryUrl=ghcr.io \
   -PregistryUsername=rlegorreta \
   -PregistryToken=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
```

### Publish the image to GitHub from the IntelliJ

To publish the image to GitHub from the IDE IntelliJ a file inside the directory `.github/workflows/commit-stage.yml`
was created.

To validate the manifest file for kubernetes run the following command:

```
kubeval --strict -d k8s
```

This file compiles de project, test it (for this project is disabled for some bug), test vulnerabilities running
skype, commits the code, sends a report of vulnerabilities, creates the image and lastly push the container image.

<img height="340" src="./images/commit-stage.png" width="550"/>

For detail information see `.github/workflows/commit-stage.yml` file.


### Run the image inside the Docker desktop

```
docker run \
    --net ailegorretaNet \
    -p 8520:8520 \
    -e SPRING_PROFILES_ACTIVE=local \
    iam-service
```

Or a better method use the `docker-compose` tool. Go to the directory `ailegorreta-deployment/docker-platform` and run
the command:

```
docker-compose up
```

note: using docker-compose up to demonstrate load balanced more than one `bup-service` are created with the
ports: 8520, 8521 8522, ... respectively.

## Run inside Kubernetes

### Manually

If we do not use the `Tilt`tool nd want to do it manually, first we need to create the image:

Fist step:

```
./gradlew bootBuildImage
```

Second step:

Then we have to load the image inside the minikube executing the command:

```
image load ailegorreta/bup-service --profile ailegorreta 
```

To verify that the image has been loaded we can execute the command that lists all minikube images:

```
kubectl get pods --all-namespaces -o jsonpath="{..image}" | tr -s '[[:space:]]' '\n' | sort | uniq -c\n
```

Third step:

Then execute the deployment defined in the file `k8s/deployment.yml` with the command:

```
kubectl apply -f k8s/deployment.yml
```

And after the deployment can be deleted executing:

```
kubectl apply -f k8s/deployment.yml
```

Fourth step:

For service discovery we need to create a service applying with the file: `k8s/service.yml` executing the command:

```
kubectl apply -f k8s/service.yml
```

And after the process we can delete the service executing:

```
kubectl deltete -f k8s/service.yml
```

Fifth step:

If we want to use the project outside kubernetes we have to forward the port as follows:

```
kubectl port-forward service/bup-service 8520:80
```

Appendix:

If we want to see the logs for this `pod` we can execute the following command:

```
kubectl logs deployment/bup-service
```

### Using Tilt tool

To avoid all these boilerplate steps is much better and faster to use the `Tilt` tool as follows: first create see the
file located in the root directory of the proyect called `TiltFile`. This file has the content:

```
# Tilt file for bup-service
# Build
custom_build(
    # Name of the container image
    ref = 'bup-service',
    # Command to build the container image
    command = './gradlew bootBuildImage --imageName $EXPECTED_REF',
    # Files to watch that trigger a new build
    deps = ['build.gradle', 'src']
)

# Deploy
k8s_yaml(['k8s/deployment.yml', 'k8s/service.yml'])

# Manage
k8s_resource('bup-service', port_forwards=['8520'])
```

To execute all five steps manually we just need to execute the command:

```
tilt up
```

In order to see the log of the deployment process please visit the following URL:

```
http://localhost:10350
```

Or execute outside Tilt the command:

```
kubectl logs deployment/bup-service
```

In order to undeploy everything just execute the command:

```
tilt down
```

To run inside a docker desktop the microservice need to use http://bup-service:8520 to 8083 path


### Reference Documentation

* [Spring Boot Gateway](https://cloud.spring.io/spring-cloud-gateway/reference/html/)
* [Spring Boot Maven Plugin Reference Guide](https://docs.spring.io/spring-boot/docs/3.0.1/maven-plugin/reference/html/)
* [Config Client Quick Start](https://docs.spring.io/spring-cloud-config/docs/current/reference/html/#_client_side_usage)
* [Spring Boot Actuator](https://docs.spring.io/spring-boot/docs/3.0.1/reference/htmlsingle/#production-ready)

### Links to Springboot 3 Observability

https://tanzu.vmware.com/developer/guides/observability-reactive-spring-boot-3/

Baeldung:

https://www.baeldung.com/spring-boot-3-observability



### Contact AI Legorreta

Feel free to reach out to AI Legorreta on [web page](https://legosoft.com.mx).


Version: 2.0.0
©LegoSoft Soluciones, S.C., 2023
